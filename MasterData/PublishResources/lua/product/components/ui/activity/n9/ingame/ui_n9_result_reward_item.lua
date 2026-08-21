_class("UIN9ResultRewardItem", UICustomWidget)
UIN9ResultRewardItem = UIN9ResultRewardItem

function UIN9ResultRewardItem:OnShow()
  self._iconImg = self:GetUIComponent("RawImageLoader", "Icon")
  self._countLabel = self:GetUIComponent("UILocalizationText", "Count")
  self._go = self:GetGameObject()
end

function UIN9ResultRewardItem:Refresh(reward)
  self._go:SetActive(true)
  self._rewardId = reward[1]
  self._countLabel.text = reward[2]
  local ItemTempleate = Cfg.cfg_item[self._rewardId]
  self._iconImg:LoadImage(ItemTempleate.Icon)
end

function UIN9ResultRewardItem:BtnOnClick()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.OnN9SubjectRewardItemClicked, self._rewardId, self._go.transform.position)
end
