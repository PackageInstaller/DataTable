local var_0_0 = class("FeastThemeTemplate", import("model.vo.NewBackYard.BackYardSelfThemeTemplate"))

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	var_0_0.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	arg_1_0.mapSize = arg_1_3

	return
end

function var_0_0.GetMapSize(arg_2_0)
	return arg_2_0.mapSize
end

return var_0_0
