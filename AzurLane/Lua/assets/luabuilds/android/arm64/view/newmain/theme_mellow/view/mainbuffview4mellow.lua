class = var_0_10000

local var_0_0 = "MainBuffView4Mellow"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...theme_classic.view.MainBuffView"))

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_1.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	arg_1_0.buffOffsetX = 6
	arg_1_0.noTagStartPos = 130
	arg_1_0.hasTagStartPos = 290
	Vector3 = var_3
	arg_1_0.tagPos = var_3(-170, -2.5, 0)

	return
end

function var_0_1.GetDirection(arg_2_0)
	Vector2 = var_1_10001

	return var_1_10001.zero
end

return var_0_1
