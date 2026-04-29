_class("UIS5TopTips", UICustomWidget)
UIS5TopTips = UIS5TopTips

function UIS5TopTips:OnShow(uiParams)
end

function UIS5TopTips:OnHide()
  self:_DetachEvents()
end

function UIS5TopTips:SetData(itemId)
  self._itemId = itemId
  self:_Refresh()
  self:_AttachEvents()
end

function UIS5TopTips:_Refresh()
  self:_SetIconText(self._itemId, "_icon", "_text")
end

function UIS5TopTips:_SetIconText(itemId, widgetIcon, widgetText)
  local atlasName = "UICommon.spriteatlas"
  local spriteName = "toptoon_" .. itemId
  UIWidgetHelper.SetImageSprite(self, widgetIcon, atlasName, spriteName)
  UIWidgetHelper.SetItemCount(self, itemId, widgetText)
end

function UIS5TopTips:BtnOnClick()
  Log.info("UIS5TopTips:BtnOnClick")
  self:ShowDialog("UIItemGetPathController", self._itemId)
end

function UIS5TopTips:_AttachEvents()
  self:AttachEvent(GameEventType.ItemCountChanged, self._Refresh)
end

function UIS5TopTips:_DetachEvents()
  self:DetachEvent(GameEventType.ItemCountChanged, self._Refresh)
end
