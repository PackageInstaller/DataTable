_class("UICN12N41LineMapLine", UICustomWidget)
UICN12N41LineMapLine = UICN12N41LineMapLine

function UICN12N41LineMapLine:OnShow()
  self._rect = self:GetUIComponent("RectTransform", "shape")
end

function UICN12N41LineMapLine:OnHide()
end

function UICN12N41LineMapLine:Flush(from, to)
  local trans = self:GetUIComponent("RectTransform", "shape")
  trans.anchorMax = Vector2(0, 0.5)
  trans.anchorMin = Vector2(0, 0.5)
  local type = to.y > from.y and 2 or 1
  local objs = UIWidgetHelper.GetObjGroupByWidgetName(self, {
    [1] = {"line1"},
    [2] = {"line2"}
  })
  UIWidgetHelper.SetObjGroupShow(objs, type)
  local offset = type == 1 and Vector2(130, -30) or Vector2(135, 35)
  local anchoredPosition = from + offset
  trans.anchoredPosition = anchoredPosition
end
