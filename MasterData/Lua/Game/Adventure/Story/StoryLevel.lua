local StoryLevel = class("StoryLevel")
local Actor2DManager = require("Game.Actor2D.Actor2DManager")
local mapEventConfig = {
  LevelStateChanged = "OnEvent_SendMsgFinishBattle",
  [EventId.AbandonBattle] = "OnEvent_AbandonBattle",
  LoadLevelRefresh = "OnEvent_LoadLevelRefresh",
  Mainline_Time_CountUp = "OnEvent_Time",
  BattlePause = "OnEvnet_Pause",
  AdventureModuleEnter = "OnEvent_AdventureModuleEnter"
}

function StoryLevel:Init(parent, nLevelId, nBuildId, bActivityStory)
  self.bSettle = false
  self.parent = parent
  self.nMainLineTime = 0
  self.nCacheFloorTime = 0
  self.nLevelId = nLevelId
  self.curFloorIdx = 1
  self.mapCharacterTempData = {}
  self.bActivityStory = bActivityStory == true
  local mapStory = bActivityStory == true and ConfigTable.GetData("ActivityStory", nLevelId) or ConfigTable.GetData_Story(nLevelId)
  if mapStory == nil then
    printError("mapStory is nil,id = " .. nLevelId)
    return
  end
  self.bTrialLevel = mapStory.TrialBuild ~= nil and nBuildId == 0
  
  local function GetBuildCallback(mapBuildData)
    self.mapBuildData = mapBuildData
    self.tbCharId, self.tbCharTrialId = {}, {}
    for _, mapChar in ipairs(self.mapBuildData.tbChar) do
      table.insert(self.tbCharId, mapChar.nTid)
      self.tbCharTrialId[mapChar.nTid] = mapChar.nTrialId
    end
    self.tbDiscId = {}
    for _, nDiscId in ipairs(self.mapBuildData.tbDisc) do
      if 0 < nDiscId then
        table.insert(self.tbDiscId, nDiscId)
      end
    end
    if bActivityStory then
      PlayerData.nCurGameType = AllEnum.WorldMapNodeType.ActivityStory
      CS.AdventureModuleHelper.EnterActivityStoryLevelsInstance(mapStory.FloorId[1], self.tbCharId)
    else
      PlayerData.nCurGameType = AllEnum.WorldMapNodeType.Mainline
      CS.AdventureModuleHelper.EnterMainlineMap(mapStory.FloorId[1], self.tbCharId, {})
    end
    NovaAPI.EnterModule("AdventureModuleScene", true, 17)
  end
  
  if self.bTrialLevel then
    local mapBuildData = PlayerData.Build:GetTrialBuild(mapStory.TrialBuild)
    GetBuildCallback(mapBuildData)
  else
    PlayerData.Build:GetBuildDetailData(GetBuildCallback, nBuildId)
  end
end

function StoryLevel:RefreshCharDamageData()
  self.tbCharDamage = UTILS.GetCharDamageResult(self.tbCharId)
  for k, v in pairs(self.tbCharDamage) do
    local mapSkin = ConfigTable.GetData_CharacterSkin(PlayerData.Char:GetCharSkinId(v.nCharId))
    if mapSkin ~= nil then
      v.nSkinId = mapSkin.Id
    end
  end
end

function StoryLevel:OnEvent_LoadLevelRefresh()
  local mapAllEft, mapDiscEft, mapNoteEffect, tbNoteInfo = PlayerData.Build:GetBuildAllEft(self.mapBuildData.nBuildId)
  safe_call_cs_func(CS.AdventureModuleHelper.SetNoteInfo, tbNoteInfo)
  self.mapEftData = UTILS.AddBuildEffect(mapAllEft, mapDiscEft, mapNoteEffect)
  self:ResetCharacter()
end

function StoryLevel:OnEvent_SendMsgFinishBattle(LevelResult, FadeTime, sVideoName)
  if self.bSettle == true then
    print("已在结算流程中！")
    return
  end
  self.bSettle = true
  print("OnEvent_SendMsgFinishBattle")
  local fadeT = 0
  if FadeTime ~= nil then
    fadeT = FadeTime
  end
  if LevelResult == AllEnum.LevelResult.Failed then
    self:OnEvent_AbandonBattle()
    return
  end
  local mapStory = self.bActivityStory == true and ConfigTable.GetData("ActivityStory", self.nLevelId) or ConfigTable.GetData_Story(self.nLevelId)
  if self.curFloorIdx < #mapStory.FloorId then
    self:ChangeFloor()
    return
  end
  
  local function func_cbFinishSucc(mapChangeInfo)
    self:PlaySuccessPerform(fadeT, mapChangeInfo, sVideoName)
  end
  
  print("====== 当前通关主线关卡ID：" .. self.nLevelId .. " ======")
  local events = {
    List = PlayerData.Achievement:GetBattleAchievement(GameEnum.levelType.Mainline, LevelResult ~= AllEnum.LevelResult.Failed)
  }
  if self.bActivityStory then
    self.parent:SendMsg_STORY_DONE(func_cbFinishSucc, events)
  else
    PlayerData.Avg:SendMsg_STORY_DONE(func_cbFinishSucc, events)
  end
end

function StoryLevel:OnEvent_AbandonBattle()
  self:RefreshCharDamageData()
  if self.nLevelId > 0 then
    local nMainlineId = self.nLevelId
    EventManager.Hit(EventId.OpenPanel, PanelId.BattleResult, false, 0, {}, {}, {}, 0, false, "", "", nMainlineId, self.tbCharId, {}, self.tbCharDamage)
    self:UnBindEvent()
    self.parent:LevelEnd()
  end
end

function StoryLevel:OnEvent_AdventureModuleEnter()
  PlayerData.Achievement:SetSpecialBattleAchievement(GameEnum.levelType.Mainline)
  local mapStory = self.bActivityStory == true and ConfigTable.GetData("ActivityStory", self.nLevelId) or ConfigTable.GetData_Story(self.nLevelId)
  local nMapId = mapStory and mapStory.FloorId[self.curFloorIdx]
  EventManager.Hit(EventId.OpenPanel, PanelId.Adventure, self.tbCharId, nMapId)
  self:SetPersonalPerk()
  self:SetDiscInfo()
  for idx, nCharId in ipairs(self.tbCharId) do
    local stActorInfo = self:CalCharFixedEffect(nCharId, idx == 1, self.tbDiscId)
    safe_call_cs_func(CS.AdventureModuleHelper.SetActorAttribute, nCharId, stActorInfo)
  end
end

function StoryLevel:BindEvent()
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

function StoryLevel:UnBindEvent()
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

function StoryLevel:PlaySuccessPerform(FadeTime, mapChangeInfo, sVideoName)
  local function func_SettlementFinish(bSuccess)
  end
  
  local bHasReward = mapChangeInfo and mapChangeInfo.Props and #mapChangeInfo.Props > 0
  local FirstRewardItems = {}
  if bHasReward then
    local tbRewardDisplay = UTILS.DecodeChangeInfo(mapChangeInfo)
    for _, v in pairs(tbRewardDisplay) do
      for k, value in pairs(v) do
        table.insert(FirstRewardItems, {
          Tid = value.Tid,
          Qty = value.Qty,
          rewardType = AllEnum.RewardType.First
        })
      end
    end
  end
  local tbChar = self.tbCharId
  self:RefreshCharDamageData()
  
  local function openBattleResultPanel()
    EventManager.Remove("SettlementPerformLoadFinish", self, openBattleResultPanel)
    local sLarge, sSmall = "", ""
    EventManager.Hit(EventId.OpenPanel, PanelId.BattleResult, true, 3, {}, FirstRewardItems or {}, {}, 0, false, sLarge, sSmall, self.nLevelId, self.tbCharId, mapChangeInfo, self.tbCharDamage)
    self.bSettle = false
    self.parent:LevelEnd()
    self:UnBindEvent()
  end
  
  local function levelEndCallback()
    EventManager.Remove("ADVENTURE_LEVEL_UNLOAD_COMPLETE", self, levelEndCallback)
    EventManager.Hit(EventId.SetTransition)
    
    local function videoCallback()
      EventManager.Remove("VIDEO_END", self, videoCallback)
      EventManager.Hit(EventId.OpenPanel, PanelId.BattleResultMask)
      local storyCfg = self.bActivityStory == true and ConfigTable.GetData("ActivityStory", self.nLevelId) or ConfigTable.GetData_Story(self.nLevelId)
      local nFloorCount = #storyCfg.FloorId
      local nMapId = storyCfg.FloorId[nFloorCount]
      local nType = self.bActivityStory == true and ConfigTable.GetData("ActivityLevelsFloor", nMapId).Theme or ConfigTable.GetData("MainlineFloor", nMapId).Theme
      local sName = ConfigTable.GetData("EndSceneType", nType).EndSceneName
      EventManager.Add("SettlementPerformLoadFinish", self, openBattleResultPanel)
      local tbSkin = {}
      for _, nCharId in ipairs(tbChar) do
        local nSkinId = PlayerData.Char:GetCharSkinId(nCharId)
        table.insert(tbSkin, nSkinId)
      end
      CS.AdventureModuleHelper.PlaySettlementPerform(sName, "", tbSkin, func_SettlementFinish)
    end
    
    if sVideoName ~= nil and sVideoName ~= "" then
      EventManager.Add("VIDEO_END", self, videoCallback)
      EventManager.Hit(EventId.OpenPanel, PanelId.ProVideoGUI, sVideoName, true, 0.5, false, 0, true)
    else
      videoCallback()
    end
  end
  
  EventManager.Add("ADVENTURE_LEVEL_UNLOAD_COMPLETE", self, levelEndCallback)
  CS.AdventureModuleHelper.LevelStateChanged(true, FadeTime or 0.5)
end

function StoryLevel:CalCharFixedEffect(nCharId, bMainChar, tbDiscId)
  local stActorInfo = CS.Lua2CSharpInfo_CharAttribute()
  PlayerData.Build:CalBuildCharacterAttrBattle(self.mapBuildData.nBuildId, nCharId, self.tbCharTrialId and self.tbCharTrialId[nCharId], stActorInfo, bMainChar, tbDiscId)
  return stActorInfo
end

function StoryLevel:SetPersonalPerk()
  if self.mapBuildData ~= nil then
    for nCharId, tbPerk in pairs(self.mapBuildData.tbPotentials) do
      local mapAddLevel = PlayerData.Build:GetBuildEnhancedPotential(self.mapBuildData.nBuildId, nCharId, self.tbCharTrialId and self.tbCharTrialId[nCharId])
      local tbPerkInfo = {}
      for _, mapPerkInfo in ipairs(tbPerk) do
        local nAddLv = mapAddLevel[mapPerkInfo.nPotentialId] or 0
        local stPerkInfo = CS.Lua2CSharpInfo_TPPerkInfo()
        stPerkInfo.perkId = mapPerkInfo.nPotentialId
        stPerkInfo.nCount = mapPerkInfo.nLevel + nAddLv
        table.insert(tbPerkInfo, stPerkInfo)
      end
      safe_call_cs_func(CS.AdventureModuleHelper.ChangePersonalPerkIds, tbPerkInfo, nCharId)
    end
  end
end

function StoryLevel:SetDiscInfo()
  local tbDiscInfo = {}
  for k, nDiscId in ipairs(self.mapBuildData.tbDisc) do
    if k <= 3 then
      local discInfo = PlayerData.Build:GetBuildDiscInfoInBuild(self.mapBuildData.nBuildId, nDiscId, self.mapBuildData.tbSecondarySkill)
      table.insert(tbDiscInfo, discInfo)
    end
  end
  safe_call_cs_func(CS.AdventureModuleHelper.SetDiscInfo, tbDiscInfo)
end

function StoryLevel:OnEvent_Time(nTime)
  self.nMainLineTime = self.nCacheFloorTime + nTime
end

function StoryLevel:OnEvnet_Pause()
  local sAim = self.bActivityStory == true and ConfigTable.GetData("ActivityStory", self.nLevelId).Aim or ConfigTable.GetData_Story(self.nLevelId).Aim
  if not self.bActivityStory then
    local mapStory = ConfigTable.GetData_Story(self.nLevelId)
    if mapStory == nil then
      printError("mapStory is nil,id = " .. self.nLevelId)
      return
    end
    if mapStory.EnterMethod == GameEnum.EnterMethod.JumpFormationPause then
      EventManager.Hit(EventId.OpenPanel, PanelId.ChapterPausePanel, self.nMainLineTime or 0, self.mapBuildData.tbChar, sAim)
      return
    end
  end
  EventManager.Hit(EventId.OpenPanel, PanelId.MainBattlePause, self.nMainLineTime or 0, self.mapBuildData.tbChar, sAim)
end

function StoryLevel:ChangeFloor()
  self:CacheTempData()
  local mapStory = self.bActivityStory == true and ConfigTable.GetData("ActivityStory", self.nLevelId) or ConfigTable.GetData_Story(self.nLevelId)
  self.curFloorIdx = self.curFloorIdx + 1
  self.nCacheFloorTime = self.nMainLineTime
  
  local function levelUnloadCallback()
    EventManager.Remove("ADVENTURE_LEVEL_UNLOAD_COMPLETE", self, levelUnloadCallback)
    self:SetPersonalPerk()
    self:SetDiscInfo()
    for idx, nCharId in ipairs(self.tbCharId) do
      local stActorInfo = self:CalCharFixedEffect(nCharId, idx == 1, self.tbDiscId)
      safe_call_cs_func(CS.AdventureModuleHelper.SetActorAttribute, nCharId, stActorInfo)
    end
    self:SetCharStatus()
  end
  
  EventManager.Add("ADVENTURE_LEVEL_UNLOAD_COMPLETE", self, levelUnloadCallback)
  if self.bActivityStory then
    CS.AdventureModuleHelper.EnterActivityStoryLevelsInstance(mapStory.FloorId[self.curFloorIdx], self.tbCharId)
  else
    CS.AdventureModuleHelper.EnterMainlineMap(mapStory.FloorId[self.curFloorIdx], self.tbCharId, {})
  end
  CS.AdventureModuleHelper.LevelStateChanged(false)
  self.bSettle = false
end

function StoryLevel:SetCharStatus()
  local nStatus = 0
  local nStatusTime = 0
  local tbActorInfo = {}
  for _, nTid in pairs(self.tbCharId) do
    local stCharInfo = CS.Lua2CSharpInfo_ActorStatus()
    if self.mapCharacterTempData.stateInfo ~= nil and self.mapCharacterTempData.stateInfo[nTid] ~= nil then
      nStatus = self.mapCharacterTempData.stateInfo[nTid].nState
      nStatusTime = self.mapCharacterTempData.stateInfo[nTid].nStateTime
    end
    stCharInfo.actorID = nTid
    stCharInfo.status = nStatus
    stCharInfo.specialStatusTime = nStatusTime
    table.insert(tbActorInfo, stCharInfo)
  end
  safe_call_cs_func(CS.AdventureModuleHelper.SetActorStatus, tbActorInfo)
end

function StoryLevel:ResetCharacter()
  if self.mapCharacterTempData.hpInfo ~= nil then
    local tbActorInfo = {}
    for nTid, nHp in pairs(self.mapCharacterTempData.hpInfo) do
      local stCharInfo = CS.Lua2CSharpInfo_ActorAttribute()
      stCharInfo.actorID = nTid
      stCharInfo.curHP = nHp
      table.insert(tbActorInfo, stCharInfo)
    end
    safe_call_cs_func(CS.AdventureModuleHelper.ResetActorAttributes, tbActorInfo)
  end
  if self.mapCharacterTempData.skillInfo ~= nil then
    local tbSkillInfos = {}
    for _, skillInfo in ipairs(self.mapCharacterTempData.skillInfo) do
      local stSkillInfo = CS.Lua2CSharpInfo_ResetSkillInfo()
      stSkillInfo.skillId = skillInfo.nSkillId
      stSkillInfo.currentSectionAmount = skillInfo.nSectionAmount
      stSkillInfo.cd = skillInfo.nCd
      stSkillInfo.currentResumeTime = skillInfo.nSectionResumeTime
      stSkillInfo.currentUseTimeHint = skillInfo.nUseTimeHint
      stSkillInfo.energy = skillInfo.nEnergy
      if tbSkillInfos[skillInfo.nCharId] == nil then
        tbSkillInfos[skillInfo.nCharId] = {}
      end
      table.insert(tbSkillInfos[skillInfo.nCharId], stSkillInfo)
    end
    safe_call_cs_func(CS.AdventureModuleHelper.ResetActorSkillInfo, tbSkillInfos)
  end
  if self.mapCharacterTempData.buffInfo ~= nil then
    local tbBuffinfo = {}
    for nCharId, mapBuff in pairs(self.mapCharacterTempData.buffInfo) do
      if mapBuff.mapBuff ~= nil then
        for _, mapBuffInfo in pairs(mapBuff.mapBuff) do
          local stBuffInfo = CS.Lua2CSharpInfo_ResetBuffInfo()
          stBuffInfo.Id = mapBuffInfo.Id
          stBuffInfo.Cd = mapBuffInfo.CD
          stBuffInfo.buffNum = mapBuffInfo.nNum
          if tbBuffinfo[nCharId] == nil then
            tbBuffinfo[nCharId] = {}
          end
          table.insert(tbBuffinfo[nCharId], stBuffInfo)
        end
      end
    end
    safe_call_cs_func(CS.AdventureModuleHelper.ResetBuff, tbBuffinfo)
  end
end

function StoryLevel:CacheTempData()
  local FP = CS.TrueSync.FP
  self.mapCharacterTempData = {}
  local AdventureModuleHelper = CS.AdventureModuleHelper
  local id = AdventureModuleHelper.GetCurrentActivePlayer()
  self.mapCharacterTempData.curCharId = CS.AdventureModuleHelper.GetCharacterId(id)
  self.mapCharacterTempData.skillInfo = {}
  self.mapCharacterTempData.effectInfo = {}
  self.mapCharacterTempData.buffInfo = {}
  self.mapCharacterTempData.hpInfo = {}
  self.mapCharacterTempData.stateInfo = {}
  local playerids = AdventureModuleHelper.GetCurrentGroupPlayers()
  local Count = playerids.Count - 1
  for i = 0, Count do
    local charTid = AdventureModuleHelper.GetCharacterId(playerids[i])
    local clsSkillId = AdventureModuleHelper.GetPlayerSkillCd(playerids[i])
    local nStatus = AdventureModuleHelper.GetPlayerActorStatus(playerids[i])
    local nStatusTime = AdventureModuleHelper.GetPlayerActorSpecialStatusTime(playerids[i])
    self.mapCharacterTempData.hpInfo[charTid] = AdventureModuleHelper.GetEntityHp(playerids[i])
    if clsSkillId ~= nil then
      local tbSkillInfos = clsSkillId.skillInfos
      local nSkillCount = tbSkillInfos.Count - 1
      for j = 0, nSkillCount do
        local clsSkillInfo = tbSkillInfos[j]
        local mapSkill = ConfigTable.GetData_Skill(clsSkillInfo.skillId)
        if mapSkill.Type == GameEnum.skillType.ULTIMATE then
          table.insert(self.mapCharacterTempData.skillInfo, {
            nCharId = charTid,
            nSkillId = clsSkillInfo.skillId,
            nCd = clsSkillInfo.currentUseInterval.RawValue,
            nSectionAmount = clsSkillInfo.currentSectionAmount,
            nSectionResumeTime = clsSkillInfo.currentResumeTime.RawValue,
            nUseTimeHint = clsSkillInfo.currentUseTimeHint.RawValue,
            nEnergy = clsSkillInfo.currentEnergy.RawValue
          })
        end
      end
      self.mapCharacterTempData.effectInfo[charTid] = {
        mapEffect = {}
      }
      local tbClsEfts = AdventureModuleHelper.GetEffectList(playerids[i])
      if tbClsEfts ~= nil then
        local nEftCount = tbClsEfts.Count - 1
        for k = 0, nEftCount do
          local eftInfo = tbClsEfts[k]
          local mapEft = ConfigTable.GetData_Effect(eftInfo.effectConfig.Id)
          local nCd = eftInfo.CD.RawValue
          if mapEft.Remove and 0 < nCd then
            self.mapCharacterTempData.effectInfo[charTid].mapEffect[eftInfo.effectConfig.Id] = {nCount = 0, nCd = nCd}
          end
        end
      end
      local tbBuffInfo = AdventureModuleHelper.GetEntityBuffList(playerids[i])
      self.mapCharacterTempData.buffInfo[charTid] = {
        mapBuff = {}
      }
      if tbBuffInfo ~= nil then
        local nBuffCount = tbBuffInfo.Count - 1
        for l = 0, nBuffCount do
          local eftInfo = tbBuffInfo[l]
          local mapBuff = ConfigTable.GetData_Buff(eftInfo.buffConfig.Id)
          if mapBuff.NotRemove then
            table.insert(self.mapCharacterTempData.buffInfo[charTid].mapBuff, {
              Id = eftInfo.buffConfig.Id,
              CD = eftInfo:GetBuffLeftTime().RawValue,
              nNum = eftInfo:GetBuffNum()
            })
          end
        end
      end
    end
    self.mapCharacterTempData.stateInfo[charTid] = {nState = nStatus, nStateTime = nStatusTime}
  end
end

return StoryLevel
