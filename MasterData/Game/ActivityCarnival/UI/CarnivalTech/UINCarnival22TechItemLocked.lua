local UINCarnival22TechItemLocked = class("UINCarnival22TechItemLocked", UIBaseNode)
local base = UIBaseNode

function UINCarnival22TechItemLocked:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINCarnival22TechItemLocked:SetTechItemLockedAlpha(a)
  local color = self.ui.img_ItemLocked.color
  color.a = a
  self.ui.img_ItemLocked.color = color
end

return UINCarnival22TechItemLocked
