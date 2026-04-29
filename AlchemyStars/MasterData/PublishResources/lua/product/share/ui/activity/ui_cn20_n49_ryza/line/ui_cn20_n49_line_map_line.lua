_class("UICN20N49LineMapLine", UICustomWidget)
UICN20N49LineMapLine = UICN20N49LineMapLine

function UICN20N49LineMapLine:OnShow()
  self._rect = self:GetUIComponent("RectTransform", "shape")
end

function UICN20N49LineMapLine:OnHide()
end

function UICN20N49LineMapLine:Flush(from, to)
  local trans = self:GetUIComponent("RectTransform", "shape")
  trans.anchorMax = Vector2(0, 0.5)
  trans.anchorMin = Vector2(0, 0.5)
  local type = to.y > from.y and 2 or 1
  local objs = UIWidgetHelper.GetObjGroupByWidgetName(self, {
    [1] = {"line1"},
    [2] = {"line2"}
  })
  UIWidgetHelper.SetObjGroupShow(objs, type)
  local anchoredPosition = from
  trans.anchoredPosition = anchoredPosition
end
