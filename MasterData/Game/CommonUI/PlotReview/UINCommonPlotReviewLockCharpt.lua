local UINCommonPlotReviewLockCharpt = class("UINCommonPlotReviewLockCharpt", UIBaseNode)
local base = UIBaseNode

function UINCommonPlotReviewLockCharpt:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINCommonPlotReviewLockCharpt:InitLockedCPRCharpt(AvgGroupData)
  local des = AvgGroupData:GetAvgGroupUnlockDes()
  self.ui.text:SetIndex(1, des)
end

return UINCommonPlotReviewLockCharpt
