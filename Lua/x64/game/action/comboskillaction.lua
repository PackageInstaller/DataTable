local var_0_0 = {}

manager.net:Bind(73001, function(arg_1_0)
	ComboSkillData:InitLevelData(arg_1_0)
end)
manager.net:Bind(73003, function(arg_2_0)
	ComboSkillData:UpdateLevelData(arg_2_0)

	local var_2_0 = arg_2_0.skill
	local var_2_1 = ComboSkillCfg[var_2_0.id]

	for iter_2_0, iter_2_1 in ipairs(var_2_1.cooperate_role_ids) do
		ArchiveAction.CheckComboSkillRedPoint(iter_2_1)
	end
end)

function var_0_0.QueryUpgradeComboSkillLevel(arg_3_0)
	manager.net:SendWithLoadingNew(73018, {
		cooperate_unique_skill_id = arg_3_0
	}, 73019, var_0_0.OnUpgradeComboSkillLevelBack)
end

function var_0_0.OnUpgradeComboSkillLevelBack(arg_4_0, arg_4_1)
	if isSuccess(arg_4_0.result) then
		manager.notify:CallUpdateFunc(HERO_COMBO_SKILL_LEVEL_UP)
		ShowTips(GetTipsF("HERO_COMBO_SKILL_LEVEL_UP_SUCCESS", "LV." .. ComboSkillData:GetCurComboSkillLevel(arg_4_1.cooperate_unique_skill_id)))
	else
		ShowTips(arg_4_0.result)
	end
end

return var_0_0
