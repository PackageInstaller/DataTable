local var_0_0 = import("game.reserve.template.ReserveBaseTemplate")
local var_0_1 = class("ReserveChallengeRogueTeamTemplate", var_0_0)

function var_0_1.GetLockHero(arg_1_0, arg_1_1, arg_1_2)
	return
end

function var_0_1.FilterInvalidTeamData(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0, var_2_1 = SectionSelectHeroTools.GetRestrictHeroList(arg_2_1.stageType, arg_2_1.stageID)
	local var_2_2, var_2_3 = SectionSelectHeroTools.GetRestrictHeroPosDic(arg_2_1.stageType, arg_2_1.stageID)
	local var_2_4 = clone(arg_2_2.resultTrialList)

	for iter_2_0, iter_2_1 in ipairs(var_2_4) do
		if iter_2_1 ~= 0 then
			if var_2_0[iter_2_0][1] ~= nil then
				if var_2_1[iter_2_0] ~= ReserveConst.RESTRICT_HERO_SWITCH_MODE.FORBID and (not var_2_3[iter_2_1] or var_2_3[iter_2_1] ~= iter_2_0) then
					arg_2_0:ResetHeroInTeamAtPos(arg_2_2, iter_2_0)
				end
			else
				local var_2_5 = arg_2_0:GetTrialHeroList(arg_2_1)

				if not table.keyof(var_2_5, iter_2_1) then
					arg_2_0:ResetHeroInTeamAtPos(arg_2_2, iter_2_0)
				end
			end
		end
	end

	local var_2_6 = clone(arg_2_2.resultHeroList)

	for iter_2_2, iter_2_3 in ipairs(var_2_6) do
		local var_2_7 = ChallengeRogueTeamData:GetHeroData(iter_2_3, nil, true)
		local var_2_8 = var_2_7 and var_2_7.hpPercent

		if not var_2_8 or var_2_8 == 0 then
			arg_2_0:ResetHeroInTeamAtPos(arg_2_2, iter_2_2)
		end
	end
end

function var_0_1.GetComboSkillID(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1.stageID and arg_3_1.stageID ~= 0 then
		local var_3_0 = BattleStageTools.GetStageCfg(arg_3_1.stageType, arg_3_1.stageID)

		if var_3_0 and var_3_0.combo_skill_id and var_3_0.combo_skill_id ~= 0 then
			return var_3_0.combo_skill_id
		end

		if SectionSelectHeroTools.IsAllPosFullLock(arg_3_1.stageType, arg_3_1.stageID) then
			return ReserveConst.DEFAULT_COMBO_SKILL_ID
		end
	end

	local var_3_1 = ReserveTools.GetHeroList(arg_3_1)
	local var_3_2 = true

	if not arg_3_0.cacheHeroTeam then
		arg_3_0.cacheHeroTeam = var_3_1
	end

	for iter_3_0, iter_3_1 in ipairs(arg_3_2) do
		if not table.indexof(arg_3_0.cacheHeroTeam, iter_3_1) then
			arg_3_0.cacheRecommendSkillID = nil
			var_3_2 = false

			break
		end
	end

	local var_3_3 = arg_3_0:GetContDataTemplateById(arg_3_1.contID):GetComboSkillID(arg_3_1.teamIndex)
	local var_3_4 = ComboSkillTools.GetRecommendSkillID(arg_3_2, true)

	if not var_3_2 then
		curReserveComnoSkillID = var_3_4
	elseif arg_3_0.cacheRecommendSkillID and arg_3_0.cacheRecommendSkillID ~= var_3_3 then
		curReserveComnoSkillID = arg_3_0.cacheRecommendSkillID
	else
		curReserveComnoSkillID = var_3_3
	end

	arg_3_0.cacheHeroTeam = {}

	for iter_3_2, iter_3_3 in ipairs(arg_3_2) do
		table.insert(arg_3_0.cacheHeroTeam, iter_3_3)
	end

	if curReserveComnoSkillID ~= 0 and not ComboSkillTools.IsAllMatch(curReserveComnoSkillID, arg_3_2) then
		return ComboSkillTools.GetRecommendSkillID(arg_3_2, true)
	end

	return curReserveComnoSkillID
end

function var_0_1.SetComboSkillID(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = arg_4_0:GetContDataTemplateById(arg_4_1.contID)

	arg_4_0.cacheRecommendSkillID = arg_4_2

	var_4_0:SetComboSkillID(arg_4_2, arg_4_1.teamIndex)
end

return var_0_1
