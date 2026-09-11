local ReserveHodurChallengeTemplate = class("ReserveHodurChallengeTemplate", (import("game.reserve.template.ReserveBaseTemplate")))

function ReserveHodurChallengeTemplate:GetHeroList(arg_1_1)
	local var_1_0 = {}

	if HodurTools.IsChallenge(arg_1_1.customData.chapterID) then
		if HodurSystemData:IsChallengeTeamSwitch() then
			local var_1_2, var_1_3 = HodurSystemData:GetChallengeTeam()

			var_1_0 = var_1_2

			for iter_1_0, iter_1_1 in ipairs(var_1_3) do
				if iter_1_1 ~= 0 then
					var_1_0[iter_1_0] = iter_1_1
				end
			end
		elseif HodurSystemData:CheckFinalHero() then
			return self:GetCacheList()
		else
			var_1_0 = HodurTools.GetChallengeBattleHero()
		end
	else
		var_1_0 = {
			(HodurTools.GetMainlineHeroID(arg_1_1.customData.chapterID))
		}
	end

	if not var_1_0 or #var_1_0 == 0 then
		return ReserveHodurChallengeTemplate.GetSuperHeroList(self, arg_1_1)
	end

	local var_1_4 = {
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
	local var_1_5 = {}

	for iter_1_2, iter_1_3 in pairs(var_1_0) do
		if HeroStandardSystemCfg[iter_1_3] then
			var_1_5[iter_1_2] = iter_1_3
			var_1_0[iter_1_2] = HeroStandardSystemCfg[iter_1_3].hero_id
		else
			var_1_5[iter_1_2] = 0
		end
	end

	var_1_4.resultHeroList = var_1_0
	var_1_4.resultTrialList = var_1_5
	var_1_4.lockStateList = {
		true,
		true,
		true
	}

	return var_1_4.resultHeroList, var_1_4.lockStateList, var_1_4.lockHeroList, var_1_4.resultTrialList, var_1_4.isInVaild
end

local function var_0_1(arg_2_0)
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

function ReserveHodurChallengeTemplate:GetCacheList()
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
		if HeroStandardSystemCfg[iter_3_1] then
			var_3_2[iter_3_0] = var_0_1(iter_3_1)
			var_3_0[iter_3_0] = HeroStandardSystemCfg[iter_3_1].hero_id
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

function ReserveHodurChallengeTemplate:GetSuperHeroList(arg_4_1)
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
		self:FormatHeroList(arg_4_1, var_4_0, (self:GetContDataTemplateById(arg_4_1.contID):GetHeroList(arg_4_1.teamIndex)))
	end

	self:FilterInvalidTeamData(arg_4_1, var_4_0)
	self:GetLockHero(arg_4_1, var_4_0)
	self:FilterLockHero(arg_4_1, var_4_0)
	self:ReorderHeroList(arg_4_1, var_4_0)

	return var_4_0.resultHeroList, var_4_0.lockStateList, var_4_0.lockHeroList, var_4_0.resultTrialList, var_4_0.isInVaild
end

return ReserveHodurChallengeTemplate
