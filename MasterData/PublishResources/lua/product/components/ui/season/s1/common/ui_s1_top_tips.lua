_class("UIS1TopTips", UICustomWidget)
UIS1TopTips = UIS1TopTips

function UIS1TopTips:OnShow(uiParams)
end

function UIS1TopTips:OnHide()
  self:_DetachEvents()
end

function UIS1TopTips:SetData(itemId)
  self._itemId = itemId
  self:_Refresh()
  self:_AttachEvents()
end

function UIS1TopTips:_Refresh()
  self:_SetIconText(self._itemId, "_icon", "_text")
end

function UIS1TopTips:_SetIconText(itemId, widgetIcon, widgetText)
  local atlasName = "UICommon.spriteatlas"
  local spriteName = "toptoon_" .. itemId
  UIWidgetHelper.SetImageSprite(self, widgetIcon, atlasName, spriteName)
  UIWidgetHelper.SetItemCount(self, itemId, widgetText)
end

function UIS1TopTips:BtnOnClick()
  Log.info("UIS1TopTips:BtnOnClick")
  self:ShowDialog("UIItemGetPathController", self._itemId)
end

function UIS1TopTips:_AttachEvents()
  self:AttachEvent(GameEventType.ItemCountChanged, self._Refresh)
end

function UIS1TopTips:_DetachEvents()
  self:DetachEvent(GameEventType.ItemCountChanged, self._Refresh)
end
