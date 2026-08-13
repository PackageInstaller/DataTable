class = var_0_10000

local var_0_0 = "IslandUIPool"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".IslandObjectPool"))

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5)
	var_0_1.super.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)

	arg_1_0.canDel = arg_1_5

	return
end

function var_0_1.CanDelete(arg_2_0)
	return var_0_1.super.CanDelete(arg_2_0) and arg_2_0.canDel
end

function var_0_1.ActiveOrDisactiveItem(arg_3_0, arg_3_1, arg_3_2)
	GetOrAddComponent = var_1_10003

	local var_3_0 = arg_3_1

	typeof = var_1_10005
	CanvasGroup = var_1_10006

	local var_3_1 = var_1_10003(var_3_0, var_1_10005(var_1_10006))

	var_3_1.alpha = arg_3_2 and 1 or 0
	var_3_1.blocksRaycasts = arg_3_2

	return
end

return var_0_1
