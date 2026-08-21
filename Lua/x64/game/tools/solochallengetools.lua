local var_0_0 = {}

function var_0_0.InitConst(arg_1_0)
	local var_1_0 = ActivitySoloChallengeCfg[arg_1_0]

	var_0_0.stageInfoDic = var_0_0.stageInfoDic or {}
	var_0_0.difficultyIDToIndex = var_0_0.difficultyIDToIndex or {}

	local var_1_1 = var_1_0.stage_id

	for iter_1_0, iter_1_1 in ipairs(var_1_1) do
		local var_1_2 = iter_1_1[1]
		local var_1_3 = iter_1_1[2]

		for iter_1_2, iter_1_3 in ipairs(var_1_3) do
			local var_1_4 = {
				stageID = iter_1_3,
				stageIndex = iter_1_2,
				difficultIndex = iter_1_0,
				difficultID = var_1_2
			}

			var_0_0.stageInfoDic[iter_1_3] = var_1_4
		end

		var_0_0.difficultyIDToIndex[var_1_2] = iter_1_0
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
	local var_6_1 = var_6_0.pos
	local var_6_2 = var_6_0.stageID
	local var_6_3 = SoloChallengeTools.GetStageInfo(var_6_2)

	ReserveTools.GetReserveTemplateByReserveType(ReserveConst.RESERVE_TYPE.SOLO_CHALLENGE):GetContDataTemplateById(var_6_3.difficultID):SetAffix(var_6_3.stageIndex, var_6_1, 0)
	ReserveAction.SaveSoloChallengeContData(arg_6_0, var_6_3.difficultIndex, function()
		SoloChallengeData:DischargeAffix(arg_6_0, arg_6_1)
		manager.notify:CallUpdateFunc(SOLO_CHALLENGE_AFFIX_REFRESH, arg_6_1)
	end)
end

return var_0_0
