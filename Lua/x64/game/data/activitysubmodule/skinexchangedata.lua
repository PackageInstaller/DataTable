local var_0_0 = singletonClass("SkinExchangeData")
local var_0_1 = {}

function var_0_0.Init(arg_1_0)
	var_0_1 = {}
end

function var_0_0.SetData(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_1.activity_id

	if not var_0_1[var_2_0] then
		var_0_1[var_2_0] = {}
		var_0_1[var_2_0].activityID = var_2_0
	end

	var_0_1[var_2_0].state = arg_2_1.received_state
end

function var_0_0.SetState(arg_3_0, arg_3_1)
	if var_0_1[arg_3_1] then
		var_0_1[arg_3_1].state = 1
	end
end

function var_0_0.GetState(arg_4_0, arg_4_1)
	if var_0_1[arg_4_1] then
		return var_0_1[arg_4_1].state
	end

	return 1
end

return var_0_0
