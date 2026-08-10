local var_0_0 = class("CanteenPassTableFoodItem", ReduxView)

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
	arg_3_0:AddUIListener()
end

function var_0_0.RefreshItem(arg_4_0, arg_4_1)
	arg_4_0.foodEid = arg_4_1

	local var_4_0 = CanteenAIFunction:GetEntityData(arg_4_1)

	arg_4_0.foodCfgID = var_4_0.cfgID
	arg_4_0.nameText_.text = string.format("<color=#%s>%s</color>", CanteenConst.FoodTaste[var_4_0.taste][2], GetTips(CanteenConst.FoodTaste[var_4_0.taste][1]))
	arg_4_0.iconImg_.sprite = pureGetSpriteWithoutAtlas(DormConst.CANTEEN_FOOD_PATH .. BackHomeCanteenFoodCfg[arg_4_0.foodCfgID].icon)
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.fooditemBtn_, nil, function()
		if arg_5_0.btnCallBack then
			arg_5_0.btnCallBack(arg_5_0.foodEid)
		end
	end)
end

function var_0_0.RegistCallBack(arg_7_0, arg_7_1)
	arg_7_0.btnCallBack = arg_7_1
end

function var_0_0.Dispose(arg_8_0)
	var_0_0.super.Dispose(arg_8_0)
end

return var_0_0
