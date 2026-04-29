_class("UIBuildRaiseFishWishFishItem", UICustomWidget)
UIBuildRaiseFishWishFishItem = UIBuildRaiseFishWishFishItem

function UIBuildRaiseFishWishFishItem:OnShow(uiParams)
  self._iconLoader = self:GetUIComponent("RawImageLoader", "Icon")
  self._qualityLoader = self:GetUIComponent("RawImageLoader", "Quality")
  self._backGround = self:GetGameObject("BackGround")
  self._isEmpty = true
end

function UIBuildRaiseFishWishFishItem:Refresh(raiseFish, raiseFishData)
  self._isEmpty = false
  self._iconLoader:LoadImage(raiseFishData:GetIcon())
  self._qualityLoader:LoadImage("n17_xxc_yangyu_kuang0" .. raiseFishData:GetColor())
  self._raiseFishData = raiseFishData
  self._raiseFish = raiseFish
  self:ShowBackGround(false)
end

function UIBuildRaiseFishWishFishItem:ShowBackGround(visible)
  if self._backGround then
    self._backGround:SetActive(visible)
  end
  self._iconLoader.gameObject:SetActive(not visible)
  self._qualityLoader.gameObject:SetActive(not visible)
  self._isEmpty = visible
end

function UIBuildRaiseFishWishFishItem:BtnOnClick(go)
  if self._isEmpty then
    return
  end
  self._raiseFish:UnRaiseFish(self._raiseFishData)
end
