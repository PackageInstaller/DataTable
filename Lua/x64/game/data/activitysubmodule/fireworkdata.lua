local var_0_0 = singletonClass("FireWorkData")
local var_0_1 = {}
local var_0_2 = {}

function var_0_0.Init(arg_1_0)
	var_0_1 = {}
end

function var_0_0.InitFireData(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_1.activity_id
	local var_2_1 = arg_2_1.is_invited == 1
	local var_2_2 = arg_2_1.is_admitted == 1

	var_0_1[var_2_0] = {
		is_invited = var_2_1,
		is_rewarded = var_2_2
	}
end

function var_0_0.SetRewarded(arg_3_0, arg_3_1, arg_3_2)
	var_0_1[arg_3_1] = var_0_1[arg_3_1] or {}
	var_0_1[arg_3_1].is_rewarded = arg_3_2
end

function var_0_0.GetReward(arg_4_0, arg_4_1)
	if var_0_1[arg_4_1] then
		return var_0_1[arg_4_1].is_rewarded
	else
		return true
	end
end

function var_0_0.SetInvited(arg_5_0, arg_5_1, arg_5_2)
	var_0_1[arg_5_1] = var_0_1[arg_5_1] or {}
	var_0_1[arg_5_1].is_invited = arg_5_2
end

function var_0_0.GetInvited(arg_6_0, arg_6_1)
	if var_0_1[arg_6_1] then
		return var_0_1[arg_6_1].is_invited
	else
		return false
	end
end

function var_0_0.GetFireData(arg_7_0, arg_7_1)
	return var_0_1[arg_7_1]
end

function var_0_0.SetRead(arg_8_0, arg_8_1)
	table.insert(var_0_2, arg_8_1)
end

function var_0_0.GetRead(arg_9_0, arg_9_1)
	return table.indexof(var_0_2, arg_9_1)
end

return var_0_0
