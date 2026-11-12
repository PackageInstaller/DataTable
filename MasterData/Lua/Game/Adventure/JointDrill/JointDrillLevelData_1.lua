local JointDrillLevelData_1 = class("JointDrillLevelData_1")
local FP = CS.TrueSync.FP
local PB = require("pb")
local AdventureModuleHelper = CS.AdventureModuleHelper
local TimerManager = require("GameCore.Timer.TimerManager")
local LocalData = require("GameCore.Data.LocalData")
local JointDrillContext = require("Game.UI.JointDrill.JointDrillContext")
local mapEventConfig = {
  LoadLevelRefresh = "OnEvent_LoadLevelRefresh",
  AdventureModuleEnter = "OnEvent_AdventureModuleEnter",
  BattlePause = "OnEvent_Pause",
  JointDrill_StartTiming = "OnEvent_BattleStart",
  JointDrill_MonsterSpawn = "OnEvent_MonsterSpawn",
  JointDrill_WaitLvChange = "OnEvent_WaitLvChange",
  JointDrill_BattleLvsToggle = "OnEvent_BattleLvsToggle",
  ADVENTURE_LEVEL_UNLOAD_COMPLETE = "OnEvent_UnloadComplete",
  JointDrill_Gameplay_Time = "OnEvent_JointDrill_Gameplay_Time",
  JointDrill_DamageValue = "OnEvent_DamageValue",
  JointDrill_CharDamageValue = "OnEvent_CharDamageValue",
  GiveUpJointDrill = "OnEvent_GiveUpBattle",
  RestartJointDrill = "OnEvent_RestartJointDrill",
  RetreatJointDrill = "OnEvent_RetreatJointDrill",
  JointDrill_Result = "OnEvent_JointDrill_Result",
  InputEnable = "OnEvent_InputEnable",
  JointDrill_StopTime = "OnEvent_JointDrill_StopTime",
  JointDrillChallengeFinishError = "OnEvent_JointDrillChallengeFinishError",
  Upload_Dodge_Event = "OnEvent_UploadDodgeEvent"
}

function JointDrillLevelData_1:Init(parent, nLevelId, nBuildId, nCurLevel, nLevelType)
  self.parent = parent
  self.nLevelId = nLevelId
  self.nCurLevel = nCurLevel
  self.nBuildId = nBuildId
  self.nLevelType = nLevelType
  self.bChangeLevel = self.nLevelType == AllEnum.JointDrillLevelStartType.ChangeLevel
  self.bRestart = self.nLevelType == AllEnum.JointDrillLevelStartType.Restart
  self.mapLevel = nil
  self.tbFloor = {}
  self.mapFloor = nil
  self.nGameTime = self.parent:GetGameTime()
  self.bInResult = false
  self.bInProcess = false
  self.nBossId = 0
  if not self.bChangeLevel then
    self.nDamageValue = 0
    self.tbCharDamage = {}
    self.mapActorInfo = nil
  end
  self.mapTempData = {}
  if self.parent.record ~= nil and self.parent.record ~= "" then
    self.mapTempData = self.parent:DecodeTempDataJson()
    if not self.bChangeLevel then
      self.mapInitTempData = clone(self.mapTempData)
    end
  end
  if self.mapInitTempData == nil then
    self.mapInitTempData = {}
  end
  local mapJointDrillLevelData_1 = ConfigTable.GetData("JointDrillLevel", nLevelId)
  if mapJointDrillLevelData_1 == nil then
    return
  end
  self.mapLevel = mapJointDrillLevelData_1
  local nFloorGroup = mapJointDrillLevelData_1.FloorId
  self.tbFloor = CacheTable.GetData("_JointDrillFloor", nFloorGroup)
  self.mapFloor = self.tbFloor[nCurLevel]
  
  local function GetBuildCallback(mapBuildData)
    self.mapBuildData = mapBuildData
    self.parent:AddJointDrillTeam(self.mapBuildData, self.nGameTime, self.nDamageValue)
    self.tbCharId = {}
    for _, mapChar in ipairs(self.mapBuildData.tbChar) do
      table.insert(self.tbCharId, mapChar.nTid)
    end
    self.tbDiscId = {}
    for _, nDiscId in pairs(self.mapBuildData.tbDisc) do
      if 0 < nDiscId then
        table.insert(self.tbDiscId, nDiscId)
      end
    end
    if #self.tbCharDamage == 0 then
      for _, v in ipairs(self.tbCharId) do
        table.insert(self.tbCharDamage, {nCharId = v, nDamage = 0})
      end
    end
    PlayerData.nCurGameType = AllEnum.WorldMapNodeType.JointDrill
    local mapParams = {
      tostring(self.nCurLevel),
      tostring(self.bChangeLevel),
      tostring(self.nGameTime)
    }
    if not self.bChangeLevel and not self.bRestart then
      AdventureModuleHelper.EnterDynamic(self.nLevelId, self.tbCharId, GameEnum.dynamicLevelType.JointDrill, mapParams)
      NovaAPI.EnterModule("AdventureModuleScene", true, 17)
    else
      self:StartJointDrill()
      AdventureModuleHelper.EnterDynamic(self.nLevelId, self.tbCharId, GameEnum.dynamicLevelType.JointDrill, mapParams)
    end
    local sKey = LocalData.GetPlayerLocalData("JointDrillRecordKey") or ""
    safe_call_cs_func(CS.AdventureModuleHelper.SetDamageRecordId, sKey)
  end
  
  PlayerData.Build:GetBuildDetailData(GetBuildCallback, nBuildId)
end

function JointDrillLevelData_1:BindEvent()
  if type(mapEventConfig) ~= "table" then
    return
  end
  for nEventId, sCallbackName in pairs(mapEventConfig) do
    local callback = self[sCallbackName]
    if type(callback) == "function" then
      EventManager.Add(nEventId, self, callback)
    end
  end
end

function JointDrillLevelData_1:UnBindEvent()
  if type(mapEventConfig) ~= "table" then
    return
  end
  for nEventId, sCallbackName in pairs(mapEventConfig) do
    local callback = self[sCallbackName]
    if type(callback) == "function" then
      EventManager.Remove(nEventId, self, callback)
    end
  end
end

function JointDrillLevelData_1:CalCharFixedEffect(nCharId, bMainChar, tbDiscId)
  local stActorInfo = CS.Lua2CSharpInfo_CharAttribute()
  PlayerData.Char:CalCharacterAttrBattle(nCharId, stActorInfo, bMainChar, tbDiscId, self.mapBuildData.nBuildId)
  return stActorInfo
end

function JointDrillLevelData_1:SetPersonalPerk()
  if self.mapBuildData ~= nil then
    for nCharId, tbPerk in pairs(self.mapBuildData.tbPotentials) do
      local mapAddLevel = PlayerData.Char:GetCharEnhancedPotential(nCharId)
      local tbPerkInfo = {}
      for _, mapPerkInfo in ipairs(tbPerk) do
        local nAddLv = mapAddLevel[mapPerkInfo.nPotentialId] or 0
        local stPerkInfo = CS.Lua2CSharpInfo_TPPerkInfo()
        stPerkInfo.perkId = mapPerkInfo.nPotentialId
        stPerkInfo.nCount = mapPerkInfo.nLevel + nAddLv
        table.insert(tbPerkInfo, stPerkInfo)
      end
      safe_call_cs_func(AdventureModuleHelper.ChangePersonalPerkIds, tbPerkInfo, nCharId)
    end
  end
end

function JointDrillLevelData_1:SetDiscInfo()
  local tbDiscInfo = {}
  for k, nDiscId in ipairs(self.mapBuildData.tbDisc) do
    if k <= 3 then
      local discInfo = PlayerData.Disc:CalcDiscInfoInBuild(nDiscId, self.mapBuildData.tbSecondarySkill)
      table.insert(tbDiscInfo, discInfo)
    end
  end
  safe_call_cs_func(AdventureModuleHelper.SetDiscInfo, tbDiscInfo)
end

function JointDrillLevelData_1:GetSyncGameTime(nTime)
  return math.floor(tonumber(string.format("%.3f", nTime)) * 1000)
end

function JointDrillLevelData_1:CacheTempData(bCharacter, bBoss, bChangeTeam, bChangeLevel, bLockBossHp)
  if not bCharacter and not bBoss then
    return
  end
  self.mapTempData = {}
  self.mapTempData.mapCharacterTempData = {}
  self.mapTempData.mapBossTempData = {}
  if bCharacter then
    self.mapTempData.mapCharacterTempData.hpInfo = {}
    self.mapTempData.mapCharacterTempData.skillInfo = {}
    self.mapTempData.mapCharacterTempData.effectInfo = {}
    self.mapTempData.mapCharacterTempData.buffInfo = {}
    self.mapTempData.mapCharacterTempData.stateInfo = {}
    self.mapTempData.mapCharacterTempData.ammoInfo = {}
    self.mapTempData.mapCharacterTempData.sommonInfo = AdventureModuleHelper.GetSummonMonsterInfos()
    self.mapActorInfo = self:GetActorHp()
    self.mapTempData.mapCharacterTempData.hpInfo = self.mapActorInfo
    local playerids = AdventureModuleHelper.GetCurrentGroupPlayers()
    local Count = playerids.Count - 1
    for i = 0, Count do
      local charTid = AdventureModuleHelper.GetCharacterId(playerids[i])
      local clsSkillId = AdventureModuleHelper.GetPlayerSkillCd(playerids[i])
      local nStatus = AdventureModuleHelper.GetPlayerActorStatus(playerids[i])
      local nStatusTime = AdventureModuleHelper.GetPlayerActorSpecialStatusTime(playerids[i])
      local tbAmmo = AdventureModuleHelper.GetPlayerActorAmmoCount(playerids[i])
      local nAmmoType = AdventureModuleHelper.GetPlayerActorAmmoType(playerids[i])
      local jsonString = AdventureModuleHelper.GetPlayerActorLocalDataJson(playerids[i])
      print(string.format("Status:%d,Time:%d", nStatus, nStatusTime))
      if clsSkillId ~= nil then
        local tbSkillInfos = clsSkillId.skillInfos
        local nSkillCount = tbSkillInfos.Count - 1
        for j = 0, nSkillCount do
          local clsSkillInfo = tbSkillInfos[j]
          local mapSkill = ConfigTable.GetData_Skill(clsSkillInfo.skillId)
          if mapSkill == nil then
            return
          end
          if not mapSkill.IsCleanSkillCD then
            table.insert(self.mapTempData.mapCharacterTempData.skillInfo, {
              nCharId = charTid,
              nSkillId = clsSkillInfo.skillId,
              nCd = clsSkillInfo.currentUseInterval.RawValue,
              nSectionAmount = clsSkillInfo.currentSectionAmount,
              nSectionResumeTime = clsSkillInfo.currentResumeTime.RawValue,
              nUseTimeHint = clsSkillInfo.currentUseTimeHint.RawValue,
              nEnergy = clsSkillInfo.currentEnergy._raw
            })
          end
        end
      end
      self.mapTempData.mapCharacterTempData.effectInfo[charTid] = {
        mapEffect = {}
      }
      local tbClsEfts = AdventureModuleHelper.GetEffectList(playerids[i])
      if tbClsEfts ~= nil then
        local nEftCount = tbClsEfts.Count - 1
        for k = 0, nEftCount do
          local eftInfo = tbClsEfts[k]
          local mapEft = ConfigTable.GetData_Effect(eftInfo.effectConfig.Id)
          if mapEft == nil then
            return
          end
          local nCd = eftInfo.CD.RawValue
          if mapEft.Remove then
            self.mapTempData.mapCharacterTempData.effectInfo[charTid].mapEffect[eftInfo.effectConfig.Id] = {nCount = 0, nCd = nCd}
          end
        end
      end
      if self.mapEffectTriggerCount ~= nil then
        for nEftId, nCount in pairs(self.mapEffectTriggerCount) do
          if self.mapTempData.mapCharacterTempData.effectInfo[charTid].mapEffect[nEftId] == nil then
            self.mapTempData.mapCharacterTempData.effectInfo[charTid].mapEffect[nEftId] = {nCount = nCount, nCd = 0}
          else
            self.mapTempData.mapCharacterTempData.effectInfo[charTid].mapEffect[nEftId].nCount = nCount
          end
        end
      end
      local tbBuffInfo = AdventureModuleHelper.GetEntityBuffList(playerids[i])
      self.mapTempData.mapCharacterTempData.buffInfo[charTid] = {}
      if tbBuffInfo ~= nil then
        local nBuffCount = tbBuffInfo.Count - 1
        for l = 0, nBuffCount do
          local eftInfo = tbBuffInfo[l]
          local mapBuff = ConfigTable.GetData_Buff(eftInfo.buffConfig.Id)
          if mapBuff == nil then
            return
          end
          if mapBuff.NotRemove then
            table.insert(self.mapTempData.mapCharacterTempData.buffInfo[charTid], {
              Id = eftInfo.buffConfig.Id,
              CD = eftInfo:GetBuffLeftTime().RawValue,
              nNum = eftInfo:GetBuffNum()
            })
          end
        end
      end
      self.mapTempData.mapCharacterTempData.stateInfo[charTid] = {
        nState = nStatus,
        nStateTime = nStatusTime,
        jsonStr = jsonString
      }
      if tbAmmo ~= nil then
        self.mapTempData.mapCharacterTempData.ammoInfo[charTid] = {}
        self.mapTempData.mapCharacterTempData.ammoInfo[charTid].nCurAmmo = nAmmoType
        self.mapTempData.mapCharacterTempData.ammoInfo[charTid].nAmmo1 = tbAmmo[0]
        self.mapTempData.mapCharacterTempData.ammoInfo[charTid].nAmmo2 = tbAmmo[1]
        self.mapTempData.mapCharacterTempData.ammoInfo[charTid].nAmmo3 = tbAmmo[2]
        self.mapTempData.mapCharacterTempData.ammoInfo[charTid].nAmmoMax1 = tbAmmo[3]
        self.mapTempData.mapCharacterTempData.ammoInfo[charTid].nAmmoMax2 = tbAmmo[4]
        self.mapTempData.mapCharacterTempData.ammoInfo[charTid].nAmmoMax3 = tbAmmo[5]
      end
      if charTid == self.tbCharId[1] then
        self.mapTempData.mapCharacterTempData.shieldList = AdventureModuleHelper.GetEntityShieldList(playerids[i])
      end
    end
  end
  if bBoss then
    local bSaveEnergyValue = false
    local bSaveResilience = false
    if bChangeLevel then
      bSaveEnergyValue = self.mapFloor.SaveEnergyValue
      bSaveResilience = self.mapFloor.SaveResilience
    elseif bChangeTeam then
      bSaveEnergyValue = self.mapFloor.TeamSaveEnergyValue
      bSaveResilience = self.mapFloor.TeamSaveResilience
    end
    EventManager.HitEntityEvent("RefreshBossEnergyValueHUD", self.nBossId, bSaveEnergyValue)
    self.mapTempData.mapBossTempData = AdventureModuleHelper.GetJointDrillBossData(self.nBossId, bChangeTeam, bSaveEnergyValue, bSaveResilience)
    if bLockBossHp then
      if 0 >= self.mapTempData.mapBossTempData.nHp then
        self.mapTempData.mapBossTempData.nHp = 1
      end
      if 0 >= self.mapTempData.mapBossTempData.nHpMax then
        self.mapTempData.mapBossTempData.nHpMax = 1
      end
    end
  end
  local data, nDataLength = self.parent:EncodeTempDataJson(self.mapTempData)
  print("temp数据长度�?" .. #data)
  local msgInt = "proto.I32"
  local msgLength = {
    Value = #data
  }
  local dataLength = assert(PB.encode(msgInt, msgLength))
  local dataNew = dataLength .. data
  print("temp数据total长度�?" .. #dataNew)
  return data, nDataLength
end

function JointDrillLevelData_1:SetActorHP()
  local tbActorInfo = {}
  if self.mapActorInfo == nil then
    return
  end
  for nTid, nHp in pairs(self.mapActorInfo) do
    local stCharInfo = CS.Lua2CSharpInfo_ActorAttribute()
    stCharInfo.actorID = nTid
    stCharInfo.curHP = nHp
    table.insert(tbActorInfo, stCharInfo)
  end
  safe_call_cs_func(CS.AdventureModuleHelper.ResetActorAttributes, tbActorInfo)
end

function JointDrillLevelData_1:ResetBuff()
  local ret = {}
  if self.mapTempData.mapCharacterTempData ~= nil and self.mapTempData.mapCharacterTempData.buffInfo ~= nil then
    for nCharId, mapBuff in pairs(self.mapTempData.mapCharacterTempData.buffInfo) do
      for _, mapBuffInfo in ipairs(mapBuff) do
        local stBuffInfo = CS.Lua2CSharpInfo_ResetBuffInfo()
        stBuffInfo.Id = mapBuffInfo.Id
        stBuffInfo.Cd = mapBuffInfo.CD
        stBuffInfo.buffNum = mapBuffInfo.nNum
        if ret[nCharId] == nil then
          ret[nCharId] = {}
        end
        table.insert(ret[nCharId], stBuffInfo)
      end
    end
  end
  safe_call_cs_func(CS.AdventureModuleHelper.ResetBuff, ret)
end

function JointDrillLevelData_1:ResetSkill()
  local ret = {}
  if self.mapTempData.mapCharacterTempData ~= nil and self.mapTempData.mapCharacterTempData.skillInfo ~= nil then
    for _, skillInfo in ipairs(self.mapTempData.mapCharacterTempData.skillInfo) do
      local stSkillInfo = CS.Lua2CSharpInfo_ResetSkillInfo()
      stSkillInfo.skillId = skillInfo.nSkillId
      stSkillInfo.currentSectionAmount = skillInfo.nSectionAmount
      stSkillInfo.cd = skillInfo.nCd
      stSkillInfo.currentResumeTime = skillInfo.nSectionResumeTime
      stSkillInfo.currentUseTimeHint = skillInfo.nUseTimeHint
      stSkillInfo.energy = skillInfo.nEnergy
      if ret[skillInfo.nCharId] == nil then
        ret[skillInfo.nCharId] = {}
      end
      table.insert(ret[skillInfo.nCharId], stSkillInfo)
    end
  end
  safe_call_cs_func(CS.AdventureModuleHelper.ResetActorSkillInfo, ret)
end

function JointDrillLevelData_1:ResetAmmo()
  if self.mapTempData.mapCharacterTempData ~= nil and self.mapTempData.mapCharacterTempData.ammoInfo ~= nil then
    local ret = {}
    for nCharId, mapAmmo in pairs(self.mapTempData.mapCharacterTempData.ammoInfo) do
      local stInfo = CS.Lua2CSharpInfo_ActorAmmoInfo()
      local tbAmmoCount = {
        mapAmmo.nAmmo1,
        mapAmmo.nAmmo2,
        mapAmmo.nAmmo3
      }
      stInfo.actorID = nCharId
      stInfo.ammoCount = tbAmmoCount
      stInfo.ammoType = mapAmmo.nCurAmmo
      table.insert(ret, stInfo)
    end
    safe_call_cs_func(CS.AdventureModuleHelper.SetActorAmmoInfos, ret)
  end
end

function JointDrillLevelData_1:ResetSommon()
  if self.mapTempData.mapCharacterTempData ~= nil and self.mapTempData.mapCharacterTempData.sommonInfo ~= nil then
    safe_call_cs_func(CS.AdventureModuleHelper.SetSummonMonsters, self.mapTempData.mapCharacterTempData.sommonInfo)
  end
end

function JointDrillLevelData_1:ResetCharacter()
end

function JointDrillLevelData_1:GetActorHp()
  local logStr = ""
  local tbActorEntity = AdventureModuleHelper.GetCurrentGroupPlayers()
  local mapCurCharInfo = {}
  local count = tbActorEntity.Count - 1
  for i = 0, count do
    local nCharId = AdventureModuleHelper.GetCharacterId(tbActorEntity[i])
    local hp = AdventureModuleHelper.GetEntityHp(tbActorEntity[i])
    mapCurCharInfo[nCharId] = hp
    logStr = logStr .. string.format("EntityID:%d\t角色Id�?%d\t角色血量：%d\n", tbActorEntity[i], nCharId, hp)
  end
  print(logStr)
  return mapCurCharInfo
end

function JointDrillLevelData_1:JointDrillSuccess(netMsg)
  local tbSkin = {}
  for _, nCharId in ipairs(self.tbCharId) do
    local nSkinId = PlayerData.Char:GetCharSkinId(nCharId)
    table.insert(tbSkin, nSkinId)
  end
  local nScoreOld = 0
  local mapSelfRank = self.parent:GetSelfRankData()
  if mapSelfRank ~= nil then
    nScoreOld = mapSelfRank.Score
  end
  
  local function func_SettlementFinish()
  end
  
  local function levelEndCallback()
    EventManager.Remove("ADVENTURE_LEVEL_UNLOAD_COMPLETE", self, levelEndCallback)
    local nType = self.mapFloor.Theme
    local sName = ConfigTable.GetData("EndSceneType", nType).EndSceneName
    print("sceneName:" .. sName)
    AdventureModuleHelper.PlaySettlementPerform(sName, "", tbSkin, func_SettlementFinish)
  end
  
  EventManager.Add("ADVENTURE_LEVEL_UNLOAD_COMPLETE", self, levelEndCallback)
  
  local function openBattleResultPanel()
    EventManager.Remove("SettlementPerformLoadFinish", self, openBattleResultPanel)
    local nResultType = AllEnum.JointDrillResultType.Success
    local nScore = netMsg.FightScore + netMsg.HpScore + netMsg.DifficultyScore
    local mapScore = {
      FightScore = netMsg.FightScore,
      HpScore = netMsg.HpScore,
      DifficultyScore = netMsg.DifficultyScore,
      nTotalScore = self.parent.nTotalScore,
      nScore = nScore,
      nScoreOld = nScoreOld
    }
    local bSimulate = self.parent:GetBattleSimulate()
    local nBattleCount = self.parent:GetJointDrillBattleCount()
    local tbLastCharIds = self.parent:GetJointDrillLastTeam()
    EventManager.Hit(EventId.OpenPanel, JointDrillContext.GetPanelId(self.parent.nActId, "Result"), nResultType, self.nCurLevel, 0, self.nLevelId, {}, mapScore, netMsg.Items or {}, netMsg.Change or {}, netMsg.Old, netMsg.New, bSimulate, nBattleCount, self.tbCharDamage, tbLastCharIds)
    self.parent:ChallengeEnd()
  end
  
  EventManager.Add("SettlementPerformLoadFinish", self, openBattleResultPanel)
  AdventureModuleHelper.LevelStateChanged(true)
  EventManager.Hit(EventId.OpenPanel, PanelId.BattleResultMask)
end

function JointDrillLevelData_1:CheckJointDrillGameOver()
  local nChallengeCount = self.parent:GetJointDrillBattleCount()
  local nAllChallengeCount = self.parent:GetMaxChallengeCount(self.nLevelId)
  if nChallengeCount >= nAllChallengeCount then
    local nHp, nHpMax = 0, 0
    local data, nDataLength = self:CacheTempData(false, true, true)
    if self.mapTempData ~= nil and self.mapTempData.mapBossTempData ~= nil then
      nHp = self.mapTempData.mapBossTempData.nHp
      nHpMax = self.mapTempData.mapBossTempData.nHpMax
    end
    
    local function syncCallback()
      local function callback(netMsg)
        self:JointDrillFail(AllEnum.JointDrillResultType.ChallengeEnd, netMsg)
      end
      
      self.parent:JointDrillGameOver(callback)
    end
    
    self.parent:JointDrillSync(self.nCurLevel, self.nGameTime, self.nDamageValue, nHp, nHpMax, data, syncCallback)
  else
    local bBossFloor = self.mapFloor.FloorType == GameEnum.JointDrillFloorType.Boss
    local data, nDataLength = self:CacheTempData(false, bBossFloor, true, false, true)
    local mapBossInfo = self.mapTempData.mapBossTempData
    
    local function callback(netMsg)
      self:JointDrillFail(AllEnum.JointDrillResultType.BattleEnd, netMsg)
    end
    
    self.parent:JointDrillGiveUp(self.nCurLevel, self.nGameTime, self.nDamageValue, mapBossInfo.nHp, data, self.mapBuildData, callback)
  end
end

function JointDrillLevelData_1:JointDrillFail(nResultType, netMsg)
  local bossInfo = {}
  local tempBossData = self.mapTempData.mapBossTempData
  if nResultType == AllEnum.JointDrillResultType.Retreat then
    tempBossData = self.mapInitTempData.mapBossTempData
  end
  if tempBossData ~= nil then
    bossInfo.nHp = tempBossData.nHp
    bossInfo.nHpMax = tempBossData.nHpMax
  end
  local bSimulate = self.parent:GetBattleSimulate()
  local mapScore = {}
  local mapReward = {}
  local mapChange = {}
  local nOld, nNew = 0, 0
  local nScoreOld = 0
  local mapSelfRank = self.parent:GetSelfRankData()
  if mapSelfRank ~= nil then
    nScoreOld = mapSelfRank.Score
  end
  if netMsg ~= nil then
    local nScore = netMsg.FightScore + netMsg.HpScore + netMsg.DifficultyScore
    mapScore = {
      FightScore = netMsg.FightScore,
      HpScore = netMsg.HpScore,
      DifficultyScore = netMsg.DifficultyScore,
      nTotalScore = self.parent.nTotalScore,
      nScore = nScore,
      nScoreOld = nScoreOld
    }
    nOld = netMsg.Old
    nNew = netMsg.New
    mapReward = netMsg.Items or {}
    mapChange = netMsg.Change or {}
  end
  local nBattleCount = self.parent:GetJointDrillBattleCount()
  local tbLastCharIds = self.parent:GetJointDrillLastTeam()
  EventManager.Hit(EventId.OpenPanel, JointDrillContext.GetPanelId(self.parent.nActId, "Result"), nResultType, self.nCurLevel, self.nGameTime, self.nLevelId, bossInfo, mapScore, mapReward, mapChange, nOld, nNew, bSimulate, nBattleCount, self.tbCharDamage, tbLastCharIds)
  self.parent:LevelEnd(nResultType)
end

function JointDrillLevelData_1:SyncGameTime(nTime)
  nTime = nTime or 0
  self.nGameTime = math.min(self:GetSyncGameTime(nTime), self.mapLevel.BattleTime * 1000)
  self.parent:SetGameTime(self.nGameTime)
  EventManager.Hit("RefreshJointDrillGameTime", self.nGameTime)
end

function JointDrillLevelData_1:ResetGameTimer()
  if self.gameTimer ~= nil then
    self.gameTimer:Cancel()
    self.gameTimer = nil
  end
  self.bTimerStart = false
end

function JointDrillLevelData_1:StartJointDrill()
  EventManager.Hit(EventId.OpenPanel, PanelId.JointDrillBattlePanel, self.tbCharId, self.mapLevel.Id, self.mapLevel.BattleTime, GameEnum.JointDrillMode.JointDrill_Mode_1)
  self:SetPersonalPerk()
  self:SetDiscInfo()
  for idx, nCharId in ipairs(self.tbCharId) do
    local stActorInfo = self:CalCharFixedEffect(nCharId, idx == 1, self.tbDiscId)
    safe_call_cs_func(AdventureModuleHelper.SetActorAttribute, nCharId, stActorInfo)
  end
end

function JointDrillLevelData_1:OnEvent_LoadLevelRefresh()
  local mapAllEft, mapDiscEft, mapNoteEffect, tbNoteInfo = PlayerData.Build:GetBuildAllEft(self.mapBuildData.nBuildId)
  safe_call_cs_func(AdventureModuleHelper.SetNoteInfo, tbNoteInfo)
  self.mapEftData = UTILS.AddBuildEffect(mapAllEft, mapDiscEft, mapNoteEffect)
  self:ResetBuff()
  self:SetActorHP()
  self:ResetSkill()
  self.parent:AddRecordFloorList()
  PlayerData.Build:SetBuildReportInfo(self.mapBuildData.nBuildId)
end

function JointDrillLevelData_1:OnEvent_AdventureModuleEnter()
  self:StartJointDrill()
end

function JointDrillLevelData_1:OnEvent_BattleStart(nTime)
  self.bTimerStart = true
  self:SyncGameTime(nTime)
end

function JointDrillLevelData_1:OnEvent_MonsterSpawn(nBossId)
  self.nBossId = nBossId
  local bBoss = self.mapFloor.FloorType == GameEnum.JointDrillFloorType.Boss
  if bBoss and self.mapTempData ~= nil and self.mapTempData.mapBossTempData ~= nil then
    AdventureModuleHelper.SetJointDrillBossData(nBossId, self.mapTempData.mapBossTempData)
  end
  if self.bChangeLevel then
    return
  end
  local data, nDataLength = self:CacheTempData(false, bBoss, true)
  local nHp, nHpMax = 1, 1
  if self.mapTempData ~= nil and self.mapTempData.mapBossTempData ~= nil then
    nHp = self.mapTempData.mapBossTempData.nHp
    nHpMax = self.mapTempData.mapBossTempData.nHpMax
  end
  self.parent:JointDrillSync(self.nCurLevel, self.nGameTime, self.nDamageValue, nHp, nHpMax, data)
  self.mapInitTempData = clone(self.mapTempData)
end

function JointDrillLevelData_1:OnEvent_WaitLvChange()
  if self.bInProcess then
    return
  end
  self.bInProcess = true
  self.bChangeLevel = true
  self.bRestart = false
  EventManager.Hit("CloseJointDrillPause")
  EventManager.Hit(EventId.CloseMessageBox)
  PanelManager.InputDisable()
  EventManager.Hit(EventId.BlockInput, true)
end

function JointDrillLevelData_1:OnEvent_BattleLvsToggle(nBattleLv, nTotalTime, nDamageValue)
  if nBattleLv < self.nCurLevel then
    return
  end
  if not self.bChangeLevel then
    return
  end
  nTotalTime = math.min(self.mapLevel.BattleTime * 1000, self:GetSyncGameTime(nTotalTime))
  self.nCurLevel = nBattleLv + 1
  self.nDamageValue = self.nDamageValue + nDamageValue
  self.mapFloor = self.tbFloor[self.nCurLevel]
  local bBoss = self.mapFloor.FloorType == GameEnum.JointDrillFloorType.Boss
  self:CacheTempData(true, bBoss, false, true, true)
  self.parent:AddJointDrillTeam(self.mapBuildData, nTotalTime, self.nDamageValue)
  self.parent:StopRecord()
  
  local function func()
    local function syncCallback()
      PanelManager.InputEnable()
      
      EventManager.Hit("CloseJointDrillPause")
      EventManager.Hit(EventId.CloseMessageBox)
      
      local function wait()
        coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
        EventManager.Hit(EventId.BlockInput, false)
        AdventureModuleHelper.LevelStateChanged(false)
      end
      
      cs_coroutine.start(wait)
      EventManager.Hit("ResetBossHUD")
    end
    
    local data, nDataLength = self.parent:EncodeTempDataJson(self.mapTempData)
    local nHp, nHpMax = 1, 1
    local tempBossData = self.mapTempData.mapBossTempData
    if tempBossData ~= nil then
      nHp = math.max(tempBossData.nHp, 1)
      nHpMax = math.max(tempBossData.nHpMax, 1)
    end
    self.parent:JointDrillSync(self.nCurLevel, nTotalTime, self.nDamageValue, nHp, nHpMax, data, syncCallback)
  end
  
  EventManager.Hit(EventId.SetTransition, 3, func)
end

function JointDrillLevelData_1:OnEvent_UnloadComplete()
  if self.bInResult == true then
    return
  end
  if self.bRestart then
    self.parent:RestartBattle()
  else
    self.parent:ChangeLevel(self.nCurLevel)
  end
  self:ResetCharacter()
end

function JointDrillLevelData_1:OnEvent_JointDrill_Gameplay_Time(nTime)
  self:SyncGameTime(nTime)
end

function JointDrillLevelData_1:OnEvent_Pause()
  if self.nBossId ~= 0 then
    EventManager.Hit("OpenJointDrillPause", self.nLevelId, self.tbCharId, self.nGameTime)
  end
end

function JointDrillLevelData_1:OnEvent_DamageValue(nDamageValue)
  self.nDamageValue = self.nDamageValue + nDamageValue
end

function JointDrillLevelData_1:OnEvent_GiveUpBattle()
  self.parent:AddJointDrillTeam(self.mapBuildData, self.nGameTime, self.nDamageValue)
  self:CheckJointDrillGameOver()
end

function JointDrillLevelData_1:OnEvent_RestartJointDrill()
  if self.bInProcess then
    return
  end
  self.bInProcess = true
  self.bRestart = true
  self.bChangeLevel = false
  self.parent:SetGameTime(0)
  AdventureModuleHelper.ClearCharacterDamageRecord(true)
  local sRecord = self.parent:EncodeTempDataJson(self.mapInitTempData)
  self.parent:ResetRecord(sRecord)
  self.parent:SetRecorderExcludeIds(true)
  AdventureModuleHelper.LevelStateChanged(false)
  EventManager.Hit("ResetBossHUD")
  EventManager.Hit("JointDrillReset")
end

function JointDrillLevelData_1:OnEvent_RetreatJointDrill()
  self.bInProcess = true
  
  local function callback()
    local sRecord = self.parent:EncodeTempDataJson(self.mapInitTempData)
    self.parent:ResetRecord(sRecord)
    self:JointDrillFail(AllEnum.JointDrillResultType.Retreat)
  end
  
  local nHp = 1
  if self.mapInitTempData ~= nil and self.mapInitTempData.mapBossTempData ~= nil then
    nHp = self.mapInitTempData.mapBossTempData.nHp
  end
  self.parent:JointDrillRetreat(self.mapBuildData, nHp, callback)
end

function JointDrillLevelData_1:OnEvent_JointDrill_Result(nLevelState, nTotalTime, nDamageValue)
  if self.bInResult then
    return
  end
  nTotalTime = math.min(self.mapLevel.BattleTime * 1000, self:GetSyncGameTime(nTotalTime))
  self.bInResult = true
  self.nDamageValue = self.nDamageValue + nDamageValue
  if nLevelState == GameEnum.levelState.Failed then
    self.parent:AddJointDrillTeam(self.mapBuildData, self.nGameTime, self.nDamageValue)
    self:CheckJointDrillGameOver()
  elseif nLevelState == GameEnum.levelState.Success then
    local function callback(netMsg)
      self:JointDrillSuccess(netMsg)
    end
    
    self.parent:JointDrillSettle(self.mapBuildData, self.nGameTime, self.nDamageValue, callback)
  end
end

function JointDrillLevelData_1:JointDrillTimeOut()
  if self.bInResult then
    return
  end
  self.bInResult = true
  NovaAPI.DispatchEventWithData("JointDrill_Level_TimeOut")
  local nHp, nHpMax = 0, 0
  local data, nDataLength = self:CacheTempData(false, true, true)
  if self.mapTempData ~= nil and self.mapTempData.mapBossTempData ~= nil then
    nHp = self.mapTempData.mapBossTempData.nHp
    nHpMax = self.mapTempData.mapBossTempData.nHpMax
  end
  
  local function syncCallback()
    local function callback(netMsg)
      self:JointDrillFail(AllEnum.JointDrillResultType.ChallengeEnd, netMsg)
    end
    
    self.parent:AddJointDrillTeam(self.mapBuildData, self.nGameTime, self.nDamageValue)
    self.parent:JointDrillGameOver(callback)
  end
  
  self.parent:JointDrillSync(self.nCurLevel, self.nGameTime, self.nDamageValue, nHp, nHpMax, data, syncCallback)
end

function JointDrillLevelData_1:OnEvent_CharDamageValue(charDamageValue)
  for nCharId, nValue in pairs(charDamageValue) do
    for _, v in ipairs(self.tbCharDamage) do
      if v.nCharId == nCharId then
        v.nDamage = v.nDamage + nValue
        break
      end
    end
  end
end

function JointDrillLevelData_1:OnEvent_InputEnable(bEnable)
end

function JointDrillLevelData_1:OnEvent_JointDrill_StopTime()
end

function JointDrillLevelData_1:OnEvent_JointDrillChallengeFinishError()
  self:JointDrillFail(AllEnum.JointDrillResultType.ChallengeEnd)
  EventManager.Hit(EventId.ClosePanel, JointDrillContext.GetPanelId(self.parent.nActId, "BuildList"))
  self.parent:ChallengeEnd()
end

function JointDrillLevelData_1:OnEvent_UploadDodgeEvent(padMode)
  local tab = {}
  table.insert(tab, {
    "role_id",
    tostring(PlayerData.Base._nPlayerId)
  })
  table.insert(tab, {"pad_mode", padMode})
  table.insert(tab, {"level_type", "JointDrill"})
  table.insert(tab, {
    "build_id",
    tostring(self.nBuildId)
  })
  table.insert(tab, {
    "level_id",
    tostring(self.nLevelId)
  })
  table.insert(tab, {
    "up_time",
    tostring(CS.ClientManager.Instance.serverTimeStamp)
  })
  NovaAPI.UserEventUpload("use_dodge_key", tab)
end

return JointDrillLevelData_1
