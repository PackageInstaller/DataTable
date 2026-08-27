local UINWAMMMapLineItem = class("UINWAMMMapLineItem", UIBaseNode)
local base = UIBaseNode

function UINWAMMMapLineItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINWAMMMapLineItem:InitWAMMMapLine(startPos, endPos)
  local length, angle, dirVector
  length = Vector2.Distance(startPos, endPos)
  dirVector = endPos - startPos
  angle = Vector2.Angle(Vector2.right, dirVector)
  angle = angle * (0 < Vector3.Cross(Vector3.right, Vector3.New(dirVector.x, dirVector.y, 0)).z and 1 or -1)
  self.transform.anchoredPosition = startPos
  self.transform.localEulerAngles = Vector3.New(0, 0, angle)
  self.transform.sizeDelta = Vector2.New(length, self.transform.sizeDelta.y)
  self.length = length
end

function UINWAMMMapLineItem:SwitchLine2DottedLine()
  self.ui.obj_img_Line:SetActive(false)
  self.ui.obj_img_PipeLine:SetActive(true)
end

function UINWAMMMapLineItem:OnDelete()
  base.OnDelete(self)
end

return UINWAMMMapLineItem
