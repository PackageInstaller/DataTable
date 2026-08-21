local var_0_0 = class("CanteenSignFoodInfoItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2)

	SetActive(arg_1_0.gameObject_, true)

	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:InitUI()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()
end

function var_0_0.RefreshUI(arg_3_0, arg_3_1)
	local var_3_0 = BackHomeCanteenFoodCfg[arg_3_1]
	local var_3_1 = CanteenFoodData:GetSignFoodInfo(arg_3_1)

	if var_3_0 and var_3_1 then
		arg_3_0.foodName.text = GetI18NText(var_3_0.name)
		arg_3_0.soldNum.text = var_3_1.soldNum .. "/" .. var_3_1.sellNum
		arg_3_0.soldIncom.text = var_3_1.soldIncome or 0
		arg_3_0.foodIcon.sprite = CanteenTools.GetFoodSprite(arg_3_1)
	end
end

function var_0_0.Dispose(arg_4_0)
	Object.Destroy(arg_4_0.gameObject_)
	var_0_0.super.Dispose(arg_4_0)
end

return var_0_0
