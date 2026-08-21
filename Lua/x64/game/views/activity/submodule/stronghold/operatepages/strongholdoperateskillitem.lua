local var_0_0 = class("StrongholdOperateSkillItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform
	arg_1_0.skill_type = arg_1_2

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.lockController = ControllerUtil.GetController(arg_3_0.transform_, "lock")
end

function var_0_0.RefreshUI(arg_4_0)
	for iter_4_0 = 1, 3 do
		local var_4_0 = StrongholdData:GetSkillAffix(arg_4_0.skill_type, iter_4_0)

		arg_4_0["m_skillDes" .. iter_4_0].text = getAffixDesc(var_4_0)

		if iter_4_0 == 1 then
			arg_4_0.m_name.text = getAffixName(var_4_0)
		end
	end

	arg_4_0.m_icon.sprite = pureGetSpriteWithoutAtlas("TextureConfig/VersionUI/XuHeng3rdUI/StrongholdUI/StrongholdSkill/" .. arg_4_0.skill_type)

	local var_4_1, var_4_2, var_4_3, var_4_4 = StrongholdData:GetStrongholdLevel(arg_4_0.skill_type)
	local var_4_5 = StrongholdData:GetSkillLimitLv()

	if var_4_2 < var_4_5 then
		arg_4_0.lockController:SetSelectedIndex(1)

		local var_4_6 = GetTips("ACTIVITY_STRONGHOLD_TYPE_NAME_" .. arg_4_0.skill_type)

		arg_4_0.m_lockLab.text = string.format(GetTips("ACTIVITY_STRONGHOLD_TYPE_LIMIT_LV"), var_4_6, var_4_5)
	else
		arg_4_0.lockController:SetSelectedIndex(0)
	end
end

return var_0_0
