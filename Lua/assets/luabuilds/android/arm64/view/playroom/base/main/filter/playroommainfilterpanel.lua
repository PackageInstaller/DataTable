local var_0_0 = class("PlayRoomMainFilterPanel", import("view.base.BasePanel"))

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0._go = arg_1_1.gameObject

	var_0_0.super.Ctor(arg_1_0, arg_1_0._go)

	arg_1_0._parentClass = arg_1_2
	arg_1_0.data = arg_1_3

	arg_1_0:attach(arg_1_2)
	arg_1_0:Init()

	return
end

function var_0_0.Init(arg_2_0)
	arg_2_0.btnItemList = {}

	return
end

function var_0_0.didEnter(arg_3_0, arg_3_1, arg_3_2)
	setText(arg_3_0.uiTitleText, arg_3_1.titleText)

	for iter_3_0, iter_3_1 in ipairs(arg_3_1.btnList) do
		arg_3_0.btnItemList[iter_3_0] = PlayRoomMainFilterBtn.New(Object.Instantiate(arg_3_0.uiTplBtn, arg_3_0.uiTplPanel), arg_3_0)

		arg_3_0.btnItemList[iter_3_0]:didEnter(iter_3_1, arg_3_2)
	end

	setActive(arg_3_0._go, arg_3_1.hide ~= true)

	return
end

function var_0_0.willExit(arg_4_0)
	arg_4_0:detach()

	for iter_4_0, iter_4_1 in ipairs(arg_4_0.btnItemList) do
		iter_4_1:willExit()
	end

	arg_4_0.btnItemList = nil

	Object.Destroy(arg_4_0._go)

	arg_4_0._tf = nil
	arg_4_0._go = nil

	return
end

function var_0_0.RefreshUI(arg_5_0)
	for iter_5_0, iter_5_1 in ipairs(arg_5_0.btnItemList) do
		iter_5_1:RefreshUI()
	end

	return
end

return var_0_0
