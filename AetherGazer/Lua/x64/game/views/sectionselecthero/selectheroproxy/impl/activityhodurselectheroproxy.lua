local var_0_0 = import("game.views.sectionSelectHero.SelectHeroProxy.SelectHeroBaseProxy")
local var_0_1 = class("ActivityHodurSelectHeroProxy", var_0_0)

function var_0_1.GetStageData(arg_1_0)
	local var_1_0 = BattleStageFactory.Produce(arg_1_0.stageType, arg_1_0.stageID, {
		activityID = arg_1_0.activityID,
		chapterID = arg_1_0.chapterID
	}, arg_1_0.reserveParams)

	HodurSystemData:CacheStageData(var_1_0)

	return var_1_0
end

function var_0_1.CustomChangeHeroTeam(arg_2_0, arg_2_1, arg_2_2)
	ReserveTools.SetHeroList(arg_2_0.reserveParams, arg_2_1, arg_2_2)
	HodurSystemData:SetChallengeTeam(arg_2_1, arg_2_2)
end

function var_0_1.InitCustomParams(arg_3_0, arg_3_1)
	arg_3_0.chapterID = arg_3_1.chapterID
	arg_3_0.needMimirPanel = false
	arg_3_0.canChangeMimir = false
	arg_3_0.needReserveProposalPanel = false
	arg_3_0.canChangeReserveProposal = false
	arg_3_0.needHeroHP = true
	arg_3_0.forceChangePos = true
	arg_3_0.canUseMultiMode = false
end

function var_0_1.CustomGetTeamData(arg_4_0)
	local var_4_0, var_4_1, var_4_2, var_4_3 = ReserveTools.GetHeroList(arg_4_0.reserveParams)

	return var_4_0, var_4_1, var_4_2, var_4_3
end

function var_0_1.CustomGetHeroHP(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	local var_5_0 = arg_5_3 ~= nil and arg_5_3 ~= 0 and arg_5_3 or arg_5_2
	local var_5_1, var_5_2 = HodurTools.GetChapterHeroHP(arg_5_0.chapterID, var_5_0)
	local var_5_3 = var_5_1
	local var_5_4 = math.max(1, math.floor(var_5_1 / var_5_2 * 100))

	if var_5_1 == 0 then
		var_5_4 = 0
	end

	return var_5_3, var_5_4
end

function var_0_1.CheckBeforeGotoHeroInfoUI(arg_6_0, arg_6_1)
	if not arg_6_0.canChangeTeam then
		return false, "CAN_NOT_CHANGE_HERO"
	end

	if arg_6_0.stageID and arg_6_0.stageID ~= 0 then
		local var_6_0, var_6_1 = BattleStageTools.GetRestrictHeroList(arg_6_0.stageType, arg_6_0.stageID)

		if type(var_6_0) == "table" then
			local var_6_2 = var_6_0[arg_6_1]

			if var_6_2[1] == 0 then
				return false, "CAN_NOT_CHANGE_HERO"
			end

			if HeroCfg[var_6_2[1]] and HeroTools.IsNPC(var_6_2[1]) and (type(var_6_1) ~= "table" or var_6_1[arg_6_1] == ReserveConst.RESTRICT_HERO_SWITCH_MODE.FORBID) then
				return false, "CAN_NOT_CHANGE_HERO"
			end
		end

		local var_6_3, var_6_4, var_6_5, var_6_6 = ReserveTools.GetHeroList(arg_6_0.reserveParams)

		if type(var_6_4) == "table" and var_6_4[arg_6_1] then
			return false, "CAN_NOT_CHANGE_HERO"
		end
	end

	return arg_6_0:CustomCheckBeforeGotoHeroInfoUI(arg_6_1)
end

return var_0_1
