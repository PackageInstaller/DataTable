local PlayerJointDrillData_1 = class("PlayerJointDrillData_1")
local ConfigData = require("GameCore.Data.ConfigData")
local TimerManager = require("GameCore.Timer.TimerManager")
local LocalData = require("GameCore.Data.LocalData")
local ClientManager = CS.ClientManager.Instance
local ListInt = CS.System.Collections.Generic.List(CS.System.Int32)
local JointDrillContext = require("Game.UI.JointDrill.JointDrillContext")

function PlayerJointDrillData_1:Init()
  self.bInit = false
end

function PlayerJointDrillData_1:InitData()
  if not self.bInit then
    self.bInit = true
    self.nActId = 0
    self.actDataIns = nil
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

function PlayerJointDrillData_1:UnInit()
end

function PlayerJointDrillData_1:InitConfig()
  self.nMaxChallengeTime = ConfigTable.GetConfigNumber("JointDrill_Challenge_Time_Max")
  self.nOverFlowChallengeTime = ConfigTable.GetConfigNumber("JointDrill_Challenge_Time_OverFlow")
  
  local function funcForeachJointDrillLevel(line)
    CacheTable.SetField("_JointDrillLevel", line.DrillLevelGroupId, line.Difficulty, line)
  end
  
  ForEachTableLine(ConfigTable.Get("JointDrillLevel"), funcForeachJointDrillLevel)
  
  local function funcForeachJointDrillFloor(line)
    CacheTable.SetField("_JointDrillFloor", line.FloorId, line.BattleLvs, line)
  end
  
  ForEachTableLine(ConfigTable.Get("JointDrillFloor"), funcForeachJointDrillFloor)
  
  local function funcForeachJointDrillQuest(line)
    if nil == CacheTable.GetData("_JointDrillQuest", line.GroupId) then
      CacheTable.SetData("_JointDrillQuest", line.GroupId, {})
    end
    CacheTable.InsertData("_JointDrillQuest", line.GroupId, line)
  end
  
  ForEachTableLine(ConfigTable.Get("JointDrillQuest"), funcForeachJointDrillQuest)
  self.nRankCount = 0
  
  local function funcForeachJointDrillRank(line)
    self.nRankCount = self.nRankCount + 1
  end
  
  ForEachTableLine(ConfigTable.Get("JointDrillRank"), funcForeachJointDrillRank)
end

local function EncodeTempDataJson(mapData)
  local stTempData = CS.JointDrillTempData(1)
  if mapData.mapCharacterTempData ~= nil and next(mapData.mapCharacterTempData) ~= nil then
    local mapCharacterTempData = mapData.mapCharacterTempData
    local stCharacter = {}
    local tbHp = mapCharacterTempData.hpInfo
    for nCharId, mapEffect in pairs(mapCharacterTempData.effectInfo) do
      if stCharacter[nCharId] == nil then
        stCharacter[nCharId] = CS.JointDrillCharacter(nCharId, tbHp[nCharId])
      end
      for nEtfId, mapEft in pairs(mapEffect.mapEffect) do
        stCharacter[nCharId].tbEffect:Add(CS.StarTowerEffect(nEtfId, mapEft.nCount, mapEft.nCd))
      end
    end
    for nCharId, mapBuff in pairs(mapCharacterTempData.buffInfo) do
      if stCharacter[nCharId] == nil then
        stCharacter[nCharId] = CS.JointDrillCharacter(nCharId, tbHp[nCharId])
      end
      for _, buffInfo in ipairs(mapBuff) do
        stCharacter[nCharId].tbBuff:Add(CS.StarTowerBuffInfo(buffInfo.Id, buffInfo.CD, buffInfo.nNum))
      end
    end
    for nCharId, mapStatus in pairs(mapCharacterTempData.stateInfo) do
      if stCharacter[nCharId] == nil then
        stCharacter[nCharId] = CS.JointDrillCharacter(nCharId, tbHp[nCharId])
      end
      stCharacter[nCharId].stateInfo = CS.StarTowerState(mapStatus.nState, mapStatus.nStateTime)
    end
    for nCharId, mapAmmoInfo in pairs(mapCharacterTempData.ammoInfo) do
      if stCharacter[nCharId] == nil then
        stCharacter[nCharId] = CS.JointDrillCharacter(nCharId, tbHp[nCharId])
      end
      stCharacter[nCharId].ammoInfo = CS.StarTowerAmmoInfo(mapAmmoInfo.nCurAmmo, mapAmmoInfo.nAmmo1, mapAmmoInfo.nAmmo2, mapAmmoInfo.nAmmo3, mapAmmoInfo.nAmmoMax1, mapAmmoInfo.nAmmoMax2, mapAmmoInfo.nAmmoMax3)
    end
    for _, skill in ipairs(mapCharacterTempData.skillInfo) do
      stTempData.skillInfo:Add(CS.StarTowerSkill(skill.nCharId, skill.nSkillId, skill.nCd, skill.nSectionAmount, skill.nSectionResumeTime, skill.nUseTimeHint, skill.nEnergy))
    end
    stTempData.summonMonsterInfo = mapCharacterTempData.sommonInfo
    for _, st in pairs(stCharacter) do
      stTempData.characterInfo:Add(st)
    end
  end
  local mapBossTempData = mapData.mapBossTempData
  stTempData.bossInfo = mapBossTempData
  local jsonData, length = NovaAPI.ParseJointDrillDataCompressed(stTempData)
  return jsonData, length
end

local function DecodeTempDataJson(sData)
  local tempData = {}
  tempData.mapCharacterTempData = {}
  tempData.mapBossTempData = {}
  tempData.mapCharacterTempData.skillInfo = {}
  local stData = NovaAPI.DecodeJointDrillDataCompressed(sData)
  local nCount = stData.skillInfo.Count
  for index = 0, nCount - 1 do
    local stSkill = stData.skillInfo[index]
    table.insert(tempData.mapCharacterTempData.skillInfo, {
      nCharId = stSkill.nCharId,
      nSkillId = stSkill.nSkillId,
      nCd = stSkill.nCd,
      nSectionAmount = stSkill.nSectionAmount,
      nSectionResumeTime = stSkill.nSectionResumeTime,
      nUseTimeHint = stSkill.nUseTimeHint,
      nEnergy = stSkill.nEnergy
    })
  end
  local nCharCount = stData.characterInfo.Count
  for index = 0, nCharCount - 1 do
    local stChar = stData.characterInfo[index]
    local nCharId = stChar.nCharId
    local nHp = stChar.nHp
    if tempData.mapCharacterTempData.hpInfo == nil then
      tempData.mapCharacterTempData.hpInfo = {}
    end
    tempData.mapCharacterTempData.hpInfo[nCharId] = nHp
    local nEffectCount = stChar.tbEffect.Count
    if tempData.mapCharacterTempData.effectInfo == nil then
      tempData.mapCharacterTempData.effectInfo = {}
    end
    if tempData.mapCharacterTempData.effectInfo[nCharId] == nil then
      tempData.mapCharacterTempData.effectInfo[nCharId] = {
        mapEffect = {}
      }
    end
    for e = 0, nEffectCount - 1 do
      local stEffect = stChar.tbEffect[e]
      tempData.mapCharacterTempData.effectInfo[nCharId].mapEffect[stEffect.nId] = {
        nCount = stEffect.nCount,
        nCd = stEffect.nCd
      }
    end
    local nBuffCount = stChar.tbBuff.Count
    if tempData.mapCharacterTempData.buffInfo == nil then
      tempData.mapCharacterTempData.buffInfo = {}
    end
    if tempData.mapCharacterTempData.buffInfo[nCharId] == nil then
      tempData.mapCharacterTempData.buffInfo[nCharId] = {}
    end
    for b = 0, nBuffCount - 1 do
      local stBuff = stChar.tbBuff[b]
      table.insert(tempData.mapCharacterTempData.buffInfo[nCharId], {
        Id = stBuff.Id,
        CD = stBuff.CD,
        nNum = stBuff.nNum
      })
    end
    if stChar.stateInfo ~= nil then
      if tempData.mapCharacterTempData.stateInfo == nil then
        tempData.mapCharacterTempData.stateInfo = {}
      end
      tempData.mapCharacterTempData.stateInfo[nCharId] = {
        jsonStr = "",
        nState = stChar.stateInfo.nState,
        nStateTime = stChar.stateInfo.nStateTime
      }
    end
    if stChar.ammoInfo ~= nil then
      if tempData.mapCharacterTempData.ammoInfo == nil then
        tempData.mapCharacterTempData.ammoInfo = {}
      end
      tempData.mapCharacterTempData.ammoInfo[nCharId] = {
        nCurAmmo = stChar.ammoInfo.nCurAmmo,
        nAmmo1 = stChar.ammoInfo.nAmmo1,
        nAmmo2 = stChar.ammoInfo.nAmmo2,
        nAmmo3 = stChar.ammoInfo.nAmmo3,
        nAmmoMax1 = stChar.ammoInfo.nAmmoMax1,
        nAmmoMax2 = stChar.ammoInfo.nAmmoMax2,
        nAmmoMax3 = stChar.ammoInfo.nAmmoMax3
      }
    end
  end
  if stData.summonMonsterInfo ~= nil and tempData.mapCharacterTempData.sommonInfo == nil then
    tempData.mapCharacterTempData.sommonInfo = stData.summonMonsterInfo
  end
  tempData.mapBossTempData = stData.bossInfo
  return tempData
end

function PlayerJointDrillData_1:EncodeTempDataJson(mapData)
  return EncodeTempDataJson(mapData)
end

function PlayerJointDrillData_1:DecodeTempDataJson()
  if self.record ~= nil then
    return DecodeTempDataJson(self.record)
  end
end

function PlayerJointDrillData_1:CacheJointDrillData(nActId, msgData, msgBossInfo)
  self.nActId = nActId
  self.actDataIns = PlayerData.Activity:GetActivityDataById(nActId)
  self.bInBattle = msgData.LevelId ~= 0
  self.nCurLevelId = msgData.LevelId
  self.nCurLevel = msgData.Floor
  self.nStartTime = msgData.StartTime
  self.tbTeams = msgData.Teams
  self.bSimulate = msgData.Simulate
  self.nTotalScore = msgData.TotalScore
  self._EntryTime = msgData.StartTime
  self.mapBossInfo.nHp = msgBossInfo.BossHp
  self.mapBossInfo.nHpMax = msgBossInfo.BossHpMax
  self.record = msgBossInfo.Record
  if self.bInBattle then
    self:StartChallengeTime()
  else
    self:ChallengeEnd()
  end
end

function PlayerJointDrillData_1:IsJointDrillUnlock(nLevelId)
  local mapLevelCfg = ConfigTable.GetData("JointDrillLevel", nLevelId)
  if mapLevelCfg == nil then
    return false
  end
  local nPreLevelId = mapLevelCfg.PreLevelId
  if nPreLevelId == 0 then
    return true
  end
  return self.actDataIns:CheckPassedId(nPreLevelId)
end

function PlayerJointDrillData_1:GetMonsterMaxHp(nMonsterId, nDifficulty)
  return NovaAPI.GetJointDrillBossMaxHp(nMonsterId, nDifficulty)
end

function PlayerJointDrillData_1:GetMonsterName(nMonsterId)
  local sName, sIcon = "", ""
  local mapMonsterCfg = ConfigTable.GetData("Monster", nMonsterId)
  if mapMonsterCfg ~= nil then
    local nSkinId = mapMonsterCfg.FAId
    local mapSkinCfg = ConfigTable.GetData("MonsterSkin", nSkinId)
    if mapSkinCfg ~= nil then
      local nManualId = mapSkinCfg.MonsterManual
      local mapManualCfg = ConfigTable.GetData("MonsterManual", nManualId)
      if mapManualCfg ~= nil then
        sName = mapManualCfg.Name
        sIcon = mapManualCfg.Icon
      end
    end
  end
  return sName, sIcon
end

function PlayerJointDrillData_1:StartChallengeTime()
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

function PlayerJointDrillData_1:EnterJointDrill(nLevelId, nBuildId, bSimulate, nStartType, nCurLevel)
  local mapLevelCfg = ConfigTable.GetData("JointDrillLevel", nLevelId)
  if mapLevelCfg == nil then
    printError("找不到总力战关卡数据！！！levelId = " .. tostring(nLevelId))
    return
  end
  local nHp, nHpMax = 0, 0
  if self.record == nil or self.record == "" then
    nHpMax = self:GetMonsterMaxHp(mapLevelCfg.BossId, mapLevelCfg.Difficulty)
    nHp = nHpMax
  else
    local mapTemp = DecodeTempDataJson(self.record)
    if mapTemp ~= nil and mapTemp.mapBossTempData ~= nil and mapTemp.mapBossTempData.nBossId ~= 0 then
      nHpMax = mapTemp.mapBossTempData.nHpMax
      nHp = mapTemp.mapBossTempData.nHp
    end
  end
  if nHpMax == 0 then
    printError(string.format("[总力战]获取boss血量失败！！！ levelId = %s, bossId = %s", nLevelId, mapLevelCfg.BossId))
    return
  end
  
  local function enterLevel(mapNetData)
    if self.curLevel == nil then
      local luaClass = require("Game.Adventure.JointDrill.JointDrillLevelData_1")
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
    self.mapBossInfo = {}
    self.mapBossInfo.nHp = nHp
    self.mapBossInfo.nHpMax = nHpMax
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
    local msg = {
      LevelId = nLevelId,
      BuildId = nBuildId,
      BossHp = nHp,
      BossHpMax = nHpMax,
      Simulate = bSimulate
    }
    HttpNetHandler.SendMsg(NetMsgId.Id.joint_drill_apply_req, msg, nil, netCallback)
  else
    enterLevel()
  end
end

function PlayerJointDrillData_1:ChangeLevel(nLevel)
  self:EnterJointDrill(self.nCurLevelId, self.nSelectBuildId, self.bSimulate, AllEnum.JointDrillLevelStartType.ChangeLevel, nLevel)
end

function PlayerJointDrillData_1:RestartBattle()
  self:EnterJointDrill(self.nCurLevelId, self.nSelectBuildId, self.bSimulate, AllEnum.JointDrillLevelStartType.Restart, self.nCurLevel)
end

function PlayerJointDrillData_1:ContinueJointDrill(nBuildId, callback, bEditor)
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
    HttpNetHandler.SendMsg(NetMsgId.Id.joint_drill_continue_req, msg, nil, NetCallback)
  elseif callback ~= nil then
    callback()
  end
end

function PlayerJointDrillData_1:JointDrillGameOver(callback, bSettle, bEditor)
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
        local nTotalScore = self:GetTotalRankScore()
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
        local tbLastCharIds = self:GetJointDrillLastTeam()
        EventManager.Hit(EventId.OpenPanel, JointDrillContext.GetPanelId(self.nActId, "Result"), nResultType, self.nCurLevel, 0, self.nCurLevelId, self.mapBossInfo, mapScore, mapItems, mapChange, nOld, nNew, self.bSimulate, #self.tbTeams, {}, tbLastCharIds)
      end
      self:EventUpload(4, 0)
      self:ChallengeEnd()
    end
    
    HttpNetHandler.SendMsg(NetMsgId.Id.joint_drill_game_over_req, {}, nil, NetCallback)
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
      local tbLastCharIds = self:GetJointDrillLastTeam()
      EventManager.Hit(EventId.OpenPanel, JointDrillContext.GetPanelId(self.nActId, "Result"), nResultType, self.nCurLevel, 0, self.nCurLevelId, self.mapBossInfo, mapScore, mapItems, mapChange, nOld, nNew, self.bSimulate, #self.tbTeams, {}, tbLastCharIds)
    end
    self:ChallengeEnd()
  end
end

function PlayerJointDrillData_1:JointDrillGiveUp(nFloor, nTime, nDamage, nBossHp, sRecord, mapBuild, callback, bEditor)
  if not bEditor then
    self:SetRecorderExcludeIds()
    self:StopRecord()
    
    local function NetCallback(_, netMsg)
      self.record = sRecord
      self.nCurLevel = nFloor
      self.mapBossInfo.nHp = nBossHp
      if callback ~= nil then
        callback(netMsg)
      end
      if netMsg.Old ~= netMsg.New then
        self:SendJointDrillRankMsg()
      end
    end
    
    local msg = {
      Floor = nFloor,
      Time = nTime,
      Damage = nDamage,
      BossHp = nBossHp,
      Record = sRecord
    }
    HttpNetHandler.SendMsg(NetMsgId.Id.joint_drill_give_up_req, msg, nil, NetCallback)
  else
    self.record = sRecord
    self.nCurLevel = nFloor
    self.mapBossInfo.nHp = nBossHp
    if callback ~= nil then
      callback()
    end
  end
end

function PlayerJointDrillData_1:JointDrillRetreat(mapBuild, nBossHp, callback, bEditor)
  if not bEditor then
    self:SetRecorderExcludeIds(true)
    self:StopRecord()
    
    local function NetCallback(_, netMsg)
      self:RemoveJointDrillTeam(mapBuild)
      self.mapBossInfo.nHp = nBossHp
      if callback ~= nil then
        callback()
      end
    end
    
    HttpNetHandler.SendMsg(NetMsgId.Id.joint_drill_retreat_req, {}, nil, NetCallback)
  else
    self:RemoveJointDrillTeam(mapBuild)
    self.mapBossInfo.nHp = nBossHp
    if callback ~= nil then
      callback()
    end
  end
end

function PlayerJointDrillData_1:JointDrillSettle(mapBuild, nTime, nDamage, callback, bEditor)
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
    HttpNetHandler.SendMsg(NetMsgId.Id.joint_drill_settle_req, msg, nil, NetCallback)
  else
    self:AddJointDrillTeam(mapBuild, nTime, nDamage)
    self.bResetLevelSelect = true
    if callback ~= nil then
      callback()
    end
  end
end

function PlayerJointDrillData_1:JointDrillSync(nFloor, nTime, nDamage, nBossHp, nBossHpMax, sRecord, callback, bEditor)
  if not bEditor then
    local function NetCallback(_, netMsg)
      self.record = sRecord
      
      self.mapBossInfo.nHp = nBossHp
      self.mapBossInfo.nHpMax = nBossHpMax
      if callback ~= nil then
        callback()
      end
    end
    
    local msg = {
      Floor = nFloor,
      Time = nTime,
      Damage = nDamage,
      BossHp = nBossHp,
      BossHpMax = nBossHpMax,
      Record = sRecord
    }
    HttpNetHandler.SendMsg(NetMsgId.Id.joint_drill_sync_req, msg, nil, NetCallback)
  else
    self.record = sRecord
    self.mapBossInfo.nHp = nBossHp
    self.mapBossInfo.nHpMax = nBossHpMax
    if callback ~= nil then
      callback()
    end
  end
end

function PlayerJointDrillData_1:LevelEnd(nType)
  if self.curLevel ~= nil and type(self.curLevel.UnBindEvent) == "function" then
    self.curLevel:UnBindEvent()
  end
  self.curLevel = nil
  self.nGameTime = 0
  if nType ~= AllEnum.JointDrillResultType.Retreat then
    self.nSelectBuildId = 0
  end
end

function PlayerJointDrillData_1:ChallengeEnd()
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
  if self.challengeTimer ~= nil then
    self.challengeTimer:Cancel()
    self.challengeTimer = nil
  end
  self._EntryTime = 0
  self._EndTime = 0
end

function PlayerJointDrillData_1:ResetRecord(sRecord)
  self.record = sRecord
end

function PlayerJointDrillData_1:GetJointDrillLevelId()
  return self.nCurLevelId
end

function PlayerJointDrillData_1:GetJointDrillCurLevel()
  return self.nCurLevel
end

function PlayerJointDrillData_1:GetJointDrillStartTime()
  return self.nStartTime
end

function PlayerJointDrillData_1:GetJointDrillBossInfo()
  return self.mapBossInfo
end

function PlayerJointDrillData_1:GetJointDrillBuildList()
  return self.tbTeams
end

function PlayerJointDrillData_1:GetJointDrillBattleCount()
  return #self.tbTeams
end

function PlayerJointDrillData_1:GetJointDrillLastTeam()
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

function PlayerJointDrillData_1:CheckChallengeCount()
  if self.nCurLevelId ~= 0 then
    local mapLevelCfg = ConfigTable.GetData("JointDrillLevel", self.nCurLevelId)
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

function PlayerJointDrillData_1:CheckJointDrillInBattle()
  return self.bInBattle
end

function PlayerJointDrillData_1:GetMaxChallengeCount(nLevelId)
  local mapLevelCfg = ConfigTable.GetData("JointDrillLevel", nLevelId)
  if mapLevelCfg ~= nil then
    return mapLevelCfg.MaxBattleNum
  end
  return 0
end

function PlayerJointDrillData_1:SetSelBuildId(nBuildId)
  self.nSelectBuildId = nBuildId
end

function PlayerJointDrillData_1:GetCachedBuild()
  return self.nSelectBuildId
end

function PlayerJointDrillData_1:GetBossHpBarNum()
  if self.nCurLevelId ~= 0 then
    local mapCfg = ConfigTable.GetData("JointDrillLevel", self.nCurLevelId)
    if mapCfg ~= nil then
      return mapCfg.HpBarNum
    end
  end
  return 40
end

function PlayerJointDrillData_1:AddJointDrillTeam(mapBuildData, nTime, nDamage)
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

function PlayerJointDrillData_1:RemoveJointDrillTeam(mapBuildData)
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

function PlayerJointDrillData_1:SetGameTime(nTime)
  self.nGameTime = nTime
end

function PlayerJointDrillData_1:GetGameTime()
  return self.nGameTime
end

function PlayerJointDrillData_1:GetBattleSimulate()
  return self.bSimulate
end

function PlayerJointDrillData_1:AddRecordFloorList()
  local nValue = LocalData.GetPlayerLocalData("JointDrillRecordFloorId") or 0
  nValue = nValue + 1
  table.insert(self.tbRecordFloors, nValue)
  LocalData.SetPlayerLocalData("JointDrillRecordFloorId", nValue)
  NovaAPI.SetRecorderFloorId(nValue)
end

function PlayerJointDrillData_1:AddRecordExcludeId(nId)
  local nValue = LocalData.GetPlayerLocalData("JointDrillRecordExcludeId") or 0
  nValue = 1 << nId - 1 | nValue
  LocalData.SetPlayerLocalData("JointDrillRecordExcludeId", nValue)
end

function PlayerJointDrillData_1:SetRecorderExcludeIds(bRemove)
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

function PlayerJointDrillData_1:StopRecord()
  NovaAPI.StopRecord()
end

function PlayerJointDrillData_1:UploadRecordFile(sToken)
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

function PlayerJointDrillData_1:CheckActChallengeTime()
  local actData = PlayerData.Activity:GetActivityDataById(self.nActId)
  if actData ~= nil then
    local nChallengeEndTime = actData:GetChallengeEndTime()
    local nCurTime = ClientManager.serverTimeStamp
    if nChallengeEndTime <= nCurTime then
      return false
    end
    return true
  end
  return false
end

function PlayerJointDrillData_1:SetResetLevelSelect(bReset)
  self.bResetLevelSelect = bReset
end

function PlayerJointDrillData_1:GetResetLevelSelect()
  return self.bResetLevelSelect
end

function PlayerJointDrillData_1:SendJointDrillRankMsg(callback)
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

function PlayerJointDrillData_1:GetSelfRankData()
  return self.mapSelfRankData
end

function PlayerJointDrillData_1:GetRankList()
  return self.mapRankList
end

function PlayerJointDrillData_1:GetRankRewardCount()
  return self.nRankCount
end

function PlayerJointDrillData_1:GetTotalRankCount()
  return self.nTotalRank
end

function PlayerJointDrillData_1:GetLastRankRefreshTime()
  return self.nLastRefreshRankTime, self.nRankingRefreshTime
end

function PlayerJointDrillData_1:GetTotalRankScore()
  return self.nTotalScore
end

function PlayerJointDrillData_1:SendJointDrillSweepMsg(nLevelId, nCount, callback)
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

function PlayerJointDrillData_1:EventUpload(action, result)
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

return PlayerJointDrillData_1
