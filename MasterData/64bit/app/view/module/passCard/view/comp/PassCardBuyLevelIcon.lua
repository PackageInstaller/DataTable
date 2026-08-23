local PassCardBuyLevelIcon = class("PassCardBuyLevelIcon", require("app.fairyGUI.passCard.UI_PassCardBuyLevelIcon"))

function PassCardBuyLevelIcon:ctor()
	return
end

function PassCardBuyLevelIcon:updateLevelAward(arg_2_1, arg_2_2)
	local var_2_1 = arg_2_1.reward or {}

	self.m_isShowMaskController:setSelectedIndex((arg_2_1.rewardLevel or 1) <= arg_2_2 and 0 or 1)
	self.m_baseIcon:updateIcon(var_2_1)
end

function PassCardBuyLevelIcon:updateLevelAwardNew(arg_3_1)
	self.m_isShowMaskController:setSelectedIndex(arg_3_1.showMask and 1 or 0)
	self.m_baseIcon:updateIcon(arg_3_1)
end

return PassCardBuyLevelIcon
