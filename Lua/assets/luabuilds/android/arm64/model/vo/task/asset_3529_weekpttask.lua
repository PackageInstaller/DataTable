local WeekPtTask = class("WeekPtTask", import(".Task"))

function WeekPtTask:Ctor(arg_1_1)
	WeekPtTask.super.Ctor(self, arg_1_1)

	self.isWeekTask = true

	return
end

function WeekPtTask:bindConfigTable()
	return pg.weekly_task_template
end

function WeekPtTask:getConfig(arg_3_1)
	local var_3_0 = self:bindConfigTable()[self.configId]

	assert(var_3_0, self.configId)

	if var_3_0[arg_3_1] then
		if arg_3_1 == "award_display" then
			return {
				var_3_0[arg_3_1]
			}
		else
			return var_3_0[arg_3_1]
		end
	elseif arg_3_1 == "name" or arg_3_1 == "story_id" or arg_3_1 == "story_icon" or arg_3_1 == "scene" then
		return ""
	elseif arg_3_1 == "type" then
		return 4
	elseif arg_3_1 == "level" or arg_3_1 == "visibility" then
		return 1
	elseif arg_3_1 == "priority_type" then
		return 0
	elseif arg_3_1 == "award_choice" then
		return nil
	else
		assert(false, "表 weekly_task_template 没有字段:" .. arg_3_1)
	end

	return
end

function WeekPtTask:GetAward()
	return self:getConfig("award_display")[1]
end

function WeekPtTask:IsFinished()
	return self:isFinish()
end

return WeekPtTask
