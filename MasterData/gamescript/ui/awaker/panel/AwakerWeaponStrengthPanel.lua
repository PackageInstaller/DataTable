local DOTween = CS.DG.Tweening.DOTween
local OrientaionChangedDuration = 0.5
local AwakerWeaponStrengthPanel, Super = System.NewClass("AwakerWeaponStrengthPanel", UIBasePanel)
AwakerWeaponStrengthPanel.uiResCls = UI_Awaker_Item_Weapon_Strengthen2Resource

function AwakerWeaponStrengthPanel:ctor(weaponUid, showBackTrackToggle)
  Super.ctor(self)
  self.weaponUid = weaponUid
  self.showBackTrackToggle = showBackTrackToggle or false
  self._isHideHUD = false
end

function AwakerWeaponStrengthPanel:OnBind(binder)
  self.binder = binder
  self.weaponRootTf = self.ui.UI_Awaker_Panel_Weapon_Main_Item1.transform
  self:_OnBindHUDHideGroup()
  local weapon = ItemDataUtils.GetItemByUid(self.weaponUid)
  self.awakerModel = binder:createModel(AwakerModel)
  self.weaponModel = binder:createModel(AwakerWeaponModel, self.awakerModel)
  self.weaponDetailModel = binder:createModel(WeaponDetailModel, weapon, self.awakerModel)
  self.weaponRefineModel = binder:createModel(WeaponRefineModel, weapon, self.weaponModel)
  self.enhanceMtrlSlotsModel = binder:createModel(WeaponEnhanceMaterialSlotsModel, self.weaponDetailModel)
  self.weaponModel:SetCurrDisplayWeapon(self.weaponUid)
  self.enhanceComp = binder:BindComponent(WeaponEnhanceCompEx(self.ui.UI_Awaker_Item_Weapon_Strengthen, self.weaponDetailModel, self.weaponRefineModel, self.enhanceMtrlSlotsModel, self.showBackTrackToggle))
  self.enhanceComp:SetBackTrackCallBack(function()
    self:Close()
  end)
  self.primaryWeaponSlotModel = binder:createModel(WeaponSlotInfoModel, self.weaponUid)
  binder:BindComponent(WeaponSlotInfoComp(self.ui.UI_Awaker_Panel_Weapon_Main_Item1, self.awakerModel, self.primaryWeaponSlotModel, self.weaponModel))
  self.closeBtn = binder:BindComponent(BtnCloseItem(self.ui.UI_Common_Btn_Back2, function()
    self:Close()
  end))
  binder:BindEvent(EventMgr.Instance.OnWeaponRefineSuccessList, function()
    self.uiAnimController = self.uiAnimController or self.ui.uiNode:GetComponent(typeof(CS.Z1Client.UIAnimationController))
    if self.uiAnimController then
      self.uiAnimController:StopPlayableGraph()
      self.uiAnimController:PlayState("UI_Awaker_Item_Weapon_Strengthen2_WeaponLevelUp")
      AudioManager.Instance:PostSoundEvent("Play_Anim_Wheel_Levelup_VFX")
    end
  end)
end

function AwakerWeaponStrengthPanel:_OnBindHUDHideGroup()
  self.binder:SetActive(self.ui.Btn_Check, true)
  self.binder:BindButtonClick(self.ui.Btn_Check, function()
    self:_HideHUD()
  end)
  self.binder:BindButtonClick(self.ui.Btn_Mask, function()
    self:_ShowHUD()
  end)
  GlobalDispatcher:AddListener(NotifyId.OnInputDeviceOrientationChanged, self._OnInputDeviceOrientationChanged, self)
  GlobalDispatcher:AddListener(NotifyId.OnScreenOrientationChanged, self._OnScreenOrientationChanged, self)
end

function AwakerWeaponStrengthPanel:_OnScreenOrientationChanged()
  self:_OnPaintingHorizontal()
end

function AwakerWeaponStrengthPanel:_OnInputDeviceOrientationChanged()
  if CS.UnityEngine.Screen.orientation == CS.UnityEngine.ScreenOrientation.LandscapeRight and CS.UnityEngine.Input.deviceOrientation == CS.UnityEngine.DeviceOrientation.LandscapeRight or CS.UnityEngine.Screen.orientation == CS.UnityEngine.ScreenOrientation.LandscapeLeft and CS.UnityEngine.Input.deviceOrientation == CS.UnityEngine.DeviceOrientation.LandscapeLeft then
    self:_OnPaintingHorizontal(true)
  elseif CS.UnityEngine.Input.deviceOrientation == CS.UnityEngine.DeviceOrientation.Portrait then
    self:_OnPaintingVertical()
  end
end

function AwakerWeaponStrengthPanel:_HideHUD()
  self._isHideHUD = true
  self.binder:SetActive(self.ui.Image_bg_1, false)
  self.binder:SetActive(self.ui.Image_bg_2, false)
  self.binder:SetActive(self.ui.Text_C_Title, false)
  self.binder:SetActive(self.ui.UI_Common_Btn_Back2, false)
  self.binder:SetActive(self.ui.UI_Awaker_Item_Weapon_Strengthen, false)
  self.binder:SetActive(self.ui.Btn_Check, false)
  self.binder:SetActive(self.ui.Btn_Mask, true)
  CS.Framework.TransformUtil.SetLocalPos(self.weaponRootTf, 0, 0, 0)
  EventMgr.Instance.OnFrozenWeaponGyroscope:Dispatch()
end

function AwakerWeaponStrengthPanel:_ShowHUD()
  self.binder:SetActive(self.ui.Image_bg_1, true)
  self.binder:SetActive(self.ui.Image_bg_2, true)
  self.binder:SetActive(self.ui.Text_C_Title, true)
  self.binder:SetActive(self.ui.UI_Common_Btn_Back2, true)
  self.binder:SetActive(self.ui.UI_Awaker_Item_Weapon_Strengthen, true)
  self.binder:SetActive(self.ui.Btn_Check, true)
  self.binder:SetActive(self.ui.Btn_Mask, false)
  CS.Framework.TransformUtil.SetLocalPos(self.weaponRootTf, -134.41, 0, 0)
  self:_OnPaintingHorizontal()
  self._isHideHUD = false
  EventMgr.Instance.OnUnfrozenWeaponGyroscope:Dispatch()
end

function AwakerWeaponStrengthPanel:_OnPaintingVertical()
  if not self._isHideHUD then
    return
  end
  DOTween.To(function()
    return 0
  end, function(newV)
    CS.Framework.TransformUtil.SetRotation(self.weaponRootTf, 0, 0, newV)
  end, self:_GetRotation(), OrientaionChangedDuration, self)
  CS.Framework.TransformUtil.SetLocalScale(self.weaponRootTf, 2, 2, 2)
end

function AwakerWeaponStrengthPanel:_OnPaintingHorizontal(withAnim)
  if not self._isHideHUD then
    return
  end
  if withAnim then
    DOTween.To(function()
      do return self._GetRotation end
      return self._GetRotation, self
    end, function(newV)
      CS.Framework.TransformUtil.SetRotation(self.weaponRootTf, 0, 0, newV)
    end, 0, OrientaionChangedDuration, self)
  else
    CS.Framework.TransformUtil.SetRotation(self.weaponRootTf, 0, 0, 0)
  end
  CS.Framework.TransformUtil.SetLocalScale(self.weaponRootTf, 1, 1, 1)
end

function AwakerWeaponStrengthPanel:_GetRotation()
  local rotation = 90
  if CS.UnityEngine.Screen.orientation == CS.UnityEngine.ScreenOrientation.LandscapeRight then
    rotation = -rotation
  end
  return rotation
end

function AwakerWeaponStrengthPanel:OnUnbind()
  EventMgr.Instance.WeaponRefined:Dispatch()
  GlobalDispatcher:RemoveListener(NotifyId.OnInputDeviceOrientationChanged, self._OnInputDeviceOrientationChanged, self)
  GlobalDispatcher:RemoveListener(NotifyId.OnScreenOrientationChanged, self._OnInputDeviceOrientationChanged, self)
end

return AwakerWeaponStrengthPanel
