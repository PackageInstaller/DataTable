local UINFlappyChocolate = class("UINFlappyChocolate", UIBaseNode)
local base = UIBaseNode

function UINFlappyChocolate:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINFlappyChocolate:OnDelete()
  base.OnDelete(self)
end

return UINFlappyChocolate
