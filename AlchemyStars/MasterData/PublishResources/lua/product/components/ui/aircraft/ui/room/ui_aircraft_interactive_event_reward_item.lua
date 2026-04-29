_class("UIAircraftInteractiveEventRewardItem", UICustomWidget)
UIAircraftInteractiveEventRewardItem = UIAircraftInteractiveEventRewardItem

function UIAircraftInteractiveEventRewardItem:OnShow(uiParams)
  local sop = self:GetUIComponent("UISelectObjectPath", "uiitem")
  self.uiItem = sop:SpawnObject("UIItem")
  self.uiItem:SetForm(UIItemForm.Base, UIItemScale.Level3)
  self.uiItem:SetClickCallBack(function()
    self:UIItemsWidgetOnClick()
  end)
end

function UIAircraftInteractiveEventRewardItem:SetData(id, count)
  self._matID = id
  self._cfgData = Cfg.cfg_item[id]
  local itemId = id
  local icon = self._cfgData.Icon
  local quality = self._cfgData.Color
  local text1 = count
  self.uiItem:SetData({
    icon = icon,
    quality = quality,
    text1 = text1,
    itemId = itemId
  })
end

function UIAircraftInteractiveEventRewardItem:UIItemsWidgetOnClick(go)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.AircraftInteractiveEventRewardShowItemTips, self._matID, self:GetGameObject().transform.position)
end
