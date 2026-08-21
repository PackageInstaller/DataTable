_class("UIDragImageController", UIController)
UIDragImageController = UIDragImageController

function UIDragImageController:OnShow(uiParams)
  self._scrollViewHelper = H3DScrollViewHelper:New(self, "ScrollView", "UIDragImageItem", function(index, uiwidget)
    return self:_OnShowItem(index, uiwidget)
  end)
  self._scrollViewHelper:Init(20, 0, Vector2(0, 0))
  self._scrollViewHelper:SetCalcScale(true)
end

function UIDragImageController:OnHide()
  self._scrollViewHelper:Dispose()
end

function UIDragImageController:_OnShowItem(index, uiwidget)
  uiwidget:SetData(index)
  Log.debug("UIDragImageController:_OnShowItem", index)
end

function UIDragImageController:ButtonOnClick(go)
  self:CloseDialog()
end
