_class("UIS4TopTips", UICustomWidget)
UIS4TopTips = UIS4TopTips

function UIS4TopTips:OnShow(uiParams)
end

function UIS4TopTips:OnHide()
  self:_DetachEvents()
end

function UIS4TopTips:SetData(itemId)
  self._itemId = itemId
  self:_Refresh()
  self:_AttachEvents()
end

function UIS4TopTips:_Refresh()
  self:_SetIconText(self._itemId, "_icon", "_text")
end

function UIS4TopTips:_SetIconText(itemId, widgetIcon, widgetText)
  local atlasName = "UICommon.spriteatlas"
  local spriteName = "toptoon_" .. itemId
  UIWidgetHelper.SetImageSprite(self, widgetIcon, atlasName, spriteName)
  UIWidgetHelper.SetItemCount(self, itemId, widgetText)
end

function UIS4TopTips:BtnOnClick()
  Log.info("UIS4TopTips:BtnOnClick")
  self:ShowDialog("UIItemGetPathController", self._itemId)
end

function UIS4TopTips:_AttachEvents()
  self:AttachEvent(GameEventType.ItemCountChanged, self._Refresh)
end

function UIS4TopTips:_DetachEvents()
  self:DetachEvent(GameEventType.ItemCountChanged, self._Refresh)
end
