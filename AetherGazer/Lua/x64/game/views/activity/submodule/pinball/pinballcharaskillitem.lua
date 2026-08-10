local var_0_0 = class("PinballCharaSkillItem", BaseView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:BindCfgUI()
end

function var_0_0.SetData(arg_3_0, arg_3_1)
	local var_3_0 = PinballSkillCfg[arg_3_1]

	if var_3_0 then
		arg_3_0.name_.text = GetI18NText(var_3_0.name)
		arg_3_0.desc_.text = PinballTools.GetSkillDesc(arg_3_1)
		arg_3_0.icon_.spriteSync = PinballTools.GetSkillIconPath(arg_3_1)

		if arg_3_0.cooldown_ then
			arg_3_0.cooldown_.text = GetTipsF("PINBALL_SKILL_CD_TIPS", var_3_0.cd)
		end

		if arg_3_0.cost_ then
			arg_3_0.cost_.text = var_3_0.cost
		end
	end
end

function var_0_0.SetVisible(arg_4_0, arg_4_1)
	SetActive(arg_4_0.gameObject_, arg_4_1)
end

return var_0_0
