class = var_0_10000

local var_0_0 = "IslandBaseMsgboxWindow"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseSubView"))

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.view = arg_1_1

	var_0_1.super.Ctor(arg_1_0, arg_1_2, arg_1_0.view.event, arg_1_0.view.contextData)

	return
end

function var_0_1.Show(arg_2_0, arg_2_1)
	var_0_1.super.Show(arg_2_0)

	arg_2_0.settings = arg_2_1

	arg_2_0:OnShow()

	local var_2_0 = arg_2_0._tf

	var_2.SetAsLastSibling(var_2_0)

	return
end

function var_0_1.Hide(arg_3_0)
	local var_3_0 = arg_3_0.view

	var_1.HideWindow(var_3_0, arg_3_0)
	arg_3_0:OnHide()

	arg_3_0.settings = nil

	return
end

function var_0_1.OnShow(arg_4_0)
	return
end

function var_0_1.OnHide(arg_5_0)
	return
end

return var_0_1
