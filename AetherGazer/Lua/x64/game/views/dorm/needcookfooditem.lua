local var_0_0 = class("NeedCookFoodItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()

	arg_2_0.itemController = ControllerUtil.GetController(arg_2_0.transform_, "food")
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()
end

function var_0_0.RefreshUI(arg_4_0, arg_4_1)
	local var_4_0 = BackHomeCanteenFoodCfg[arg_4_1]

	if CanteenFoodData:GetSignFoodCanCookNum(arg_4_1) > 0 then
		arg_4_0.itemController:SetSelectedState("on")

		arg_4_0.foodtextText_.text = var_4_0.name
	else
		arg_4_0.itemController:SetSelectedState("off")

		arg_4_0.foodnameText_.text = var_4_0.name
	end
end

function var_0_0.Dispose(arg_5_0)
	var_0_0.super.Dispose(arg_5_0)
end

return var_0_0
