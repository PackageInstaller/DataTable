_class("UICN16N45LineMapLine", UICustomWidget)
UICN16N45LineMapLine = UICN16N45LineMapLine

function UICN16N45LineMapLine:OnShow()
  self._rect = self:GetUIComponent("RectTransform", "shape")
end

function UICN16N45LineMapLine:OnHide()
end

function UICN16N45LineMapLine:Flush(from, to)
  local trans = self:GetUIComponent("RectTransform", "shape")
  trans.anchorMax = Vector2(0, 0.5)
  trans.anchorMin = Vector2(0, 0.5)
  local type = to.y > from.y and 2 or 1
  local objs = UIWidgetHelper.GetObjGroupByWidgetName(self, {
    [1] = {"line1"},
    [2] = {"line2"}
  })
  UIWidgetHelper.SetObjGroupShow(objs, type)
  local offset = type == 1 and Vector2(-80, 105) or Vector2(-80, 75)
  local anchoredPosition = from + offset
  trans.anchoredPosition = anchoredPosition
end
