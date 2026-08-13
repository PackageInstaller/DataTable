class = var_0_10000

local var_0_0 = "PlayRoomMainFilterBtn"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BasePanel"))

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

function var_0_1.didEnter(arg_3_0, arg_3_1, arg_3_2)
	setText = var_1_10003

	var_1_10003(arg_3_0.uiText, arg_3_1.text)

	setText = var_1_10003

	var_1_10003(arg_3_0.uiText2, arg_3_1.text)

	onButton = var_1_10003

	var_1_10003(arg_3_0, arg_3_0.uiBtn, function()
		arg_3_1.clickBtn()

		return
	end)

	setActive = var_1_10003

	var_1_10003(arg_3_0._go, true)

	arg_3_0.data = arg_3_1

	return
end

function var_0_1.willExit(arg_5_0)
	arg_5_0:detach()

	Object = var_1

	var_1.Destroy(arg_5_0._go)

	arg_5_0._tf = nil
	arg_5_0._go = nil

	return
end

function var_0_1.RefreshUI(arg_6_0)
	setActive = var_1_10001

	var_1_10001(arg_6_0.uiSelectTf, arg_6_0.data.selected())

	setActive = var_1_10001

	var_1_10001(arg_6_0.uiUnSelectTf, not arg_6_0.data.selected())

	return
end

return var_0_1
