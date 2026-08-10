local var_0_0 = class("CanteenSkillItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:InitUI()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.lockController = ControllerUtil.GetController(arg_2_0.transform_, "lock")
end

function var_0_0.RefreshUI(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	arg_3_0.lockController:SetSelectedState("unlock")

	arg_3_0.iconskillImg_.sprite = CanteenTools.GetCanteenSkillSprite(arg_3_1)
	arg_3_0.skillDec_.text = GetI18NText(DormSkillData:GetSkillDesc(arg_3_1))
	arg_3_0.skillName_.text = GetI18NText(BackHomeHeroSkillCfg[arg_3_1].name)

	if arg_3_2 then
		local var_3_0 = 0

		if arg_3_3 == 1 then
			var_3_0 = GameSetting.dorm_hero_skill_unlock.value[1]
		elseif arg_3_3 == 2 then
			var_3_0 = GameSetting.dorm_hero_skill_unlock.value[2]
		end

		if arg_3_2 < var_3_0 then
			arg_3_0.lockController:SetSelectedState("lock")

			arg_3_0.unLockConText_.text = string.format(GetTips("DORM_CANTEEN_UNLOCK"), var_3_0)
		end
	end
end

function var_0_0.Dispose(arg_4_0)
	var_0_0.super.Dispose(arg_4_0)
end

return var_0_0
