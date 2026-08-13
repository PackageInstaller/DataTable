class = var_0_10000

local var_0_0 = "WorldAchievement"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...BaseEntity"))

var_0_1.Fields = {
	triggers = "table",
	id = "number",
	config = "table"
}

function var_0_1.Setup(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1
	pg = var_1_10002
	arg_1_0.config = var_1_10002.world_target_data[arg_1_0.id]
	assert = var_2

	var_2(arg_1_0.config, "world_target_data not exist: " .. arg_1_0.id)

	local var_1_0 = {}

	ipairs = var_3

	for iter_1_0, iter_1_1 in var_3(arg_1_0.config.condition) do
		WorldTrigger = var_1_10008

		local var_1_1 = var_1_10008.New()

		var_1_10008.Setup(var_1_1, iter_1_1[1])

		var_1_10008.progress = 0
		var_1_10008.maxProgress = iter_1_1[2]
		var_1_10008.desc = arg_1_0.config.condition_text[iter_1_0]
		table = var_9

		var_9.insert(var_1_0, var_1_10008)
	end

	arg_1_0.triggers = var_1_0

	return
end

function var_0_1.NetUpdate(arg_2_0, arg_2_1)
	local var_2_0
	local var_2_1 = {}

	_ = var_1_10004

	var_1_10004.each(arg_2_1, function(arg_3_0)
		local var_3_0 = arg_2_0
		local var_3_1 = var_1.GetTrigger(var_3_0, arg_3_0.trigger_id)

		assert = var_3_0

		var_3_0(var_3_1, "can not find trigger: " .. arg_3_0.trigger_id)

		if var_3_1 then
			local var_3_2 = var_3_1:IsAchieved()

			var_3_1.progress = arg_3_0.count

			if not var_3_2 and var_3_1:IsAchieved() then
				if #arg_2_0.triggers > 1 then
					table = var_3

					var_3.insert(var_2_1, var_3_1:GetDesc())
				end

				local var_3_3 = arg_2_0

				if var_3.IsAchieved(var_3_3) then
					var_2_0 = arg_2_0
				end
			end
		end

		return
	end)

	return var_2_1, var_2_0
end

function var_0_1.GetTrigger(arg_4_0, arg_4_1)
	_ = var_1_10002

	return var_1_10002.detect(arg_4_0.triggers, function(arg_5_0)
		return arg_5_0.id == arg_4_1
	end)
end

function var_0_1.GetTriggers(arg_6_0)
	return arg_6_0.triggers
end

function var_0_1.IsAchieved(arg_7_0)
	_ = var_1_10001

	return var_1_10001.all(arg_7_0.triggers, function(arg_8_0)
		return arg_8_0:IsAchieved()
	end)
end

function var_0_1.GetProgress(arg_9_0)
	if #arg_9_0.triggers > 1 then
		_ = var_1

		return var_1.reduce(arg_9_0.triggers, 0, function(arg_10_0, arg_10_1)
			return arg_10_0 + (arg_10_1:IsAchieved() and 1 or 0)
		end)
	else
		local var_9_0 = arg_9_0.triggers[1]

		return var_1.GetProgress(var_9_0)
	end

	return
end

function var_0_1.GetMaxProgress(arg_11_0)
	if #arg_11_0.triggers > 1 then
		return #arg_11_0.triggers
	else
		local var_11_0 = arg_11_0.triggers[1]

		return var_1.GetMaxProgress(var_11_0)
	end

	return
end

return var_0_1
