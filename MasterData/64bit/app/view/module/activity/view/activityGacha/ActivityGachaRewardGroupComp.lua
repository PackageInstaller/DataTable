local var_0_1 = g.core.model.User.activityMonthGachaData
local ActivityGachaRewardGroupComp = class("ActivityGachaRewardGroupComp", require("app.fairyGUI.activity.UI_ActivityGachaRewardGroupComp"))

function ActivityGachaRewardGroupComp:ctor()
	self.m_rewardABList:setVirtual()
	self.m_rewardABList:setItemRenderer(handler(self, self._onRewardRenderer))
end

function ActivityGachaRewardGroupComp:updateGroup(arg_2_1, arg_2_2)
	self._groupData = arg_2_1

	self.m_rewardABList:setNumItems(#self._groupData)

	local var_2_0, var_2_1 = var_0_1:getAllAndLastNumByQuality(arg_2_2)

	self.m_lastNumTxt:setText(var_2_0 .. "/" .. var_2_1)
end

function ActivityGachaRewardGroupComp:_onDetailClick()
	if not self._clickGood then
		return
	end

	g.core.common.GlobalFunc.pushInfoPop(self._clickGood)
end

function ActivityGachaRewardGroupComp:_onRewardRenderer(arg_4_1, arg_4_2)
	arg_4_2:updateItem(self._groupData[arg_4_1 + 1])
end

return ActivityGachaRewardGroupComp
