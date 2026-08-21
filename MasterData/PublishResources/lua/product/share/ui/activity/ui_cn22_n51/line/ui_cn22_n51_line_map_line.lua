_class("UICN22N51LineMapLine", UICustomWidget)
UICN22N51LineMapLine = UICN22N51LineMapLine

function UICN22N51LineMapLine:OnShow()
  self._rect = self:GetUIComponent("RectTransform", "shape")
end

function UICN22N51LineMapLine:OnHide()
end

function UICN22N51LineMapLine:Flush(from, to)
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
