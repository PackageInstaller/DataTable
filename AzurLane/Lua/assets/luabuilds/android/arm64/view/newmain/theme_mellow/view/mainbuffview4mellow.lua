local var_0_0 = class("MainBuffView4Mellow", import("...theme_classic.view.MainBuffView"))

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_0.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	arg_1_0.buffOffsetX = 6
	arg_1_0.noTagStartPos = 130
	arg_1_0.hasTagStartPos = 290
	arg_1_0.tagPos = Vector3(-170, -2.5, 0)

	return
end

function var_0_0.GetDirection(arg_2_0)
	return Vector2.zero
end

return var_0_0
