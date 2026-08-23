local var_0_0 = g.core.common.Goods
local var_0_1 = g.core.model.User.activityCelebrationLoginData
local ActivityCelebrationLoginPreviewCell = class("ActivityCelebrationLoginPreviewCell", require("app.fairyGUI.activity.UI_ActivityCelebrationLoginPreviewCell"))

function ActivityCelebrationLoginPreviewCell:ctor()
	return
end

function ActivityCelebrationLoginPreviewCell:updatePreviewCell(arg_2_1)
	local var_2_0 = var_0_0:convert(arg_2_1)

	self.m_isRecvController:setSelectedIndex(var_0_1:isCumulateRewardReceived(arg_2_1.activityId, (var_0_1:getCumulateRewardKey(arg_2_1.mark, arg_2_1.type, arg_2_1.value))) and 1 or 0)
	self.m_knightIcon:updateIcon(var_2_0)
end

return ActivityCelebrationLoginPreviewCell
