local InfinityTowerLevel = class("InfinityTowerLevel")
local mapEventConfig = {
  LoadLevelRefresh = "OnEvent_LoadLevelRefresh",
  InfinityTowerEnd = "OnEvent_InfinityTowerEnd",
  AdventureModuleEnter = "OnEvent_AdventureModuleEnter",
  BattlePause = "OnEvnet_Pause",
  [EventId.AbandonBattle] = "OnEvent_AbandonBattle",
  Infinity_Tower_RunTime = "OnEvent_InfinityTowerRunTime",
  ADVENTURE_LEVEL_UNLOAD_COMPLETE = "OnEvent_UnloadComplete"
}

function InfinityTowerLevel:Init(parent, floorId, nBuildId, againOrNextLv, isContinue)
  self.parent = parent
  self.floorId = floorId
  self.lvRunTime = 0
  
  local function GetBuildCallback(mapBuildData)
    self.mapBuildData = mapBuildData
    self.tbCharId = {}
    self.tbCharTrialId = {}
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
    self.mapActorInfo = {}
    for idx, nTid in ipairs(self.tbCharId) do
      local stActorInfo = self:CalCharFixedEffect(nTid, idx == 1, self.tbDiscId)
      self.mapActorInfo[nTid] = stActorInfo
    end
    self.parent:CacheBuildCharTid(self.tbCharId)
    PlayerData.nCurGameType = AllEnum.WorldMapNodeType.InfinityTower
    CS.AdventureModuleHelper.EnterInfinityTowerFloor(self.floorId, self.tbCharId, isContinue)
    if againOrNextLv == 0 then
      NovaAPI.EnterModule("AdventureModuleScene", true, 17)
    else
      self:OnEvent_AdventureModuleEnter()
    end
    EventManager.Hit("Infinity_Refresh_Msg")
  end
  
  PlayerData.Build:GetBuildDetailData(GetBuildCallback, nBuildId)
end

function InfinityTowerLevel:CalCharFixedEffect(nCharId, bMainChar, tbDiscId)
  local stActorInfo = CS.Lua2CSharpInfo_CharAttribute()
  PlayerData.Build:CalBuildCharacterAttrBattle(self.mapBuildData.nBuildId, nCharId, self.tbCharTrialId and self.tbCharTrialId[nCharId], stActorInfo, bMainChar, tbDiscId)
  return stActorInfo
end

function InfinityTowerLevel:BindEvent()
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

function InfinityTowerLevel:UnBindEvent()
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

function InfinityTowerLevel:OnEvent_InfinityTowerEnd(state)
  if state == 1 then
    self.parent:ITSettleReq(2, self.lvRunTime, self.tbCharId)
  elseif state == 2 then
    self.parent:ITSettleReq(1, self.lvRunTime, self.tbCharId)
  elseif state == 3 then
    self.parent:ITSettleReq(3, self.lvRunTime, self.tbCharId)
  end
  EventManager.Hit("Infinity_Hide_Time")
  EventManager.Hit("ResetBossHUD")
end

function InfinityTowerLevel:OnEvent_AdventureModuleEnter()
  PlayerData.Achievement:SetSpecialBattleAchievement(GameEnum.levelType.InfinityTower)
  EventManager.Hit(EventId.OpenPanel, PanelId.InfinityTowerBattlePanel, self.tbCharId)
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    EventManager.Hit(EventId.OpenPanel, PanelId.Hud)
  end
  
  cs_coroutine.start(wait)
  self:SetPersonalPerk()
  self:SetDiscInfo()
  for idx, nCharId in ipairs(self.tbCharId) do
    local stActorInfo = self:CalCharFixedEffect(nCharId, idx == 1, self.tbDiscId)
    safe_call_cs_func(CS.AdventureModuleHelper.SetActorAttribute, nCharId, stActorInfo)
  end
end

function InfinityTowerLevel:SetPersonalPerk()
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

function InfinityTowerLevel:SetDiscInfo()
  local tbDiscInfo = {}
  for k, nDiscId in ipairs(self.mapBuildData.tbDisc) do
    if k <= 3 then
      local discInfo = PlayerData.Build:GetBuildDiscInfoInBuild(self.mapBuildData.nBuildId, nDiscId, self.mapBuildData.tbSecondarySkill)
      table.insert(tbDiscInfo, discInfo)
    end
  end
  safe_call_cs_func(CS.AdventureModuleHelper.SetDiscInfo, tbDiscInfo)
end

function InfinityTowerLevel:OnEvent_LoadLevelRefresh()
  EventManager.Hit("MainBattleMenuBtnPauseActive", true)
  local mapAllEft, mapDiscEft, mapNoteEffect, tbNoteInfo = PlayerData.Build:GetBuildAllEft(self.mapBuildData.nBuildId)
  safe_call_cs_func(CS.AdventureModuleHelper.SetNoteInfo, tbNoteInfo)
  self.mapEftData = UTILS.AddBuildEffect(mapAllEft, mapDiscEft, mapNoteEffect)
  local tabAddAffixBuff = PlayerData.InfinityTower:GetFloorAffixBuff(self.tbCharId, self.floorId)
  safe_call_cs_func(CS.AdventureModuleHelper.InfinityTowerFloorEffects, tabAddAffixBuff)
end

function InfinityTowerLevel:OnEvent_UnloadComplete()
  self.parent:EnterInfinityTowerAgainNext()
end

function InfinityTowerLevel:OnEvnet_Pause()
  EventManager.Hit("show_Infinity_Pause", self.lvRunTime, self.tbCharId)
end

function InfinityTowerLevel:OnEvent_AbandonBattle()
  self:OnEvent_InfinityTowerEnd(3)
end

function InfinityTowerLevel:OnEvent_InfinityTowerRunTime(rTime)
  self.lvRunTime = rTime
end

return InfinityTowerLevel
