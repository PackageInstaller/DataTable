local UINEnemyTagItem = class("UINEnemyTagItem", UIBaseNode)
local base = UIBaseNode

function UINEnemyTagItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINEnemyTagItem:InitEnemyTagItem(tagTex)
  self.ui.tex_tag.text = tagTex
end

return UINEnemyTagItem
