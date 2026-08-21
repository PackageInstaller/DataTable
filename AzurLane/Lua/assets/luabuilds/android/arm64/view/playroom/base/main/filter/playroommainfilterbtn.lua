local var_0_0 = class("PlayRoomMainFilterBtn", import("view.base.BasePanel"))

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

function var_0_0.didEnter(arg_3_0, arg_3_1, arg_3_2)
	setText(arg_3_0.uiText, arg_3_1.text)
	setText(arg_3_0.uiText2, arg_3_1.text)
	onButton(arg_3_0, arg_3_0.uiBtn, function()
		arg_3_1.clickBtn()

		return
	end)
	setActive(arg_3_0._go, true)

	arg_3_0.data = arg_3_1

	return
end

function var_0_0.willExit(arg_5_0)
	arg_5_0:detach()
	Object.Destroy(arg_5_0._go)

	arg_5_0._tf = nil
	arg_5_0._go = nil

	return
end

function var_0_0.RefreshUI(arg_6_0)
	setActive(arg_6_0.uiSelectTf, arg_6_0.data.selected())
	setActive(arg_6_0.uiUnSelectTf, not arg_6_0.data.selected())

	return
end

return var_0_0
