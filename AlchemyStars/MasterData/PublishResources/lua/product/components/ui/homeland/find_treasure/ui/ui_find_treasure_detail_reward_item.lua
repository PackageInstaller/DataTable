_class("UIFindTreasureDetailRewardItem", UICustomWidget)
UIFindTreasureDetailRewardItem = UIFindTreasureDetailRewardItem

function UIFindTreasureDetailRewardItem:OnShow(uiParams)
  self._iconLoader = self:GetUIComponent("RawImageLoader", "Icon")
  self._countLabel = self:GetUIComponent("UILocalizationText", "Count")
  self._countPanel = self:GetGameObject("CountPanel")
end

function UIFindTreasureDetailRewardItem:Refresh(reward, clickCallback)
  local cfg = Cfg.cfg_item[reward[1]]
  self._iconLoader:LoadImage(cfg.Icon)
  if reward[2] and reward[2] > 0 then
    self._countPanel:SetActive(true)
    self._countLabel:SetText(reward[2])
  else
    self._countPanel:SetActive(false)
  end
  self._id = reward[1]
  self._clickCallback = clickCallback
end

function UIFindTreasureDetailRewardItem:BtnOnClick(go)
  if self._clickCallback then
    self._clickCallback(self._id, go)
  end
end
