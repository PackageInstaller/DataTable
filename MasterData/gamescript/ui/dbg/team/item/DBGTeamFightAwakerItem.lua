local UI_Team_Item_Awaker_ListResource = require("UI.UIPackages.UI_Team_Item_Awaker_ListResource")
local System = require("System.System")
local DT = require("System.DataTable")
local LT = require("System.LangTable")
local UIManager = require("Managers.UI.UIManager")
local Urls = require("Managers.UI.Urls")
local CommonDefine = require("World.Enums.CommonDefine")
local Logger = require("Utility.Logger")
local Alert = require("System.Alert")
local AwakerPortraitComp = require("UI.MainInterface.Panel.AwakerPortraitComp")
local MAX_WEAPONED_WEAPON_NUM = 2
local TRINKET_SLOT_COUNT = CommonDefine.MaxEquipTrinketsNum
local BOUND_TRINKET_TAG_NODE_NAME = "Image_Trinket_Bind"
local HAS_BIND_TRINKET_TAG_NODE_NAME = "Image_HasBindTrinket"
local AnimatorUtils = require("Animation.AnimatorUtils")
local AddClipToPlay = AnimatorUtils.AddClipToPlay
local UIAnimationController = CS.Z1Client.UIAnimationController
local DBGTeamFightAwakerItem, Super = System.NewComponent("DBGTeamFightAwakerItem")

function DBGTeamFightAwakerItem:ctor(gameObj, slot, dbgTeamBuildModel)
  Super.ctor(self)
  self.ui = UI_Team_Item_Awaker_ListResource(gameObj)
  self.slot = slot
  self.model = dbgTeamBuildModel
end

function DBGTeamFightAwakerItem:OnBind(binder)
  self.binder = binder
  self:InitAnimation()
  self:_OnBindAwakerBaseInfo(binder)
  self:_OnBindAwakerWeaponInfo(binder)
  self:_OnBindAwakerTrinketInfo(binder)
  self:_OnBindAwakerTalentInfo(binder)
  binder:BindButtonClick(self.ui.Btn_Click, System.fn(self, self.OnClickAwaker))
  binder:BindToVisible(self.ui.Image_Quality, System.fn(self, self.GetQualityColorFloat))
  binder:BindToImage(self.ui.Image_Quality, System.fn(self, self.GetQualityColorFloat))
  binder:BindToImage(self.ui.Image_Quality_2, System.fn(self, self.GetQualityTeamFrame))
  binder:BindToImage(self.ui.Image_Career_Icon, System.fn(self, self.GetSchoolIcon))
  binder:BindToVisible(self.ui.Image_Career_Icon, System.fn(self, self.GetSchoolIcon))
  binder:BindToVisible(self.ui.Image_Melt_Erosion, System.fn(self, self.GetAwakerCfg))
  binder:BindToRaw(function(childBinder, resNum)
    if resNum then
      local portraitAlign = CommonDefine.PortraitAlign.Center
      childBinder:BindComponent(AwakerPortraitComp(self.ui.Container_Awaker, nil, resNum, nil, portraitAlign))
    end
  end, function()
    local awakerData = self:GetAwakerData()
    if not awakerData or not awakerData.tid then
      return
    end
    if awakerData and awakerData.curSkin and awakerData.curSkin ~= cd.DefaultSkinTid then
      do return AwakerSkinUtils.GetSkinResNum end
      return AwakerSkinUtils.GetSkinResNum, awakerData.curSkin, nil, nil
    end
    do return AwakerDataUtils.GetAwakerResNum, math.abs(awakerData.tid, awakerData.isFakeAwaker) end
    return AwakerDataUtils.GetAwakerResNum, math.abs(awakerData.tid, awakerData.isFakeAwaker)
  end)
  binder:BindToVisible(self.ui.Image_Add, function()
    local isEmpty = self:IsEmpty()
    local isBanPos = self.model:IsBanPos(self.slot)
    return isEmpty and not isBanPos
  end)
  binder:BindToText(self.ui.Text_Add, function()
    if self.model:IsForceAssistStage() and self.model:IsAssistSlot(self.slot) then
      do return LT.Text end
      return LT.Text, "Formation_Role_ForceAssist_Recommend", self.slot
    end
    do return LT.Text end
    return LT.Text, "Formation_Role_Recommend_String", self.slot
  end)
  binder:BindToVisible(self.ui.Group_Ban, function()
    local tid = self:GetAwakerTid()
    if self.model:IsForceAssistStage() and self.model:IsAssistSlot(self.slot) and not self.model:GetAssistAwaker() and 0 ~= (tid or 0) then
      return true
    end
    local schoolList = {}
    for i = 1, self.slot - 1 do
      local awakerTid = self.model.teamAwakerTids[i]
      local schoolId = AwakerCfgUtils.GetCfgField("School", awakerTid)
      if schoolId and not table.contains(schoolList, schoolId) then
        table.insert(schoolList, schoolId)
      end
    end
    local schoolId = AwakerCfgUtils.GetCfgField("School", self:GetAwakerTid())
    if #schoolList >= 2 and schoolId and not table.contains(schoolList, schoolId) then
      return true
    end
    return self.model:IsBanPos(self.slot) or self.model:IsBanAwaker(tid, self.slot)
  end)
  binder:BindButtonClick(self.ui.Group_Ban, function()
    if self.model:IsBanPos(self.slot) then
      Alert.Show(10576)
      return
    end
    self:OpenDBGTeamBuildAwakerPanel()
  end)
  binder:BindToVisible(self.ui.Image_Disable, function()
    do return self.model.IsBanPos, self.model end
    return self.model.IsBanPos, self.model, self.slot
  end)
  self:BindAssistAwaker()
  self:BindAwakerTag()
  self:_BindAwakerFavor(binder)
  self.binder:BindToRaw(function(_, v, _)
    local state = v[1]
    local aniName = v[2]
    if aniName then
      self:PlayAnim(aniName)
    end
    self.ui.Group_Awaker:SetActive(state)
  end, function()
    local tid = self:GetAwakerTid() or 0
    if 0 ~= tid and self.model.showAwakerInSertAnim then
      return {
        false,
        "UI_Team_Item_Awaker_List_open"
      }
    elseif 0 == tid then
      return {false}
    else
      return {true}
    end
  end)
end

function DBGTeamFightAwakerItem:OnUnbind()
  Super.OnUnbind(self)
  GlobalDispatcher:RemoveListener(NotifyId.OnTeamSlotTrinketsChanged, self._OnTeamSlotTrinketsChanged, self)
end

function DBGTeamFightAwakerItem:BindAssistAwaker()
  if self.slot == CommonDefine.TeamAssign.MaxBattleNum then
    self.binder:BindToRaw(function(_, v, _)
      if v then
        self.assistAwaker = v
        self.ui.Image_Help:SetActive(true)
      else
        self.ui.Image_Help:SetActive(false)
      end
      self:_UpdateTrinketEmptyButton()
    end, function()
      local assistAwaker = self.model:GetAssistAwaker()
      return assistAwaker
    end)
  end
end

function DBGTeamFightAwakerItem:BindAwakerTag()
  self.binder:BindToVisible(self.ui.Image_Default, function()
    return self:GetAwakerTag() ~= nil
  end)
  self.binder:BindToText(self.ui.Text_Default, function()
    do return self.GetAwakerTag end
    return self.GetAwakerTag, self
  end)
  self.binder:BindToVisible(self.ui.Image_Preselection, function()
    return self:GetPreChooseTag() ~= nil
  end)
  self.binder:BindToText(self.ui.Text_Preselection, function()
    do return self.GetPreChooseTag end
    return self.GetPreChooseTag, self
  end)
  self.binder:BindToRaw(function(_, presetTag)
    self.binder:SetActive(self.ui.Image_Preset, nil ~= presetTag)
    self.binder:SetText(self.ui.Text_Preset, presetTag)
  end, function()
    do return self.GetPresetTag end
    return self.GetPresetTag, self
  end)
  self.binder:BindToRaw(function(_, tag, preTag)
    self.binder:SetActive(self.ui.Image_Default, nil ~= tag)
    self.binder:SetText(self.ui.Text_Default, tag)
    if tag then
      self.ui.Image_Help.transform.anchoredPosition = CS.UnityEngine.Vector2(61, 393)
    else
      self.ui.Image_Help.transform.anchoredPosition = CS.UnityEngine.Vector2(61, 355)
    end
  end, function()
    do return self.GetAwakerTag end
    return self.GetAwakerTag, self
  end)
end

function DBGTeamFightAwakerItem:_BindAwakerFavor(binder)
  if not self.ui.Image_AwakerFavor then
    return
  end
  binder:BindToVisible(self.ui.Image_AwakerFavor, function()
    local awakerData = self:GetAwakerData()
    if not awakerData or not awakerData.tid then
      return false
    end
    do return FavorabilityVisualUtils.IsPremiumCardFaceUnlocked, awakerData.tid end
    return FavorabilityVisualUtils.IsPremiumCardFaceUnlocked, awakerData.tid, awakerData
  end)
end

function DBGTeamFightAwakerItem:IsEmpty()
  local tid = self:GetAwakerTid() or 0
  return 0 == tid
end

function DBGTeamFightAwakerItem:GetAwakerTid()
  if self.slot == cd.TeamAssign.MaxBattleNum then
    local assistAwaker = self.model:GetAssistAwaker()
    if assistAwaker then
      return assistAwaker.tid
    end
  end
  do return self.model.GetTeamAwakerTidBySlot, self.model end
  return self.model.GetTeamAwakerTidBySlot, self.model, self.slot
end

function DBGTeamFightAwakerItem:GetAwakerAbsTid()
  local tid = self:GetAwakerTid()
  return tid and math.abs(tid)
end

function DBGTeamFightAwakerItem:GetAwakerData()
  if self.slot == cd.TeamAssign.MaxBattleNum then
    local assistAwaker = self.model:GetAssistAwaker()
    if assistAwaker then
      return assistAwaker
    end
  end
  local tid = self:GetAwakerTid()
  if tid and 0 ~= tid then
    return self.model:GetAwakerDataByCfgId(tid) or {}
  end
  return {}
end

function DBGTeamFightAwakerItem:GetAwakerCfg()
  local tid = self:GetAwakerTid()
  if not tid or 0 == tid then
    return
  end
  return DT.AwakerConfig[math.abs(tid)]
end

function DBGTeamFightAwakerItem:GetQuality()
  local cfg = self:GetAwakerCfg()
  return cfg and cfg.Quality
end

function DBGTeamFightAwakerItem:GetQualityColorFloat()
  local quality = self:GetQuality()
  return quality and DT.ItemQuality[quality].TeamQualityColorFloat
end

function DBGTeamFightAwakerItem:GetQualityTeamFrame()
  local quality = self:GetQuality()
  return quality and DT.ItemQuality[quality].TeamFrame
end

function DBGTeamFightAwakerItem:GetSchoolIcon()
  local cfg = self:GetAwakerCfg()
  local schoolConfig = cfg and cfg.School and DT.SchoolConfig[cfg.School]
  return schoolConfig and schoolConfig.Icon
end

function DBGTeamFightAwakerItem:GetAwakerTag()
  if self.model:IsSlotLevelAjusted(self.slot) or self.model:IsAwakerSkillLevelAjusted(self.slot) or self.model:IsSlotTalentAjusted(self.slot) then
    do return LT.Text end
    return LT.Text, "DeepSeaInvasionDefensiveActiviityTips9", self.slot
  end
end

function DBGTeamFightAwakerItem:GetPresetTag()
  if self.model.stageGroupType == CommonDefine.StageGroupType.DailyChallenge then
    local strongAwakerTidList = DailyChallengeDataUtils.GetStrongAwakers()
    if strongAwakerTidList and table.contains(strongAwakerTidList, self:GetAwakerTid()) then
      do return LT.Text end
      return LT.Text, "DailyChallengeAttrBonus", self:GetAwakerTid()
    end
  end
  local specialSlotCfg = TeamAssignDataUtils.GetSpecialSlotCfg(self.model.stageId, self.slot) or {}
  if tonumber(specialSlotCfg.AwakerIndex) then
    local IsOwnedAwaker = specialSlotCfg.IsOwnedAwaker
    if nil == IsOwnedAwaker or IsOwnedAwaker == cd.TeamAssignAwaker.UseConfigData then
      do return LT.Text end
      return LT.Text, "SystemPreset", self:GetAwakerTid()
    end
  end
  local awakerData = self.model:GetAwakerDataBySlot(self.slot) or {}
  local specialTeamCfg = TeamAssignDataUtils.GetStageSpecialTeamCfg(self.model.stageId) or {}
  for i, slotCfg in ipairs(specialTeamCfg.data_list or {}) do
    if slotCfg.IsOwnedAwaker == cd.TeamAssignAwaker.UseOwnedAwaker and slotCfg.AwakerIndex == math.abs(awakerData.tid or 0) then
      return LT.Text("MustBattle")
    end
  end
end

function DBGTeamFightAwakerItem:GetPreChooseTag()
  local specialSlotCfg = TeamAssignDataUtils.GetSpecialSlotCfg(self.model.stageId, self.slot)
  local awakerData = self:GetAwakerData() or {}
  if awakerData.isFakeAwaker then
    if specialSlotCfg.IsOwnedAwaker == cd.TeamAssignAwaker.SwitchSameAwaker then
      do return LT.Text end
      return LT.Text, "SpecialTeamPreset"
    end
    if specialSlotCfg.IsOwnedAwaker == cd.TeamAssignAwaker.Trail then
      do return LT.Text end
      return LT.Text, "SpecialTeamTryOut"
    end
  end
end

function DBGTeamFightAwakerItem:_OnBindAwakerBaseInfo(binder)
  binder:BindToText(self.ui.Text_Name_2, System.fn(self, self._GetAwakerShowName))
  binder:BindToText(self.ui.Text_C_Lv_Dissolution, function()
    if self.model:IsSlotLevelAjusted(self.slot) then
      do return string.color, "Lv." end
      return string.color, "Lv.", "#5ef2ff"
    end
    return "Lv."
  end)
  binder:BindToText(self.ui.Text_Number_Dissolution, System.fn(self, self._GetAwakerShowLevelStr))
  binder:BindToRaw(function(childBinder, data)
    if not data then
      return
    end
    local assistAwakerData = self.model:GetAssistAwaker()
    if self.slot == CommonDefine.TeamAssign.MaxBattleNum and assistAwakerData then
      local awakerTid = data[1]
      childBinder:BindComponent(CommonAwakerPotencyItem(self.ui.UI_Common_Item_Potency, {
        awakerTid = awakerTid,
        potencyLevel = assistAwakerData.potencyLevel
      }))
    else
      local awakerTid = data[1]
      local potencyLevel = data[2]
      childBinder:BindComponent(CommonAwakerPotencyItem(self.ui.UI_Common_Item_Potency, {awakerTid = awakerTid, potencyLevel = potencyLevel}))
    end
  end, function()
    local awakerData = self:GetAwakerData()
    if not awakerData or not awakerData.tid then
      return nil
    end
    local potency = 0
    if awakerData.potencyLevel then
      potency = awakerData.potencyLevel
    elseif awakerData.potency then
      potency = AwakerDataUtils.GetAwakerPotencyIndex(math.abs(awakerData.tid), awakerData.potency)
    end
    return {
      math.abs(awakerData.tid),
      potency
    }
  end)
  binder:BindToText(self.ui.Text_Mad, System.fn(self, self._GetAwakerMadSkillLevelStr))
  binder:BindToText(self.ui.Text_Skill_01, System.fn(self, self._GetAwakerOtherSkillLevelStr))
end

function DBGTeamFightAwakerItem:_OnBindAwakerTalentInfo(binder)
  binder:BindToRaw(function(cBinder, talents)
    if self.model:IsPresetFakeAwakerSlot(self.slot) then
      cBinder:SetText(self.ui.Txt_Talent, TalentDataUtils.GetDisplayTalentLvDesc(talents))
      return
    end
    local adjustTalentLv1 = self.model:GetStageAjustAwakerTalent1Level()
    local adjustTalentLv2 = self.model:GetStageAjustAwakerTalent2Level()
    local adjustTalentLv3 = self.model:GetStageAjustAwakerTalent3Level()
    local awakerTalentLv1, awakerTalentLv2, awakerTalentLv3 = TalentDataUtils.GetDisplayTalentLv(talents)
    local showTalentLv1 = adjustTalentLv1 > awakerTalentLv1 and string.color(adjustTalentLv1, "#5ef2ff") or awakerTalentLv1
    local showTalentLv2 = adjustTalentLv2 > awakerTalentLv2 and string.color(adjustTalentLv2, "#5ef2ff") or awakerTalentLv2
    local showTalentLv3 = adjustTalentLv3 > awakerTalentLv3 and string.color(adjustTalentLv3, "#5ef2ff") or awakerTalentLv3
    cBinder:SetText(self.ui.Txt_Talent, string.format("%s/%s/%s", showTalentLv1, showTalentLv2, showTalentLv3))
  end, function()
    local awakerData = self:GetAwakerData()
    local assistAwakerData = self.model:GetAssistAwaker()
    if self.slot == CommonDefine.TeamAssign.MaxBattleNum and assistAwakerData then
      return assistAwakerData.talents
    end
    do return self.model.GetAwakerTalents, self.model end
    return self.model.GetAwakerTalents, self.model, awakerData.tid
  end)
  binder:BindEvent(EventMgr.Instance.OnAwakerUpgradeTalent, System.fn(self, self._RefreshAwakerTalent))
end

function DBGTeamFightAwakerItem:_RefreshAwakerTalent(awakerTid, talentTid, level)
  local awakerData = self:GetAwakerData()
  if awakerData.tid ~= awakerTid then
    return
  end
  self.model:RefreshTeamAwakerTalent(awakerTid, talentTid, level)
end

function DBGTeamFightAwakerItem:_OnBindAwakerWeaponInfo(binder)
  binder:BindToRaw(function(cBinder)
    local awakerData = self:GetAwakerData()
    if awakerData and awakerData.isFakeAwaker then
      self:_BindDBGTeamFightFakeWeaponItem(cBinder)
    else
      self:_BindDBGTeamFightWeaponItem(cBinder)
    end
    EventMgr.Instance.AwakerAttrChangeEvent:Dispatch()
  end, function()
    return {
      self.model:GetTeamWeaponGroupBySlot(self.slot),
      self.model.reactiveNum
    }
  end)
end

function DBGTeamFightAwakerItem:_BindDBGTeamFightWeaponItem(binder)
  for weaponSlot = 1, MAX_WEAPONED_WEAPON_NUM do
    local uiNode = self.ui["UI_Dungeons_Item_Weapon_" .. weaponSlot]
    local weaponGroup = self.model:GetTeamWeaponGroupBySlot(self.slot)
    local weaponUid = weaponGroup and weaponGroup[weaponSlot] or 0
    local itemData = {
      model = self.model,
      uidFunc = function()
        return weaponUid
      end,
      awakerTidFunc = function()
        do return self.GetAwakerAbsTid end
        return self.GetAwakerAbsTid, self
      end,
      weaponSlot = weaponSlot,
      teamSlot = self.slot,
      selectedFunc = function()
        return false
      end,
      clickFunc = function()
        local panelData = {
          dbgTeamBuildModel = self.model,
          selectWeaponSlot = weaponSlot,
          selectAwakerTid = self:GetAwakerTid(),
          selectWeaponUid = weaponUid,
          teamSlot = self.slot
        }
        UIManager.Instance:Reopen(Urls.TeamWeaponEquipView, panelData)
      end
    }
    binder:BindComponent(DBGTeamFightWeaponItem(uiNode, itemData))
  end
end

function DBGTeamFightAwakerItem:_BindDBGTeamFightFakeWeaponItem(binder)
  local awakerData = self:GetAwakerData() or {}
  local showWeaponTidGroup = {
    [1] = {
      weaponId = awakerData.weaponTid or 0,
      potencyLv = awakerData.weaponPotencyLv or 0
    },
    [2] = {
      weaponId = awakerData.subWeaponTid or 0,
      potencyLv = awakerData.subWeaponPotencyLv or 0
    }
  }
  for weaponSlot, data in pairs(showWeaponTidGroup) do
    local uiNode = self.ui["UI_Dungeons_Item_Weapon_" .. weaponSlot]
    binder:BindComponent(DBGTeamFightFakeWeaponItem(uiNode, data.weaponId, data.potencyLv))
  end
end

function DBGTeamFightAwakerItem:_OnBindAwakerTrinketInfo()
  self:_UpdateTrinkets()
  self:_BindBoundTrinketTag()
end

function DBGTeamFightAwakerItem:_GetLiveAwakerData()
  local awakerTid = self:GetAwakerAbsTid()
  if not awakerTid or 0 == awakerTid then
    return nil
  end
  local awakerData = AwakerDataUtils.GetAwakerData(awakerTid)
  return awakerData
end

function DBGTeamFightAwakerItem:_CanUseBoundTrinketFallback()
  if self.model.teamMode == CommonDefine.TeamAssign.eStageTeamMode.Preview and table.next(AwakerDataUtils.GetMockAwakerMap()) == nil then
    return false
  end
  local awakerData = self:_GetLiveAwakerData()
  if self.slot == cd.TeamAssistPos and self.model:GetAssistAwaker() then
    return false
  end
  if self.model:IsPresetFakeAwakerSlot(self.slot) then
    return false
  end
  if not awakerData or awakerData.isFakeAwaker then
    return false
  end
  return true
end

function DBGTeamFightAwakerItem:_IsShowingAssistAwaker()
  return self.slot == cd.TeamAssistPos and self.model:GetAssistAwaker() ~= nil
end

function DBGTeamFightAwakerItem:_GetBoundTrinketDisplayData(pos)
  if self:_IsShowingAssistAwaker() then
    local assistAwaker = self.model:GetAssistAwaker()
    local boundUid = assistAwaker.boundTrinkets and assistAwaker.boundTrinkets[pos] or 0
    if 0 == boundUid then
      return nil
    end
    do return self._GetAssistItemDataByUid, self end
    return self._GetAssistItemDataByUid, self, boundUid
  end
  if not self:_CanUseBoundTrinketFallback() then
    return nil
  end
  local awakerTid = self:GetAwakerAbsTid()
  if not awakerTid or 0 == awakerTid then
    return nil
  end
  local boundUid = AwakerDataUtils.GetBoundTrinketUidFormAware(awakerTid, pos)
  if 0 == boundUid then
    return nil
  end
  do return ItemDataUtils.GetItemByUid end
  return ItemDataUtils.GetItemByUid, boundUid, boundUid
end

function DBGTeamFightAwakerItem:_HasOverriddenBoundTrinket()
  self:_GetLiveAwakerData()
  if self:_IsShowingAssistAwaker() then
    local assistAwaker = self.model:GetAssistAwaker()
    do return AwakerTrinketDataUtils.HasBoundTrinketOverriddenByBoundTable, AwakerTrinketDataUtils.GetSnapshotBoundTrinkets(assistAwaker), self:_GetAssistAwakerTrinketData(), self.model:GetAssistItem() end
    return AwakerTrinketDataUtils.HasBoundTrinketOverriddenByBoundTable, AwakerTrinketDataUtils.GetSnapshotBoundTrinkets(assistAwaker), self:_GetAssistAwakerTrinketData(), self.model:GetAssistItem()
  end
  local awakerTid = self:GetAwakerAbsTid()
  local trinketUids = self.model:GetTeamTrinketGroupBySlot(self.slot)
  if not self:_CanUseBoundTrinketFallback() or self:IsEmpty() then
    return false
  end
  if not awakerTid or 0 == awakerTid then
    return false
  end
  do return AwakerTrinketDataUtils.HasBoundTrinketOverridden, awakerTid end
  return AwakerTrinketDataUtils.HasBoundTrinketOverridden, awakerTid, trinketUids, self.model:GetAssistItem()
end

function DBGTeamFightAwakerItem:_HasEffectiveBoundTrinket()
  self:_GetLiveAwakerData()
  if self:_IsShowingAssistAwaker() then
    local assistAwaker = self.model:GetAssistAwaker()
    do return AwakerTrinketDataUtils.IsBoundTrinketEffectiveByBoundTable, AwakerTrinketDataUtils.GetSnapshotBoundTrinkets(assistAwaker), self:_GetAssistAwakerTrinketData(), self.model:GetAssistItem() end
    return AwakerTrinketDataUtils.IsBoundTrinketEffectiveByBoundTable, AwakerTrinketDataUtils.GetSnapshotBoundTrinkets(assistAwaker), self:_GetAssistAwakerTrinketData(), self.model:GetAssistItem()
  end
  local awakerTid = self:GetAwakerAbsTid()
  local trinketUids = self.model:GetTeamTrinketGroupBySlot(self.slot)
  if not self:_CanUseBoundTrinketFallback() or self:IsEmpty() then
    return false
  end
  if not awakerTid or 0 == awakerTid then
    return false
  end
  do return AwakerTrinketDataUtils.IsBoundTrinketEffective, awakerTid end
  return AwakerTrinketDataUtils.IsBoundTrinketEffective, awakerTid, trinketUids, self.model:GetAssistItem()
end

function DBGTeamFightAwakerItem:_BindBoundTrinketTag()
  self.binder:BindToVisible(self.ui[BOUND_TRINKET_TAG_NODE_NAME], function()
    do return self._HasEffectiveBoundTrinket end
    return self._HasEffectiveBoundTrinket, self
  end)
  self.binder:BindToVisible(self.ui[HAS_BIND_TRINKET_TAG_NODE_NAME], function()
    do return self._HasOverriddenBoundTrinket end
    return self._HasOverriddenBoundTrinket, self
  end)
end

function DBGTeamFightAwakerItem:_RefreshTrinketIcons(trinketUids, assistAwakerData)
  local trinketDatas = {}
  local isEmptyTrinkets = true
  for i = 1, TRINKET_SLOT_COUNT do
    local imageObj = self.ui["Team_Icon_0" .. i]
    local uid = trinketUids[i] and trinketUids[i] or 0
    local isValid = uid and uid > 0
    local trinket
    if isValid then
      trinket = assistAwakerData and self:_GetAssistItemDataByUid(uid) or ItemDataUtils.GetItemByUid(uid)
      if not trinket then
        isValid = false
      end
    else
      trinket = self:_GetBoundTrinketDisplayData(i)
      if trinket then
        isValid = true
      end
    end
    if imageObj then
      imageObj:SetActive(isValid)
    end
    if trinket then
      isEmptyTrinkets = false
    end
    trinketDatas[i] = trinket
  end
  return trinketDatas, isEmptyTrinkets
end

function DBGTeamFightAwakerItem:_RefreshConversionAndSuitIcon(trinketDatas, isEmptyTrinkets, awakerData, ccbinder)
  if isEmptyTrinkets or awakerData.isFakeAwaker then
    self.ui.Image_Conversion:SetActive(false)
    self.binder:SetText(self.ui.Text_Conversion, "")
  else
    self.ui.Image_Conversion:SetActive(true)
    self.binder:SetText(self.ui.Text_Conversion, AwakerTrinketDataUtils.GetTrinketSuitCompletionRate(trinketDatas) .. "%")
  end
  local isSuitGatherAll = AwakerTrinketDataUtils.IsSuitGatherAll(trinketDatas)
  self.ui.Trinket_Icon:SetActive(isSuitGatherAll)
  if isSuitGatherAll then
    local suitId = trinketDatas[1].suitId
    ccbinder:SetImage(self.ui.Trinket_Icon, AwakerTrinketDataUtils.GetSuitIcon(suitId))
  end
  ccbinder:BindToVisible(self.ui.Image_Trinket_Disable, function()
    return self:_CheckTrinketNotEffect() and not isEmptyTrinkets
  end)
  if awakerData.isFakeAwaker then
    local suitEffectId = awakerData.suitEffectId
    if nil ~= suitEffectId then
      self.ui.Trinket_Icon:SetActive(true)
      ccbinder:SetImage(self.ui.Trinket_Icon, AwakerTrinketDataUtils.GetSuitIcon(suitEffectId))
    end
  end
end

function DBGTeamFightAwakerItem:_BindTrinketClick(trinketDatas, assistAwakerData, awakerData, ccbinder)
  ccbinder:BindButtonClick(self.ui.Btn_Click_Trinket, function()
    local hasFakeAwaker = awakerData.isFakeAwaker
    local isSpecialFakeAwaker = self.model.teamMode == CommonDefine.TeamAssign.eStageTeamMode.Special and hasFakeAwaker
    local isPreviewMode = self.model.teamMode == CommonDefine.TeamAssign.eStageTeamMode.Preview
    if not table.next(trinketDatas) then
      local tipsTid
      if isSpecialFakeAwaker then
        tipsTid = 10837
      elseif assistAwakerData then
        tipsTid = 10835
      end
      if tipsTid then
        Alert.Show(tipsTid)
        return
      end
    end
    if assistAwakerData or isSpecialFakeAwaker or isPreviewMode then
      UIManager.Instance:Reopen(Urls.TrinketGroupDetailTipsView, trinketDatas, awakerData and awakerData.boundTrinkets or nil)
      return
    end
    local teamAwakerTids = self.model:GetTeamAwakerTids()
    local awakerteamData = {}
    for _, tid in pairs(teamAwakerTids) do
      local data = AwakerDataUtils.GetAwakerData(tid)
      if data then
        table.insert(awakerteamData, data)
      end
    end
    UIManager.Instance:Reopen(Urls.TrinketEquipedView, awakerData, awakerteamData, self.model, self.slot)
  end)
end

function DBGTeamFightAwakerItem:_UpdateTrinkets()
  self.binder:BindToRaw(function(cBinder)
    cBinder:BindToRaw(function(ccbinder)
      local trinketUids = self.model:GetTeamTrinketGroupBySlot(self.slot)
      local assistAwakerData = self:_GetAssistAwakerTrinketData()
      if assistAwakerData then
        trinketUids = assistAwakerData
      end
      local trinketDatas, isEmptyTrinkets = self:_RefreshTrinketIcons(trinketUids, assistAwakerData)
      self:_UpdateTrinketEmptyButton()
      local awakerData = self:GetAwakerData() or {}
      self:_RefreshConversionAndSuitIcon(trinketDatas, isEmptyTrinkets, awakerData, ccbinder)
      self:_BindTrinketClick(trinketDatas, assistAwakerData, awakerData, ccbinder)
      EventMgr.Instance.AwakerAttrChangeEvent:Dispatch()
    end, function()
      local trinks = self.model:GetTeamTrinketGroupBySlot(self.slot)
      if self.slot == cd.TeamAssistPos and self.model:GetAssistAwaker() then
        local assistAwaker = self.model:GetAssistAwaker()
        local assistTrinks = self:_GetAssistAwakerTrinketData()
        return tostring(assistTrinks or trinks) .. "|" .. tostring(assistAwaker.boundTrinkets)
      end
      local awakerData = self:_GetLiveAwakerData()
      local boundTrinkets = awakerData and AwakerDataUtils.GetBoundTrinketsFormAware(awakerData.tid)
      return tostring(trinks) .. "|" .. tostring(boundTrinkets)
    end)
  end, function()
    local awakerTid = self:GetAwakerTid() or 0
    if self.slot == cd.TeamAssistPos then
      local assistAwaker = self.model:GetAssistAwaker()
      local liveData = self:_GetLiveAwakerData()
      return tostring(assistAwaker) .. "|" .. tostring(liveData) .. "|" .. awakerTid
    end
    return tostring(self:_GetLiveAwakerData()) .. "|" .. awakerTid
  end)
end

function DBGTeamFightAwakerItem:_UpdateTrinketEmptyButton()
  local trinketUids = self.model:GetTeamTrinketGroupBySlot(self.slot)
  local awakerData = self:GetAwakerData()
  if TrinketModel.Instance:ExistsAnyTrinkets(trinketUids) or awakerData.isFakeAwaker then
    self.ui.Trinket_Add:SetActive(false)
    return
  end
  if self.model.teamMode == CommonDefine.TeamAssign.eStageTeamMode.Preview then
    self.ui.Trinket_Add:SetActive(false)
    return
  end
  if self:_HasEffectiveBoundTrinket() then
    self.ui.Trinket_Add:SetActive(false)
    return
  end
  if self.slot == CommonDefine.TeamAssign.MaxBattleNum then
    local assistAwaker = self.model:GetAssistAwaker()
    self.ui.Trinket_Add:SetActive(not assistAwaker)
  else
    self.ui.Trinket_Add:SetActive(true)
  end
end

function DBGTeamFightAwakerItem:_CheckTrinketNotEffect()
  local trinketDatas = {}
  for teamIdx, trinketUids in pairs(self.model.teamTrinketGroups) do
    if not trinketDatas[teamIdx] then
      trinketDatas[teamIdx] = {}
    end
    if teamIdx == self.model.MaxBattleNum and self.model:GetAssistUid() ~= nil then
      local assistAwaker = self.model:GetAssistAwaker()
      local assistTrinketUids = assistAwaker.trinkets
      local assistBound = assistAwaker.boundTrinkets
      local assistItems = self.model:GetAssistItem()
      for slot = 1, TRINKET_SLOT_COUNT do
        local trinketUid = assistTrinketUids[slot] or 0
        if 0 == trinketUid then
          trinketUid = assistBound and assistBound[slot] or 0
        end
        if 0 ~= trinketUid then
          trinketDatas[teamIdx][slot] = assistItems[trinketUid] or nil
        end
      end
    else
      local awakerTid = self.model.teamAwakerTids[teamIdx]
      local displayUids = AwakerTrinketExtModel.Instance:GetDisplayTrinketMapWithBound(awakerTid, trinketUids)
      for slot, trinketUid in pairs(displayUids) do
        if 0 ~= (trinketUid or 0) then
          trinketDatas[teamIdx][slot] = ItemDataUtils.GetItemByUid(trinketUid)
        end
      end
    end
  end
  local awakerDataList = {}
  for idx, awakerTid in ipairs(self.model.teamAwakerTids) do
    if idx == self.model.MaxBattleNum and self.model:GetAssistUid() ~= nil then
      table.insert(awakerDataList, self.model:GetAssistAwaker())
    else
      table.insert(awakerDataList, AwakerDataUtils.GetAwakerData(awakerTid))
    end
  end
  local invalidMap = AwakerTrinketDataUtils.GetInvalidTrinketSuitInfos(awakerDataList, trinketDatas)
  if not invalidMap or nil == table.next(invalidMap) then
    return false
  end
  return invalidMap[self:GetAwakerAbsTid()]
end

function DBGTeamFightAwakerItem:OnClickAwaker()
  if self.model.teamMode == CommonDefine.TeamAssign.eStageTeamMode.Preview then
    local awakerBasePanelData = {
      jumpPage = CommonDefine.AwakerPage.Detail,
      previewAwakersData = table.deepclone(self.model.previewAwakersData),
      selectAwakerId = self:GetAwakerAbsTid()
    }
    UIManager.Instance:Reopen(Urls.AwakerBasePanel, awakerBasePanelData)
    return
  end
  local isAssisSlot = self.slot == CommonDefine.TeamAssign.MaxBattleNum
  local hasAssistAwaker = self.model:GetAssistAwaker()
  if isAssisSlot and hasAssistAwaker then
    self:OpenAssistPanel()
    return
  end
  if self.model:IsBanPos(self.slot) then
    Alert.Show(10576)
    return
  end
  if self.model:IsSpecAssignAwaker(self.slot) then
    local awakerData = self:GetAwakerData() or {}
    if awakerData.isFakeAwaker then
      local tid = self:GetAwakerTid()
      if table.contains(DT.GetOriginalConstant("SpecialTeamAssignBlockView"), math.abs(tid)) then
        Alert.Show(10815)
        return
      end
      if tid < 0 then
        local targetAwakerData = table.clone(self.model:GetAwakerDataByCfgId(tid) or {})
        targetAwakerData.tid = math.abs(targetAwakerData.tid)
        local previewData = {
          items = {},
          awakers = {
            [tid] = targetAwakerData
          },
          hideAwakerChangeForm = true
        }
        local awakerBasePanelData = {
          jumpPage = CommonDefine.AwakerPage.Detail,
          previewAwakersData = previewData
        }
        UIManager.Instance:Reopen(Urls.AwakerBasePanel, awakerBasePanelData)
      else
        local awakerBasePanelData = {}
        awakerBasePanelData.jumpPage = CommonDefine.AwakerPage.Detail
        awakerBasePanelData.specialAwakerList = {
          AwakerDataUtils.GetAwakerData(tid)
        }
        UIManager.Instance:Reopen(Urls.AwakerBasePanel, awakerBasePanelData)
      end
      return
    end
    self.model:SetSingleChooseSpecialAwakerMode(true)
  else
    self.model:SetSingleChooseSpecialAwakerMode(false)
  end
  self:OpenDBGTeamBuildAwakerPanel()
end

function DBGTeamFightAwakerItem:OpenDBGTeamBuildAwakerPanel()
  self.model:SetCurAwakerSlot(self.slot)
  UIManager.Instance:Reopen(Urls.DBGTeamBuildAwakerPanel, self.model)
  self.model:SetPage(CommonDefine.DBGTeamBuildPage.SingleChoose)
  self.model:SetShowAwakerInSertAnim(true)
end

function DBGTeamFightAwakerItem:_GetSkillDisplayAwakerData()
  local awakerData = self:GetAwakerData()
  local assistAwakerData = self.model:GetAssistAwaker()
  if self.slot == CommonDefine.TeamAssign.MaxBattleNum and assistAwakerData then
    return assistAwakerData
  end
  return awakerData
end

function DBGTeamFightAwakerItem:_GetAwakerSkillLevelDisplay()
  local awakerData = self:_GetSkillDisplayAwakerData()
  if not awakerData or not awakerData.tid then
    return nil
  end
  local useStageAdjust = not self.model:IsPresetFakeAwakerData(awakerData)
  do return self.model.GetAwakerSkillLevelDisplay, self.model, awakerData end
  return self.model.GetAwakerSkillLevelDisplay, self.model, awakerData, useStageAdjust
end

function DBGTeamFightAwakerItem:_GetAwakerMadSkillLevelStr()
  local display = self:_GetAwakerSkillLevelDisplay()
  return display and display.madLevel or ""
end

function DBGTeamFightAwakerItem:_GetAwakerOtherSkillLevelStr()
  local display = self:_GetAwakerSkillLevelDisplay()
  return display and display.otherSkillLevel or ""
end

function DBGTeamFightAwakerItem:_GetAwakerShowName()
  local tid = self:GetAwakerAbsTid() or 0
  if 0 == tid then
    return ""
  end
  local config = DT.AwakerConfig[tid]
  return config and config.Name or ""
end

function DBGTeamFightAwakerItem:_GetAwakerShowLevelStr()
  local awakerData = self:GetAwakerData() or {}
  if self.model:IsPresetFakeAwakerSlot(self.slot) then
    return awakerData.level
  end
  if self.model:IsSlotLevelAjusted(self.slot) then
    local level = self.model:GetAwakerShowLevelBySlot(self.slot)
    do return string.color, level end
    return string.color, level, "#5ef2ff"
  end
  return self.model.teamType ~= CommonDefine.TeamType.Daily and awakerData.level or 1
end

function DBGTeamFightAwakerItem:InitAnimation()
  self.uiAnimController = self.ui.uiNode:GetComponent(typeof(UIAnimationController))
end

function DBGTeamFightAwakerItem:PlayAnim(clipsString, func)
  local clipsToPlay = ""
  Logger.Debug("DBGTeamBuildMainPanel PlayAnim: ", clipsString)
  self.uiAnimController:PlayMultiState(AddClipToPlay(clipsToPlay, clipsString), func)
end

function DBGTeamFightAwakerItem:OpenAssistPanel()
  SocialDataUtils.OpenBattleAssistPanel(self.model)
end

function DBGTeamFightAwakerItem:_GetAssistAwakerTrinketData()
  if self.slot == CommonDefine.TeamAssign.MaxBattleNum and self.model:GetAssistAwaker() then
    local assistAwakerData = self.model:GetAssistAwaker()
    return assistAwakerData.trinkets
  end
  return nil
end

function DBGTeamFightAwakerItem:_GetAssistItemDataByUid(uid)
  if not self.model:GetAssistItem() then
    return nil
  end
  return self.model:GetAssistItem()[uid]
end

return DBGTeamFightAwakerItem
