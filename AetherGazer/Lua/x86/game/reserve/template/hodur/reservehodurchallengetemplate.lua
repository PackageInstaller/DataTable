local var_0_0 = import("game.reserve.template.ReserveBaseTemplate")
local var_0_1 = class("ReserveHodurChallengeTemplate", var_0_0)

function var_0_1.GetHeroList(arg_1_0, arg_1_1)
	local var_1_0 = {}

	if HodurTools.IsChallenge(arg_1_1.customData.chapterID) then
		if HodurSystemData:IsChallengeTeamSwitch() then
			local var_1_1 = {}
			local var_1_2

			var_1_0, var_1_2 = HodurSystemData:GetChallengeTeam()

			for iter_1_0, iter_1_1 in ipairs(var_1_2) do
				if iter_1_1 ~= 0 then
					var_1_0[iter_1_0] = iter_1_1
				end
			end
		elseif HodurSystemData:CheckFinalHero() then
			return arg_1_0:GetCacheList()
		else
			var_1_0 = HodurTools.GetChallengeBattleHero()
		end
	else
		var_1_0 = {
			(HodurTools.GetMainlineHeroID(arg_1_1.customData.chapterID))
		}
	end

	if not var_1_0 or #var_1_0 == 0 then
		return var_0_1.GetSuperHeroList(arg_1_0, arg_1_1)
	end

	local var_1_3 = {
		isInVaild = false,
		resultHeroList = {
			0,
			0,
			0
		},
		lockStateList = {
			false,
			false,
			false
		},
		lockHeroList = {},
		resultTrialList = {
			0,
			0,
			0
		}
	}
	local var_1_4 = {}

	for iter_1_2, iter_1_3 in pairs(var_1_0) do
		local var_1_5 = HeroStandardSystemCfg[iter_1_3]

		if var_1_5 then
			var_1_4[iter_1_2] = iter_1_3
			var_1_0[iter_1_2] = var_1_5.hero_id
		else
			var_1_4[iter_1_2] = 0
		end
	end

	var_1_3.resultHeroList = var_1_0
	var_1_3.resultTrialList = var_1_4
	var_1_3.lockStateList = {
		true,
		true,
		true
	}

	return var_1_3.resultHeroList, var_1_3.lockStateList, var_1_3.lockHeroList, var_1_3.resultTrialList, var_1_3.isInVaild
end

local function var_0_2(arg_2_0)
	if HodurTools.CheckSpecialAffix() then
		if HodurConst.TRAIL_DIC[arg_2_0] then
			return HodurConst.TRAIL_DIC[arg_2_0]
		else
			return arg_2_0
		end
	elseif HodurConst.TRAIL_DIC_SPE[arg_2_0] then
		return HodurConst.TRAIL_DIC_SPE[arg_2_0]
	else
		return arg_2_0
	end

	return arg_2_0
end

function var_0_1.GetCacheList(arg_3_0)
	local var_3_0 = HodurSystemData:GetFinalHero()
	local var_3_1 = {
		isInVaild = false,
		resultHeroList = {
			0,
			0,
			0
		},
		lockStateList = {
			false,
			false,
			false
		},
		lockHeroList = {},
		resultTrialList = {
			0,
			0,
			0
		}
	}
	local var_3_2 = {}

	for iter_3_0, iter_3_1 in pairs(var_3_0) do
		local var_3_3 = HeroStandardSystemCfg[iter_3_1]

		if var_3_3 then
			var_3_2[iter_3_0] = var_0_2(iter_3_1)
			var_3_0[iter_3_0] = var_3_3.hero_id
		else
			var_3_2[iter_3_0] = 0
		end
	end

	var_3_1.resultHeroList = var_3_0
	var_3_1.resultTrialList = var_3_2
	var_3_1.lockStateList = {
		false,
		false,
		false
	}

	return var_3_1.resultHeroList, var_3_1.lockStateList, var_3_1.lockHeroList, var_3_1.resultTrialList, var_3_1.isInVaild
end

function var_0_1.GetSuperHeroList(arg_4_0, arg_4_1)
	local var_4_0 = {
		isInVaild = false,
		resultHeroList = {
			0,
			0,
			0
		},
		lockStateList = {
			false,
			false,
			false
		},
		lockHeroList = {},
		resultTrialList = {
			0,
			0,
			0
		}
	}

	if arg_4_1.reserveType ~= ReserveConst.RESERVE_TYPE.NOT_NEED_RESERVE then
		local var_4_1 = arg_4_0:GetContDataTemplateById(arg_4_1.contID):GetHeroList(arg_4_1.teamIndex)

		arg_4_0:FormatHeroList(arg_4_1, var_4_0, var_4_1)
	end

	arg_4_0:FilterInvalidTeamData(arg_4_1, var_4_0)
	arg_4_0:GetLockHero(arg_4_1, var_4_0)
	arg_4_0:FilterLockHero(arg_4_1, var_4_0)
	arg_4_0:ReorderHeroList(arg_4_1, var_4_0)

	return var_4_0.resultHeroList, var_4_0.lockStateList, var_4_0.lockHeroList, var_4_0.resultTrialList, var_4_0.isInVaild
end

return var_0_1
