local var_0_0 = class("ChooseFoodMaterialItem", ReduxView)

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
	arg_4_0.nameText_.text = ItemTools.getItemName(arg_4_1)

	local var_4_0 = BackHomeCanteenFoodCfg[arg_4_2].ingredient_list
	local var_4_1 = {}

	for iter_4_0, iter_4_1 in ipairs(var_4_0) do
		if iter_4_1[1] == arg_4_1 then
			var_4_1 = iter_4_1[2]

			break
		end
	end

	local var_4_2 = var_4_1
	local var_4_3 = CanteenFoodData:GetCateenIngredient()[arg_4_1]
end

function var_0_0.RegistCallBack(arg_5_0, arg_5_1)
	arg_5_0.changeListFun = arg_5_1
end

function var_0_0.Dispose(arg_6_0)
	arg_6_0:RemoveAllListeners()
	var_0_0.super.Dispose(arg_6_0)
end

return var_0_0
