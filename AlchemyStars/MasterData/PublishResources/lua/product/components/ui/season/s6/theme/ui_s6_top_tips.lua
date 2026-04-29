_class("UIS6TopTips", UICustomWidget)
UIS6TopTips = UIS6TopTips

function UIS6TopTips:OnShow(uiParams)
end

function UIS6TopTips:OnHide()
  self:_DetachEvents()
end

function UIS6TopTips:SetData(itemId)
  self._itemId = itemId
  self:_Refresh()
  self:_AttachEvents()
end

function UIS6TopTips:_Refresh()
  self:_SetIconText(self._itemId, "_icon", "_text")
end

function UIS6TopTips:_SetIconText(itemId, widgetIcon, widgetText)
  local atlasName = "UICommon.spriteatlas"
  local spriteName = "toptoon_" .. itemId
  UIWidgetHelper.SetImageSprite(self, widgetIcon, atlasName, spriteName)
  UIWidgetHelper.SetItemCount(self, itemId, widgetText)
end

function UIS6TopTips:BtnOnClick()
  Log.info("UIS6TopTips:BtnOnClick")
  self:ShowDialog("UIItemGetPathController", self._itemId)
end

function UIS6TopTips:_AttachEvents()
  self:AttachEvent(GameEventType.ItemCountChanged, self._Refresh)
end

function UIS6TopTips:_DetachEvents()
  self:DetachEvent(GameEventType.ItemCountChanged, self._Refresh)
end
