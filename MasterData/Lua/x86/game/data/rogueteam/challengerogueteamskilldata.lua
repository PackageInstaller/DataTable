local ChallengeRogueTeamSkillData = class("ChallengeRogueTeamSkillData")

function ChallengeRogueTeamSkillData:ExportMethod()
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

function ChallengeRogueTeamSkillData:Init()
	self.unlockSkillIDList = {}
end

function ChallengeRogueTeamSkillData:InitSkillTreeFromServer(arg_3_1, arg_3_2)
	self.unlockSkillIDList = {}
	self.unlockSkillIDList[arg_3_1] = self.unlockSkillIDList[arg_3_1] or {}

	for iter_3_0, iter_3_1 in ipairs(arg_3_2) do
		if not table.indexof(self.unlockSkillIDList[arg_3_1], iter_3_1) then
			table.insert(self.unlockSkillIDList[arg_3_1], iter_3_1)
		end
	end
end

function ChallengeRogueTeamSkillData:GetSkillByLevel(arg_4_1)
	local var_4_0 = {}

	for iter_4_0, iter_4_1 in ipairs(RogueTeamSkillTreeCfg.get_id_list_by_level[arg_4_1]) do
		if RogueTeamSkillTreeCfg[iter_4_1].template_id == RogueTeamCfg[ChallengeRogueTeamData:GetCacheTemplateID()].tree_temp then
			table.insert(var_4_0, iter_4_1)
		end
	end

	return var_4_0
end

function ChallengeRogueTeamSkillData:IsHasSkill(arg_5_1, arg_5_2)
	self.unlockSkillIDList[arg_5_1] = self.unlockSkillIDList[arg_5_1] or {}

	return table.indexof(self.unlockSkillIDList[arg_5_1], arg_5_2) and table.indexof(self.unlockSkillIDList[arg_5_1], arg_5_2) > 0
end

function ChallengeRogueTeamSkillData:UnLockSkill(arg_6_1, arg_6_2)
	self.unlockSkillIDList[arg_6_1] = self.unlockSkillIDList[arg_6_1] or {}

	if not table.indexof(self.unlockSkillIDList[arg_6_1], arg_6_2) then
		table.insert(self.unlockSkillIDList[arg_6_1], arg_6_2)
	end

	self:UpdateSkillRedPoint(arg_6_1)
	manager.notify:Invoke(CHALLENGE_ROGUE_TEAM_UNLOCK_SKILL)
end

function ChallengeRogueTeamSkillData:GetUnlockNormalSkill(arg_7_1)
	local var_7_0 = {}

	self.unlockSkillIDList[arg_7_1] = self.unlockSkillIDList[arg_7_1] or {}

	for iter_7_0, iter_7_1 in ipairs(self.unlockSkillIDList[arg_7_1]) do
		if RogueTeamSkillTreeCfg[iter_7_1].node_type == 0 then
			table.insert(var_7_0, iter_7_1)
		end
	end

	return var_7_0
end

function ChallengeRogueTeamSkillData:GetUnlockSpecialSkill(arg_8_1)
	local var_8_0 = {}

	self.unlockSkillIDList[arg_8_1] = self.unlockSkillIDList[arg_8_1] or {}

	for iter_8_0, iter_8_1 in ipairs(self.unlockSkillIDList[arg_8_1]) do
		if RogueTeamSkillTreeCfg[iter_8_1].node_type == 1 then
			table.insert(var_8_0, iter_8_1)
		end
	end

	return var_8_0
end

function ChallengeRogueTeamSkillData:CanSelectSkill(arg_9_1, arg_9_2)
	if RogueTeamSkillTreeCfg[arg_9_2].level == 1 then
		return true
	end

	local var_9_0 = table.indexof(self:GetSkillByLevel(RogueTeamSkillTreeCfg[arg_9_2].level), arg_9_2)
	local var_9_1 = self:GetSkillByLevel(RogueTeamSkillTreeCfg[arg_9_2].level - 1)

	if RogueTeamSkillTreeCfg[arg_9_2].node_type == 1 then
		for iter_9_0, iter_9_1 in ipairs(var_9_1) do
			if not self:IsHasSkill(arg_9_1, iter_9_1) then
				return false
			end
		end
	else
		preSkillID = #var_9_1 == 1 and var_9_1[1] or var_9_1[var_9_0]

		if not self:IsHasSkill(arg_9_1, preSkillID) then
			return false
		end
	end

	return true
end

function ChallengeRogueTeamSkillData:CanLevelUpSkill(arg_10_1, arg_10_2)
	return self:CanSelectSkill(arg_10_1, arg_10_2) and ItemTools.getItemNum(RogueTeamCfg[arg_10_1].tech_item) >= tonumber(RogueTeamSkillTreeCfg[arg_10_2].cost)
end

function ChallengeRogueTeamSkillData:UpdateSkillRedPoint(arg_11_1)
	for iter_11_0, iter_11_1 in ipairs(RogueTeamSkillTreeCfg.get_id_list_by_template_id[RogueTeamCfg[arg_11_1].tree_temp]) do
		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.CHALLENGE_ROGUE_TEAM_SKILL, iter_11_1), not self:IsHasSkill(arg_11_1, iter_11_1) and self:CanLevelUpSkill(arg_11_1, iter_11_1) and 1 or 0)
	end
end

return ChallengeRogueTeamSkillData
