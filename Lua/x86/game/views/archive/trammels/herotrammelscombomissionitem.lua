local var_0_0 = class("HeroTrammelsComboMissionItem", ReduxView)

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

	arg_3_0.stateController = ControllerUtil.GetController(arg_3_0.transform_, "state")
end

function var_0_0.AddUIListener(arg_4_0)
	return
end

function var_0_0.SetData(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = ComboSkillLevelCfg[arg_5_1]
	local var_5_1 = ComboSkillCfg[arg_5_2]
	local var_5_2 = HeroSkillCfg[var_5_1.skill_id]
	local var_5_3 = GetI18NText(var_5_0.des)

	if var_5_0.condition_type ~= 1 then
		var_5_3 = string.format(var_5_3, GetI18NText(var_5_2.name))
	end

	arg_5_0.m_des.text = var_5_3

	local var_5_4, var_5_5, var_5_6 = ComboSkillTools.CheckComboSkillUpContion(arg_5_1, arg_5_2)

	if var_5_4 then
		arg_5_0.stateController:SetSelectedIndex(1)
	else
		arg_5_0.stateController:SetSelectedIndex(0)
	end

	arg_5_0.m_process.text = var_5_5 .. "/" .. var_5_6
end

function var_0_0.Dispose(arg_6_0)
	var_0_0.super.Dispose(arg_6_0)
end

return var_0_0
