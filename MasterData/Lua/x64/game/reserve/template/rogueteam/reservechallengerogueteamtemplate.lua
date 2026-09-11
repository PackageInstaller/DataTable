local ReserveChallengeRogueTeamTemplate = class("ReserveChallengeRogueTeamTemplate", (import("game.reserve.template.ReserveBaseTemplate")))

function ReserveChallengeRogueTeamTemplate:GetLockHero(arg_1_1, arg_1_2)
	return
end

function ReserveChallengeRogueTeamTemplate:FilterInvalidTeamData(arg_2_1, arg_2_2)
	local var_2_0, var_2_1 = SectionSelectHeroTools.GetRestrictHeroList(arg_2_1.stageType, arg_2_1.stageID)
	local var_2_2, var_2_3 = SectionSelectHeroTools.GetRestrictHeroPosDic(arg_2_1.stageType, arg_2_1.stageID)

	for iter_2_0, iter_2_1 in ipairs((clone(arg_2_2.resultTrialList))) do
		if iter_2_1 ~= 0 then
			if var_2_0[iter_2_0][1] ~= nil then
				if var_2_1[iter_2_0] ~= ReserveConst.RESTRICT_HERO_SWITCH_MODE.FORBID and (not var_2_3[iter_2_1] or var_2_3[iter_2_1] ~= iter_2_0) then
					self:ResetHeroInTeamAtPos(arg_2_2, iter_2_0)
				end
			elseif not table.keyof(self:GetTrialHeroList(arg_2_1), iter_2_1) then
				self:ResetHeroInTeamAtPos(arg_2_2, iter_2_0)
			end
		end
	end

	for iter_2_2, iter_2_3 in ipairs((clone(arg_2_2.resultHeroList))) do
		local var_2_4 = ChallengeRogueTeamData:GetHeroData(iter_2_3, nil, true)

		if not (var_2_4 and var_2_4.hpPercent) or (var_2_4 and var_2_4.hpPercent) == 0 then
			self:ResetHeroInTeamAtPos(arg_2_2, iter_2_2)
		end
	end
end

function ReserveChallengeRogueTeamTemplate:GetComboSkillID(arg_3_1, arg_3_2)
	if arg_3_1.stageID and arg_3_1.stageID ~= 0 then
		local var_3_0 = BattleStageTools.GetStageCfg(arg_3_1.stageType, arg_3_1.stageID)

		if var_3_0 and var_3_0.combo_skill_id and var_3_0.combo_skill_id ~= 0 then
			return var_3_0.combo_skill_id
		end

		if SectionSelectHeroTools.IsAllPosFullLock(arg_3_1.stageType, arg_3_1.stageID) then
			return ReserveConst.DEFAULT_COMBO_SKILL_ID
		end
	end

	local var_3_1 = true

	self.cacheHeroTeam = self.cacheHeroTeam or ReserveTools.GetHeroList(arg_3_1)

	for iter_3_0, iter_3_1 in ipairs(arg_3_2) do
		if not table.indexof(self.cacheHeroTeam, iter_3_1) then
			self.cacheRecommendSkillID = nil
			var_3_1 = false

			break
		end
	end

	local var_3_2 = self:GetContDataTemplateById(arg_3_1.contID):GetComboSkillID(arg_3_1.teamIndex)

	curReserveComnoSkillID = not var_3_1 and ComboSkillTools.GetRecommendSkillID(arg_3_2, true) or self.cacheRecommendSkillID and self.cacheRecommendSkillID ~= var_3_2 and self.cacheRecommendSkillID or var_3_2
	self.cacheHeroTeam = {}

	for iter_3_2, iter_3_3 in ipairs(arg_3_2) do
		table.insert(self.cacheHeroTeam, iter_3_3)
	end

	if curReserveComnoSkillID ~= 0 and not ComboSkillTools.IsAllMatch(curReserveComnoSkillID, arg_3_2) then
		return ComboSkillTools.GetRecommendSkillID(arg_3_2, true)
	end

	return curReserveComnoSkillID
end

function ReserveChallengeRogueTeamTemplate:SetComboSkillID(arg_4_1, arg_4_2)
	self.cacheRecommendSkillID = arg_4_2

	self:GetContDataTemplateById(arg_4_1.contID):SetComboSkillID(arg_4_2, arg_4_1.teamIndex)
end

return ReserveChallengeRogueTeamTemplate
