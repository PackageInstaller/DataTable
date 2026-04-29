_class("UIFeatureShopInfoItem", UICustomWidget)
UIFeatureShopInfoItem = UIFeatureShopInfoItem

function UIFeatureShopInfoItem:Constructor(uiview, index, callBack)
  self._view = uiview
  self._index = index
  self._callBack = callBack
  self.text = self._view:GetUIComponent("UILocalizationText", "CellText")
  self.lock = self._view:GetUIComponent("RawImage", "Lock")
  self.select = self._view:GetGameObject("Select")
  self.cellImage = self._view:GetUIComponent("RawImageLoader", "CellImage")
  self.hadInvest = self._view:GetGameObject("HadInvest")
  self.mask = self._view:GetGameObject("Mask")
  self._anim = self._view:GetUIComponent("Animation", "CellItem")
end

function UIFeatureShopInfoItem:OnHide()
end

function UIFeatureShopInfoItem:OnRefresh(isLock, hadInvest, cantSelect)
  self._isLock = isLock
  self._hadInvest = hadInvest
  self._cantSelect = cantSelect
  local shopUIHadSeeUnlockCellList = FeatureServiceHelper.GetShopUIHadSeeUnlockCellList()
  if isLock and not table.icontains(shopUIHadSeeUnlockCellList, self._index) then
    self.lock.color = Color(1, 1, 1, 1)
  else
    self.lock.color = Color(1, 1, 1, 0)
  end
  self.hadInvest:SetActive(hadInvest)
  local showMask = hadInvest == false and cantSelect == true
  self.mask:SetActive(showMask)
  self._selectStage = false
  self.select:SetActive(self._selectStage)
end

function UIFeatureShopInfoItem:OnPlayAnimHadInvest()
  self._anim:Play("uieff_UIFeatureShopInfo_CellItem_HadInvest")
end

function UIFeatureShopInfoItem:OnPlayAnimCantInvest()
  self._anim:Play("uieff_UIFeatureShopInfo_CellItem_NotInvest")
end

function UIFeatureShopInfoItem:OnPlayAnimUnlock()
  self._isLock = false
  self._anim:Play("uieff_UIFeatureShopInfo_CellItem_unlock")
end

function UIFeatureShopInfoItem:ButtonOnClick(go)
  if self._isLock or self._hadInvest or self._cantSelect then
  else
    if self._selectStage == false then
      self._selectStage = true
    else
      self._selectStage = false
    end
    self.select:SetActive(self._selectStage)
  end
  if self._callBack then
    self._callBack(self._index, self._selectStage)
  end
end

function UIFeatureShopInfoItem:ClearSelect()
  if self._cantSelect then
    return
  end
  self._selectStage = false
  if self._cantSelect == false then
    self.select:SetActive(self._selectStage)
  end
end
