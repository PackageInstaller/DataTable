local UINChipScoreItem = class("UINChipDisplaceItem", UIBaseNode)
local base = UIBaseNode
local UINBaseEpChipItem = require("Game.Exploration.UI.Base.UINBaseEpChipItem")

function UINChipScoreItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINChipScoreItem:InitChipScoreItem(showType, level, num)
  self.ui.tex_name:SetIndex(showType - 1, tostring(level))
  self.ui.tex_score.text = tostring(num)
end

function UINChipScoreItem:OnDelete()
  base.OnDelete(self)
end

return UINChipScoreItem
