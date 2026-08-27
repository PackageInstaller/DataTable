local UINAct21SumExcgRewardGroup = class("UINAct21SumExcgRewardGroup", UIBaseNode)
local base = UIBaseNode

function UINAct21SumExcgRewardGroup:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINAct21SumExcgRewardGroup:InitAct21SumExcgRewardGroup(qualityId, usedNum, totalNum)
  self.ui.title.color = self.ui.color_tileBg[qualityId]
  self.ui.tex_GroupTitle:SetIndex(qualityId - 1)
  self.ui.tex_Total:SetIndex(0, tostring(totalNum - usedNum), tostring(totalNum))
end

function UINAct21SumExcgRewardGroup:OnDelete()
  base.OnDelete(self)
end

return UINAct21SumExcgRewardGroup
