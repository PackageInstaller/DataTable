local MainlineBattleLevel = class("MainlineBattleLevel")
local RapidJson = require("rapidjson")
local Actor2DManager = require("Game.Actor2D.Actor2DManager")
local mapEventConfig = {
  LevelStateChanged = "OnEvent_SendMsgFinishBattle",
  [EventId.AbandonBattle] = "OnEvent_AbandonBattle",
  InteractiveBoxGet = "OnEvent_OpenChest",
  LoadLevelRefresh = "OnEvent_LoadLevelRefresh",
  Mainline_Time_CountUp = "OnEvent_Time",
  BattlePause = "OnEvnet_Pause",
  AdventureModuleEnter = "OnEvent_AdventureModuleEnter"
}

function MainlineBattleLevel:Init(parent, nSelectId, nTeamIdx, tbChestS, tbChestL)
  self.bSettle = false
  self.parent = parent
  self.nMainLineTime = 0
  self:BindEvent()
  self._nSelectId = nSelectId
  self.curFloorIdx = 1
  self.nLargeTotalCount = 0
  self.nSmallTotalCount = 0
  self.curSmallCount = 0
  self.curLargeCount = 0
  self.bNewSmall = false
  self.bNewLarge = false
  self._tbBoxS = nil
  self._tbBoxL = nil
  self.mapCharacterTempData = {}
  self._tbOpendChestS = {}
  self._tbOpendChestL = {}
  local mapMainline = ConfigTable.GetData_Mainline(nSelectId)
  self:PrePorcessChestData(self._nSelectId)
  self.nSmallTotalCount = #self._tbBoxS
  self.nLargeTotalCount = #self._tbBoxL
  self.bTrialLevel = mapMainline.TrialCharacter ~= nil and 0 < #mapMainline.TrialCharacter
  if self.bTrialLevel then
    self.nCurTeamIndex = 1
    self.tbChar = {}
    self.tbTrialId = {}
    for _, nTrialId in pairs(mapMainline.TrialCharacter) do
      if 0 < nTrialId then
        local mapTrialChar = PlayerData.Char:GetTrialCharById(nTrialId)
        table.insert(self.tbChar, mapTrialChar.nId)
        table.insert(self.tbTrialId, nTrialId)
      end
    end
  else
    self.nCurTeamIndex = nTeamIdx
    self.tbChar = PlayerData.Team:GetTeamCharId(nTeamIdx)
  end
  self.tbOpenedChestId = {}
  for _, idx in ipairs(tbChestS) do
    table.insert(self.tbOpenedChestId, self._tbBoxS[idx])
  end
  for _, idx in ipairs(tbChestL) do
    table.insert(self.tbOpenedChestId, self._tbBoxL[idx])
  end
  if self.bTrialLevel then
    for _, nTrialId in ipairs(self.tbTrialId) do
      if 0 < nTrialId then
        local mapTrialChar = PlayerData.Char:GetTrialCharById(nTrialId)
        local stActorInfo = self.CalCharFixedEffectTrial(nTrialId)
        safe_call_cs_func(CS.AdventureModuleHelper.SetActorAttribute, mapTrialChar.nId, stActorInfo)
      end
    end
  else
    for idx, nCharId in ipairs(self.tbChar) do
      local stActorInfo = self.CalCharFixedEffect(nCharId, idx == 1)
      safe_call_cs_func(CS.AdventureModuleHelper.SetActorAttribute, nCharId, stActorInfo)
    end
  end
  PlayerData.nCurGameType = AllEnum.WorldMapNodeType.Mainline
  CS.AdventureModuleHelper.EnterMainlineMap(mapMainline.FloorId[1], self.tbChar, self.tbOpenedChestId)
  self.curSmallCount = #tbChestS
  self.curLargeCount = #tbChestL
  NovaAPI.EnterModule("AdventureModuleScene", true, 17)
end

function MainlineBattleLevel:BindEvent()
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

function MainlineBattleLevel:UnBindEvent()
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

function MainlineBattleLevel.CalCharFixedEffect(nCharId, bMainChar)
  local tbstInfo = {}
  local tbEffectId = {}
  PlayerData.Char:CalcAffinityEffect(nCharId, tbstInfo, tbEffectId)
  local stActorInfo = CS.Lua2CSharpInfo_CharAttribute()
  local nHeartStoneLevel = PlayerData.Char:CalCharacterAttrBattle(nCharId, tbstInfo, stActorInfo, bMainChar)
  return tbstInfo, stActorInfo, nHeartStoneLevel
end

function MainlineBattleLevel.CalCharFixedEffectTrial(nTrialId)
  local tbstInfo = {}
  local stActorInfo = CS.Lua2CSharpInfo_CharAttribute()
  local nHeartStoneLevel = PlayerData.Char:CalCharacterTrialAttrBattle(nTrialId, tbstInfo, stActorInfo)
  return stActorInfo, nHeartStoneLevel
end

function MainlineBattleLevel:PrePorcessChestData(nMainlineId)
  if ConfigTable.GetData_Mainline(nMainlineId) == nil then
    printError("no level data：" .. nMainlineId)
  end
  local tbChestS = decodeJson(ConfigTable.GetData_Mainline(nMainlineId).MinChestReward)
  local tbChestL = decodeJson(ConfigTable.GetData_Mainline(nMainlineId).MaxChestReward)
  self._tbBoxS = tbChestS
  self._tbBoxL = tbChestL
end

function MainlineBattleLevel:PlaySuccessPerform(GenerRewardItems, FirstRewardItems, ChestRewardItems, nExp, nStar, FadeTime, mapChangeInfo)
  local function func_SettlementFinish(bSuccess)
  end
  
  local tbChar = self.tbChar
  
  local function levelEndCallback()
    EventManager.Remove("ADVENTURE_LEVEL_UNLOAD_COMPLETE", self, levelEndCallback)
    local nFloorCount, nMapId
    if PlayerData.Mainline.bUseOldMainline then
      nFloorCount = #ConfigTable.GetData_Mainline(self._nSelectId).FloorId
      nMapId = ConfigTable.GetData_Mainline(self._nSelectId).FloorId[nFloorCount]
    else
      nFloorCount = #ConfigTable.GetData_Story(self._nSelectId).FloorId
      nMapId = ConfigTable.GetData_Story(self._nSelectId).FloorId[nFloorCount]
    end
    local nType = ConfigTable.GetData("MainlineFloor", nMapId).Theme
    local sName = ConfigTable.GetData("EndSceneType", nType).EndSceneName
    local tbSkin = {}
    for _, nCharId in ipairs(tbChar) do
      local nSkinId = PlayerData.Char:GetCharSkinId(nCharId)
      table.insert(tbSkin, nSkinId)
    end
    CS.AdventureModuleHelper.PlaySettlementPerform(sName, "", tbSkin, func_SettlementFinish)
  end
  
  EventManager.Add("ADVENTURE_LEVEL_UNLOAD_COMPLETE", self, levelEndCallback)
  
  local function openBattleResultPanel()
    EventManager.Remove("SettlementPerformLoadFinish", self, openBattleResultPanel)
    local sLarge, sSmall = self:CalChestInfo()
    EventManager.Hit(EventId.OpenPanel, PanelId.BattleResult, true, nStar or 3, GenerRewardItems or {}, FirstRewardItems or {}, ChestRewardItems or {}, nExp or 0, false, sLarge, sSmall, self._nSelectId, self.tbChar, mapChangeInfo)
    self.bSettle = false
    self:UnBindEvent()
    if PlayerData.Mainline.bUseOldMainline then
      self.parent:LevelEnd()
    end
  end
  
  EventManager.Add("SettlementPerformLoadFinish", self, openBattleResultPanel)
  CS.AdventureModuleHelper.LevelStateChanged(true, FadeTime or 0.5)
  EventManager.Hit(EventId.OpenPanel, PanelId.BattleResultMask)
end

function MainlineBattleLevel:OnEvent_OpenChest(nId)
  print("OpenBox:" .. nId)
  local mapChest = ConfigTable.GetData("Chest", nId)
  if mapChest == nil then
    printError("宝箱id不存在" .. nId)
    return
  end
  local nType = mapChest.Label
  if nType == 1 then
    local nIndex = table.indexof(self._tbBoxS, nId)
    if self._tbBoxS == nil then
      return
    end
    if nIndex < 1 then
      return
    end
    mapChest = ConfigTable.GetData("Chest", nId)
    table.insert(self._tbOpendChestS, nIndex)
    self.curSmallCount = self.curSmallCount + 1
    self.bNewSmall = true
  else
    local nIndex = table.indexof(self._tbBoxL, nId)
    if self._tbBoxL == nil then
      return
    end
    if nIndex < 1 then
      return
    end
    mapChest = ConfigTable.GetData("Chest", nId)
    table.insert(self._tbOpendChestL, nIndex)
    self.curLargeCount = self.curLargeCount + 1
    self.bNewLarge = true
  end
  
  local function ShowTips(nTid, nCount)
    if nTid == 0 or nCount == 0 then
      return
    end
    EventManager.Hit(EventId.ShowRoguelikeDrop, nTid, nCount)
  end
  
  ShowTips(mapChest.Item1, mapChest.Number1)
  ShowTips(mapChest.Item2, mapChest.Number2)
  ShowTips(mapChest.Item3, mapChest.Number3)
  ShowTips(mapChest.Item4, mapChest.Number4)
end

function MainlineBattleLevel:OnEvent_LoadLevelRefresh()
  self:ResetCharacter()
end

function MainlineBattleLevel:CacheTempData()
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

function MainlineBattleLevel:ResetCharacter()
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

function MainlineBattleLevel:OnEvent_SendMsgFinishBattle(LevelResult, _doorIdx, FadeTime)
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
  local mapMainline
  if PlayerData.Mainline.bUseOldMainline then
    mapMainline = ConfigTable.GetData_Mainline(self._nSelectId)
  else
    mapMainline = ConfigTable.GetData_Story(self._nSelectId)
  end
  if self.curFloorIdx < #mapMainline.FloorId then
    self:ChangeFloor()
    return
  end
  local nStar = 1
  local nMainlineId = self._nSelectId
  if PlayerData.Mainline.bUseOldMainline then
    if #self._tbBoxS == self.curSmallCount then
      nStar = nStar | 2
    end
    if #self._tbBoxL == self.curLargeCount then
      nStar = nStar | 4
    end
  end
  
  local function func_cbFinishSucc(_, mapMainData)
    local nLevelStar = 0
    if PlayerData.Mainline.bUseOldMainline then
      self.parent:UpdateMainlineStar(self._nSelectId, nStar)
      nLevelStar = self.parent:GetMianlineLevelStar(nMainlineId)
    end
    
    local function func_AvgEnd()
      EventManager.Remove("StoryDialog_DialogEnd", self, func_AvgEnd)
      local sLarge, sSmall = self:CalChestInfo()
      EventManager.Hit(EventId.OpenPanel, PanelId.BattleResult, true, nLevelStar, mapMainData.GenerRewardItems or {}, mapMainData.FirstRewardItems or {}, mapMainData.ChestRewardItems or {}, mapMainData.Exp or 0, false, sLarge, sSmall, nMainlineId, self.tbChar, mapMainData.Change)
      self:UnBindEvent()
      self.parent:LevelEnd()
    end
    
    local sAvgId = PlayerData.Mainline:GetAfterBattleAvg()
    if sAvgId then
      EventManager.Add("StoryDialog_DialogEnd", self, func_AvgEnd)
      EventManager.Hit("StoryDialog_DialogStart", sAvgId)
    elseif PlayerData.Mainline.bUseOldMainline then
      self:PlaySuccessPerform(mapMainData.GenerRewardItems, mapMainData.FirstRewardItems, mapMainData.ChestRewardItems, mapMainData.Exp, nLevelStar, fadeT, mapMainData.Change)
    else
      self:PlaySuccessPerform()
    end
  end
  
  local Events = PlayerData.Achievement:GetBattleAchievement(GameEnum.levelType.Mainline, true)
  local mapSendMsg = {}
  mapSendMsg.Ok = true
  mapSendMsg.MinChests = self._tbOpendChestS
  mapSendMsg.MaxChests = self._tbOpendChestL
  if 0 < #Events then
    mapSendMsg.Events = {
      List = {}
    }
    mapSendMsg.Events.List = Events
  end
  print("====== 当前通关主线关卡ID：" .. self._nSelectId .. " ======")
  if PlayerData.Mainline.bUseOldMainline then
    HttpNetHandler.SendMsg(NetMsgId.Id.mainline_settle_req, mapSendMsg, nil, func_cbFinishSucc)
  elseif self.bActivityStory then
    PlayerData.ActivityAvg:SendMsg_STORY_DONE(func_cbFinishSucc)
  else
    PlayerData.Avg:SendMsg_STORY_DONE(func_cbFinishSucc)
  end
end

function MainlineBattleLevel:OnEvent_AbandonBattle()
  if self._nSelectId > 0 then
    local nStar = PlayerData.Mainline:GetMianlineLevelStar(self._nSelectId)
    if 0 < nStar then
      if #self._tbBoxS == self.curSmallCount then
        nStar = 3
      end
      if #self._tbBoxL == self.curLargeCount then
        nStar = nStar | 4
      end
    end
    
    local function func_cbExitSucc(_, mapMainData)
      local nMainlineId = self._nSelectId
      local sLarge, sSmall = self:CalChestInfo()
      self.parent:UpdateMainlineStar(self._nSelectId, nStar)
      EventManager.Hit(EventId.OpenPanel, PanelId.BattleResult, false, 0, mapMainData.GenerRewardItems or {}, mapMainData.FirstRewardItems or {}, mapMainData.ChestRewardItems or {}, mapMainData.Exp or 0, false, sLarge, sSmall, nMainlineId, self.tbChar, mapMainData.Change)
      self:UnBindEvent()
      self.parent:LevelEnd()
    end
    
    local mapSendMsg = {}
    mapSendMsg.MinChests = self._tbOpendChestS
    mapSendMsg.MaxChests = self._tbOpendChestL
    HttpNetHandler.SendMsg(NetMsgId.Id.mainline_exit_req, mapSendMsg, nil, func_cbExitSucc)
  end
end

function MainlineBattleLevel:CalChestInfo()
  local sSmall, sLarge
  if self.bNewSmall then
    sSmall = string.format("<color=#4ee5d1>%d</color>/%d", self.curSmallCount, self.nSmallTotalCount)
  else
    sSmall = string.format("%d/%d", self.curSmallCount, self.nSmallTotalCount)
  end
  if self.bNewLarge then
    sLarge = string.format("<color=#4ee5d1>%d</color>/%d", self.curLargeCount, self.nLargeTotalCount)
  else
    sLarge = string.format("%d/%d", self.curLargeCount, self.nLargeTotalCount)
  end
  if self.nSmallTotalCount == 0 then
    sSmall = "无"
  end
  if self.nLargeTotalCount == 0 then
    sLarge = "无"
  end
  return sLarge, sSmall
end

function MainlineBattleLevel:ChangeFloor()
  self:CacheTempData()
  local mapMainline = ConfigTable.GetData_Mainline(self._nSelectId)
  self.curFloorIdx = self.curFloorIdx + 1
  
  local function levelUnloadCallback()
    EventManager.Remove("ADVENTURE_LEVEL_UNLOAD_COMPLETE", self, levelUnloadCallback)
    if self.bTrialLevel then
      for _, nTrialId in ipairs(self.tbTrialId) do
        if 0 < nTrialId then
          local mapTrialChar = PlayerData.Char:GetTrialCharById(nTrialId)
          local stActorInfo, nHeartStoneLevel = self.CalCharFixedEffectTrial(nTrialId)
          safe_call_cs_func(CS.AdventureModuleHelper.SetActorAttribute, mapTrialChar.nId, stActorInfo)
        end
      end
    else
      for idx, nCharId in ipairs(self.tbChar) do
        local stActorInfo, nHeartStoneLevel = self.CalCharFixedEffect(nCharId, idx == 1)
        safe_call_cs_func(CS.AdventureModuleHelper.SetActorAttribute, nCharId, stActorInfo)
      end
    end
    self:SetCharStatus()
  end
  
  EventManager.Add("ADVENTURE_LEVEL_UNLOAD_COMPLETE", self, levelUnloadCallback)
  CS.AdventureModuleHelper.EnterMainlineMap(mapMainline.FloorId[self.curFloorIdx], self.tbChar, self.tbOpenedChestId)
  CS.AdventureModuleHelper.LevelStateChanged(false)
  self.bSettle = false
end

function MainlineBattleLevel:SetCharStatus()
  local nStatus = 0
  local nStatusTime = 0
  local tbActorInfo = {}
  for _, nTid in pairs(self.tbChar) do
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

function MainlineBattleLevel:OnEvent_Time(nTime)
  self.nMainLineTime = nTime
end

function MainlineBattleLevel:OnEvnet_Pause()
  EventManager.Hit(EventId.OpenPanel, PanelId.MainBattlePause, self.nMainLineTime or 0)
end

function MainlineBattleLevel:OnEvent_AdventureModuleEnter()
  EventManager.Hit(EventId.OpenPanel, PanelId.Adventure, self.tbChar)
end

return MainlineBattleLevel
