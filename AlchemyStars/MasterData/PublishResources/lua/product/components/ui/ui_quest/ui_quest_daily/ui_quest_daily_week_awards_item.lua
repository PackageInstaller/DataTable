_class("UIQuestDailyWeekAwardsItem", UICustomWidget)
UIQuestDailyWeekAwardsItem = UIQuestDailyWeekAwardsItem

function UIQuestDailyWeekAwardsItem:OnShow(uiParams)
end

function UIQuestDailyWeekAwardsItem:SetData(index, reward, callback)
  self:_GetComponents()
  self._index = index
  self._reward = reward
  self._id = reward.assetid
  self._callback = callback
  self:_OnValue()
end

function UIQuestDailyWeekAwardsItem:OnHide()
end

function UIQuestDailyWeekAwardsItem:_GetComponents()
  self._item = self:GetUIComponent("UISelectObjectPath", "item")
end

function UIQuestDailyWeekAwardsItem:_OnValue()
  local cfg_item = Cfg.cfg_item[self._id]
  if cfg_item == nil then
    Log.fatal("[quest] error --> cfg_item is nil ! id --> " .. self._id)
    return
  end
  local award = self._item:SpawnObject("UIQuestSideAwardItem")
  local params = {}
  params.quality = cfg_item.Color
  params.icon = cfg_item.Icon
  params.text = self._reward.count
  award:SetData(self._id, params, self._callback)
end
