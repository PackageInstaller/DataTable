local var_0_0 = class("IslandBaseMsgboxWindow", import("view.base.BaseSubView"))

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.view = arg_1_1

	var_0_0.super.Ctor(arg_1_0, arg_1_2, arg_1_0.view.event, arg_1_0.view.contextData)

	return
end

function var_0_0.Show(arg_2_0, arg_2_1)
	var_0_0.super.Show(arg_2_0)

	arg_2_0.settings = arg_2_1

	arg_2_0:OnShow()
	arg_2_0._tf:SetAsLastSibling()

	return
end

function var_0_0.Hide(arg_3_0)
	arg_3_0.view:HideWindow(arg_3_0)
	arg_3_0:OnHide()

	arg_3_0.settings = nil

	return
end

function var_0_0.OnShow(arg_4_0)
	return
end

function var_0_0.OnHide(arg_5_0)
	return
end

return var_0_0
