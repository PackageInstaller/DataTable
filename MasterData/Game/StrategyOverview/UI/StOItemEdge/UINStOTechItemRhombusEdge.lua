local UINStOTechItemBaseEdge = require("Game.StrategyOverview.UI.StOItemEdge.UINStOTechItemBaseEdge")
local UINStOTechItemRhombusEdge = class("UINStOTechItemRhombusEdge", UINStOTechItemBaseEdge)
local base = UINStOTechItemBaseEdge

function UINStOTechItemRhombusEdge:InitEdge(techItem)
  base.InitEdge(self, techItem)
  techItem.ui.img_Icon.transform:SetParent(self.ui.img_RewardNodePlus.transform)
end

return UINStOTechItemRhombusEdge
