local UINChartAreaSector = class("UINChartAreaSector", UIBaseNode)
local base = UIBaseNode

function UINChartAreaSector:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.defaultColor = self.ui.img.color
end

function UINChartAreaSector:InitAthAreaSector(angleOffset, ratio, color)
  self.ui.img.fillAmount = ratio
  if color == nil then
    self.ui.img.color = self.defaultColor
  else
    self.ui.img.color = color
  end
  local eAngle = self.transform.localEulerAngles
  eAngle.z = angleOffset
  self.transform.localEulerAngles = eAngle
end

function UINChartAreaSector:OnDelete()
  base.OnDelete(self)
end

return UINChartAreaSector
