local var_0_0 = class("WorldAchievement", import("...BaseEntity"))

var_0_0.Fields = {
	triggers = "table",
	id = "number",
	config = "table"
}

function var_0_0.Setup(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1
	arg_1_0.config = pg.world_target_data[arg_1_0.id]

	assert(arg_1_0.config, "world_target_data not exist: " .. arg_1_0.id)

	for iter_1_0, iter_1_1 in ipairs(arg_1_0.config.condition) do
		local var_1_0 = WorldTrigger.New()

		var_1_0:Setup(iter_1_1[1])

		var_1_0.progress = 0
		var_1_0.maxProgress = iter_1_1[2]
		var_1_0.desc = arg_1_0.config.condition_text[iter_1_0]

		table.insert({}, var_1_0)
	end

	arg_1_0.triggers = {}

	return
end

function var_0_0.NetUpdate(arg_2_0, arg_2_1)
	local var_2_0
	local var_2_1 = {}

	_.each(arg_2_1, function(arg_3_0)
		local var_3_0 = arg_2_0:GetTrigger(arg_3_0.trigger_id)

		assert(var_3_0, "can not find trigger: " .. arg_3_0.trigger_id)

		if var_3_0 then
			var_3_0.progress = arg_3_0.count

			if not var_3_0:IsAchieved() and var_3_0:IsAchieved() then
				if #arg_2_0.triggers > 1 then
					table.insert(var_2_1, var_3_0:GetDesc())
				end

				if arg_2_0:IsAchieved() then
					var_2_0 = arg_2_0
				end
			end
		end

		return
	end)

	return {}, nil
end

function var_0_0.GetTrigger(arg_4_0, arg_4_1)
	return _.detect(arg_4_0.triggers, function(arg_5_0)
		return arg_5_0.id == arg_4_1
	end)
end

function var_0_0.GetTriggers(arg_6_0)
	return arg_6_0.triggers
end

function var_0_0.IsAchieved(arg_7_0)
	return _.all(arg_7_0.triggers, function(arg_8_0)
		return arg_8_0:IsAchieved()
	end)
end

function var_0_0.GetProgress(arg_9_0)
	if #arg_9_0.triggers > 1 then
		return _.reduce(arg_9_0.triggers, 0, function(arg_10_0, arg_10_1)
			return arg_10_0 + (arg_10_1:IsAchieved() and 1 or 0)
		end)
	else
		return arg_9_0.triggers[1]:GetProgress()
	end

	return
end

function var_0_0.GetMaxProgress(arg_11_0)
	if #arg_11_0.triggers > 1 then
		return #arg_11_0.triggers
	else
		return arg_11_0.triggers[1]:GetMaxProgress()
	end

	return
end

return var_0_0
