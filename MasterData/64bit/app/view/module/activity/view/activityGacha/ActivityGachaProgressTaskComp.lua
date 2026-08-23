local var_0_0 = {
	{
		0,
		110
	},
	{
		170,
		280
	},
	{
		340,
		450
	},
	{
		510,
		620
	},
	{
		680,
		790
	},
	{
		850,
		960
	}
}
local var_0_1 = g.core.model.User.activityMonthGachaData
local ActivityGachaProgressTaskComp = class("ActivityGachaProgressTaskComp", require("app.fairyGUI.activity.UI_ActivityGachaProgressTaskComp"))

function ActivityGachaProgressTaskComp:ctor()
	self.m_progress:setMax(1000)
end

function ActivityGachaProgressTaskComp:updateProgressView()
	local var_2_0 = var_0_1:getTaskData(true)
	local var_2_1 = var_0_1:getDrawTimes()
	local var_2_2 = 0

	for iter_2_0, iter_2_1 in ipairs(var_2_0) do
		local var_2_3

		if -1 == -1 and (var_2_1 <= iter_2_1.taskCfg.task_value or iter_2_0 == #var_2_0) then
			var_2_3 = iter_2_0
			var_2_2 = var_0_0[iter_2_0][1] + (var_2_1 - 0) / (iter_2_1.taskCfg.task_value - 0) * 110
		end

		if self["m_reward" .. iter_2_0] then
			self["m_reward" .. iter_2_0]:updateGachaTaskReward(iter_2_1)
		end
	end

	self.m_numTxt:setText(var_2_1)

	if (self.lastValue or 0) >= 1000 then
		return
	end

	self.m_progress:setValue(var_2_2)

	self.lastValue = var_2_2
end

return ActivityGachaProgressTaskComp
