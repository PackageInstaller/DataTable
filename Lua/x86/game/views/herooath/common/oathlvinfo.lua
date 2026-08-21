local var_0_0 = class("OathLvInfo", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:InitUI()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.lvStateController_ = arg_2_0.controller_:GetController("lvState")
end

function var_0_0.SetData(arg_3_0, arg_3_1)
	arg_3_0.heroID = arg_3_1

	arg_3_0:RegistEventListener(OATH_HERO_LV_UPDATE, handler(arg_3_0, arg_3_0.OnLvChange))
	arg_3_0:RefreshUI()
end

function var_0_0.OnLvChange(arg_4_0)
	arg_4_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_5_0)
	local var_5_0 = OathCollectionContentData:GetOathLevel(arg_5_0.heroID)
	local var_5_1 = OathTools.GetOathLvShowTips(var_5_0) or var_5_0

	arg_5_0.lvText_.text = var_5_1

	local var_5_2, var_5_3 = OathAssignmentData:GetOathAssignmentHeroLevelProgress(arg_5_0.heroID, var_5_0)

	arg_5_0.progressImg_.fillAmount = var_5_2 / var_5_3

	if var_5_0 >= OathConst.OATH_MAX_LV then
		arg_5_0.lvStateController_:SetSelectedState("max")
	else
		arg_5_0.lvStateController_:SetSelectedState("normal")
	end
end

function var_0_0.OnExit(arg_6_0)
	arg_6_0:RemoveAllEventListener()
end

function var_0_0.Dispose(arg_7_0)
	var_0_0.super.Dispose(arg_7_0)
end

return var_0_0
