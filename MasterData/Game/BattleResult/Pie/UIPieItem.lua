local UIPieItem = class("UIPieItem", UIBaseNode)
local base = UIBaseNode

function UIPieItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UIPieItem:InitPieItem(fillAmount, clockwise, color)
  self.ui.img_Pie.fillAmount = fillAmount
  self.ui.img_Pie.color = color
  local pieRoteValue, barRoteValue
  if clockwise then
    pieRoteValue = 360 - 360 * fillAmount
    barRoteValue = -fillAmount * 180
  else
    pieRoteValue = 360 * fillAmount
    barRoteValue = fillAmount * 180
  end
  self.pieRot = Vector3.New(0, 0, pieRoteValue)
  self.ui.img_bar.localEulerAngles = Vector3.New(0, 0, barRoteValue)
  self.transform.localScale = Vector3.one
  self.ui.img_bar.localScale = Vector3.one
end

function UIPieItem:GetTextNodePos()
  return self.ui.tex_Node.position
end

function UIPieItem:GetPieRot()
  return self.pieRot
end

function UIPieItem:SetItemRot(rotVector3)
  self.transform.localEulerAngles = rotVector3
end

function UIPieItem:SetScaleToBig()
  local scale = self.transform.localScale
  scale.x = scale.x * 1.1
  scale.y = scale.y * 1.1
  self.transform.localScale = scale
  scale = self.ui.img_bar.localScale
  scale.x = scale.x * 0.909
  scale.y = scale.y * 0.909
  self.ui.img_bar.localScale = scale
end

function UIPieItem:SetShortBar(isShort)
  if isShort then
    local scale = self.ui.img_bar.localScale
    scale.y = scale.y * 0.8
    self.ui.img_bar.localScale = scale
  end
end

function UIPieItem:OnDelete()
  base.OnDelete(self)
end

return UIPieItem
