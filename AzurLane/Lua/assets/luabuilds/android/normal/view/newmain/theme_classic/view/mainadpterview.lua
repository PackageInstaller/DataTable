class = var_0_10000

local var_0_0 = "MainAdpterView"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.MainBaseView"))

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	var_0_1.super.Ctor(arg_1_0, arg_1_1, nil)

	MainFoldableHelper = var_4

	local var_1_0 = var_4.New
	local var_1_1 = arg_1_2

	Vector2 = var_6
	arg_1_0.foldableHelperBottom = var_1_0(var_1_1, var_6(0, -1))
	MainFoldableHelper = var_4

	local var_1_2 = var_4.New
	local var_1_3 = arg_1_3

	Vector2 = var_6
	arg_1_0.foldableHelperRight = var_1_2(var_1_3, var_6(1, 0))

	return
end

function var_0_1.Fold(arg_2_0, arg_2_1, arg_2_2)
	var_0_1.super.Fold(arg_2_0, arg_2_1, arg_2_2)

	local var_2_0 = arg_2_0.foldableHelperBottom

	var_3.Fold(var_2_0, arg_2_1, arg_2_2)

	local var_2_1 = arg_2_0.foldableHelperRight

	var_3.Fold(var_2_1, arg_2_1, arg_2_2)

	return
end

function var_0_1.GetDirection(arg_3_0)
	Vector2 = var_1_10001

	return var_1_10001(0, 1)
end

function var_0_1.Dispose(arg_4_0)
	var_0_1.super.Dispose(arg_4_0)

	local var_4_0 = arg_4_0.foldableHelperBottom

	var_1.Dispose(var_4_0)

	local var_4_1 = arg_4_0.foldableHelperRight

	var_1.Dispose(var_4_1)

	return
end

return var_0_1
