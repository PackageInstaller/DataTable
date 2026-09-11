local var_0_0 = {
	GetLockHero = function()
		local var_1_0 = BattleBossChallengeData:GetSelectMode()

		if var_1_0 == BossConst.MODE_NONE then
			return {}
		end

		if var_1_0 == BossConst.MODE_NORMAL then
			return BattleBossChallengeNormalData:GetLockHero()
		else
			return BattleBossChallengeAdvanceData:GetLockHero()
		end
	end,
	GetCacheHeroTeam = function(arg_2_0)
		if BattleBossChallengeData:GetSelectMode() == BossConst.MODE_NORMAL then
			return BattleBossChallengeNormalData:GetCacheHeroTeam(arg_2_0)
		else
			return BattleBossChallengeAdvanceData:GetCacheHeroTeam(arg_2_0)
		end
	end,
	CheckTimeout = function()
		if BattleBossChallengeData:GetSelectMode() == BossConst.MODE_NONE then
			BattleBossChallengeAction.BossChallengeBackEntrace()
		end
	end,
	GetBossID = function(arg_4_0, arg_4_1)
		if arg_4_0 == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_BOSS_CHALLENGE then
			return StageGroupCfg[BattleBossChallengeNormalData:GetBossList()[arg_4_1]].boss_id
		elseif arg_4_0 == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_BOSS_CHALLENGE_ADVANCE then
			return BattleBossChallengeAdvanceData:GetBossList()[arg_4_1].templateID
		end
	end,
	GetContID = function(arg_5_0, arg_5_1)
		if arg_5_0 == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_BOSS_CHALLENGE then
			return BattleBossChallengeNormalData:GetBossList()[arg_5_1]
		elseif arg_5_0 == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_BOSS_CHALLENGE_ADVANCE then
			return BattleBossChallengeAdvanceData:GetBossList()[arg_5_1].id
		end
	end
}

function var_0_0.IsFirstEnterUI(arg_6_0)
	local var_6_0 = BattleBossChallengeData:GetRewardPreviewLevel()

	if var_0_0.IsClearedStage() then
		return false
	end

	return var_6_0 ~= (arg_6_0 == BossConst.MODE_NORMAL and BattleBossChallengeNormalData:GetBossChallengeCfg().range_id or BattleBossChallengeAdvanceData:GetChooseModeID())
end

function var_0_0.SaveFirstEnterUIValue(arg_7_0)
	BattleBossChallengeData:SetRewardPreviewLevel(arg_7_0 == BossConst.MODE_NORMAL and BattleBossChallengeNormalData:GetBossChallengeCfg().range_id or BattleBossChallengeAdvanceData:GetChooseModeID())
end

function var_0_0.IsClearedStage()
	for iter_8_0, iter_8_1 in ipairs(var_0_0.GetLockHero()) do
		if #iter_8_1 > 0 then
			return true
		end
	end

	return false
end

return var_0_0
