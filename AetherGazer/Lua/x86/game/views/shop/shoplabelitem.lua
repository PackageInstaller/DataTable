local var_0_0 = class("ShopLabelItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()
end

function var_0_0.RefreshUI(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = ""

	if BackHomeFurniture[arg_4_1] then
		var_4_0 = DormTools:GetFurLableDesc(arg_4_1, arg_4_2)
	end

	arg_4_0.textText_.text = var_4_0
end

function var_0_0.Dispose(arg_5_0)
	var_0_0.super.Dispose(arg_5_0)
end

return var_0_0
