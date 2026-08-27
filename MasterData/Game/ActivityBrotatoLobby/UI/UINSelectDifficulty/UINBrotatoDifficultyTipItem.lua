local UINBrotatoDifficultyTipItem = class("UINBrotatoDifficultyTipItem", UIBaseNode)
local UIBaseNode

function UINBrotatoDifficultyTipItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINBrotatoDifficultyTipItem:InitBrotatoDifficultyTipItem(tipString)
  self.ui.tex_Des.text = tipString
end

return UINBrotatoDifficultyTipItem
