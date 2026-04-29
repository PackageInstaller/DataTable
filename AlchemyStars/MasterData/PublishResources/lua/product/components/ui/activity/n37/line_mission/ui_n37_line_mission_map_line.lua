_class("UIN37LineMissionMapLine", UICustomWidget)
UIN37LineMissionMapLine = UIN37LineMissionMapLine

function UIN37LineMissionMapLine:Flush(from, to)
  local type = to.y > from.y and 1 or 2
  local objs = UIWidgetHelper.GetObjGroupByWidgetName(self, {
    [1] = {"line1"},
    [2] = {"line2"}
  })
  UIWidgetHelper.SetObjGroupShow(objs, type)
  local trans = self:GetUIComponent("RectTransform", "root")
  trans.anchorMax = Vector2(0, 0.5)
  trans.anchorMin = Vector2(0, 0.5)
  local anchoredPosition = (from + to) * 0.5
  trans.anchoredPosition = anchoredPosition
  local x = math.abs(from.x - to.x)
  local y = math.abs(from.y - to.y)
  trans.sizeDelta = Vector2(x, y)
end
