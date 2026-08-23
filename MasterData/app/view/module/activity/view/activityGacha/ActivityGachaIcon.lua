local var_0_0 = g.core.model.User.activityMonthGachaData
local ActivityGachaIcon = class("ActivityGachaIcon", require("app.fairyGUI.activity.UI_ActivityGachaIcon"))

function ActivityGachaIcon:updateId(arg_1_1)
	local var_1_0, var_1_1 = var_0_0:getTargetRewardById(arg_1_1)

	self.m_qualityController:setSelectedIndex(var_1_1 - 1)
	self.m_itemComp:updateIcon(var_1_0)
end

function ActivityGachaIcon:playIconEffect()
	self.m_enterTransition:play()
	self.m_itemComp:playIconEffect(...)
end

return ActivityGachaIcon
