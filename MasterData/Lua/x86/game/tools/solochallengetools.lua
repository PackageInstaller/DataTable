local var_0_0 = {}

function var_0_0.InitConst(arg_1_0)
	var_0_0.stageInfoDic = var_0_0.stageInfoDic or {}
	var_0_0.difficultyIDToIndex = var_0_0.difficultyIDToIndex or {}

	for iter_1_0, iter_1_1 in ipairs(ActivitySoloChallengeCfg[arg_1_0].stage_id) do
		for iter_1_2, iter_1_3 in ipairs(iter_1_1[2]) do
			var_0_0.stageInfoDic[iter_1_3] = {
				stageID = iter_1_3,
				stageIndex = iter_1_2,
				difficultIndex = iter_1_0,
				difficultID = iter_1_1[1]
			}
		end

		var_0_0.difficultyIDToIndex[iter_1_1[1]] = iter_1_0
	end
end

function var_0_0.GetStageInfo(arg_2_0)
	return var_0_0.stageInfoDic[arg_2_0] or {}
end

function var_0_0.GetDifficultyIndex(arg_3_0)
	return var_0_0.difficultyIDToIndex[arg_3_0]
end

function var_0_0.EquipAffix(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	local var_4_0 = SoloChallengeTools.GetStageInfo(arg_4_1)

	ReserveTools.GetReserveTemplateByReserveType(ReserveConst.RESERVE_TYPE.SOLO_CHALLENGE):GetContDataTemplateById(var_4_0.difficultID):SetAffix(var_4_0.stageIndex, arg_4_2, arg_4_3)
	ReserveAction.SaveSoloChallengeContData(arg_4_0, var_4_0.difficultIndex, function()
		SoloChallengeData:EquipAffix(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
		manager.notify:CallUpdateFunc(SOLO_CHALLENGE_AFFIX_REFRESH, arg_4_3)
	end)
end

function var_0_0.DischargeAffix(arg_6_0, arg_6_1)
	local var_6_0 = SoloChallengeData:GetAffixState(arg_6_0, arg_6_1)
	local var_6_1 = SoloChallengeTools.GetStageInfo(var_6_0.stageID)

	ReserveTools.GetReserveTemplateByReserveType(ReserveConst.RESERVE_TYPE.SOLO_CHALLENGE):GetContDataTemplateById(var_6_1.difficultID):SetAffix(var_6_1.stageIndex, var_6_0.pos, 0)
	ReserveAction.SaveSoloChallengeContData(arg_6_0, var_6_1.difficultIndex, function()
		SoloChallengeData:DischargeAffix(arg_6_0, arg_6_1)
		manager.notify:CallUpdateFunc(SOLO_CHALLENGE_AFFIX_REFRESH, arg_6_1)
	end)
end

return var_0_0
