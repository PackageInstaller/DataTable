local UINWATechSideUpItem = class("UINWATechSideUpItem", UIBaseNode)
local base = UIBaseNode

function UINWATechSideUpItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINWATechSideUpItem:RefreshWATechSideUpItem(isUnlocked, isMaxLevel, shortDes, valueDes, nextLevelValue)
  self.ui.tex_Name.text = shortDes
  if isMaxLevel or valueDes == nextLevelValue then
    self.ui.tex_Value:SetIndex(0, valueDes)
  elseif not isUnlocked then
    self.ui.tex_Value:SetIndex(2, valueDes)
  else
    self.ui.tex_Value:SetIndex(1, valueDes, nextLevelValue)
  end
end

function UINWATechSideUpItem:OnDelete()
  base.OnDelete(self)
end

return UINWATechSideUpItem
