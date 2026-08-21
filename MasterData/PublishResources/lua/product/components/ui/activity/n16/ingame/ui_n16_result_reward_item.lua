_class("UIN16ResultRewardItem", UICustomWidget)
UIN16ResultRewardItem = UIN16ResultRewardItem

function UIN16ResultRewardItem:OnShow()
  self._iconImg = self:GetUIComponent("RawImageLoader", "Icon")
  self._countLabel = self:GetUIComponent("UILocalizationText", "Count")
  self._go = self:GetGameObject()
end

function UIN16ResultRewardItem:Refresh(reward)
  self._go:SetActive(true)
  self._rewardId = reward[1]
  self._countLabel.text = reward[2]
  local ItemTempleate = Cfg.cfg_item[self._rewardId]
  self._iconImg:LoadImage(ItemTempleate.Icon)
end

function UIN16ResultRewardItem:BtnOnClick()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.OnN16SubjectRewardItemClicked, self._rewardId, self._go.transform.position)
end
