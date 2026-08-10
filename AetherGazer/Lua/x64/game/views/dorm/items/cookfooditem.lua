local var_0_0 = class("CookFoodItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.itemController = ControllerUtil.GetController(arg_3_0.transform_, "state")
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.buttonBtn_, nil, function()
		if arg_4_0.clickFunc then
			arg_4_0.clickFunc(arg_4_0.uid_)
		end
	end)
end

function var_0_0.RegistCallBack(arg_6_0, arg_6_1)
	arg_6_0.clickFunc = arg_6_1
end

function var_0_0.RefreshUI(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0.uid_ = arg_7_1.id

	if arg_7_1.type == DormEnum.UniversalUIType.FoodName then
		if arg_7_1.id == arg_7_2 then
			arg_7_0.itemController:SetSelectedState("choose")
		else
			arg_7_0.itemController:SetSelectedState("unchoose")
		end

		arg_7_0.nameText_.text = GetI18NText(BackHomeCanteenFoodCfg[arg_7_0.uid_].name)
	elseif arg_7_1.type == DormEnum.UniversalUIType.TasteName then
		if arg_7_1.id == arg_7_2 then
			arg_7_0.itemController:SetSelectedState("choose")
		else
			arg_7_0.itemController:SetSelectedState("unchoose")
		end

		arg_7_0.nameText_.text = GetTips(CanteenConst.FoodTaste[arg_7_1.id][1])
	end
end

function var_0_0.Dispose(arg_8_0)
	var_0_0.super.Dispose(arg_8_0)
end

return var_0_0
