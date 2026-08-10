local var_0_0 = class("HeroTrammelsNetMissionItem", ReduxView)

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
	arg_4_0:AddBtnListener(nil, arg_4_0.m_unlockBtn, function()
		ArchiveAction.QueryUnlockRelationNet(arg_4_0.net_id, arg_4_0.complete)
	end)
end

function var_0_0.SetData(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4, arg_6_5)
	arg_6_0.net_id = HeroRelationNetCfg.get_id_list_by_hero_id[arg_6_4][arg_6_2]
	arg_6_0.complete = arg_6_3

	local var_6_0 = HeroRelationUpgradeCfg[arg_6_1]
	local var_6_1 = var_6_0.condition_id
	local var_6_2 = ArchiveTools.GetRelationUpgradeConditionDes(var_6_1)

	arg_6_0.m_conditionDes.text = var_6_2

	local var_6_3 = var_6_0.attr[1]
	local var_6_4 = GetI18NText(PublicAttrCfg[var_6_3[1]].name)
	local var_6_5 = ""

	if PublicAttrCfg[var_6_3[1]].percent == 1 then
		var_6_5 = string.format("%s+%.2f%%", var_6_4, var_6_3[2] / 10)
	else
		var_6_5 = string.format("%s+%d", var_6_4, var_6_3[2])
	end

	arg_6_0.m_attrAdd.text = var_6_5
	arg_6_0.m_lockEffectDes.text = GetTipsF("HERO_RELATION_UPGRADE_UNLOCK", var_6_5)

	if HeroData:GetHeroData(arg_6_4).relation:GetIsUnlock(arg_6_2, arg_6_3) then
		arg_6_0.stateController:SetSelectedIndex(2)
	elseif ArchiveTools.CheckRelationUpgradeCondition(var_6_1, arg_6_5) then
		arg_6_0.stateController:SetSelectedIndex(1)
	else
		arg_6_0.stateController:SetSelectedIndex(0)
	end
end

function var_0_0.Dispose(arg_7_0)
	var_0_0.super.Dispose(arg_7_0)
end

return var_0_0
