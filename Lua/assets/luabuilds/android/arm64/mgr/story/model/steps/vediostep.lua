local var_0_0 = class("VedioStep", import(".StoryStep"))

function var_0_0.Ctor(arg_1_0, arg_1_1)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.cpkPath = arg_1_1.cpkPath
	arg_1_0.skippable = defaultValue(arg_1_1.skippable, true)
	arg_1_0.blackFg = 1

	return
end

function var_0_0.GetMode(arg_2_0)
	return Story.MODE_VEDIO
end

function var_0_0.GetVedioPath(arg_3_0)
	return arg_3_0.cpkPath
end

function var_0_0.GetSkipFlag(arg_4_0)
	return arg_4_0.skippable
end

return var_0_0
