local UINLevelEnemyNode = class("UINLevelEnemyNode", UIBaseNode)
local base = UIBaseNode

function UINLevelEnemyNode:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINLevelEnemyNode:InitInfoNode(LevelDtail)
end

function UINLevelEnemyNode:OnDelete()
  base.OnDelete(self)
end

return UINLevelEnemyNode
