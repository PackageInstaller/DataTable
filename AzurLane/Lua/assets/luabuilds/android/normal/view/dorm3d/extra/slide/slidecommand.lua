class = var_0_10000

local var_0_0 = "SlideCommand"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("model.vo.BaseVO"))

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
	pg = var_1_10003

	local var_1_0 = var_1_10003.dorm3d_slide_command[arg_1_1]

	var_0_1.super.Ctor(arg_1_0, var_1_0)

	arg_1_0.id = arg_1_1
	arg_1_0.type = var_1_0.type
	arg_1_0.target = var_1_0.target
	arg_1_0.anim = var_1_0.anim
	arg_1_0.time = var_1_0.time
	arg_1_0.fade_in_time = var_1_0.fade_in_time
	arg_1_0.effect = var_1_0.effect
	arg_1_0.wet = var_1_0.wet

	if arg_1_0.target and arg_1_0.target ~= "" then
		arg_1_0.target = arg_1_2:Find(arg_1_0.target)
	end

	return
end

function var_0_1.GetFadeInTime(arg_2_0)
	if arg_2_0.fade_in_time and arg_2_0.fade_in_time ~= 0 then
		return arg_2_0.fade_in_time
	else
		DormConst = var_1

		return var_1.DEFAULT_ANIM_FADE_IN_TIME
	end

	return
end

function var_0_1.HasEffect(arg_3_0)
	local var_3_0

	if arg_3_0.effect then
		var_3_0 = arg_3_0.effect ~= ""
	end

	return var_3_0
end

function var_0_1.HasWet(arg_4_0)
	local var_4_0

	if arg_4_0.wet then
		var_4_0 = arg_4_0.wet ~= ""
	end

	return var_4_0
end

function var_0_1.GetEffect(arg_5_0)
	if arg_5_0:HasEffect() then
		return arg_5_0.effect[1], arg_5_0.effect[2]
	end

	return
end

function var_0_1.GetWet(arg_6_0)
	if arg_6_0:HasWet() then
		return arg_6_0.wet[1], arg_6_0.wet[2]
	end

	return
end

return var_0_1
