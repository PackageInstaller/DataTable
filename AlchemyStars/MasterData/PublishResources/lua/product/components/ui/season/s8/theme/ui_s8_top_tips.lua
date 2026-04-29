_class("UIS8TopTips", UICustomWidget)
UIS8TopTips = UIS8TopTips

function UIS8TopTips:OnShow(uiParams)
end

function UIS8TopTips:OnHide()
  self:_DetachEvents()
end

function UIS8TopTips:SetData(itemId)
  self._itemId = itemId
  self:_Refresh()
  self:_AttachEvents()
end

function UIS8TopTips:_Refresh()
  self:_SetIconText(self._itemId, "_icon", "_text")
end

function UIS8TopTips:_SetIconText(itemId, widgetIcon, widgetText)
  local atlasName = "UICommon.spriteatlas"
  local spriteName = "toptoon_" .. itemId
  UIWidgetHelper.SetImageSprite(self, widgetIcon, atlasName, spriteName)
  UIWidgetHelper.SetItemCount(self, itemId, widgetText)
end

function UIS8TopTips:BtnOnClick()
  Log.info("UIS8TopTips:BtnOnClick")
  self:ShowDialog("UIItemGetPathController", self._itemId)
end

function UIS8TopTips:_AttachEvents()
  self:AttachEvent(GameEventType.ItemCountChanged, self._Refresh)
end

function UIS8TopTips:_DetachEvents()
  self:DetachEvent(GameEventType.ItemCountChanged, self._Refresh)
end
