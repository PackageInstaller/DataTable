_class("UIActivityNPlusSixEventRewardItem", UICustomWidget)
UIActivityNPlusSixEventRewardItem = UIActivityNPlusSixEventRewardItem

function UIActivityNPlusSixEventRewardItem:OnShow()
  self._iconImg = self:GetUIComponent("RawImageLoader", "Icon")
  self._countLabel = self:GetUIComponent("UILocalizationText", "Count")
  self._go = self:GetGameObject("go")
end

function UIActivityNPlusSixEventRewardItem:Refresh(rewardData, isCompletePanel)
  self._rewardData = rewardData
  self._countLabel.text = rewardData.count
  local ItemTempleate = Cfg.cfg_item[rewardData.assetid]
  self._iconImg:LoadImage(ItemTempleate.Icon)
  self._go = self:GetGameObject()
  self._isCompletePanel = isCompletePanel
end

function UIActivityNPlusSixEventRewardItem:btnOnClick()
  if self._isCompletePanel then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.NPlusSixShowEventCompleteRewardTips, self._rewardData.assetid, self._go.transform.position)
  else
    GameGlobal.EventDispatcher():Dispatch(GameEventType.NPlusSixShowEventRewardTips, self._rewardData.assetid, self._go.transform.position)
  end
end
