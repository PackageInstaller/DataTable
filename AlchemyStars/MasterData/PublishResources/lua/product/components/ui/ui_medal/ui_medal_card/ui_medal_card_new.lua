_class("UIMedalCard_New", UICustomWidget)
UIMedalCard_New = UIMedalCard_New

function UIMedalCard_New:Constructor()
  self.roleModule = GameGlobal.GetModule(RoleModule)
  self.visitData = nil
end

function UIMedalCard_New:OnShow(uiParams)
  self:InitWidget()
end

function UIMedalCard_New:InitWidget()
  self.root = self:GetGameObject("root")
  self.imgLock = self:GetGameObject("imgLock")
  self.imgEdit = self:GetGameObject("imgEdit")
  self.imgDetail = self:GetGameObject("imgDetail")
  self.cardPool = self:GetUIComponent("UISelectObjectPath", "card")
  self._rightTopGO = self:GetGameObject("rightTop")
end

function UIMedalCard_New:SetData(visitData, hideRightTop, closeCB)
  if visitData then
    self.visitData = visitData
    self:_SetPlaceData(visitData, true)
    self.imgLock:SetActive(false)
    self.imgEdit:SetActive(false)
  else
    local medalMoule = GameGlobal.GetModule(MedalModule)
    local placeData = medalMoule:GetPlacementInfo()
    self:_SetPlaceData(placeData)
    local unLock = self.roleModule:CheckModuleUnlock(GameModuleID.MD_MEDAL)
    self.imgLock:SetActive(not unLock)
    self.imgEdit:SetActive(unLock)
    self.imgDetail:SetActive(unLock)
  end
  if hideRightTop then
    self._rightTopGO:SetActive(false)
  end
  self.closeCB = closeCB
end

function UIMedalCard_New:_SetPlaceData(placeData, visit)
  if not self.visitData then
    local unLock = self.roleModule:CheckModuleUnlock(GameModuleID.MD_MEDAL)
    if not unLock then
      return
    end
  end
  if not self.card then
    self.card = self.cardPool:SpawnObject("UIMedalCardSimple")
  end
  self.card:SetData(672, placeData, visit, function()
    self:_OnBgClicked()
  end)
end

function UIMedalCard_New:_OnBgClicked()
  if not self.visitData then
    local unLock = self.roleModule:CheckModuleUnlock(GameModuleID.MD_MEDAL)
    if not unLock then
      ToastManager.ShowToast(StringTable.Get("str_function_lock_unlock"))
      return
    end
  end
  self:ShowDetailDialog()
end

function UIMedalCard_New:ImgEditOnClick(go)
  self:ShowDialog("UIN22MedalEdit")
end

function UIMedalCard_New:ImgDetailOnClick(go)
  self:ShowDetailDialog()
end

function UIMedalCard_New:ImgLockOnClick(go)
  ToastManager.ShowToast(StringTable.Get("str_function_lock_zidongzhandou_tips"))
end

function UIMedalCard_New:ShowDetailDialog()
  if self.visitData then
    self:ShowDialog("UIMedalCardDetailController", self.visitData)
  else
    self:ShowDialog("UIMedalCardDetailController", nil, function()
      if self.closeCB then
        self.closeCB()
      end
    end)
  end
end
