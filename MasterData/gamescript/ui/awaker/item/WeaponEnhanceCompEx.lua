local WeaponEnhanceCompEx, Super = System.NewComponent("WeaponEnhanceCompEx")

function WeaponEnhanceCompEx:ctor(uiNode, model, refineModel, mtrlSlotsModel, showBackTrackToggle)
  Super.ctor(self)
  self.ui = UI_Awaker_Item_Weapon_StrengthenResource(uiNode)
  self.model = model
  self.refineModel = refineModel
  self.mtrlSlotsModel = mtrlSlotsModel
  self.breakthroughStars = AwakerBreakthroughStars(self.ui.RootStars, CommonDefine.WeaponEnhance.MaxBreakthroughStar)
  self.showBackTrackToggle = showBackTrackToggle or false
end

function WeaponEnhanceCompEx:OnBind(binder)
  self.binder = binder
  binder:BindToText(self.ui.Text_Weapon_Name, function()
    do return self.model.GetWeaponName end
    return self.model.GetWeaponName, self.model
  end)
  self:_OnBindRefineUI(binder)
  if self.model:HasOwner() then
    self.ui.Image_Small_Avatar:SetActive(true)
    binder:SetImage(self.ui.Image_Avatar, self.model:GetAwakerIcon())
  else
    self.ui.Image_Small_Avatar:SetActive(false)
  end
  local currencyList = DT.GetOriginalConstant("GeneralCultivationNeedCurreny")
  binder:BindComponent(CommonCurrencyGroupItem(self.ui.UI_Common_Item_Coin_Group, currencyList, false, true))
  self.binder:SetActive(self.ui.UI_Common_Item_Coin_Group, not ZoneFeatureUtils.IsWeaponAutoRefine())
  self.binder:SetActive(self.ui.Toggle_Enhance, false)
  self.binder:SetActive(self.ui.Toggle_Refine, true)
  self.binder:SetActive(self.ui.RootEnhance, false)
  self.binder:SetActive(self.ui.RootRefine, true)
  self:_RefreshSelectWeapon()
  binder:BindToZ1Toggle(self.ui.Toggle_Refine, nil, function(isOn)
    if isOn then
      self.refineComp.ui.Image_Overlay:SetActive(true)
    else
      self:_RefreshSelectWeapon()
      self.mtrlSlotsModel:ClearSlots()
    end
    binder:SetZ1Toggle(self.ui.Toggle_Enhance, not isOn)
    binder:SetZ1Toggle(self.ui.Toggle_Backtrack, not isOn)
    self.ui.RootRefine:SetActive(isOn)
    self.refineComp.ui.Image_Backtrace:SetActive(false)
  end)
  binder:BindToZ1Toggle(self.ui.Toggle_Backtrack, nil, function(isOn)
    binder:SetZ1Toggle(self.ui.Toggle_Refine, not isOn)
    binder:SetZ1Toggle(self.ui.Toggle_Enhance, not isOn)
    self.refineComp.ui.Image_Backtrace:SetActive(isOn)
    self.ui.RootRefine:SetActive(isOn)
    self.refineComp.ui.Image_Overlay:SetActive(false)
    self:_RefreshSelectWeapon()
    if isOn then
      RedPointDataUtils.RemoveBackTrackOnceRed(self.model.weapon.uid)
    end
  end)
  binder:BindToRaw(function(_, isShowRefineBtn)
    self.binder:SetActive(self.ui.Toggle_Refine, isShowRefineBtn)
    if isShowRefineBtn then
      self.binder:SetZ1Toggle(self.ui.Toggle_Refine, true)
    end
    if not isShowRefineBtn and BackTrackDataUtils.IsWeaponOpen(self.model.weapon.tid, self.model.weapon.uid) then
      self.binder:SetZ1Toggle(self.ui.Toggle_Backtrack, true)
    end
  end, function()
    do return ItemDataUtils.IsShowRefineBtn end
    return ItemDataUtils.IsShowRefineBtn, self.model.weapon.uid
  end)
  binder:BindToRaw(function(cb2, weapon, o)
    cb2:BindToRaw(function(childBinder, isOpenBackTrack)
      if isOpenBackTrack then
        self.ui.Toggle_Backtrack:SetActive(true)
        childBinder:SetZ1Toggle(self.ui.Toggle_Backtrack, self.showBackTrackToggle)
        self.refineComp.ui.Image_Backtrace:SetActive(self.showBackTrackToggle)
        self.refineComp.ui.Image_Overlay:SetActive(not self.showBackTrackToggle)
        if self.showBackTrackToggle then
          RedPointDataUtils.RemoveBackTrackOnceRed(weapon.uid)
        end
        local ui = UI_Common_Toggle_ListResource(self.ui.Toggle_Backtrack)
        childBinder:BindComponent(RedDotComponent(ui.Com_RedDot_UnSelect, CommonDefine.RedDotType.Dot, function()
          do return RedPointDataUtils.IsBackTrackShowRed end
          return RedPointDataUtils.IsBackTrackShowRed, weapon.uid
        end))
        childBinder:BindComponent(RedDotComponent(ui.Com_RedDot_Select, CommonDefine.RedDotType.Dot, function()
          do return RedPointDataUtils.IsBackTrackShowRed end
          return RedPointDataUtils.IsBackTrackShowRed, weapon.uid
        end))
      else
        self.ui.Toggle_Backtrack:SetActive(false)
        self.refineComp.ui.Image_Backtrace:SetActive(false)
        self.refineComp.ui.Image_Overlay:SetActive(true)
        self.refineComp.ui.Image_Backtrace:SetActive(false)
      end
    end, function()
      return weapon and BackTrackDataUtils.IsWeaponOpen(weapon.tid, weapon.uid)
    end)
  end, function()
    return self.model.weapon
  end)
  binder:SetZ1Toggle(self.ui.Toggle_Refine, not self.showBackTrackToggle)
  binder:SetZ1Toggle(self.ui.Toggle_Backtrack, self.showBackTrackToggle)
  if not self.showBackTrackToggle then
    self:ShowRefine()
  end
end

function WeaponEnhanceCompEx:_OnBindRefineUI(binder)
  self.refineComp = binder:BindComponent(WeaponRefineComp(self.ui.RootRefine, self.refineModel))
end

function WeaponEnhanceCompEx:SetBackTrackCallBack(func)
  if self.refineComp then
    self.refineComp:SetBackTrackCallBack(func)
  end
end

function WeaponEnhanceCompEx:ShowRefine()
  self.binder:SetZ1Toggle(self.ui.Toggle_Refine, true)
  self.ui.RootEnhance:SetActive(false)
  self.ui.RootRefine:SetActive(true)
  if self.refineComp then
    self.refineComp:HideMtrlSelectionPanel()
  end
end

function WeaponEnhanceCompEx:_RefreshSelectWeapon()
  if self.ui.RootRefine.activeSelf and self.refineComp then
    self.refineComp:HideMtrlSelectionPanel()
    self.refineComp:RefreshSelectWeapon()
  end
end

return WeaponEnhanceCompEx
