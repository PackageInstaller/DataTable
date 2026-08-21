local var_0_0 = class("IslandUIPool", import(".IslandObjectPool"))

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5)
	var_0_0.super.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)

	arg_1_0.canDel = arg_1_5

	return
end

function var_0_0.CanDelete(arg_2_0)
	return var_0_0.super.CanDelete(arg_2_0) and arg_2_0.canDel
end

function var_0_0.ActiveOrDisactiveItem(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = GetOrAddComponent(arg_3_1, typeof(CanvasGroup))

	var_3_0.alpha = arg_3_2 and 1 or 0
	var_3_0.blocksRaycasts = arg_3_2

	return
end

return var_0_0
