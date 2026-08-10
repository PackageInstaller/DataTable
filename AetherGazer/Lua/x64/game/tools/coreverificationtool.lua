return {
	GotoFightSelect = function(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
		local var_1_0 = ReserveParams.New(ReserveConst.RESERVE_TYPE.CORE_VERIFICATION, arg_1_2, nil, {
			stageType = BattleConst.STAGE_TYPE_NEW.CORE_VERIFICATION,
			stageID = arg_1_0,
			suffixList = arg_1_3
		})

		JumpTools.OpenPageByJump("/sectionSelectHero", {
			section = arg_1_0,
			sectionType = BattleConst.STAGE_TYPE_NEW.CORE_VERIFICATION,
			reserveParams = var_1_0,
			activityID = arg_1_1
		})
	end,
	IsOpenSuperStage = function()
		local var_2_0, var_2_1 = CoreVerificationData:GetMaxPassByBossType(1)
		local var_2_2, var_2_3 = CoreVerificationData:GetMaxPassByBossType(2)
		local var_2_4 = CoreVerificationData:GetMaxUnlockByBossType(1)
		local var_2_5 = CoreVerificationData:GetMaxUnlockByBossType(1)
		local var_2_6 = CoreVerificationData:GetInfoCfgByTypeAndDiff(1, var_2_4)
		local var_2_7 = CoreVerificationData:GetInfoCfgByTypeAndDiff(2, var_2_5)
		local var_2_8 = var_2_6 and var_2_6.stage_type == 1 or false
		local var_2_9 = var_2_7 and var_2_7.stage_type == 1 or false

		return var_2_4 <= var_2_1 + 1 and var_2_5 <= var_2_3 + 1 and var_2_8 and var_2_9 and not var_2_0 and not var_2_2
	end,
	IsPassSuperStage = function()
		local var_3_0 = CoreVerificationData:IsPassChallengeChallge(1)
		local var_3_1 = CoreVerificationData:IsPassChallengeChallge(2)

		return var_3_0 and var_3_1
	end
}
