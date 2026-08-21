local var_0_0 = class("SlideCommand", import("model.vo.BaseVO"))

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_0.super.Ctor(arg_1_0, pg.dorm3d_slide_command[arg_1_1])

	arg_1_0.id = arg_1_1
	arg_1_0.type = pg.dorm3d_slide_command[arg_1_1].type
	arg_1_0.target = pg.dorm3d_slide_command[arg_1_1].target
	arg_1_0.anim = pg.dorm3d_slide_command[arg_1_1].anim
	arg_1_0.time = pg.dorm3d_slide_command[arg_1_1].time
	arg_1_0.fade_in_time = pg.dorm3d_slide_command[arg_1_1].fade_in_time
	arg_1_0.effect = pg.dorm3d_slide_command[arg_1_1].effect
	arg_1_0.wet = pg.dorm3d_slide_command[arg_1_1].wet

	if arg_1_0.target and arg_1_0.target ~= "" then
		arg_1_0.target = arg_1_2:Find(arg_1_0.target)
	end

	return
end

function var_0_0.GetFadeInTime(arg_2_0)
	if arg_2_0.fade_in_time and arg_2_0.fade_in_time ~= 0 then
		return arg_2_0.fade_in_time
	else
		return DormConst.DEFAULT_ANIM_FADE_IN_TIME
	end

	return
end

function var_0_0.HasEffect(arg_3_0)
	return arg_3_0.effect and arg_3_0.effect ~= ""
end

function var_0_0.HasWet(arg_4_0)
	return arg_4_0.wet and arg_4_0.wet ~= ""
end

function var_0_0.GetEffect(arg_5_0)
	if arg_5_0:HasEffect() then
		return arg_5_0.effect[1], arg_5_0.effect[2]
	end

	return
end

function var_0_0.GetWet(arg_6_0)
	if arg_6_0:HasWet() then
		return arg_6_0.wet[1], arg_6_0.wet[2]
	end

	return
end

return var_0_0
