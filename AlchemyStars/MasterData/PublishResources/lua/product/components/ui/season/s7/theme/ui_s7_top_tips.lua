_class("UIS7TopTips", UICustomWidget)
UIS7TopTips = UIS7TopTips

function UIS7TopTips:OnShow(uiParams)
end

function UIS7TopTips:OnHide()
  self:_DetachEvents()
end

function UIS7TopTips:SetData(itemId)
  self._itemId = itemId
  self:_Refresh()
  self:_AttachEvents()
end

function UIS7TopTips:_Refresh()
  self:_SetIconText(self._itemId, "_icon", "_text")
end

function UIS7TopTips:_SetIconText(itemId, widgetIcon, widgetText)
  local atlasName = "UICommon.spriteatlas"
  local spriteName = "toptoon_" .. itemId
  UIWidgetHelper.SetImageSprite(self, widgetIcon, atlasName, spriteName)
  UIWidgetHelper.SetItemCount(self, itemId, widgetText)
end

function UIS7TopTips:BtnOnClick()
  Log.info("UIS7TopTips:BtnOnClick")
  self:ShowDialog("UIItemGetPathController", self._itemId)
end

function UIS7TopTips:_AttachEvents()
  self:AttachEvent(GameEventType.ItemCountChanged, self._Refresh)
end

function UIS7TopTips:_DetachEvents()
  self:DetachEvent(GameEventType.ItemCountChanged, self._Refresh)
end
