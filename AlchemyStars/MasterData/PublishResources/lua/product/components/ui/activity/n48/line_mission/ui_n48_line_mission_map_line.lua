_class("UIN48LineMissionMapLine", UICustomWidget)
UIN48LineMissionMapLine = UIN48LineMissionMapLine

function UIN48LineMissionMapLine:OnShow()
  self._rect = self:GetUIComponent("RectTransform", "shape")
end

function UIN48LineMissionMapLine:OnHide()
end

function UIN48LineMissionMapLine:Flush(from, to)
  local trans = self:GetUIComponent("RectTransform", "shape")
  trans.anchorMax = Vector2(0, 0.5)
  trans.anchorMin = Vector2(0, 0.5)
  local type = to.y > from.y and 2 or 1
  local objs = UIWidgetHelper.GetObjGroupByWidgetName(self, {
    [1] = {"line2"},
    [2] = {"line1"}
  })
  UIWidgetHelper.SetObjGroupShow(objs, type)
  local anchoredPosition = from
  trans.anchoredPosition = anchoredPosition
end
