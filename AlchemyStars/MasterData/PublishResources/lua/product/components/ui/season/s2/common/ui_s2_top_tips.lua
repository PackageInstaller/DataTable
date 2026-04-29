_class("UIS2TopTips", UICustomWidget)
UIS2TopTips = UIS2TopTips

function UIS2TopTips:OnShow(uiParams)
end

function UIS2TopTips:OnHide()
  self:_DetachEvents()
end

function UIS2TopTips:SetData(itemId)
  self._itemId = itemId
  self:_Refresh()
  self:_AttachEvents()
end

function UIS2TopTips:_Refresh()
  self:_SetIconText(self._itemId, "_icon", "_text")
end

function UIS2TopTips:_SetIconText(itemId, widgetIcon, widgetText)
  local atlasName = "UICommon.spriteatlas"
  local spriteName = "toptoon_" .. itemId
  UIWidgetHelper.SetImageSprite(self, widgetIcon, atlasName, spriteName)
  UIWidgetHelper.SetItemCount(self, itemId, widgetText)
end

function UIS2TopTips:BtnOnClick()
  Log.info("UIS2TopTips:BtnOnClick")
  self:ShowDialog("UIItemGetPathController", self._itemId)
end

function UIS2TopTips:_AttachEvents()
  self:AttachEvent(GameEventType.ItemCountChanged, self._Refresh)
end

function UIS2TopTips:_DetachEvents()
  self:DetachEvent(GameEventType.ItemCountChanged, self._Refresh)
end
