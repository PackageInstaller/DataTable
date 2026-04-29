_class("UIActivityNPlusSixRewardItem", UICustomWidget)
UIActivityNPlusSixRewardItem = UIActivityNPlusSixRewardItem

function UIActivityNPlusSixRewardItem:OnShow()
  self._iconImg = self:GetUIComponent("RawImageLoader", "Icon")
  self._countLabel = self:GetUIComponent("UILocalizationText", "Count")
  self._go = self:GetGameObject("go")
end

function UIActivityNPlusSixRewardItem:Refresh(rewardData, isGet)
  self._rewardData = rewardData
  self._countLabel.text = rewardData.count
  local ItemTempleate = Cfg.cfg_item[rewardData.assetid]
  self._iconImg:LoadImage(ItemTempleate.Icon)
  self._go = self:GetGameObject()
  self:SetRawImageGray(isGet)
end

function UIActivityNPlusSixRewardItem:SetRawImageGray(gray)
  local iconRawImg = self:GetUIComponent("RawImage", "Icon")
  local iconObj = self:GetGameObject("Icon")
  local EMIMat = UnityEngine.Material:New(iconRawImg.material)
  if gray then
    local texture = iconRawImg.material.mainTexture
    iconRawImg.material = EMIMat
    iconRawImg.material.mainTexture = texture
    iconRawImg.material:SetFloat("_LuminosityAmount", 1)
  else
    iconRawImg.material:SetFloat("_LuminosityAmount", 0)
  end
  iconObj:SetActive(false)
  iconObj:SetActive(true)
end

function UIActivityNPlusSixRewardItem:btnOnClick()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.ShowItemTips, self._rewardData.assetid, self._go.transform.position)
end
