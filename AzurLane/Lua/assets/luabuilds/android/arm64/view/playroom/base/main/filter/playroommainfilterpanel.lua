class = var_0_10000

local var_0_0 = "PlayRoomMainFilterPanel"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BasePanel"))

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0._go = arg_1_1.gameObject

	var_0_1.super.Ctor(arg_1_0, arg_1_0._go)

	arg_1_0._parentClass = arg_1_2
	arg_1_0.data = arg_1_3

	arg_1_0:attach(arg_1_2)
	arg_1_0:Init()

	return
end

function var_0_1.Init(arg_2_0)
	arg_2_0.btnItemList = {}

	return
end

function var_0_1.didEnter(arg_3_0, arg_3_1, arg_3_2)
	setText = var_1_10003

	var_1_10003(arg_3_0.uiTitleText, arg_3_1.titleText)

	ipairs = var_1_10003

	for iter_3_0, iter_3_1 in var_1_10003(arg_3_1.btnList) do
		local var_3_0 = arg_3_0.btnItemList

		PlayRoomMainFilterBtn = var_1_10009
		var_1_10009 = var_1_10009.New
		Object = var_1_10011
		var_3_0[iter_3_0] = var_1_10009(var_1_10011.Instantiate(arg_3_0.uiTplBtn, arg_3_0.uiTplPanel), arg_3_0)

		local var_3_1 = arg_3_0.btnItemList[iter_3_0]

		var_8.didEnter(var_3_1, iter_3_1, arg_3_2)
	end

	setActive = var_3

	var_3(arg_3_0._go, arg_3_1.hide ~= true)

	return
end

function var_0_1.willExit(arg_4_0)
	arg_4_0:detach()

	ipairs = var_1

	for iter_4_0, iter_4_1 in var_1(arg_4_0.btnItemList) do
		iter_4_1:willExit()
	end

	arg_4_0.btnItemList = nil
	Object = var_1

	var_1.Destroy(arg_4_0._go)

	arg_4_0._tf = nil
	arg_4_0._go = nil

	return
end

function var_0_1.RefreshUI(arg_5_0)
	ipairs = var_1_10001

	for iter_5_0, iter_5_1 in var_1_10001(arg_5_0.btnItemList) do
		iter_5_1:RefreshUI()
	end

	return
end

return var_0_1
