local var_0_0 = class("SpringFestivalZumaEndlessTalentItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1

	arg_1_0:InitUI()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.lockController = arg_2_0.controller_:GetController("lock")
end

function var_0_0.SetData(arg_3_0, arg_3_1)
	arg_3_0.talentID = arg_3_1

	local var_3_0 = ActivityZumaTalentCfg[arg_3_1]

	arg_3_0.scoreTxt_.text = var_3_0.need
	arg_3_0.describeTxt_.text = var_3_0.desc

	arg_3_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_4_0)
	if (ZumaData:GetEndlessScore() or 0) >= ActivityZumaTalentCfg[arg_4_0.talentID].need then
		arg_4_0.lockController:SetSelectedState("unlock")
	else
		arg_4_0.lockController:SetSelectedState("lock")
	end
end

function var_0_0.Dispose(arg_5_0)
	var_0_0.super.Dispose(arg_5_0)
end

return var_0_0
