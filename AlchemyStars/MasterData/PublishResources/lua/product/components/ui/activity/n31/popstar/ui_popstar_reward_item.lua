_class("UIPopStarRewardItem", UICustomWidget)
UIPopStarRewardItem = UIPopStarRewardItem

function UIPopStarRewardItem:OnShow()
  self._complete = self:GetGameObject("Complete")
  self._countLabel = self:GetUIComponent("UILocalizationText", "Count")
  self._iconLoader = self:GetUIComponent("RawImageLoader", "Icon")
  self._btnImg = self:GetUIComponent("Image", "Btn")
  self._go = self:GetGameObject()
end

function UIPopStarRewardItem:SetData(data, isComplete, scale, callback)
  self._go.transform.localScale = Vector3(scale, scale, scale)
  self._callback = callback
  self._complete:SetActive(isComplete)
  self._btnImg.enabled = not isComplete
  self._countLabel:SetText(data[2] .. "")
  local cfg = Cfg.cfg_item[data[1]]
  if not cfg then
    return
  end
  self._iconLoader:LoadImage(cfg.Icon)
  self._data = data
end

function UIPopStarRewardItem:BtnOnClick()
  if self._callback then
    self._callback(self._data[1], self._go.transform.position)
  end
end
