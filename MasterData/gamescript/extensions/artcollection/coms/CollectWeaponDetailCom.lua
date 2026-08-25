local DOTween = CS.DG.Tweening.DOTween
local OrientaionChangedDuration = 0.5
local CollectWeaponDetailCom, Super = NewViewComponent("CollectWeaponDetailCom")

function CollectWeaponDetailCom:ctor(uiNode, view, weaponCollectTid)
  Super.ctor(self, uiNode, view)
  self.ui = UI_Collection_Panel_EquipDetailResource(uiNode)
  self:_InitViewData(weaponCollectTid)
end

function CollectWeaponDetailCom:OnEnterComponent()
  Super.OnEnterComponent(self)
  self.weaponRootTf = self.ui.Item_Weapon.transform
  self:_RefreshView()
end

function CollectWeaponDetailCom:RegisterEvents()
  self:AddButtonClickListener(self.ui.Btn_Check, System.fn(self, self._HideHUD))
  self:AddButtonClickListener(self.ui.Btn_Mask, System.fn(self, self._ShowHUD))
end

function CollectWeaponDetailCom:RegisterNotifications()
  self:RegisterNotify(NotifyId.OnInputDeviceOrientationChanged, System.fn(self, self._OnInputDeviceOrientationChanged))
  self:RegisterNotify(NotifyId.OnScreenOrientationChanged, System.fn(self, self._OnScreenOrientationChanged))
end

function CollectWeaponDetailCom:_OnScreenOrientationChanged()
  self:_OnPaintingHorizontal()
end

function CollectWeaponDetailCom:_OnInputDeviceOrientationChanged()
  if CS.UnityEngine.Screen.orientation == CS.UnityEngine.ScreenOrientation.LandscapeRight and CS.UnityEngine.Input.deviceOrientation == CS.UnityEngine.DeviceOrientation.LandscapeRight or CS.UnityEngine.Screen.orientation == CS.UnityEngine.ScreenOrientation.LandscapeLeft and CS.UnityEngine.Input.deviceOrientation == CS.UnityEngine.DeviceOrientation.LandscapeLeft then
    self:_OnPaintingHorizontal(true)
  elseif CS.UnityEngine.Input.deviceOrientation == CS.UnityEngine.DeviceOrientation.Portrait then
    self:_OnPaintingVertical()
  end
end

function CollectWeaponDetailCom:_InitViewData(weaponCollectTid)
  self._weaponCollectTid = weaponCollectTid
end

function CollectWeaponDetailCom:_RefreshView()
  self:SetActive(self.ui.Btn_Check, true)
  self:SetActive(self.ui.Item_Trinket, false)
  self:SetActive(self.ui.Item_Weapon, true)
  local collectCfg = CollectionHallCfgUtils.GetCfg(self._weaponCollectTid)
  local itemCfg = CollectionHallCfgUtils.GetCollectionItemCfg(self._weaponCollectTid)
  local viewData = {
    path = itemCfg.SpIcon,
    scale = 0.8
  }
  self:AddViewComponentOnce(self.ui.Image_Weapon_Large, CompPublicAwakerWeapon, viewData)
  self:SetImage(self.ui.Image_Weapon_Quality, DT.ItemQuality[itemCfg.Quality].BigWeaponFrame)
  self:SetText(self.ui.Text_Name, LT.Text(collectCfg.Title))
  self:SetText(self.ui.Text_Desc, LT.Text(collectCfg.Desc))
  StrUtils.SetPreferredHeight(self.ui.Text_Desc, 10)
end

function CollectWeaponDetailCom:_HideHUD()
  self._isHideHUD = true
  self.binder:SetActive(self.ui.Group_Info, false)
  self.binder:SetActive(self.ui.Btn_Check, false)
  self.binder:SetActive(self.view.ui.Group_Line, false)
  self.binder:SetActive(self.view.ui.TitleCon, false)
  self.binder:SetActive(self.ui.Btn_Mask, true)
  CS.Framework.TransformUtil.SetLocalPos(self.weaponRootTf, 0, 0, 0)
  EventMgr.Instance.OnFrozenWeaponGyroscope:Dispatch()
end

function CollectWeaponDetailCom:_ShowHUD()
  self.binder:SetActive(self.ui.Group_Info, true)
  self.binder:SetActive(self.ui.Btn_Check, true)
  self.binder:SetActive(self.view.ui.Group_Line, true)
  self.binder:SetActive(self.view.ui.TitleCon, true)
  self.binder:SetActive(self.ui.Btn_Mask, false)
  CS.Framework.TransformUtil.SetLocalPos(self.weaponRootTf, -180, 0, 0)
  self:_OnPaintingHorizontal()
  self._isHideHUD = false
  EventMgr.Instance.OnUnfrozenWeaponGyroscope:Dispatch()
end

function CollectWeaponDetailCom:_OnPaintingVertical()
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

function CollectWeaponDetailCom:_OnPaintingHorizontal(withAnim)
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

function CollectWeaponDetailCom:_GetRotation()
  local rotation = 90
  if CS.UnityEngine.Screen.orientation == CS.UnityEngine.ScreenOrientation.LandscapeRight then
    rotation = -rotation
  end
  return rotation
end

return CollectWeaponDetailCom
