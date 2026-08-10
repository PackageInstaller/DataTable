local var_0_0 = class("AdminSkinItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform
	arg_1_0.skinID = arg_1_2

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.selController = arg_3_0.controllerEx_:GetController("Select")
	arg_3_0.skinController = arg_3_0.controllerEx_:GetController("skin")
	arg_3_0.skinCurController = arg_3_0.controllerEx_:GetController("SelectCurrent")
end

function var_0_0.Refresh(arg_4_0, arg_4_1)
	arg_4_0.selController:SetSelectedIndex(arg_4_1 and 1 or 0)

	local var_4_0 = AdminSystemTools.HeroUsingSkinInfo(1001)

	arg_4_0.skinCurController:SetSelectedIndex(var_4_0 == arg_4_0.skinID and 1 or 0)
end

function var_0_0.Dispose(arg_5_0)
	var_0_0.super.Dispose(arg_5_0)
end

return var_0_0
