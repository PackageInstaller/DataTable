local var_0_0 = class("HeroFileGiftTrustLvUpTaskItem", ReduxView)

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

	arg_3_0.completeStateController_ = arg_3_0.conditionControllerEx_:GetController("completeState")
end

function var_0_0.AddUIListener(arg_4_0)
	return
end

function var_0_0.SetData(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = ConditionCfg[arg_5_1]

	if var_5_0 and var_5_0.type == 8023 then
		arg_5_0.nameText_.text = string.format(GetI18NText(var_5_0.desc), HeroCfg[arg_5_2].suffix)
	else
		arg_5_0.nameText_.text = var_5_0 and GetI18NText(var_5_0.desc) or ""
	end

	local var_5_1, var_5_2, var_5_3 = IsConditionAchieved(arg_5_1, {
		heroId = arg_5_2
	})
	local var_5_4 = math.min(var_5_2, var_5_3)

	if var_5_1 then
		arg_5_0.completeStateController_:SetSelectedState("done")

		arg_5_0.processText_.text = var_5_4 .. "/" .. var_5_3
	else
		arg_5_0.completeStateController_:SetSelectedState("not")

		arg_5_0.processText_.text = "<color=#F65632>" .. var_5_4 .. "</color>" .. "/" .. var_5_3
	end
end

function var_0_0.Dispose(arg_6_0)
	var_0_0.super.Dispose(arg_6_0)
end

return var_0_0
