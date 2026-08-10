local var_0_0 = class("ChallengeRogueTeamSkillData")

function var_0_0.ExportMethod(arg_1_0)
	return {
		"GetSkillByLevel",
		"IsHasSkill",
		"UnLockSkill",
		"CanSelectSkill",
		"CanLevelUpSkill",
		"UpdateSkillRedPoint",
		"InitSkillTreeFromServer",
		"GetUnlockNormalSkill",
		"GetUnlockSpecialSkill"
	}
end

function var_0_0.Init(arg_2_0)
	arg_2_0.unlockSkillIDList = {}
end

function var_0_0.InitSkillTreeFromServer(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0.unlockSkillIDList = {}

	if not arg_3_0.unlockSkillIDList[arg_3_1] then
		arg_3_0.unlockSkillIDList[arg_3_1] = {}
	end

	for iter_3_0, iter_3_1 in ipairs(arg_3_2) do
		if not table.indexof(arg_3_0.unlockSkillIDList[arg_3_1], iter_3_1) then
			table.insert(arg_3_0.unlockSkillIDList[arg_3_1], iter_3_1)
		end
	end
end

function var_0_0.GetSkillByLevel(arg_4_0, arg_4_1)
	local var_4_0 = {}

	for iter_4_0, iter_4_1 in ipairs(RogueTeamSkillTreeCfg.get_id_list_by_level[arg_4_1]) do
		if RogueTeamSkillTreeCfg[iter_4_1].template_id == RogueTeamCfg[ChallengeRogueTeamData:GetCacheTemplateID()].tree_temp then
			table.insert(var_4_0, iter_4_1)
		end
	end

	return var_4_0
end

function var_0_0.IsHasSkill(arg_5_0, arg_5_1, arg_5_2)
	if not arg_5_0.unlockSkillIDList[arg_5_1] then
		arg_5_0.unlockSkillIDList[arg_5_1] = {}
	end

	return table.indexof(arg_5_0.unlockSkillIDList[arg_5_1], arg_5_2) and table.indexof(arg_5_0.unlockSkillIDList[arg_5_1], arg_5_2) > 0
end

function var_0_0.UnLockSkill(arg_6_0, arg_6_1, arg_6_2)
	if not arg_6_0.unlockSkillIDList[arg_6_1] then
		arg_6_0.unlockSkillIDList[arg_6_1] = {}
	end

	if not table.indexof(arg_6_0.unlockSkillIDList[arg_6_1], arg_6_2) then
		table.insert(arg_6_0.unlockSkillIDList[arg_6_1], arg_6_2)
	end

	arg_6_0:UpdateSkillRedPoint(arg_6_1)
	manager.notify:Invoke(CHALLENGE_ROGUE_TEAM_UNLOCK_SKILL)
end

function var_0_0.GetUnlockNormalSkill(arg_7_0, arg_7_1)
	local var_7_0 = {}

	if not arg_7_0.unlockSkillIDList[arg_7_1] then
		arg_7_0.unlockSkillIDList[arg_7_1] = {}
	end

	for iter_7_0, iter_7_1 in ipairs(arg_7_0.unlockSkillIDList[arg_7_1]) do
		if RogueTeamSkillTreeCfg[iter_7_1].node_type == 0 then
			table.insert(var_7_0, iter_7_1)
		end
	end

	return var_7_0
end

function var_0_0.GetUnlockSpecialSkill(arg_8_0, arg_8_1)
	local var_8_0 = {}

	if not arg_8_0.unlockSkillIDList[arg_8_1] then
		arg_8_0.unlockSkillIDList[arg_8_1] = {}
	end

	for iter_8_0, iter_8_1 in ipairs(arg_8_0.unlockSkillIDList[arg_8_1]) do
		if RogueTeamSkillTreeCfg[iter_8_1].node_type == 1 then
			table.insert(var_8_0, iter_8_1)
		end
	end

	return var_8_0
end

function var_0_0.CanSelectSkill(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = RogueTeamSkillTreeCfg[arg_9_2]

	if var_9_0.level == 1 then
		return true
	end

	local var_9_1 = table.indexof(arg_9_0:GetSkillByLevel(var_9_0.level), arg_9_2)
	local var_9_2 = arg_9_0:GetSkillByLevel(var_9_0.level - 1)

	if var_9_0.node_type == 1 then
		for iter_9_0, iter_9_1 in ipairs(var_9_2) do
			if not arg_9_0:IsHasSkill(arg_9_1, iter_9_1) then
				return false
			end
		end
	else
		if #var_9_2 == 1 then
			preSkillID = var_9_2[1]
		else
			preSkillID = var_9_2[var_9_1]
		end

		if not arg_9_0:IsHasSkill(arg_9_1, preSkillID) then
			return false
		end
	end

	return true
end

function var_0_0.CanLevelUpSkill(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = RogueTeamSkillTreeCfg[arg_10_2]
	local var_10_1 = ItemTools.getItemNum(RogueTeamCfg[arg_10_1].tech_item) >= tonumber(var_10_0.cost)

	return arg_10_0:CanSelectSkill(arg_10_1, arg_10_2) and var_10_1
end

function var_0_0.UpdateSkillRedPoint(arg_11_0, arg_11_1)
	local var_11_0 = RogueTeamSkillTreeCfg.get_id_list_by_template_id[RogueTeamCfg[arg_11_1].tree_temp]

	for iter_11_0, iter_11_1 in ipairs(var_11_0) do
		local var_11_1 = string.format("%s_%s", RedPointConst.CHALLENGE_ROGUE_TEAM_SKILL, iter_11_1)
		local var_11_2 = not arg_11_0:IsHasSkill(arg_11_1, iter_11_1) and arg_11_0:CanLevelUpSkill(arg_11_1, iter_11_1)

		manager.redPoint:setTip(var_11_1, var_11_2 and 1 or 0)
	end
end

return var_0_0
