_class("UIActivityNPlusSixEventInfoItem", UICustomWidget)
UIActivityNPlusSixEventInfoItem = UIActivityNPlusSixEventInfoItem

function UIActivityNPlusSixEventInfoItem:OnShow()
  self._name = self:GetUIComponent("UILocalizationText", "Name")
  self._go = self:GetGameObject("Go")
  self._contents = self:GetUIComponent("UISelectObjectPath", "Content")
end

function UIActivityNPlusSixEventInfoItem:Refresh(eventData)
  self._eventData = eventData
  if not self._eventData then
    self._go:SetActive(false)
    return
  end
  self._go:SetActive(true)
  self._name.text = self._eventData:GetName()
  local rewards = self._eventData:GetRewards()
  self._contents:SpawnObjects("UIActivityNPlusSixEventRewardItem", #rewards)
  local items = self._contents:GetAllSpawnList()
  for i = 1, #items do
    items[i]:Refresh(rewards[i], false)
  end
end

function UIActivityNPlusSixEventInfoItem:BtnOnClick()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.NPlusSixEventInfoItemClick, self._eventData:GetEventId())
end
