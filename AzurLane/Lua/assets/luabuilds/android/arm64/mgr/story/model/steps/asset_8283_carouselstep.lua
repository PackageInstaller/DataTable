class = var_0_10000

local var_0_0 = "CarouselStep"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".StoryStep"))

function var_0_1.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.bgs = arg_1_1.bgs

	return
end

function var_0_1.GetMode(arg_2_0)
	Story = var_1_10001

	return var_1_10001.MODE_CAROUSE
end

function var_0_1.GetBgs(arg_3_0)
	return arg_3_0.bgs
end

return var_0_1
