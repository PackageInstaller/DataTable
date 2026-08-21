local var_0_0 = class("TrainInfoSkillItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()

	arg_1_0.lockController_ = arg_1_0.mainControllerEx_:GetController("lock")
end

function var_0_0.SetData(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = IdolTraineeSkillCfg[arg_2_1.skill]

	arg_2_0.name_.text = var_2_0.name
	arg_2_0.desc_.text = IdolTraineeTools:GetSkillDescString(arg_2_1.skill)
	arg_2_0.icon_.sprite = IdolTraineeTools:GetSkillIcon(arg_2_1.skill)
	arg_2_0.typeText_.text = GetTips("IDOL_DANCE_SKILL_TYPE_TIPS_" .. var_2_0.type)

	local var_2_1 = arg_2_1.property or 0

	arg_2_0.lockText_.text = string.format(GetTips("IDOL_DANCE_SKILL_UNLOCK_TIPS"), arg_2_2, var_2_1)

	if var_2_1 <= arg_2_2 then
		arg_2_0.lockController_:SetSelectedState("normal")
	else
		arg_2_0.lockController_:SetSelectedState("lock")
	end
end

function var_0_0.Dispose(arg_3_0)
	var_0_0.super.Dispose(arg_3_0)
end

return var_0_0
