local var_0_0 = {}

manager.net:Bind(73001, function(arg_1_0)
	ComboSkillData:InitLevelData(arg_1_0)
end)
manager.net:Bind(73003, function(arg_2_0)
	ComboSkillData:UpdateLevelData(arg_2_0)

	for iter_2_0, iter_2_1 in ipairs(ComboSkillCfg[arg_2_0.skill.id].cooperate_role_ids) do
		ArchiveAction.CheckComboSkillRedPoint(iter_2_1)
	end
end)

function var_0_0.QueryUpgradeComboSkillLevel(arg_3_0)
	manager.net:SendWithLoadingNew(73018, {
		cooperate_unique_skill_id = arg_3_0
	}, 73019, var_0_0.OnUpgradeComboSkillLevelBack)
end

function var_0_0:OnUpgradeComboSkillLevelBack(arg_4_1)
	if isSuccess(self.result) then
		manager.notify:CallUpdateFunc(HERO_COMBO_SKILL_LEVEL_UP)
		ShowTips(GetTipsF("HERO_COMBO_SKILL_LEVEL_UP_SUCCESS", "LV." .. ComboSkillData:GetCurComboSkillLevel(arg_4_1.cooperate_unique_skill_id)))
	else
		ShowTips(self.result)
	end
end

return var_0_0
