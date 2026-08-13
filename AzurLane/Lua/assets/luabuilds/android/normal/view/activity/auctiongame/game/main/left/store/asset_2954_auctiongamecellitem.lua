class = var_0_10000

local var_0_0 = "AuctionGameCellItem"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BasePanel"))

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._go = arg_1_1.gameObject

	var_0_1.super.Ctor(arg_1_0, arg_1_0._go)

	arg_1_0._parentClass = arg_1_2

	arg_1_0:attach(arg_1_2)
	arg_1_0:Init()

	return
end

function var_0_1.Init(arg_2_0)
	return
end

function var_0_1.didEnter(arg_3_0)
	return
end

function var_0_1.Show(arg_4_0, arg_4_1)
	setActive = var_1_10002

	var_1_10002(arg_4_0._go, arg_4_1)

	return
end

function var_0_1.GetPosition(arg_5_0)
	return arg_5_0.uiItemTf.anchoredPosition
end

function var_0_1.willExit(arg_6_0)
	arg_6_0:detach()

	Object = var_1

	var_1.Destroy(arg_6_0._go)

	return
end

return var_0_1
