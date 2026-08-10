local var_0_0 = singletonClass("SwimsuitBattleData")
local var_0_1 = 0
local var_0_2 = 0
local var_0_3 = 0
local var_0_4 = {}
local var_0_5 = {}
local var_0_6 = {}
local var_0_7 = {}
local var_0_8 = 0
local var_0_9 = {}
local var_0_10

function var_0_0.Init(arg_1_0)
	var_0_1 = SwimsuitBattleInfoCfg.all[1]
	var_0_2 = 0
	var_0_3 = 0
	var_0_4 = {}

	for iter_1_0, iter_1_1 in ipairs(SwimsuitBattleInfoCfg.all) do
		local var_1_0 = SwimsuitBattleInfoCfg[iter_1_1]

		var_0_4[iter_1_1] = {}

		for iter_1_2 = 1, #var_1_0.hero_list do
			table.insert(var_0_4[iter_1_1], {
				heroID = var_1_0.hero_list[iter_1_2],
				skinID = var_1_0.skin_id[iter_1_2],
				activityID = var_1_0.subactivity_list[iter_1_2]
			})
		end
	end

	var_0_9 = {}

	for iter_1_3, iter_1_4 in ipairs(SwimsuitVoteSystemCfg.all) do
		var_0_9[iter_1_4] = SwimsuitVoteSystemCfg[iter_1_4].activity_subsidiary_id
	end

	var_0_10 = false
end

function var_0_0.initDataFromServer(arg_2_0, arg_2_1)
	var_0_2 = arg_2_1.day_vote_ticket_num

	SwimsuitBattleAction.CheckSwimsuitVoteTicketNum()
end

function var_0_0.initVoteFromServer(arg_3_0, arg_3_1)
	var_0_7 = {}

	for iter_3_0, iter_3_1 in ipairs(arg_3_1.all_schedule_time) do
		var_0_7[iter_3_1.schedule_id] = {}
		var_0_7[iter_3_1.schedule_id].startTime = iter_3_1.start_time
		var_0_7[iter_3_1.schedule_id].endTime = iter_3_1.end_time
	end
end

function var_0_0.UpdateVoteFromServer(arg_4_0, arg_4_1)
	var_0_8 = arg_4_1.schedule_id

	if var_0_8 == 0 then
		var_0_8 = 5
	end

	var_0_5 = {}

	for iter_4_0, iter_4_1 in ipairs(arg_4_1.schedule_list) do
		var_0_5[iter_4_1.schedule_id] = {}

		for iter_4_2, iter_4_3 in ipairs(iter_4_1.competition_list) do
			var_0_5[iter_4_1.schedule_id][iter_4_3.competition_id] = iter_4_3.competition_value
		end
	end

	var_0_6 = {}

	for iter_4_4, iter_4_5 in ipairs(arg_4_1.schedule_win_competition) do
		var_0_6[iter_4_5.schedule_id] = {}

		for iter_4_6, iter_4_7 in ipairs(iter_4_5.competition_list) do
			var_0_6[iter_4_5.schedule_id][iter_4_7.competition_id] = iter_4_7.competition_value
		end
	end

	SwimsuitBattleAction.CheckSwimsuitVoteTicketNum()
end

function var_0_0.UpdateTicketNumAfterBattle(arg_5_0, arg_5_1)
	var_0_2 = var_0_2 + arg_5_1
end

function var_0_0.GetUseHeroList(arg_6_0, arg_6_1)
	return var_0_4[arg_6_1]
end

function var_0_0.GetLastUseHeroID(arg_7_0)
	return var_0_3
end

function var_0_0.SetLastUseHeroID(arg_8_0, arg_8_1)
	var_0_3 = arg_8_1
end

function var_0_0.GetVoteTicketInfo(arg_9_0, arg_9_1)
	local var_9_0 = SwimsuitBattleInfoCfg[arg_9_1].voting_ticket_id
	local var_9_1 = SwimsuitBattleInfoCfg[arg_9_1].voting_ticket_limit

	return var_9_0, var_0_2, var_9_1
end

function var_0_0.GetCurVoteRound(arg_10_0)
	return var_0_8
end

function var_0_0.GetVoteContestantsData(arg_11_0)
	return var_0_5
end

function var_0_0.GetSortVoteContestantsData(arg_12_0, arg_12_1)
	local var_12_0 = {}

	if not var_0_5[arg_12_1] then
		return var_12_0
	end

	for iter_12_0, iter_12_1 in pairs(var_0_5[arg_12_1]) do
		table.insert(var_12_0, {
			ID = iter_12_0,
			voteNum = iter_12_1
		})
	end

	table.sort(var_12_0, function(arg_13_0, arg_13_1)
		return arg_13_0.voteNum > arg_13_1.voteNum
	end)

	return var_12_0
end

function var_0_0.GetSortVoteContestantsDataByID(arg_14_0, arg_14_1)
	local var_14_0 = {}

	if not var_0_5[arg_14_1] then
		return var_14_0
	end

	for iter_14_0, iter_14_1 in pairs(var_0_5[arg_14_1]) do
		table.insert(var_14_0, {
			ID = iter_14_0,
			voteNum = iter_14_1
		})
	end

	table.sort(var_14_0, function(arg_15_0, arg_15_1)
		return arg_15_0.ID < arg_15_1.ID
	end)

	return var_14_0
end

function var_0_0.GetWinerMapByRound(arg_16_0, arg_16_1)
	if not var_0_6[arg_16_1] then
		return {}
	end

	return var_0_6[arg_16_1]
end

function var_0_0.GetWinerListByRound(arg_17_0, arg_17_1)
	local var_17_0 = {}

	if not var_0_6[arg_17_1] then
		return var_17_0
	end

	for iter_17_0, iter_17_1 in pairs(var_0_6[arg_17_1]) do
		table.insert(var_17_0, {
			ID = iter_17_0,
			voteNum = iter_17_1
		})
	end

	table.sort(var_17_0, function(arg_18_0, arg_18_1)
		return arg_18_0.voteNum > arg_18_1.voteNum
	end)

	return var_17_0
end

function var_0_0.GetRoundTimerData(arg_19_0, arg_19_1)
	return var_0_7[arg_19_1]
end

function var_0_0.GetSkinByHeroID(arg_20_0, arg_20_1)
	for iter_20_0, iter_20_1 in ipairs(var_0_4[var_0_1]) do
		if iter_20_1.heroID == arg_20_1 then
			return iter_20_1.skinID
		end
	end

	return nil
end

function var_0_0.GetVoteActivityID(arg_21_0)
	return var_0_9
end

function var_0_0.CheckInRoundTime(arg_22_0)
	if var_0_8 == 5 then
		ShowTips("TIME_OVER")

		return false
	end

	local var_22_0 = var_0_7[var_0_8]

	if manager.time:GetServerTime() < var_22_0.startTime then
		ShowTips("SOLO_NOT_OPEN")

		return false
	end

	if manager.time:GetServerTime() >= var_22_0.endTime then
		ShowTips("SWIM_VOTE_SETTLEMENT")

		return false
	end

	return true
end

function var_0_0.GetTaskIdByRound(arg_23_0, arg_23_1)
	local var_23_0 = AssignmentCfg.get_id_list_by_activity_id[SwimsuitBattleInfoCfg[var_0_1].vote_activity_id]

	if not arg_23_1 then
		return var_23_0
	end

	local var_23_1 = {}

	for iter_23_0, iter_23_1 in ipairs(var_23_0) do
		if AssignmentCfg[iter_23_1].additional_parameter[1] == arg_23_1 then
			table.insert(var_23_1, iter_23_1)
		end
	end

	return var_23_1
end

function var_0_0.GetRedPointClickTag(arg_24_0)
	return var_0_10
end

function var_0_0.SetRedPointClickTag(arg_25_0)
	var_0_10 = true
end

return var_0_0
