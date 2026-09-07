local WorldAchievement = class("WorldAchievement", import("...BaseEntity"))

WorldAchievement.Fields = {
	triggers = "table",
	id = "number",
	config = "table"
}

function WorldAchievement:Setup(arg_1_1)
	self.id = arg_1_1
	self.config = pg.world_target_data[self.id]

	assert(self.config, "world_target_data not exist: " .. self.id)

	local var_1_0 = {}

	for iter_1_0, iter_1_1 in ipairs(self.config.condition) do
		local var_1_1 = WorldTrigger.New()

		var_1_1:Setup(iter_1_1[1])

		var_1_1.progress = 0
		var_1_1.maxProgress = iter_1_1[2]
		var_1_1.desc = self.config.condition_text[iter_1_0]

		table.insert(var_1_0, var_1_1)
	end

	self.triggers = var_1_0

	return
end

function WorldAchievement:NetUpdate(arg_2_1)
	local var_2_0
	local var_2_1 = {}

	_.each(arg_2_1, function(arg_3_0)
		local var_3_0 = self:GetTrigger(arg_3_0.trigger_id)

		assert(var_3_0, "can not find trigger: " .. arg_3_0.trigger_id)

		if var_3_0 then
			var_3_0.progress = arg_3_0.count

			if not var_3_0:IsAchieved() and var_3_0:IsAchieved() then
				if #self.triggers > 1 then
					table.insert(var_2_1, var_3_0:GetDesc())
				end

				if self:IsAchieved() then
					var_2_0 = self
				end
			end
		end

		return
	end)

	return var_2_1, nil
end

function WorldAchievement:GetTrigger(arg_4_1)
	return _.detect(self.triggers, function(arg_5_0)
		return arg_5_0.id == arg_4_1
	end)
end

function WorldAchievement:GetTriggers()
	return self.triggers
end

function WorldAchievement:IsAchieved()
	return _.all(self.triggers, function(arg_8_0)
		return arg_8_0:IsAchieved()
	end)
end

function WorldAchievement:GetProgress()
	if #self.triggers > 1 then
		return _.reduce(self.triggers, 0, function(arg_10_0, arg_10_1)
			return arg_10_0 + (arg_10_1:IsAchieved() and 1 or 0)
		end)
	else
		return self.triggers[1]:GetProgress()
	end

	return
end

function WorldAchievement:GetMaxProgress()
	if #self.triggers > 1 then
		return #self.triggers
	else
		return self.triggers[1]:GetMaxProgress()
	end

	return
end

return WorldAchievement
