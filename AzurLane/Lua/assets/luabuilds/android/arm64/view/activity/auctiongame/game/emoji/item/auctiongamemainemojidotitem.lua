local var_0_0 = class("AuctionGameMainEmojiDotItem", import("view.base.BasePanel"))

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

function var_0_0.didEnter(arg_3_0, arg_3_1)
	setActive(arg_3_0.uiSelectedGo, arg_3_1)

	return
end

function var_0_0.willExit(arg_4_0)
	arg_4_0:detach()
	Object.Destroy(arg_4_0._go)

	return
end

return var_0_0
