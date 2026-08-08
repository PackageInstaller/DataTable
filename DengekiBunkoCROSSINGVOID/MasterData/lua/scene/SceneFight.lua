local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local DU = require("Common/DungeonUtil")
local TLog = require("Common/TlogUtil")
local S = require("Common/Singleton")
local m_configDataManager = S:Get("ConfigDataManager")
local PU = require("Common/PlatformUtil")
local ATU = require("Common/AutumnUtil")
local FH = require("Logic/HelpLogic")
local DBH = require("Manager/DataBindingHandler")
local DEFINE = require("Logic/Define")
local DungeonChainSetup = 9
local m_fightDungeonType
local bBalance = false
local resultVal
local enableChangeScene = false

local function RecordUseCount(cardList)
  local result = {}
  for i = 1, #cardList do
    local roundCardInfo = cardList[i]
    local team, seat, flag, indexOfAllCards = DEFINE.RoundCardInfoIndex(roundCardInfo.index)
    local actorID = roundCardInfo.actorID
    local skillIndex = roundCardInfo.skillIndex
    local useCount = roundCardInfo.useCount
    if flag == DEFINE.CardFlag.Normal then
      result["n_" .. actorID .. skillIndex] = useCount
    elseif flag == DEFINE.CardFlag.S then
      result["s_" .. actorID .. skillIndex] = useCount
    elseif flag == DEFINE.CardFlag.Link then
      result["l_" .. roundCardInfo.linkID] = useCount
    elseif flag == DEFINE.CardFlag.Weapon then
      result["w_" .. actorID .. roundCardInfo.weaponPhase] = useCount
    end
  end
  return result
end

local function SetupNextDungeonChain()
  local fightLuaLogic = CS.FightLuaLogic.Instance
  local fightLuaRef = _ENV["$"](fightLuaLogic.transform)
  local fightActiveData = fightLuaRef.MainLogic["$fightActiveData"]()
  local commands = this:GetData("Fight/CommandSequenceTemp")
  DU.SaveAutoFightCommands(fightActiveData.stageID, commands)
  this:SetData("Fight/PrevDungeonChain", fightActiveData.stageID)
  local selfTeam = fightLuaLogic.SelfTeam
  local roundActorInfoList = FH.getTeamActorsByAssist(fightActiveData.teamList, selfTeam, false)
  local roundTeamInfo = FH.getTeamInfo(fightActiveData.teamList, selfTeam)
  local fightInitInfo = this:GetData("FightInitInfo") or {}
  local fightInitTeamInfo = fightInitInfo[selfTeam] or {}
  fightInitTeamInfo.recordBuffs = {}
  fightInitTeamInfo.energyWPList = {}
  for i = 1, #roundActorInfoList do
    local roundActorInfo = roundActorInfoList[i]
    local aliveBuffList = table.select(roundActorInfo.buffList, function(v)
      if v.state == PB.enum.BuffFightState.Alive then
        local buffData = FH.getBuffData(v.buffKey.id, v.buffKey.owner)
        if buffData.type ~= PB.enum.BuffFightType.LockCard then
          return v
        end
      end
    end):toarray()
    local copyBuffList = {}
    table.copy(aliveBuffList, copyBuffList, true)
    local baseSeat = roundActorInfo.baseSeat
    fightInitTeamInfo.recordBuffs[baseSeat] = copyBuffList
  end
  local weapons = FH.getTeamWeapons(fightActiveData.teamList, selfTeam)
  for i = 1, #weapons do
    local weapon = weapons[i]
    fightInitTeamInfo.energyWPList[weapon.baseSeat] = weapon.energyWP
  end
  fightInitTeamInfo.allCardUseCount = RecordUseCount(roundTeamInfo.allCardList)
  local statistic = roundTeamInfo.statistic
  fightInitTeamInfo.hp = {}
  for i = 1, DEFINE.ACTOR_NUM do
    fightInitTeamInfo.hp[i] = fif(statistic.recordHpList[i] == 0, -1, statistic.recordHpList[i] or 0)
  end
  fightInitTeamInfo.sp = roundTeamInfo.energySp
  fightInitTeamInfo.mp = roundTeamInfo.energyMp
  
  local function BuildActorIdList()
    local result = {}
    local processList = CS.ActorManager.Instance:GetActorList()
    for i = 0, processList.Count - 1 do
      local actorProcess = processList[i]
      if actorProcess:GetTeam() == selfTeam then
        result[actorProcess:GetBaseSeat()] = actorProcess:GetActorID()
      end
    end
    return result
  end
  
  fightInitTeamInfo.monsterList = fightInitTeamInfo.monsterList or BuildActorIdList()
  fightInitInfo[selfTeam] = fightInitTeamInfo
  fightInitInfo.gameRound = fightActiveData.gameRound + 1
  this:SetData("FightInitInfo", fightInitInfo)
  return DungeonChainSetup
end

local function InitNextDungeonChain(dungeonId, dungeonUid)
  if dungeonId == nil then
    return
  end
  
  local function SetupSelectedGroupId(param)
    local info = this:GetData("BalanceInfo/Groups")
    local selectedGroupId
    if info and info.selectedGroupId then
      selectedGroupId = info.selectedGroupId
    end
    param.selectActorGroupId = selectedGroupId
    return selectedGroupId
  end
  
  local param = {
    dungeonId = dungeonId,
    multiPower = this:GetData("PowerMultiple"),
    price = DU.GetDungeonPrice(dungeonId),
    preDungeonChainUid = dungeonUid
  }
  if m_fightDungeonType == PB.enum.DungeonType.Normal then
    local selectedGroupId = SetupSelectedGroupId(param)
    local actorGroup = this:GetData("fci/ActorGroup") or {}
    local groupInfo = actorGroup[tostring(selectedGroupId)] or {}
    param.reduceInfo = DU.CultivationPVPRatioConvert(groupInfo.members, this:GetData("ActorGroup/CurrentCultivationRatios/" .. dungeonId))
    this:SetData("WindowDungeon/EnterParam", param)
    param = ProtobufT("ApiDungeon", param)
    this:GameRequest("fci/dungeon/"):Post(param, function(result)
      this:SetData("EnteredChapterId", this:GetData("WindowDungeon/ChapterId"))
      DBH.ResChange(result.resChange)
      WU.EnterGameLevel(result.dungeonUid, result.baseInfo, dungeonId, PB.enum.DungeonType.Normal, 1, true)
    end, function(error)
      EndGame("SceneCity")
    end)
  elseif m_fightDungeonType == PB.enum.DungeonType.WeekActivity then
    SetupSelectedGroupId(param)
    local record = this:GetData("ActivityActorGroup/DungeonInfo") or {}
    param.activityType = record.activityType
    param.activityId = record.activityId
    param.wheelMode = record.wheelMode
    if param.wheelMode then
      param.wheelModeEntrance = record.dungeonId
    end
    param = ProtobufT("ApiEventDungeon", param)
    this:GameRequest("fci/event-dungeon/"):Post(param, function(result)
      DBH.ResChange(result.resChange)
      WU.EnterGameLevel(result.dungeonUid, result.baseInfo, dungeonId, PB.enum.DungeonType.WeekActivity, 1, false)
    end, function(error)
      EndGame("SceneCity")
    end)
  elseif m_fightDungeonType == PB.enum.DungeonType.MaidCafe then
    SetupSelectedGroupId(param)
    local record = this:GetData("MaidCafe/DungeonInfo") or {}
    local exParam = {
      dungeonExCreateParam = {
        common = param,
        maidcafe = {
          rankModeType = record.rankType
        }
      }
    }
    exParam = ProtobufT("ApiDungeonEx", exParam)
    this:GameRequest("fci/dungeon-ex/"):Post(exParam, function(result)
      local exResult = result.dungeonExCreateResult
      DBH.ResChange(exResult.common.resChange)
      WU.EnterGameLevel(exResult.common.dungeonUid, exResult.common.baseInfo, dungeonId, PB.enum.DungeonType.MaidCafe, 1, false)
    end, function(error)
      EndGame("SceneCity")
    end)
  else
    warning("InitNextDungeonChain", "DungeonType " .. tostring(m_fightDungeonType) .. " not inplement")
  end
end

local function RequestBalanceNormal(response)
  this:GameRequest("fci/dungeon/{Dungeon/DungeonUid}/balance"):Post({}, function(response2)
    if response2.chapterSummaryInfo ~= nil and this:GetData("fci/dungeon/chapter-summary") then
      table.merge(this:GetData("fci/dungeon/chapter-summary"), response2.chapterSummaryInfo)
    end
    this:SetData("NoNewChapterUnlocked", #response2.chapterInfo <= 1)
    for i = 1, #response2.chapterInfo do
      local chapterInfo = response2.chapterInfo[i]
      this:SetData("fci/dungeon/chapter/" .. chapterInfo.recordChapter.chapterId, chapterInfo)
    end
    if response2.chapterSummaryInfo ~= nil then
      this:SetData("fci/dungeon/chapter-summary", response2.chapterSummaryInfo)
    end
    this:SetData("DungeonBalance/result", response2.balanceInfo)
    resultVal = response2
  end)
end

function Start()
  m_fightDungeonType = this:GetData("FightDungeonType")
  this:RegisterGameEvent("Fight_GameEnd", ProcessGameEnd)
  this:RegisterGameEvent("Fight_EnableChange", OnChangeScene)
  this:RegisterGameEvent("FightWebSocket_Init", InitWebSocket)
  StartRecordVideo()
end

function OnDestroy()
  if PU.IsRecordVideoEnabled() then
    CS.RecordVideoManager.Instance:ClearStartMomentsRecordingCallbacks()
    CS.RecordVideoManager.Instance:ClearEndMomentsRecordingCallbacks()
  end
end

function StartRecordVideo()
  if PU.IsRecordVideoEnabled() then
    this:SetData("RecordVideoList", nil)
    CS.RecordVideoManager.Instance:StartMomentsRecording(function(status)
      if status == CS.GameJoyAPI.RecordingStartStatus.Fail then
        warning("RecordVideo", "record start error")
      else
        this:SetData("RecordVideoStartTime", CS.GameJoy.getSystemCurrentTimeMillis)
      end
      this:DelayInvokeInSeconds(1, function()
        local dungeonId = this:GetData("WindowDungeon/DungeonId")
        local dungeonMonster = PB.get("DungeonMonster", dungeonId)
        if dungeonMonster then
          CS.SoundManager.Instance:StopCurrentMusic()
          CS.SoundManager.Instance:PlayMusic(dungeonMonster.musicID)
        end
      end)
    end)
  end
end

function EndRecordVideo()
  if PU.IsRecordVideoEnabled() then
    local isRecording = CS.RecordVideoManager.Instance:isRecordingMoments()
    if isRecording then
      CS.RecordVideoManager.Instance:EndMomentsRecording(function(status)
        if status == CS.GameJoyAPI.RecordingStartStatus.Fail then
          warning("RecordVideo", "record end error")
        end
      end)
    end
  end
end

function InitWebSocket()
  if m_fightDungeonType == PB.enum.DungeonType.BurstLinkPvp or m_fightDungeonType == PB.enum.DungeonType.TeamPve or m_fightDungeonType == PB.enum.DungeonType.FriendPvp or m_fightDungeonType == PB.enum.DungeonType.RD then
    this:RegisterWebSocketLuaListener(CS.Restifizer.WebSocketTag.FightService, "ScInteractionRsp", OnFightEmoteNtf)
    this:RegisterWebSocketLuaListener(CS.Restifizer.WebSocketTag.FightService, "ScLeaveDungeonNtf", OnLeaveDungeonNtf)
    CS.Restifizer.RestifizerManager.Instance:RegisterWebSocketKickCallback(CS.Restifizer.WebSocketTag.FightService, function(webSocket)
      info("GameLogic", "fight kick")
      local message = WU.GetString(PB.enum.ErrorMessageBox.__keys[webSocket.DisconnectReason])
      WU.ShowMessageOK(message, function()
        if CS.FightBase.Instance ~= nil then
          EndGame("SceneCity")
        end
      end)
    end)
  end
end

function OnFightEmoteNtf(data)
  if data.dungeonId == this:GetData("Dungeon/DungeonUid") then
    this:BroadcastGameEvent("FightUI_EmoteNtf", data)
  else
    warning("GamePlay", "error data = " .. table.dump(data))
  end
end

function OnLeaveDungeonNtf(data)
  if bBalance == true then
    return
  end
  bBalance = true
  DU.LeaveDungeon(3)
end

function EndGame(scene)
  info("GamePlay", "SceneFight.EndGame( " .. scene .. " )")
  ReportTLog()
  CS.FightBase.Instance:LeaveGameLua(scene)
end

function OnChangeScene()
  enableChangeScene = true
end

function Update()
  if enableChangeScene and resultVal ~= nil then
    ProcessChangeScene()
    enableChangeScene = false
  end
end

function ProcessChangeScene()
  info("GamePlay", "ProcessChangeScene")
  local uid = this:GetData("Dungeon/DungeonUid")
  local dungeonId = this:GetData("WindowDungeon/DungeonId")
  local dungeonMonster = PB.get("DungeonMonster", dungeonId)
  local uniqueWeaponTutorial = this:GetData("uniqueWeaponTutorial")
  if uid == nil or CS.SceneFight.s_Standalone or uniqueWeaponTutorial then
    if uniqueWeaponTutorial then
      this:SetData("uniqueWeaponTutorial", false)
      CS.FightBase.Instance:TimeOutLeaveGameLua("SceneCity", 1)
    elseif resultVal == DungeonChainSetup then
      CS.FightBase.Instance:TimeOutLeaveGameLua(tostring(dungeonMonster.nextDungeonId), 1)
    else
      CS.FightBase.Instance:TimeOutLeaveGameLua("", 1)
    end
  elseif m_fightDungeonType == PB.enum.DungeonType.BurstLinkPvp then
    EndGame("SceneBalance")
  elseif m_fightDungeonType == PB.enum.DungeonType.RacePVP then
    EndGame("SceneBalance")
  elseif m_fightDungeonType == PB.enum.DungeonType.TeamPve then
    EndGame("SceneBalance")
  elseif m_fightDungeonType == PB.enum.DungeonType.FriendPvp then
    EndGame("SceneBalance")
  elseif m_fightDungeonType == PB.enum.DungeonType.RD then
    EndGame("SceneBalance")
  elseif m_fightDungeonType == PB.enum.DungeonType.AsyncPvp then
    EndGame("SceneBalance")
  elseif m_fightDungeonType == PB.enum.DungeonType.AsyncPvpV2 then
    EndGame("SceneBalance")
  elseif m_fightDungeonType == PB.enum.DungeonType.Tower then
    if resultVal == 1 then
      EndGame("SceneBalance")
    elseif resultVal == 2 then
      WU.ShowMessageOK(WU.GetString("WindowTower_DataReset"), function(result)
        if result == "OK" then
          this:SetData("SceneContext/SceneCity", "Tower")
          EndGame("SceneCity")
        end
      end)
    end
  elseif m_fightDungeonType == PB.enum.DungeonType.TowerNew then
    EndGame("SceneBalance")
  elseif m_fightDungeonType == PB.enum.DungeonType.WeekActivity then
    if resultVal == DungeonChainSetup then
      InitNextDungeonChain(dungeonMonster.nextDungeonId, uid)
    else
      EndGame("SceneBalance")
    end
  elseif m_fightDungeonType == PB.enum.DungeonType.MaidCafe then
    if resultVal == DungeonChainSetup then
      InitNextDungeonChain(dungeonMonster.nextDungeonId, uid)
    else
      EndGame("SceneBalance")
    end
  elseif m_fightDungeonType == PB.enum.DungeonType.Story or m_fightDungeonType == PB.enum.DungeonType.Normal or m_fightDungeonType == PB.enum.DungeonType.Training or m_fightDungeonType == PB.enum.DungeonType.Challenge then
    if type(resultVal) == "table" and resultVal.balanceInfo and resultVal.balanceInfo.win then
      local chapterId = this:GetData("WindowDungeon/ChapterId")
      local dungeonId = this:GetData("WindowDungeon/DungeonId")
      local cartoon = WU.GetCartoonInfo(chapterId, dungeonId, 1)
      if cartoon then
        WU.EnterCartoonLevel(cartoon.id, nil, "balance")
      else
        EndGame("SceneBalance")
      end
    elseif m_fightDungeonType == PB.enum.DungeonType.Normal and resultVal == DungeonChainSetup then
      InitNextDungeonChain(dungeonMonster.nextDungeonId, uid)
    else
      EndGame("SceneBalance")
    end
  elseif m_fightDungeonType == PB.enum.DungeonType.Gold then
    EndGame("SceneBalance")
  elseif m_fightDungeonType == PB.enum.DungeonType.Maze then
    EndGame("SceneBalance")
  elseif m_fightDungeonType == PB.enum.DungeonType.Triggered then
    EndGame("SceneBalance")
  elseif m_fightDungeonType == PB.enum.DungeonType.SemiFixed then
    EndGame("SceneBalance")
  elseif m_fightDungeonType == PB.enum.DungeonType.AssistGuild or m_fightDungeonType == PB.enum.DungeonType.ChallengeGuild then
    EndGame("SceneBalance")
  elseif m_fightDungeonType == PB.enum.DungeonType.MaidCafe then
    if resultVal == DungeonChainSetup then
      InitNextDungeonChain(dungeonMonster.nextDungeonId, uid)
    else
      EndGame("SceneBalance")
    end
  else
    error("GamePlay", "no m_fightDungeonType = " .. m_fightDungeonType)
    EndGame("SceneCity")
  end
end

function ProcessGameEnd(fightLuaTable)
  local dungeonId = this:GetData("WindowDungeon/DungeonId")
  local dungeonMonster = PB.get("DungeonMonster", dungeonId)
  fightLuaTable = ProtobufT("FightActiveData", fightLuaTable)
  TLog.CollectEndInfo(fightLuaTable)
  local selfTeam = CS.FightLuaLogic.Instance.SelfTeam
  local selfTeamWin = fightLuaTable.winTeam == selfTeam
  local isSetupNextDungeonChain = dungeonMonster and dungeonMonster.nextDungeonId > 0 and selfTeamWin
  EndRecordVideo()
  local uid = this:GetData("Dungeon/DungeonUid")
  if uid ~= nil then
    info("GamePlay", "request game end " .. uid)
    CS.FightBase.Instance:TimeOutLeaveGameLua("SceneCity", 70)
  end
  if uid == nil or CS.SceneFight.s_Standalone then
    if isSetupNextDungeonChain then
      resultVal = SetupNextDungeonChain()
    elseif dungeonMonster and dungeonMonster.nextDungeonId == 0 then
      this:SetData("FightDataRecord", fightLuaTable)
      resultVal = 1
    end
  else
    DU.SendAutoFightSetting()
    local eventActivityType = this:GetData("Event/ActivityType")
    if eventActivityType then
      this:GameRequest("fci/event-dungeon/{Dungeon/DungeonUid}/active/"):Patch(fightLuaTable, function(response)
        if isSetupNextDungeonChain then
          resultVal = SetupNextDungeonChain()
        else
          this:GameRequest("fci/event-dungeon/{Dungeon/DungeonUid}/balance"):Post({}, function(response2)
            this:SetData("DungeonBalance/result", response2)
            if ATU.UsedForAutumn(eventActivityType) then
              DB:SyncRemote(DB:GameRequest("fci/event-dungeon/record/"))
            else
              DB:SyncRemote(DB:GameRequest(string.format("fci/activity/record/%s/%s", eventActivityType, this:GetData("Event/ActivityId"))))
            end
            resultVal = 1
          end, function(error)
            resultVal = 2
            return true
          end)
        end
      end)
      return
    end
    if m_fightDungeonType == PB.enum.DungeonType.MaidCafe then
      this:GameRequest("fci/dungeon-ex/{Dungeon/DungeonUid}/active/"):Patch(fightLuaTable, function(response)
        if isSetupNextDungeonChain then
          resultVal = SetupNextDungeonChain()
        else
          this:GameRequest("fci/dungeon-ex/{Dungeon/DungeonUid}/balance"):Post({}, function(response2)
            local common = response2.dungeonExBalanceResult.common
            this:SetData("DungeonBalance/result", common)
            this:SetData("DungeonBalanceMaidCafe/result", response2)
            resultVal = 1
          end, function(error)
            resultVal = 2
            return true
          end)
        end
      end)
      return
    elseif m_fightDungeonType == PB.enum.DungeonType.AsyncPvpV2 then
      if this:GetData("FightDataRecord") == nil then
        this:GameRequest("fci/dungeon-ex/{Dungeon/DungeonUid}/active/"):Patch(fightLuaTable, function(response)
          this:GameRequest("fci/dungeon-ex/{Dungeon/DungeonUid}/balance"):Post({}, function(response2)
            this:SetData("DungeonBalance/result", response2.dungeonExBalanceResult)
            resultVal = 1
          end)
        end)
      else
        this:SetData("DungeonBalance/result", {recordMode = 1})
        resultVal = 1
      end
    elseif m_fightDungeonType == PB.enum.DungeonType.BurstLinkPvp then
      if bBalance == true then
        return
      end
      bBalance = true
      this:GameRequest("fci/BurstLinkDunBalance/"):Post({}, function(response)
        this:SetData("DungeonBalance/result", response)
        resultVal = 1
      end)
    elseif m_fightDungeonType == PB.enum.DungeonType.RD then
      if bBalance == true then
        return
      end
      bBalance = true
      this:GameRequest("fci/RDPVPDunBalance/"):Post({}, function(response)
        this:SetData("DungeonBalance/result", response)
        resultVal = 1
      end)
    elseif m_fightDungeonType == PB.enum.DungeonType.FriendPvp then
      if bBalance == true then
        return
      end
      bBalance = true
      this:GameRequest("fci/friendpvp/balance/{Dungeon/DungeonUid}"):Post({}, function(response2)
        this:SetData("DungeonBalance/result", response2)
        resultVal = 1
      end)
    elseif m_fightDungeonType == PB.enum.DungeonType.TeamPve then
      if bBalance == true then
        return
      end
      bBalance = true
      this:GameRequest("fci/teamdungeon/{Dungeon/DungeonUid}/balance/"):Post({}, function(response2)
        this:SetData("DungeonBalance/result", response2)
        resultVal = 1
      end)
    elseif m_fightDungeonType == PB.enum.DungeonType.RacePVP then
      this:GameRequest("fci/dungeon/{Dungeon/DungeonUid}/active/"):Patch(fightLuaTable, function(response)
        this:GameRequest("fci/racepvp-dungeon/{Dungeon/DungeonUid}/balance/"):Post({}, function(response2)
          this:SetData("DungeonBalance/result", response2)
          resultVal = 1
        end)
      end)
    elseif m_fightDungeonType == PB.enum.DungeonType.AsyncPvp then
      this:GameRequest("fci/tournamentdungeon/{Dungeon/DungeonUid}/active/"):Patch(fightLuaTable, function(response)
        this:GameRequest("fci/tournament/dungeonbalance/"):Post({
          activityType = this:GetData("fci/tournament/curActivityType")
        }, function(response2)
          this:SetData("DungeonBalance/result", response2)
          resultVal = 1
        end)
      end)
    elseif m_fightDungeonType == PB.enum.DungeonType.Tower then
      this:GameRequest("fci/tower-dungeon/{Dungeon/DungeonUid}/active/"):Patch(fightLuaTable, function(response)
        this:GameRequest("fci/tower-dungeon/{Dungeon/DungeonUid}/balance"):Post({}, function(response2)
          this:SetData("DungeonBalance/result", response2)
          resultVal = 1
        end, function(error)
          resultVal = 2
          return true
        end)
      end)
    elseif m_fightDungeonType == PB.enum.DungeonType.TowerNew then
      this:GameRequest("fci/extreme-challenge/{Dungeon/DungeonUid}/active/"):Patch(fightLuaTable, function(response)
        this:GameRequest("fci/extreme-challenge/{Dungeon/DungeonUid}/balance/"):Post({}, function(response2)
          this:SetData("DungeonBalance/result", response2)
          resultVal = 1
        end, function(error)
          resultVal = 2
          return true
        end)
      end)
    elseif m_fightDungeonType == PB.enum.DungeonType.WeekActivity then
      this:GameRequest("fci/dungeon/{Dungeon/DungeonUid}/active/"):Patch(fightLuaTable, function(response)
        if isSetupNextDungeonChain then
          resultVal = SetupNextDungeonChain()
        else
          this:GameRequest("fci/activity-dungeon/{Dungeon/DungeonUid}/balance/"):Post({}, function(response2)
            this:SetData("DungeonBalance/result", response2)
            resultVal = 1
          end)
        end
      end)
    elseif m_fightDungeonType == PB.enum.DungeonType.Story or m_fightDungeonType == PB.enum.DungeonType.Normal or m_fightDungeonType == PB.enum.DungeonType.Training or m_fightDungeonType == PB.enum.DungeonType.Challenge then
      this:GameRequest("fci/dungeon/{Dungeon/DungeonUid}/active/"):Patch(fightLuaTable, function(response)
        if m_fightDungeonType == PB.enum.DungeonType.Normal and isSetupNextDungeonChain then
          resultVal = SetupNextDungeonChain()
        else
          RequestBalanceNormal(response)
        end
      end)
    elseif m_fightDungeonType == PB.enum.DungeonType.Gold then
      this:GameRequest("fci/dungeon/{Dungeon/DungeonUid}/active/"):Patch(fightLuaTable, function(response)
        this:GameRequest("fci/gold-dungeon/{Dungeon/DungeonUid}/balance/"):Post({}, function(response2)
          local deadCount = #fightLuaTable.teamList[2].statistic.deadInfo
          DB:SetData("FightBeatEnemyCount", deadCount)
          this:SetData("DungeonBalance/result", response2)
          resultVal = 1
        end)
      end)
    elseif m_fightDungeonType == PB.enum.DungeonType.Maze then
      local fightLuaLogic = CS.FightLuaLogic.Instance
      local fightLuaRef = _ENV["$"](fightLuaLogic.transform)
      local fightActiveData = fightLuaRef.MainLogic["$fightActiveData"]()
      local roundTeamInfo = FH.getTeamInfo(fightActiveData.teamList, selfTeam)
      local result = RecordUseCount(roundTeamInfo.allCardList)
      local normalSkillUseCount = {}
      local linkSkillUseCount = {}
      for k, v in pairs(result) do
        if not string.starts(v, "l_") then
          normalSkillUseCount[k] = v
        else
          linkSkillUseCount[k] = v
        end
      end
      local postData = {normalSkillUseCount = normalSkillUseCount, linkSkillUseCount = linkSkillUseCount}
      local mazeActivityId = this:GetData("MazeActivityId")
      this:GameRequest("fci/maze-dungeon/{Dungeon/DungeonUid}/active/" .. mazeActivityId .. "/"):Patch(fightLuaTable, function(response)
        this:GameRequest("fci/maze-dungeon/{Dungeon/DungeonUid}/balance/" .. mazeActivityId .. "/"):Post(postData, function(response2)
          this:SetData("DungeonBalance/result", response2)
          resultVal = 1
        end)
      end)
    elseif m_fightDungeonType == PB.enum.DungeonType.Triggered then
      this:GameRequest("fci/triggered-dungeon/{Dungeon/DungeonUid}/active/"):Patch(fightLuaTable, function(response)
        this:GameRequest("fci/triggered-dungeon/{Dungeon/DungeonUid}/balance/"):Post({}, function(response2)
          this:SetData("DungeonBalance/result", response2)
          resultVal = 1
        end)
      end)
    elseif m_fightDungeonType == PB.enum.DungeonType.SemiFixed then
      this:GameRequest("fci/semifixed-dungeon/{Dungeon/DungeonUid}/active/"):Patch(fightLuaTable, function(response)
        this:GameRequest("fci/semifixed-dungeon/{Dungeon/DungeonUid}/balance/"):Post({}, function(response2)
          this:SetData("DungeonBalance/result", response2)
          resultVal = 1
        end)
      end)
    elseif m_fightDungeonType == PB.enum.DungeonType.AssistGuild or m_fightDungeonType == PB.enum.DungeonType.ChallengeGuild then
      this:GameRequest("fci/guild-dungeon/{Dungeon/DungeonUid}/active/"):Patch(fightLuaTable, function(response)
        this:GameRequest("fci/guild-dungeon/v2/{Dungeon/DungeonUid}/balance/"):Post({}, function(response2)
          this:SetData("DungeonBalance/result", response2)
          resultVal = 1
        end)
      end)
    else
      resultVal = 1
    end
  end
end

function ReportTLog()
  TLog.CollectBalanceData()
  TLog.Report()
end
