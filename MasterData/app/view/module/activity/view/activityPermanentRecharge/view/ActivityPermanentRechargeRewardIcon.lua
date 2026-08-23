local ActivityPermanentRechargeRewardIcon = class("ActivityPermanentRechargeRewardIcon", require("app.fairyGUI.activity.UI_ActivityPermanentRechargeRewardIcon"))

function ActivityPermanentRechargeRewardIcon:updateIcon(arg_1_1, arg_1_2, arg_1_3)
	self.m_hasDrawController:setSelectedIndex(arg_1_2 and 1 or 0)

	if arg_1_3 then
		self.m_hasDrawController:setSelectedIndex(0)
	end

	self.m_icon:updateIcon(arg_1_1)
end

return ActivityPermanentRechargeRewardIcon
