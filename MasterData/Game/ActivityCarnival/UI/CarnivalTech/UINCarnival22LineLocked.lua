local UINCarnival22LineLocked = class("UINCarnival22LineLocked", UIBaseNode)
local base = UIBaseNode

function UINCarnival22LineLocked:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINCarnival22LineLocked:InitCarnival22LineLocked(des)
  self.ui.tex_Condition.text = des
end

return UINCarnival22LineLocked
