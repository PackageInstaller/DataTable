local UINCommonRewardTimeTips = class("UINCommonRewardTimeTips", UIBaseNode)
local base = UIBaseNode

function UINCommonRewardTimeTips:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINCommonRewardTimeTips:InitCommonRewardTipeTips(monthCardType)
  self.ui.tex_MonthCardTime:SetIndex(monthCardType - 1)
  self.ui.img_monthCardTime.color = self.ui.array_cardTipsColor[monthCardType]
end

return UINCommonRewardTimeTips
