local var_0_0 = g.core.config.celebration_login_gift_info
local ActivityCelebrationLoginProgBar = class("ActivityCelebrationLoginProgBar", require("app.fairyGUI.activity.UI_ActivityCelebrationLoginProgBar"))

function ActivityCelebrationLoginProgBar:ctor()
	return
end

function ActivityCelebrationLoginProgBar:updateProgress(arg_2_1, arg_2_2)
	local var_2_0
	local var_2_1

	if arg_2_1.prev_id > 0 then
		var_2_0 = var_0_0.get(arg_2_1.prev_id)
	end

	if arg_2_1.next_id > 0 then
		var_2_1 = var_0_0.get(arg_2_1.next_id)
	end

	local var_2_2 = 0

	if arg_2_2 >= arg_2_1.day then
		var_2_2 = 50

		if var_2_1 then
			local var_2_3 = math.floor((var_2_1.day - arg_2_1.day) / 2)

			var_2_2 = var_2_2 + math.min(arg_2_2 - arg_2_1.day, var_2_3) / var_2_3 * 50
		end
	elseif var_2_0 and arg_2_2 <= var_2_0.day then
		local var_2_4 = math.floor((arg_2_1.day - var_2_0.day) / 2)

		var_2_2 = math.min(arg_2_2 - (arg_2_1.day - var_2_4), var_2_4) / var_2_4 * 50
	end

	self.m_progBar:setPercent({
		max = 100,
		tween = false,
		cur = var_2_2
	})
	self.m_mask:setVisible(not checkbool(var_2_1))
end

return ActivityCelebrationLoginProgBar
