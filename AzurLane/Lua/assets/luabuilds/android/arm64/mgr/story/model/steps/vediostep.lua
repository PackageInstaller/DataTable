class = var_0_10000

local var_0_0 = "VedioStep"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".StoryStep"))

function var_0_1.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.cpkPath = arg_1_1.cpkPath
	defaultValue = var_2
	arg_1_0.skippable = var_2(arg_1_1.skippable, true)
	arg_1_0.blackFg = 1

	return
end

function var_0_1.GetMode(arg_2_0)
	Story = var_1_10001

	return var_1_10001.MODE_VEDIO
end

function var_0_1.GetVedioPath(arg_3_0)
	return arg_3_0.cpkPath
end

function var_0_1.GetSkipFlag(arg_4_0)
	return arg_4_0.skippable
end

return var_0_1
