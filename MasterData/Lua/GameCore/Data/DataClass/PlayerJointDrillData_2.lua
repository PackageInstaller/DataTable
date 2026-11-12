local PlayerJointDrillData_2 = class("PlayerJointDrillData_2")
local ConfigData = require("GameCore.Data.ConfigData")
local TimerManager = require("GameCore.Timer.TimerManager")
local LocalData = require("GameCore.Data.LocalData")
local ClientManager = CS.ClientManager.Instance
local ListInt = CS.System.Collections.Generic.List(CS.System.Int32)
local JointDrillContext = require("Game.UI.JointDrill.JointDrillContext")

function PlayerJointDrillData_2:Init()
  self.bInit = false
end

function PlayerJointDrillData_2:InitData()
  if not self.bInit then
    self.bInit = true
    self.nActId = 0
    self.actDataIns = nil
    self.actTimer = nil
    self.bInBattle = false
    self.bResetLevelSelect = false
    self.curLevel = nil
    self.nCurLevelId = 0
    self.nCurLevel = 1
    self.nStartTime = 0
    self.nGameTime = 0
    self._EntryTime = 0
    self._EndTime = 0
    self.mapBossInfo = {}
    self.record = nil
    self.bSimulate = false
    self.tbTeams = {}
    self.nSelectBuildId = 0
    self.nChallengeCount = 0
    self.tbRecordFloors = {}
    self.nTotalScore = 0
    self.nLastRefreshRankTime = 0
    self.nRankingRefreshTime = 600
    self.mapSelfRankData = nil
    self.mapRankList = nil
    self.nTotalRank = 0
    self:InitConfig()
  end
end

function PlayerJointDrillData_2:UnInit()
end

function PlayerJointDrillData_2:InitConfig()
  self.nMaxChallengeTime = ConfigTable.GetConfigNumber("JointDrill_Challenge_Time_Max")
  self.nOverFlowChallengeTime = ConfigTable.GetConfigNumber("JointDrill_Challenge_Time_OverFlow")
  
  local function funcForeachJointDrillLevel2(line)
    CacheTable.SetField("_JointDrill_2_Level", line.DrillLevelGroupId, line.Difficulty, line)
  end
  
  ForEachTableLine(ConfigTable.Get("JointDrill_2_Level"), funcForeachJointDrillLevel2)
  
  local function funcForeachJointDrillFloor2(line)
    CacheTable.SetField("_JointDrill_2_Floor", line.FloorId, line.BattleLvs, line)
  end
  
  ForEachTableLine(ConfigTable.Get("JointDrill_2_Floor"), funcForeachJointDrillFloor2)
  self.nRankCount = 0
  
  local function funcForeachJointDrillRank(line)
    self.nRankCount = self.nRankCount + 1
  end
  
  ForEachTableLine(ConfigTable.Get("JointDrillRank"), funcForeachJointDrillRank)
end

function PlayerJointDrillData_2:CacheJointDrillData(nActId, msgData, msgBossInfo)
  self.nActId = nActId
  self.actDataIns = PlayerData.Activity:GetActivityDataById(nActId)
  self.bInBattle = msgData.LevelId ~= 0
  self.nCurLevelId = msgData.LevelId
  self.nCurLevel = msgData.Floor
  if self.bInBattle then
    local mapCfg = ConfigTable.GetData("JointDrill_2_Level", self.nCurLevelId)
    if mapCfg == nil then
      return
    end
    self:InitBossInfo(mapCfg.MonsterGroupId)
    self.mapActControl = ConfigTable.GetData("JointDrillControl", self.nActId)
    for _, v in ipairs(msgBossInfo.BossHpMaxes) do
      for nLevel, mapBoss in ipairs(self.mapBossInfo) do
        for nIndex, boss in ipairs(mapBoss) do
          if boss.nBossCfgId == v.Id then
            boss.nHpMax = v.Hp
          end
        end
      end
    end
    for _, v in ipairs(msgBossInfo.BossHps) do
      for nLevel, mapBoss in ipairs(self.mapBossInfo) do
        for nIndex, boss in ipairs(mapBoss) do
          if boss.nBossCfgId == v.Id then
            boss.nHp = v.Hp
          end
        end
      end
    end
  end
  self.nStartTime = msgData.StartTime
  self.tbTeams = msgData.Teams
  self.bSimulate = msgData.Simulate
  self.nTotalScore = msgData.TotalScore
  self._EntryTime = msgData.StartTime
  self.record = msgBossInfo.Record
  if self.bInBattle then
    self:StartChallengeTime()
  else
    self:ChallengeEnd()
  end
end

function PlayerJointDrillData_2:GetMonsterCfg(nMonsterId)
  local mapMonsterCfg = ConfigTable.GetData("Monster", nMonsterId)
  if mapMonsterCfg ~= nil then
    local nSkinId = mapMonsterCfg.FAId
    local mapSkinCfg = ConfigTable.GetData("MonsterSkin", nSkinId)
    if mapSkinCfg ~= nil then
      local nManualId = mapSkinCfg.MonsterManual
      local mapManualCfg = ConfigTable.GetData("MonsterManual", nManualId)
      if mapManualCfg ~= nil then
        return mapManualCfg
      end
    end
  end
end

function PlayerJointDrillData_2:GetMonsterMaxHp(nMonsterId, nDifficulty)
  return NovaAPI.GetJointDrillBossMaxHp(nMonsterId, nDifficulty)
end

function PlayerJointDrillData_2:InitBossInfo(nGroupId, nDifficulty)
  self.mapBossInfo = {}
  local mapCfg = ConfigTable.GetData("JointDrill_2_MonsterGroup", nGroupId)
  if mapCfg ~= nil then
    local nLevelCount = 4
    local nIndexCount = 3
    for i = 1, nLevelCount do
      self.mapBossInfo[i] = {}
      for j = 1, nIndexCount do
        local nCfgId = mapCfg["MateId_" .. (i - 1) * nIndexCount + j]
        if nCfgId == 0 then
          nCfgId = mapCfg["MateId_" .. j]
        end
        local nHp = 0
        local nHpMax = 0
        if i == 1 and nCfgId ~= 0 then
          nHpMax = self:GetMonsterMaxHp(nCfgId, nDifficulty)
          nHp = nHpMax
        end
        self.mapBossInfo[i][j] = {
          nBossCfgId = nCfgId,
          nHp = nHp,
          nHpMax = nHpMax
        }
      end
    end
  end
end

function PlayerJointDrillData_2:UpdateBossInfo(mapBossInfo)
  if mapBossInfo == nil then
    return
  end
  local nCount = mapBossInfo.Count
  for index = 0, nCount - 1 do
    local bossData = mapBossInfo[index]
    local nIndex = bossData.nIndex
    local nFloor = bossData.nFloor
    local nBossCfgId = bossData.nDataId
    if self.mapBossInfo[nFloor] ~= nil and self.mapBossInfo[nFloor][nIndex] ~= nil then
      self.mapBossInfo[nFloor][nIndex].nHp = bossData.nHp
      self.mapBossInfo[nFloor][nIndex].nHpMax = bossData.nHpMax
    else
      traceback(string.format("【总力战】更新boss血量信息失败！！！floor = %s, bossId = %s", nFloor, nBossCfgId))
    end
  end
end

function PlayerJointDrillData_2:ResetBossInfo(mapBossInfo)
  self.mapBossInfo = clone(mapBossInfo)
end

function PlayerJointDrillData_2:GetCurBossInfo()
  if self.mapBossInfo[self.nCurLevel] ~= nil then
    return self.mapBossInfo[self.nCurLevel]
  end
end

function PlayerJointDrillData_2:GetBossInfo()
  return self.mapBossInfo
end

function PlayerJointDrillData_2:IsJointDrillUnlock(nLevelId)
  local mapLevelCfg = ConfigTable.GetData("JointDrill_2_Level", nLevelId)
  if mapLevelCfg == nil then
    return false
  end
  local nPreLevelId = mapLevelCfg.PreLevelId
  if nPreLevelId == 0 then
    return true
  end
  return self.actDataIns:CheckPassedId(nPreLevelId)
end

function PlayerJointDrillData_2:StartChallengeTime()
  if self.challengeTimer ~= nil then
    self.challengeTimer:Cancel()
    self.challengeTimer = nil
  end
  local nOpenTime = self.nStartTime
  
  local function refreshTime()
    local nCurTime = CS.ClientManager.Instance.serverTimeStamp
    local nTime = self.nMaxChallengeTime - (nCurTime - nOpenTime)
    if 0 <= nTime then
      EventManager.Hit("RefreshChallengeTime", nTime)
    end
    return nTime
  end
  
  local nTime = refreshTime()
  if 0 < nTime then
    self.challengeTimer = TimerManager.Add(0, 1, nil, function()
      local nTime = refreshTime()
      if nTime <= 0 then
        self.challengeTimer:Cancel()
        self.challengeTimer = nil
        if self.curLevel ~= nil then
          self.curLevel:JointDrillTimeOut()
        end
      end
    end, true, true, true)
  end
end

function PlayerJointDrillData_2:EnterJointDrill(nLevelId, nBuildId, bSimulate, nStartType, nCurLevel)
  local mapLevelCfg = ConfigTable.GetData("JointDrill_2_Level", nLevelId)
  if mapLevelCfg == nil then
    return
  end
  
  local function enterLevel(mapNetData)
    if self.curLevel == nil then
      local luaClass = require("Game.Adventure.JointDrill.JointDrillLevelData_2")
      if luaClass == nil then
        return
      end
      self.curLevel = luaClass
      if type(self.curLevel.BindEvent) == "function" then
        self.curLevel:BindEvent()
      end
    end
    self.nCurLevelId = nLevelId
    self.bInBattle = true
    self.bSimulate = bSimulate
    if nCurLevel == nil then
      nCurLevel = self.nCurLevel
    end
    if mapNetData ~= nil then
      self.nStartTime = mapNetData.StarTime
      self._EntryTime = mapNetData.StarTime
      local sKey = LocalData.GetPlayerLocalData("JointDrillRecordKey") or ""
      if sKey ~= nil and sKey ~= "" then
        NovaAPI.DeleteRecFile(sKey)
      end
      sKey = tostring(mapNetData.StarTime)
      LocalData.SetPlayerLocalData("JointDrillRecordKey", sKey)
      LocalData.SetPlayerLocalData("JointDrillRecordFloorId", 0)
      LocalData.SetPlayerLocalData("JointDrillRecordExcludeId", 0)
      self:EventUpload(1)
    end
    self:StartChallengeTime()
    if type(self.curLevel.Init) == "function" then
      self.curLevel:Init(self, nLevelId, nBuildId, nCurLevel, nStartType)
    end
  end
  
  local function netCallback(_, netMsg)
    enterLevel(netMsg)
  end
  
  if nStartType == AllEnum.JointDrillLevelStartType.Continue then
    self:ContinueJointDrill(nBuildId, enterLevel)
  elseif nStartType == AllEnum.JointDrillLevelStartType.Start then
    self:InitBossInfo(mapLevelCfg.MonsterGroupId, mapLevelCfg.Difficulty)
    local tbBossHp = {}
    local tbBossHpMax = {}
    for _, v in ipairs(mapLevelCfg.BossId) do
      local nHp = self:GetMonsterMaxHp(v, mapLevelCfg.Difficulty)
      if nHp == 0 then
        printError(string.format("[总力战]获取boss血量失败！！！ levelId = %s, bossId = %s", nLevelId, mapLevelCfg.BossId))
        return
      end
      table.insert(tbBossHp, {Id = v, Hp = nHp})
      table.insert(tbBossHpMax, {Id = v, Hp = nHp})
    end
    local msg = {
      LevelId = nLevelId,
      BuildId = nBuildId,
      BossHps = tbBossHp,
      BossHpMaxes = tbBossHpMax,
      Simulate = bSimulate
    }
    HttpNetHandler.SendMsg(NetMsgId.Id.joint_drill_2_apply_req, msg, nil, netCallback)
  else
    enterLevel()
  end
end

function PlayerJointDrillData_2:ChangeLevel(nLevel)
  self:EnterJointDrill(self.nCurLevelId, self.nSelectBuildId, self.bSimulate, AllEnum.JointDrillLevelStartType.ChangeLevel, nLevel)
end

function PlayerJointDrillData_2:RestartBattle()
  self:EnterJointDrill(self.nCurLevelId, self.nSelectBuildId, self.bSimulate, AllEnum.JointDrillLevelStartType.Restart, self.nCurLevel)
end

function PlayerJointDrillData_2:ContinueJointDrill(nBuildId, callback, bEditor)
  if not bEditor then
    local function NetCallback(_, netMsg)
      local sKey = LocalData.GetPlayerLocalData("JointDrillRecordKey") or ""
      
      if sKey == "" or sKey ~= tostring(self.nStartTime) then
        if sKey ~= "" then
          NovaAPI.DeleteRecFile(sKey)
        end
        LocalData.SetPlayerLocalData("JointDrillRecordKey", self.nStartTime)
        LocalData.SetPlayerLocalData("JointDrillRecordFloorId", 0)
        LocalData.SetPlayerLocalData("JointDrillRecordExcludeId", 0)
      end
      if callback ~= nil then
        callback()
      end
    end
    
    local msg = {BuildId = nBuildId}
    HttpNetHandler.SendMsg(NetMsgId.Id.joint_drill_2_continue_req, msg, nil, NetCallback)
  elseif callback ~= nil then
    callback()
  end
end

function PlayerJointDrillData_2:JointDrillGameOver(callback, bSettle, bEditor)
  if not bEditor then
    self:SetRecorderExcludeIds()
    self:StopRecord()
    self._EndTime = ClientManager.serverTimeStamp
    
    local function NetCallback(_, netMsg)
      local nScoreOld = 0
      if self.mapSelfRankData ~= nil then
        nScoreOld = self.mapSelfRankData.Score
      end
      if netMsg.Old ~= netMsg.New then
        self:SendJointDrillRankMsg()
      end
      self:UploadRecordFile(netMsg.Token)
      if not self.bSimulate then
        self.nTotalScore = self.nTotalScore + netMsg.FightScore + netMsg.HpScore + netMsg.DifficultyScore
      end
      EventManager.Hit(EventId.ClosePanel, JointDrillContext.GetPanelId(self.nActId, "BuildList"))
      self.bResetLevelSelect = true
      if callback ~= nil then
        callback(netMsg)
      end
      if bSettle then
        local nResultType = AllEnum.JointDrillResultType.ChallengeEnd
        local mapScore = {}
        local nTotalScore = self.nTotalScore
        local mapChange, mapItems = {}, {}
        local nOld, nNew = 0, 0
        if netMsg ~= nil then
          mapChange = netMsg.Change or {}
          mapItems = netMsg.Items or {}
          local nScore = netMsg.FightScore + netMsg.HpScore + netMsg.DifficultyScore
          mapScore = {
            FightScore = netMsg.FightScore,
            HpScore = netMsg.HpScore,
            DifficultyScore = netMsg.DifficultyScore,
            nTotalScore = nTotalScore,
            nScore = nScore,
            nScoreOld = nScoreOld
          }
          nOld = netMsg.Old
          nNew = netMsg.New
        end
        local mapBossInfo = self.mapBossInfo[self.nCurLevel]
        local tbLastCharIds = self:GetJointDrillLastTeam()
        EventManager.Hit(EventId.OpenPanel, JointDrillContext.GetPanelId(self.nActId, "Result"), nResultType, self.nCurLevel, 0, self.nCurLevelId, mapBossInfo, mapScore, mapItems, mapChange, nOld, nNew, self.bSimulate, #self.tbTeams, {}, tbLastCharIds)
      end
      self:EventUpload(4, 0)
      self:ChallengeEnd()
    end
    
    HttpNetHandler.SendMsg(NetMsgId.Id.joint_drill_2_game_over_req, {}, nil, NetCallback)
  else
    self.bResetLevelSelect = true
    if callback ~= nil then
      callback()
    end
    if bSettle then
      local nResultType = AllEnum.JointDrillResultType.ChallengeEnd
      local mapScore = {}
      local mapChange, mapItems = {}, {}
      local nOld, nNew = 0, 0
      local mapBossInfo = self.mapBossInfo[self.nCurLevel]
      local tbLastCharIds = self:GetJointDrillLastTeam()
      EventManager.Hit(EventId.OpenPanel, JointDrillContext.GetPanelId(self.nActId, "Result"), nResultType, self.nCurLevel, 0, self.nCurLevelId, mapBossInfo, mapScore, mapItems, mapChange, nOld, nNew, self.bSimulate, #self.tbTeams, {}, tbLastCharIds)
    end
    self:ChallengeEnd()
  end
end

function PlayerJointDrillData_2:JointDrillGiveUp(nLevel, nTime, nDamage, sRecord, callback, bEditor)
  if not bEditor then
    self:SetRecorderExcludeIds()
    self:StopRecord()
    
    local function NetCallback(_, netMsg)
      self.record = sRecord
      self.nCurLevel = nLevel
      if callback ~= nil then
        callback(netMsg)
      end
      if netMsg.Old ~= netMsg.New then
        self:SendJointDrillRankMsg()
      end
    end
    
    local tbBossHps = {}
    local mapBoss = self.mapBossInfo[nLevel]
    if mapBoss ~= nil then
      for nIndex, v in ipairs(mapBoss) do
        if v.nBossCfgId ~= 0 then
          table.insert(tbBossHps, {
            Id = v.nBossCfgId,
            Hp = v.nHp
          })
        end
      end
    end
    local msg = {
      Floor = nLevel,
      Time = nTime,
      Damage = nDamage,
      BossHps = tbBossHps,
      Record = sRecord
    }
    HttpNetHandler.SendMsg(NetMsgId.Id.joint_drill_2_give_up_req, msg, nil, NetCallback)
  else
    self.record = sRecord
    self.nCurLevel = nLevel
    if callback ~= nil then
      callback()
    end
  end
end

function PlayerJointDrillData_2:JointDrillRetreat(mapBuild, callback, bEditor)
  if not bEditor then
    self:SetRecorderExcludeIds(true)
    self:StopRecord()
    
    local function NetCallback(_, netMsg)
      self:RemoveJointDrillTeam(mapBuild)
      if callback ~= nil then
        callback()
      end
    end
    
    HttpNetHandler.SendMsg(NetMsgId.Id.joint_drill_2_retreat_req, {}, nil, NetCallback)
  else
    self:RemoveJointDrillTeam(mapBuild)
    if callback ~= nil then
      callback()
    end
  end
end

function PlayerJointDrillData_2:JointDrillSettle(mapBuild, nTime, nDamage, callback, bEditor)
  if not bEditor then
    self:SetRecorderExcludeIds()
    self:StopRecord()
    self:AddJointDrillTeam(mapBuild, nTime, nDamage)
    self._EndTime = ClientManager.serverTimeStamp
    
    local function NetCallback(_, netMsg)
      self:UploadRecordFile(netMsg.Token)
      if not self.bSimulate then
        local nScore = netMsg.FightScore + netMsg.HpScore + netMsg.DifficultyScore
        self.nTotalScore = self.nTotalScore + nScore
        self.actDataIns:PassedLevel(self.nCurLevelId, nScore)
      end
      EventManager.Hit(EventId.ClosePanel, JointDrillContext.GetPanelId(self.nActId, "BuildList"))
      self.bResetLevelSelect = true
      if callback ~= nil then
        callback(netMsg)
      end
      if netMsg.Old ~= netMsg.New then
        self:SendJointDrillRankMsg()
      end
      self:EventUpload(4, 1)
    end
    
    local sKey = LocalData.GetPlayerLocalData("JointDrillRecordKey") or ""
    local tbSamples = UTILS.GetBattleSamples(sKey)
    local bSuccess, nCheckSum = NovaAPI.GetRecorderKey(sKey)
    local tbSendSample = {Sample = tbSamples, Checksum = nCheckSum}
    local msg = {
      Time = nTime,
      Damage = nDamage,
      Sample = tbSendSample,
      Events = {
        List = PlayerData.Achievement:GetBattleAchievement(GameEnum.levelType.JointDrill, true)
      }
    }
    HttpNetHandler.SendMsg(NetMsgId.Id.joint_drill_2_settle_req, msg, nil, NetCallback)
  else
    self:AddJointDrillTeam(mapBuild, nTime, nDamage)
    self.bResetLevelSelect = true
    if callback ~= nil then
      callback()
    end
  end
end

function PlayerJointDrillData_2:JointDrillSync(nLevel, nTime, nDamage, sRecord, callback, bEditor)
  if not bEditor then
    local function NetCallback(_, netMsg)
      self.record = sRecord
      
      if callback ~= nil then
        callback()
      end
    end
    
    local tbBossHp = {}
    local tbBossHpMax = {}
    if self.mapBossInfo[nLevel] ~= nil then
      for nIndex, v in ipairs(self.mapBossInfo[nLevel]) do
        if v.nBossCfgId ~= 0 then
          table.insert(tbBossHp, {
            Id = v.nBossCfgId,
            Hp = v.nHp
          })
          table.insert(tbBossHpMax, {
            Id = v.nBossCfgId,
            Hp = v.nHpMax
          })
        end
      end
    end
    local msg = {
      Floor = nLevel,
      Time = nTime,
      Damage = nDamage,
      BossHps = tbBossHp,
      BossHpMaxes = tbBossHpMax,
      Record = sRecord
    }
    HttpNetHandler.SendMsg(NetMsgId.Id.joint_drill_2_sync_req, msg, nil, NetCallback)
  else
    self.record = sRecord
    if callback ~= nil then
      callback()
    end
  end
end

function PlayerJointDrillData_2:LevelEnd(nType)
  if self.curLevel ~= nil and type(self.curLevel.UnBindEvent) == "function" then
    self.curLevel:UnBindEvent()
  end
  self.curLevel = nil
  self.nGameTime = 0
  self.mapCurBossInfo = {}
  if nType ~= AllEnum.JointDrillResultType.Retreat then
    self.nSelectBuildId = 0
  end
end

function PlayerJointDrillData_2:ChallengeEnd()
  if self.curLevel ~= nil and type(self.curLevel.UnBindEvent) == "function" then
    self.curLevel:UnBindEvent()
  end
  self.bInBattle = false
  self.curLevel = nil
  self.nCurLevelId = 0
  self.nCurLevel = 1
  self.nStartTime = 0
  self.nGameTime = 0
  self.bSimulate = false
  self.record = nil
  self.tbTeams = {}
  self.nSelectBuildId = 0
  self.tbRecordFloors = {}
  self.mapCurBossInfo = {}
  self.mapBossInfo = {}
  if self.challengeTimer ~= nil then
    self.challengeTimer:Cancel()
    self.challengeTimer = nil
  end
  self._EntryTime = 0
  self._EndTime = 0
end

function PlayerJointDrillData_2:ResetRecord(sRecord)
  self.record = sRecord
end

function PlayerJointDrillData_2:GetJointDrillLevelId()
  return self.nCurLevelId
end

function PlayerJointDrillData_2:GetJointDrillCurLevel()
  return self.nCurLevel
end

function PlayerJointDrillData_2:GetJointDrillStartTime()
  return self.nStartTime
end

function PlayerJointDrillData_2:GetJointDrillBuildList()
  return self.tbTeams
end

function PlayerJointDrillData_2:GetJointDrillBattleCount()
  return #self.tbTeams
end

function PlayerJointDrillData_2:GetJointDrillLastTeam()
  local tbChar = {}
  if #self.tbTeams > 0 then
    local tbTeam = self.tbTeams[#self.tbTeams].Chars
    if tbTeam ~= nil then
      for _, v in ipairs(tbTeam) do
        table.insert(tbChar, v.CharId)
      end
    end
  end
  return tbChar
end

function PlayerJointDrillData_2:CheckChallengeCount()
  if self.nCurLevelId ~= 0 then
    local mapLevelCfg = ConfigTable.GetData("JointDrill_2_Level", self.nCurLevelId)
    if mapLevelCfg ~= nil then
      if #self.tbTeams < mapLevelCfg.MaxBattleNum then
        return true
      else
        self:JointDrillGameOver()
        return false
      end
    end
    return false
  end
  return true
end

function PlayerJointDrillData_2:CheckJointDrillInBattle()
  return self.bInBattle
end

function PlayerJointDrillData_2:GetMaxChallengeCount(nLevelId)
  local mapLevelCfg = ConfigTable.GetData("JointDrill_2_Level", nLevelId)
  if mapLevelCfg ~= nil then
    return mapLevelCfg.MaxBattleNum
  end
  return 0
end

function PlayerJointDrillData_2:SetSelBuildId(nBuildId)
  self.nSelectBuildId = nBuildId
end

function PlayerJointDrillData_2:GetCachedBuild()
  return self.nSelectBuildId
end

function PlayerJointDrillData_2:GetBossHpBarNum()
  if self.nCurLevelId ~= 0 then
    local mapCfg = ConfigTable.GetData("JointDrill_2_Level", self.nCurLevelId)
    if mapCfg ~= nil then
      return mapCfg.HpBarNum
    end
  end
  return 40
end

function PlayerJointDrillData_2:AddJointDrillTeam(mapBuildData, nTime, nDamage)
  local bInsert = false
  for _, v in ipairs(self.tbTeams) do
    if v.BuildId == mapBuildData.nBuildId then
      bInsert = true
      v.Damage = nDamage
      v.Time = nTime
      break
    end
  end
  if not bInsert then
    local tbChar = {}
    for _, mapChar in ipairs(mapBuildData.tbChar) do
      local nCharId = mapChar.nTid
      local nLv = PlayerData.Char:GetCharLv(nCharId)
      table.insert(tbChar, {CharId = nCharId, CharLevel = nLv})
    end
    local teamData = {
      Chars = tbChar,
      BuildScore = mapBuildData.nScore,
      Damage = nDamage,
      Time = nTime,
      BuildId = mapBuildData.nBuildId
    }
    table.insert(self.tbTeams, teamData)
  end
end

function PlayerJointDrillData_2:RemoveJointDrillTeam(mapBuildData)
  local nIndex = 0
  for k, v in ipairs(self.tbTeams) do
    if v.BuildId == mapBuildData.nBuildId then
      nIndex = k
      break
    end
  end
  if nIndex ~= 0 then
    table.remove(self.tbTeams, nIndex)
  end
end

function PlayerJointDrillData_2:SetGameTime(nTime)
  self.nGameTime = nTime
end

function PlayerJointDrillData_2:GetGameTime()
  return self.nGameTime
end

function PlayerJointDrillData_2:GetBattleSimulate()
  return self.bSimulate
end

function PlayerJointDrillData_2:AddRecordFloorList()
  local nValue = LocalData.GetPlayerLocalData("JointDrillRecordFloorId") or 0
  nValue = nValue + 1
  table.insert(self.tbRecordFloors, nValue)
  LocalData.SetPlayerLocalData("JointDrillRecordFloorId", nValue)
  NovaAPI.SetRecorderFloorId(nValue)
end

function PlayerJointDrillData_2:AddRecordExcludeId(nId)
  local nValue = LocalData.GetPlayerLocalData("JointDrillRecordExcludeId") or 0
  nValue = 1 << nId - 1 | nValue
  LocalData.SetPlayerLocalData("JointDrillRecordExcludeId", nValue)
end

function PlayerJointDrillData_2:SetRecorderExcludeIds(bRemove)
  local tbFloorId = ListInt()
  if bRemove then
    for _, v in ipairs(self.tbRecordFloors) do
      self:AddRecordExcludeId(v)
    end
  end
  local nExcludeValue = LocalData.GetPlayerLocalData("JointDrillRecordExcludeId") or 0
  if 0 < nExcludeValue then
    local tbTemp = {}
    while 0 < nExcludeValue do
      table.insert(tbTemp, 1, nExcludeValue % 2)
      nExcludeValue = math.floor(nExcludeValue / 2)
    end
    for k, v in ipairs(tbTemp) do
      if v == 1 then
        tbFloorId:Add(#tbTemp - k + 1)
      end
    end
  end
  self.tbRecordFloors = {}
  NovaAPI.SetRecorderExcludeIds(tbFloorId)
end

function PlayerJointDrillData_2:StopRecord()
  NovaAPI.StopRecord()
end

function PlayerJointDrillData_2:UploadRecordFile(sToken)
  local sKey = LocalData.GetPlayerLocalData("JointDrillRecordKey") or ""
  if sKey ~= nil and sKey ~= "" then
    if sToken ~= nil and sToken ~= "" then
      NovaAPI.UploadStartowerFile(sToken, sKey)
    else
      NovaAPI.DeleteRecFile(sKey)
    end
  end
  LocalData.SetPlayerLocalData("JointDrillRecordKey", "")
end

function PlayerJointDrillData_2:CheckActChallengeTime()
  if self.actDataIns ~= nil then
    local nChallengeEndTime = self.actDataIns:GetChallengeEndTime()
    local nCurTime = ClientManager.serverTimeStamp
    if nChallengeEndTime <= nCurTime then
      return false
    end
    return true
  end
  return false
end

function PlayerJointDrillData_2:SetResetLevelSelect(bReset)
  self.bResetLevelSelect = bReset
end

function PlayerJointDrillData_2:GetResetLevelSelect()
  return self.bResetLevelSelect
end

function PlayerJointDrillData_2:SendJointDrillRankMsg(callback)
  local function NetCallback(_, netMsg)
    self.nLastRefreshRankTime = netMsg.LastRefreshTime
    
    self.mapSelfRankData = netMsg.Self
    self.mapRankList = netMsg.Rank
    self.nTotalRank = netMsg.Total or 0
    if callback ~= nil then
      callback()
    end
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.joint_drill_rank_req, {}, nil, NetCallback)
end

function PlayerJointDrillData_2:GetSelfRankData()
  return self.mapSelfRankData
end

function PlayerJointDrillData_2:GetRankList()
  return self.mapRankList
end

function PlayerJointDrillData_2:GetRankRewardCount()
  return self.nRankCount
end

function PlayerJointDrillData_2:GetTotalRankCount()
  return self.nTotalRank
end

function PlayerJointDrillData_2:GetLastRankRefreshTime()
  return self.nLastRefreshRankTime, self.nRankingRefreshTime
end

function PlayerJointDrillData_2:GetTotalRankScore()
  return self.nTotalScore
end

function PlayerJointDrillData_2:SendJointDrillSweepMsg(nLevelId, nCount, callback)
  local function NetCallback(_, netMsg)
    local mapSelfRank = self:GetSelfRankData()
    
    local nRank = 0
    local nScoreOld = 0
    if mapSelfRank ~= nil then
      nRank = mapSelfRank.Rank
      nScoreOld = mapSelfRank.Score
    end
    local nTotalScoreOld = self:GetTotalRankScore()
    local nScore = math.max(netMsg.Score - nTotalScoreOld, 0)
    local mapScore = {
      nScore = nScore,
      nTotalScore = netMsg.Score,
      nScoreOld = nScoreOld
    }
    
    local function panelCallback()
      if netMsg.Rewards ~= nil then
        local tabItem = {}
        for k, v in ipairs(netMsg.Rewards) do
          for _, item in ipairs(v.Items) do
            if tabItem[item.Tid] == nil then
              tabItem[item.Tid] = 0
            end
            tabItem[item.Tid] = tabItem[item.Tid] + item.Qty
          end
        end
        local tbShowItem = {}
        for nId, nCount in pairs(tabItem) do
          table.insert(tbShowItem, {Tid = nId, Qty = nCount})
        end
        UTILS.OpenReceiveByDisplayItem(tbShowItem, netMsg.Change, callback)
      end
    end
    
    EventManager.Hit(EventId.OpenPanel, JointDrillContext.GetPanelId(self.nActId, "RankUp"), nRank, nRank, mapScore, AllEnum.JointDrillResultType.ChallengeEnd, panelCallback)
    self.nTotalScore = netMsg.Score
    self:EventUpload(5)
  end
  
  local msg = {LevelId = nLevelId, Count = nCount}
  HttpNetHandler.SendMsg(NetMsgId.Id.joint_drill_sweep_req, msg, nil, NetCallback)
end

function PlayerJointDrillData_2:EventUpload(action, result)
  result = result or ""
  local nCostTime = 0
  if action == 4 then
    nCostTime = self._EndTime - self._EntryTime
  end
  local tabUpLevel = {}
  table.insert(tabUpLevel, {
    "action",
    tostring(action)
  })
  table.insert(tabUpLevel, {
    "role_id",
    tostring(PlayerData.Base._nPlayerId)
  })
  table.insert(tabUpLevel, {
    "game_cost_time",
    tostring(nCostTime)
  })
  table.insert(tabUpLevel, {
    "battle_id",
    tostring(self.nCurLevelId)
  })
  table.insert(tabUpLevel, {
    "battle_result",
    tostring(result)
  })
  table.insert(tabUpLevel, {
    "team_num",
    tostring(#self.tbTeams)
  })
  table.insert(tabUpLevel, {
    "simulate",
    tostring(self.bSimulate and 1 or 0)
  })
  NovaAPI.UserEventUpload("joint_drill_battle", tabUpLevel)
end

return PlayerJointDrillData_2
