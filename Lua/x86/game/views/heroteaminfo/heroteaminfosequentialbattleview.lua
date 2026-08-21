local var_0_0 = import("game.views.heroTeamInfo.NewHeroTeamInfoBaseView")
local var_0_1 = class("HeroTeamInfoSequentialBattleView", var_0_0)

function var_0_1.OnEnter(arg_1_0)
	arg_1_0.cacheSorterExtraHeroList_ = {}

	var_0_1.super.OnEnter(arg_1_0)
end

function var_0_1.GetCacheSorterExtraHeroList(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_0.cacheSorterExtraHeroList_[arg_2_2] then
		return arg_2_0.cacheSorterExtraHeroList_[arg_2_2]
	end

	local var_2_0 = arg_2_1
	local var_2_1 = arg_2_2
	local var_2_2 = ReserveTools.GetReserveTemplateByReserveType(ReserveConst.RESERVE_TYPE.SEQUENTIAL_BATTLE_CACHE):GetContDataTemplateById(var_2_0)

	arg_2_0.cacheSorterExtraHeroList_[arg_2_2] = var_2_2:GetHeroList(var_2_1)

	return arg_2_0.cacheSorterExtraHeroList_[arg_2_2]
end

function var_0_1.ExtraSorter(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	local var_3_0 = arg_3_0.heroTeam_
	local var_3_1 = arg_3_0.heroTrialList_
	local var_3_2 = table.keyof(SequentialBattleChapterCfg[arg_3_0.params_.activityID].stage_id, arg_3_0.params_.stageID)
	local var_3_3 = {}

	for iter_3_0, iter_3_1 in pairs(var_3_0) do
		var_3_3[iter_3_0] = {
			id = iter_3_1,
			trialID = var_3_1[iter_3_0]
		}
	end

	local var_3_4 = false
	local var_3_5 = false

	for iter_3_2 = 1, #SequentialBattleChapterCfg[arg_3_0.params_.activityID].stage_id do
		if iter_3_2 ~= var_3_2 then
			local var_3_6 = arg_3_0:GetCacheSorterExtraHeroList(arg_3_0.params_.activityID, iter_3_2)

			for iter_3_3, iter_3_4 in pairs(var_3_6) do
				local var_3_7 = iter_3_4:GetHeroID()

				if arg_3_1.id == var_3_7 then
					var_3_4 = true
				end

				if arg_3_2.id == var_3_7 then
					var_3_5 = true
				end
			end
		end
	end

	if var_3_4 ~= var_3_5 then
		return true, var_3_5 and true or false
	end

	return var_0_1.super.ExtraSorter(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
end

function var_0_1.HeadRenderer(arg_4_0, arg_4_1, arg_4_2)
	var_0_1.super.HeadRenderer(arg_4_0, arg_4_1, arg_4_2)

	local var_4_0 = arg_4_0.heroDataList_[arg_4_1].id

	arg_4_2:SetHeroLock(table.keyof(arg_4_0.lockHeroList_, var_4_0) ~= nil)
end

function var_0_1.OnJoinClick(arg_5_0)
	var_0_1.super.OnJoinClick(arg_5_0)
end

function var_0_1.ChangeTeam(arg_6_0, arg_6_1, arg_6_2)
	ReserveTools.SetHeroList(arg_6_0.params_.reserveParams, arg_6_1, arg_6_2)
	arg_6_0.sectionProxy_:ChangeHeroTeam(arg_6_1, arg_6_2)
end

return var_0_1
