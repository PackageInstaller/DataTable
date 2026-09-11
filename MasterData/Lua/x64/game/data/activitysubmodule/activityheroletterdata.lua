local var_0_0 = singletonClass("ActivityHeroLetterData")
local var_0_1 = {}
local var_0_2 = {}
local var_0_3 = {}

function var_0_0.Init(arg_1_0)
	var_0_1 = {}
end

function var_0_0.InitFirstTips(arg_2_0, arg_2_1)
	var_0_2 = arg_2_1.activity_id
	var_0_3 = arg_2_1.sign
end

function var_0_0.GetActivityUrl(arg_3_0)
	return var_0_2
end

function var_0_0.SetSign(arg_4_0, arg_4_1)
	if arg_4_1 == var_0_2 then
		var_0_3 = 1
	end
end

function var_0_0.GetSign(arg_5_0, arg_5_1)
	if arg_5_1 == var_0_2 then
		return var_0_3
	end

	return 1
end

function var_0_0.SetData(arg_6_0, arg_6_1)
	var_0_1[arg_6_1.activity_id] = arg_6_1.sign
end

function var_0_0.SetRewardSign(arg_7_0, arg_7_1, arg_7_2)
	var_0_1[arg_7_1] = arg_7_2 and 1 or 0
end

function var_0_0.GetRewwardSign(arg_8_0, arg_8_1)
	return var_0_1[arg_8_1] or 1
end

return var_0_0
