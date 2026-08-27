local UISctBuildResItem = class("UISctBuildResItem", UIBaseNode)
local base = UIBaseNode

function UISctBuildResItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UISctBuildResItem:InitSctBuildResItem(index)
  self.ui.img_Rate.color = self.ui.barColor[index]
end

function UISctBuildResItem:UpdateSctBuildResItem(name, count, progress)
  self.ui.tex_ResName.text = name
  self.ui.tex_ResCount.text = tostring(count)
  self.ui.img_Rate.fillAmount = progress
end

function UISctBuildResItem:OnDelete()
  base.OnDelete(self)
end

return UISctBuildResItem
