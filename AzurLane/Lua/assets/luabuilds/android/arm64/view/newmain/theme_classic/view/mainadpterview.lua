local var_0_0 = class("MainAdpterView", import("...base.MainBaseView"))

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	var_0_0.super.Ctor(arg_1_0, arg_1_1, nil)

	arg_1_0.foldableHelperBottom = MainFoldableHelper.New(arg_1_2, Vector2(0, -1))
	arg_1_0.foldableHelperRight = MainFoldableHelper.New(arg_1_3, Vector2(1, 0))

	return
end

function var_0_0.Fold(arg_2_0, arg_2_1, arg_2_2)
	var_0_0.super.Fold(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.foldableHelperBottom:Fold(arg_2_1, arg_2_2)
	arg_2_0.foldableHelperRight:Fold(arg_2_1, arg_2_2)

	return
end

function var_0_0.GetDirection(arg_3_0)
	return Vector2(0, 1)
end

function var_0_0.Dispose(arg_4_0)
	var_0_0.super.Dispose(arg_4_0)
	arg_4_0.foldableHelperBottom:Dispose()
	arg_4_0.foldableHelperRight:Dispose()

	return
end

return var_0_0
