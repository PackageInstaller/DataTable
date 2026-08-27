local base = UIBaseNode
local UINDeliverySimulatorSelectRankItem = class("UINDeliverySimulatorSelectRankItem", base)

function UINDeliverySimulatorSelectRankItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINDeliverySimulatorSelectRankItem:InitDeliverySimulatorSelectRankItem(rankData, index)
  self.ui.tex_Rank.text = string.format("%02d", index)
  self.ui.tex_Player.text = rankData.name
  self.ui.tex_Score.text = rankData.num
end

function UINDeliverySimulatorSelectRankItem:OnDelete()
end

return UINDeliverySimulatorSelectRankItem
