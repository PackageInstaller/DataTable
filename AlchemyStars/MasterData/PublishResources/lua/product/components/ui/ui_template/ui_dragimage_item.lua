_class("UIDragImageItem", UICustomWidget)
UIDragImageItem = UIDragImageItem

function UIDragImageItem:OnShow(uiParams)
  self._textNum = self:GetUIComponent("Text", "Text")
end

function UIDragImageItem:OnHide()
end

function UIDragImageItem:SetData(index)
  self._textNum.text = index
end
