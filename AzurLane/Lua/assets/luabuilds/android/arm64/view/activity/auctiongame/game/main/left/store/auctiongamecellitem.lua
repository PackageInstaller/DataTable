local var_0_0 = class("AuctionGameCellItem", import("view.base.BasePanel"))

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._go = arg_1_1.gameObject

	var_0_0.super.Ctor(arg_1_0, arg_1_0._go)

	arg_1_0._parentClass = arg_1_2

	arg_1_0:attach(arg_1_2)
	arg_1_0:Init()

	return
end

function var_0_0.Init(arg_2_0)
	return
end

function var_0_0.didEnter(arg_3_0)
	return
end

function var_0_0.Show(arg_4_0, arg_4_1)
	setActive(arg_4_0._go, arg_4_1)

	return
end

function var_0_0.GetPosition(arg_5_0)
	return arg_5_0.uiItemTf.anchoredPosition
end

function var_0_0.willExit(arg_6_0)
	arg_6_0:detach()
	Object.Destroy(arg_6_0._go)

	return
end

return var_0_0
