local var_0_0 = import("game.views.sectionSelectHero.SelectHeroProxy.SelectHeroBaseProxy")
local var_0_1 = class("AreaBattleHeroProxy", var_0_0)

function var_0_1.IsSameTeam(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	local var_1_0 = 0

	for iter_1_0, iter_1_1 in pairs(arg_1_1) do
		for iter_1_2, iter_1_3 in ipairs(arg_1_2) do
			if iter_1_1 == iter_1_3 then
				var_1_0 = var_1_0 + 1
			end
		end
	end

	for iter_1_4, iter_1_5 in pairs(arg_1_3) do
		for iter_1_6, iter_1_7 in ipairs(arg_1_2) do
			if iter_1_5 == iter_1_7 then
				var_1_0 = var_1_0 + 1
			end
		end
	end

	return var_1_0 == #arg_1_2
end

function var_0_1.InitCustomParams(arg_2_0, arg_2_1)
	arg_2_0.reserveParams = var_0_1.GetCustomReserveParams(arg_2_0.reserveParams.stageType, arg_2_0.reserveParams.stageID, arg_2_0.reserveParams.customData.activityID)
end

function var_0_1.GotoHeroInfoUI(arg_3_0, arg_3_1)
	local var_3_0, var_3_1 = arg_3_0:CheckBeforeGotoHeroInfoUI(arg_3_1)

	if not var_3_0 then
		if var_3_1 then
			ShowTips(var_3_1)
		end

		return
	end

	local var_3_2 = arg_3_0:GetDefaultTeamInfoParams(arg_3_1)
	local var_3_3 = arg_3_0:GetCustomeTeamInfoParams(arg_3_1)

	for iter_3_0, iter_3_1 in pairs(var_3_3) do
		var_3_2[iter_3_0] = iter_3_1
	end

	local var_3_4 = ActivityCfg.get_id_list_by_sub_activity_list[arg_3_0.activityID][1]
	local var_3_5 = ActivityAreaBattleData:GetDataByActivityID(var_3_4)[arg_3_0.activityID]
	local var_3_6 = 1

	for iter_3_2, iter_3_3 in pairs(ActivityAreaBattleCfg[arg_3_0.activityID].stage_id) do
		for iter_3_4, iter_3_5 in pairs(iter_3_3) do
			if iter_3_5 == arg_3_0.reserveParams.stageID then
				var_3_6 = iter_3_2
			end
		end
	end

	if var_3_5.difficultList[var_3_6] and var_3_5.difficultList[var_3_6][arg_3_0.stageID] and #var_3_5.difficultList[var_3_6][arg_3_0.stageID].usedHeroList ~= 0 then
		ShowTips("ACTIVITY_AREA_BATTLE_RESETTING_TIP")

		return
	end

	JumpTools.OpenPageByJump(arg_3_0:GetHeroTeamInfoRoute(), var_3_2)
end

function var_0_1.GetCustomReserveParams(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = ReserveTools.GetReserveType(arg_4_0, arg_4_1)
	local var_4_1 = ReserveTools.GetContID(arg_4_0, arg_4_1)
	local var_4_2 = ActivityCfg.get_id_list_by_sub_activity_list[arg_4_2][1]
	local var_4_3 = ActivityAreaBattleData:GetDataByActivityID(var_4_2)[arg_4_2]
	local var_4_4 = 1

	for iter_4_0, iter_4_1 in pairs(ActivityAreaBattleCfg[arg_4_2].stage_id) do
		for iter_4_2, iter_4_3 in pairs(iter_4_1) do
			if iter_4_3 == arg_4_1 then
				var_4_4 = iter_4_0
			end
		end
	end

	local var_4_5 = {
		stageType = arg_4_0,
		stageID = arg_4_1,
		activityID = arg_4_2 or 0,
		data = var_4_3,
		difficult = var_4_4
	}

	return ReserveParams.New(var_4_0, var_4_1, nil, var_4_5)
end

function var_0_1.GotoReservesProposalUI(arg_5_0)
	local var_5_0 = ActivityCfg.get_id_list_by_sub_activity_list[arg_5_0.activityID][1]
	local var_5_1 = ActivityAreaBattleData:GetDataByActivityID(var_5_0)[arg_5_0.activityID]
	local var_5_2 = 1

	for iter_5_0, iter_5_1 in pairs(ActivityAreaBattleCfg[arg_5_0.activityID].stage_id) do
		for iter_5_2, iter_5_3 in pairs(iter_5_1) do
			if iter_5_3 == arg_5_0.reserveParams.stageID then
				var_5_2 = iter_5_0
			end
		end
	end

	if var_5_1.difficultList[var_5_2] and var_5_1.difficultList[var_5_2][arg_5_0.stageID] and #var_5_1.difficultList[var_5_2][arg_5_0.stageID].usedHeroList ~= 0 then
		ShowTips("ACTIVITY_AREA_BATTLE_RESETTING_TIP")

		return
	end

	var_0_1.super.GotoReservesProposalUI(arg_5_0)
end

return var_0_1
