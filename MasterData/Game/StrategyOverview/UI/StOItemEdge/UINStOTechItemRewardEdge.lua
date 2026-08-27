local UINStOTechItemBaseEdge = require("Game.StrategyOverview.UI.StOItemEdge.UINStOTechItemBaseEdge")
local UINStOTechItemRewardEdge = class("UINStOTechItemRewardEdge", UINStOTechItemBaseEdge)
local base = UINStOTechItemBaseEdge

function UINStOTechItemRewardEdge:InitEdge(techItem)
  techItem.ui.norGroup.gameObject:SetActive(false)
  base.InitEdge(self, techItem)
end

function UINStOTechItemRewardEdge:SetState(level, isUnLock)
  if 0 < level then
    self.ui.rewardItem:SetIndex(0)
    self.ui.tex_Got:SetIndex(2)
  elseif isUnLock then
    self.ui.rewardItem:SetIndex(1)
    self.ui.tex_Got:SetIndex(1)
  else
    self.ui.rewardItem:SetIndex(1)
    self.ui.tex_Got:SetIndex(0)
  end
end

return UINStOTechItemRewardEdge
