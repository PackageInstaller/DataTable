local var_0_0 = {}
local var_0_1 = 222581
local var_0_2
local var_0_3
local var_0_4
local var_0_5
local var_0_6
local var_0_7
local var_0_8
local var_0_9
local var_0_10 = {}
local var_0_11 = {}
local var_0_12 = {}
local var_0_13
local var_0_14
local var_0_15
local var_0_16

function var_0_0.SetGoViewStr(arg_1_0, arg_1_1)
	var_0_5 = arg_1_1
end

function var_0_0.GetGoViewStr(arg_2_0)
	return var_0_5
end

function var_0_0.GetActivityID(arg_3_0)
	return var_0_1
end

function var_0_0.InitFromServer(arg_4_0, arg_4_1)
	var_0_1 = arg_4_1.activity_id
	var_0_9 = arg_4_1.equip
	var_0_10 = {}

	for iter_4_0, iter_4_1 in ipairs(cleanProtoTable(arg_4_1.unlock_equip)) do
		table.insert(var_0_10, iter_4_1)
	end

	for iter_4_2, iter_4_3 in ipairs(cleanProtoTable(arg_4_1.activity_point_list)) do
		var_0_11[iter_4_3.activity_id] = iter_4_3.point
		var_0_12[iter_4_3.activity_id] = {}

		for iter_4_4, iter_4_5 in ipairs(cleanProtoTable(iter_4_3.reward_list)) do
			table.insert(var_0_12[iter_4_3.activity_id], iter_4_5)
		end
	end

	var_0_2 = ActivityCfg[var_0_1].sub_activity_list[1]
	var_0_3 = ActivityCfg[var_0_1].sub_activity_list[2]

	local var_4_0 = arg_4_0:GetSingleModelActivityIDByModelAndLevel(1, 1)

	var_0_8 = PushSnowBallCfg[PushSnowBallCfg.get_id_list_by_activityId[var_4_0][1]].hero_backhome
	var_0_7 = PushSnowBallCfg[PushSnowBallCfg.get_id_list_by_activityId[var_4_0][1]].hero_list
end

function var_0_0.OnUnlockDevice(arg_5_0, arg_5_1)
	var_0_10 = {}

	for iter_5_0, iter_5_1 in pairs(arg_5_1.unlock_equip_list) do
		table.insert(var_0_10, iter_5_1)
	end
end

function var_0_0.GetUnlockDeviceList(arg_6_0)
	return var_0_10
end

function var_0_0.GetIsDeviceUnlockByID(arg_7_0, arg_7_1)
	for iter_7_0, iter_7_1 in ipairs(var_0_10) do
		if iter_7_1 == arg_7_1 then
			return true
		end
	end

	return false
end

function var_0_0.GetSingleActivityID(arg_8_0)
	return var_0_2
end

function var_0_0.GetTeamActivityID(arg_9_0)
	return var_0_3
end

function var_0_0.GetSingleModelActivityIDByModelAndLevel(arg_10_0, arg_10_1, arg_10_2)
	return ActivityCfg[var_0_2].sub_activity_list[2 * ((arg_10_1 or 1) - 1) + (arg_10_2 or 1)]
end

function var_0_0.GetSingleDescTipsByModelAndSubModel(arg_11_0, arg_11_1)
	return GetTips("ACTIVITY_SNOWBALL_PUSH_DESC_" .. arg_11_1 + 1)
end

function var_0_0.GetTeamDescTipsByModelAndSubModel(arg_12_0, arg_12_1)
	return GetTips("ACTIVITY_SNOWBALL_PUSH_DESC_" .. 4 + arg_12_1)
end

function var_0_0.GetSingleWeeklyTaskIDList(arg_13_0)
	local var_13_0 = {}

	for iter_13_0, iter_13_1 in ipairs(ActivityCfg[var_0_2].sub_activity_list) do
		if ActivityCfg[iter_13_1].activity_template == 4 then
			table.insert(var_13_0, iter_13_1)
		end
	end

	return var_13_0
end

function var_0_0.GetTeamRankActivtyID(arg_14_0)
	local var_14_0 = 0

	for iter_14_0, iter_14_1 in ipairs(ActivityCfg[var_0_3].sub_activity_list) do
		if ActivityCfg[iter_14_1].activity_template == 271 then
			var_14_0 = iter_14_1
		end
	end

	return var_14_0
end

function var_0_0.GetTeamModelActivityIDByModel(arg_15_0, arg_15_1)
	return ActivityCfg[var_0_3].sub_activity_list[arg_15_1]
end

function var_0_0.GetTeamTaskIDList(arg_16_0)
	local var_16_0 = {}

	for iter_16_0, iter_16_1 in ipairs(ActivityCfg[var_0_3].sub_activity_list) do
		if ActivityCfg[iter_16_1].activity_template == 4 then
			table.insert(var_16_0, iter_16_1)
		end
	end

	return var_16_0
end

function var_0_0.GetTeamRankActivityID(arg_17_0)
	for iter_17_0, iter_17_1 in ipairs(ActivityCfg[var_0_3].sub_activity_list) do
		if ActivityCfg[iter_17_1].activity_template == ActivityTemplateConst.ACTIVITY_PUSH_SNOW_BALL_RANK then
			return iter_17_1
		end
	end
end

function var_0_0.GetDeviceDataList(arg_18_0)
	return var_0_6
end

function var_0_0.GetHeroDataList(arg_19_0)
	return var_0_8
end

function var_0_0.GetHeroInfoByHeroID(arg_20_0, arg_20_1)
	local var_20_0 = DormData:GetHeroArchiveID(arg_20_1)

	return (DormData:GetHeroInfo(var_20_0))
end

function var_0_0.SetSelectedHeroIndex(arg_21_0, arg_21_1)
	saveData("pushsnowball", "selectHeroIndex", arg_21_1)

	var_0_4 = arg_21_1
end

function var_0_0.GetSelectedHeroIndex(arg_22_0)
	return var_0_4 or getData("pushsnowball", "selectHeroIndex") or 1
end

function var_0_0.GetSelectedHeroID(arg_23_0)
	return var_0_8[arg_23_0:GetSelectedHeroIndex()]
end

function var_0_0.GetSelectedBattleModelID(arg_24_0)
	return var_0_7[arg_24_0:GetSelectedHeroIndex()]
end

function var_0_0.SetSelectedDeviceID(arg_25_0, arg_25_1)
	var_0_9 = arg_25_1
end

function var_0_0.GetSelectedDeviceID(arg_26_0)
	return var_0_9 or 0
end

function var_0_0.GetNormalTaskListByType(arg_27_0, arg_27_1)
	local var_27_0 = arg_27_0:GetSingleModelActivityIDByModelAndLevel(arg_27_1, 1)

	return ActivityPointRewardCfg.get_id_list_by_activity_id[var_27_0]
end

function var_0_0.GetHardTaskListByType(arg_28_0, arg_28_1)
	local var_28_0 = arg_28_0:GetSingleModelActivityIDByModelAndLevel(arg_28_1, 2)

	return ActivityPointRewardCfg.get_id_list_by_activity_id[var_28_0]
end

function var_0_0.GetScoreTaskIsCompleteById(arg_29_0, arg_29_1)
	local var_29_0 = ActivityPointRewardCfg[arg_29_1]

	return (var_0_11[var_29_0.activity_id] or 0) >= var_29_0.need
end

function var_0_0.GetScoreByActivityID(arg_30_0, arg_30_1)
	return var_0_11[arg_30_1] or 0
end

function var_0_0.GetScoreTaskIsRewardedById(arg_31_0, arg_31_1)
	local var_31_0 = ActivityPointRewardCfg[arg_31_1]

	if not var_0_12[var_31_0.activity_id] then
		return false
	end

	for iter_31_0, iter_31_1 in pairs(var_0_12[var_31_0.activity_id]) do
		if iter_31_1 == arg_31_1 then
			return true
		end
	end

	return false
end

function var_0_0.ReceiveScoreReward(arg_32_0, arg_32_1)
	local var_32_0 = ActivityPointRewardCfg[arg_32_1]

	if not var_0_12[var_32_0.activity_id] then
		var_0_12[var_32_0.activity_id] = {}
	end

	table.insert(var_0_12[var_32_0.activity_id], arg_32_1)
end

function var_0_0.GetScoreTaskIDListByModel(arg_33_0, arg_33_1)
	return ActivityPointRewardCfg.get_id_list_by_activity_id[arg_33_0:GetTeamModelActivityIDByModel(arg_33_1)]
end

function var_0_0.GetWeeklyTaskList(arg_34_0)
	local var_34_0 = arg_34_0:GetSingleWeeklyTaskIDList()

	if not var_34_0 then
		return {}
	end

	for iter_34_0, iter_34_1 in ipairs(var_34_0) do
		if ActivityData:GetActivityData(iter_34_1).stopTime > manager.time:GetServerTime() then
			return TaskTools:GetActivityTaskList(iter_34_1)
		end
	end

	return {}
end

function var_0_0.GetRefreshTimeStamp(arg_35_0)
	local var_35_0 = arg_35_0:GetSingleWeeklyTaskIDList()
	local var_35_1 = {}

	if not var_35_0 then
		return {}
	end

	for iter_35_0, iter_35_1 in ipairs(var_35_0) do
		local var_35_2 = ActivityData:GetActivityData(iter_35_1).startTime

		if var_35_2 > manager.time:GetServerTime() then
			table.insert(var_35_1, var_35_2)
		end
	end

	return var_35_1
end

function var_0_0.GetTeamWinTaskList(arg_36_0)
	local var_36_0 = arg_36_0:GetTeamTaskIDList()

	if not var_36_0 then
		return {}
	end

	return TaskTools:GetActivityTaskList(var_36_0[2])
end

function var_0_0.GetTeamParticipateTaskList(arg_37_0)
	local var_37_0 = arg_37_0:GetTeamTaskIDList()
	local var_37_1 = {}

	if not var_37_0 then
		return {}
	end

	local var_37_2 = TaskTools:GetActivityTaskList(var_37_0[1])

	if not var_37_2 then
		return {}
	end

	for iter_37_0, iter_37_1 in pairs(var_37_2) do
		table.insert(var_37_1, iter_37_1)
	end

	table.sort(var_37_1, function(arg_38_0, arg_38_1)
		return arg_38_0.id < arg_38_1.id
	end)

	return var_37_1
end

function var_0_0.GetHasCompeletedWeeklyTask(arg_39_0)
	local var_39_0 = arg_39_0:GetWeeklyTaskList()
	local var_39_1 = {}

	if not var_39_0 then
		return false
	end

	for iter_39_0, iter_39_1 in pairs(var_39_0) do
		table.insert(var_39_1, iter_39_1)
	end

	table.sort(var_39_1, function(arg_40_0, arg_40_1)
		return arg_40_0.id < arg_40_1.id
	end)

	local var_39_2 = var_39_1[1]

	if not var_39_2 then
		return false
	end

	local var_39_3 = AssignmentCfg[var_39_2.id]
	local var_39_4 = TaskData2:GetTaskComplete(var_39_2.id)

	if AssignmentCfg[var_39_2.id].need <= TaskData2:GetTaskProgress(var_39_2.id) and not var_39_4 then
		return true
	end

	return false
end

function var_0_0.GetHasCompeletedScoreTaskByModel(arg_41_0, arg_41_1)
	local var_41_0 = PushSnowBallData:GetNormalTaskListByType(arg_41_1)
	local var_41_1 = PushSnowBallData:GetHardTaskListByType(arg_41_1)

	if not var_41_0 and not var_41_1 then
		return false
	end

	for iter_41_0, iter_41_1 in ipairs(var_41_0) do
		local var_41_2 = PushSnowBallData:GetScoreTaskIsCompleteById(iter_41_1)

		if not PushSnowBallData:GetScoreTaskIsRewardedById(iter_41_1) and var_41_2 then
			return true
		end
	end

	for iter_41_2, iter_41_3 in ipairs(var_41_1) do
		local var_41_3 = PushSnowBallData:GetScoreTaskIsCompleteById(iter_41_3)

		if not PushSnowBallData:GetScoreTaskIsRewardedById(iter_41_3) and var_41_3 then
			return true
		end
	end

	return false
end

function var_0_0.GetHasCompeletedWinTaskByID(arg_42_0, arg_42_1)
	local var_42_0 = arg_42_0:GetTeamWinTaskList()

	if not var_42_0 then
		return false
	end

	for iter_42_0, iter_42_1 in pairs(var_42_0) do
		if arg_42_1 == iter_42_1.id then
			local var_42_1 = iter_42_1.complete_flag >= 1

			if AssignmentCfg[iter_42_1.id].need <= iter_42_1.progress and not var_42_1 then
				return true
			end
		end
	end

	return false
end

function var_0_0.GetHasCompeletedTeamTask(arg_43_0)
	local var_43_0 = arg_43_0:GetTeamParticipateTaskList()

	if not var_43_0 then
		return false
	end

	for iter_43_0, iter_43_1 in pairs(var_43_0) do
		local var_43_1 = iter_43_1.complete_flag >= 1

		if AssignmentCfg[iter_43_1.id].need <= iter_43_1.progress and not var_43_1 then
			return true
		end
	end

	return false
end

function var_0_0.GetCompeletedTeamTaskNum(arg_44_0)
	local var_44_0 = arg_44_0:GetTeamParticipateTaskList()
	local var_44_1 = 0

	if not var_44_0 then
		return var_44_1
	end

	for iter_44_0, iter_44_1 in pairs(var_44_0) do
		if AssignmentCfg[iter_44_1.id].need <= iter_44_1.progress then
			var_44_1 = var_44_1 + 1
		end
	end

	return var_44_1
end

function var_0_0.GetHasAllRewardedTeamTask(arg_45_0)
	local var_45_0 = arg_45_0:GetTeamParticipateTaskList()

	if not var_45_0 then
		return false
	end

	for iter_45_0, iter_45_1 in pairs(var_45_0) do
		local var_45_1

		var_45_1 = iter_45_1.complete_flag == 0

		return false
	end

	return true
end

function var_0_0.GetIsNewLevelUnLock(arg_46_0, arg_46_1)
	local var_46_0 = arg_46_0:GetSingleModelActivityIDByModelAndLevel(arg_46_1, 2)

	if ActivityData:GetActivityData(var_46_0).startTime < manager.time:GetServerTime() then
		return true
	end

	return false
end

function var_0_0.OnReceviedSingleBattleResult(arg_47_0, arg_47_1)
	var_0_14 = arg_47_1.score
	var_0_13 = arg_47_1.use_seconds
	var_0_11[arg_47_1.activity_id] = math.max(var_0_11[arg_47_1.activity_id] or 0, arg_47_1.score)
end

function var_0_0.OnReceviedTeamBattleResult(arg_48_0, arg_48_1)
	var_0_16 = {}

	for iter_48_0, iter_48_1 in pairs(cleanProtoTable(arg_48_1.battle_result.battle_record)) do
		local var_48_0 = iter_48_1.user_id
		local var_48_1
		local var_48_2
		local var_48_3

		for iter_48_2, iter_48_3 in pairs(cleanProtoTable(iter_48_1.battle_record)) do
			if iter_48_3.id == 66 then
				var_48_1 = iter_48_3.value
			end

			if iter_48_3.id == 67 then
				var_48_2 = iter_48_3.value % 2
				var_48_3 = iter_48_3.value < 2 and 1 or 0
			end
		end

		table.insert(var_0_16, {
			user_id = var_48_0,
			score = var_48_1,
			type = var_48_2,
			result = var_48_3
		})
	end

	for iter_48_4, iter_48_5 in pairs(cleanProtoTable(arg_48_1.battle_result.player_list)) do
		local var_48_4 = iter_48_5.player_id
		local var_48_5 = iter_48_5.player_battle_info.nick
		local var_48_6 = iter_48_5.player_battle_info.hero_list[1].hero_id
		local var_48_7 = iter_48_5.player_battle_info.icon
		local var_48_8 = iter_48_5.player_battle_info.frame

		for iter_48_6, iter_48_7 in ipairs(var_0_16) do
			if iter_48_7.user_id == var_48_4 then
				iter_48_7.nick = var_48_5
				iter_48_7.hero_id = var_48_6
				iter_48_7.icon = var_48_7
				iter_48_7.frame = var_48_8
			end
		end
	end
end

function var_0_0.GetTeamBattleResultInfo(arg_49_0)
	return var_0_16
end

function var_0_0.GetBattleResultScore(arg_50_0)
	return var_0_14 or 0
end

function var_0_0.GetBattleResultSecond(arg_51_0)
	return var_0_13 or 0
end

function var_0_0.SetPlayerList(arg_52_0, arg_52_1)
	var_0_15 = {}

	for iter_52_0, iter_52_1 in ipairs(cleanProtoTable(arg_52_1.client_player_list)) do
		table.insert(var_0_15, {
			uid = iter_52_1.user_id,
			heroID = iter_52_1.hero_id
		})
	end
end

function var_0_0.GetPlayerList(arg_53_0)
	return var_0_15
end

PushSnowBallRankTemplate = class("PushSnowBallRankTemplate")

function PushSnowBallRankTemplate.Ctor(arg_54_0, arg_54_1)
	arg_54_0.user_id = arg_54_1.user_id
	arg_54_0.score = arg_54_1.score
	arg_54_0.difficulty = arg_54_1.difficulty
	arg_54_0.rank = arg_54_1.rank
	arg_54_0.timestamp = arg_54_1.timestamp
	arg_54_0.team_list = {}

	for iter_54_0, iter_54_1 in ipairs(arg_54_1.team_info) do
		local var_54_0 = {}

		for iter_54_2, iter_54_3 in ipairs(iter_54_1.hero_info_list) do
			table.insert(var_54_0, {
				id = iter_54_3.hero_id,
				skin_id = iter_54_3.skin_id
			})
		end

		table.insert(arg_54_0.team_list, var_54_0)
	end

	local var_54_1 = PlayerData:GetPlayerInfo()

	if var_54_1 and tonumber(arg_54_0.user_id) == var_54_1.userID then
		arg_54_0.nick = var_54_1.nick
		arg_54_0.icon = var_54_1.portrait
		arg_54_0.icon_frame = var_54_1.icon_frame
	else
		arg_54_0.nick = arg_54_1.nick
		arg_54_0.icon = arg_54_1.portrait
		arg_54_0.icon_frame = arg_54_1.frame
	end
end

local var_0_17 = {
	ALL = 1,
	GUILD = 2
}
local var_0_18 = var_0_17.ALL

function var_0_0.GetCurActivityID(arg_55_0)
	return arg_55_0:GetTeamRankActivityID()
end

function var_0_0.GetRankTypeConst(arg_56_0)
	return var_0_17
end

function var_0_0.GetCurRankType(arg_57_0)
	return var_0_18
end

function var_0_0.SetCurRankType(arg_58_0, arg_58_1)
	var_0_18 = arg_58_1
end

function var_0_0.GetRankVersion(arg_59_0)
	return rank_version
end

function var_0_0.GetRankTotalPeople(arg_60_0)
	return rank_total_people
end

function var_0_0.InitCurRank(arg_61_0, arg_61_1)
	cur_rank = PushSnowBallRankTemplate.New(arg_61_1.my_rank)
	rank_total_people = arg_61_1.total
end

function var_0_0.InitRankData(arg_62_0, arg_62_1)
	rank_list = {}

	for iter_62_0, iter_62_1 in ipairs(arg_62_1.rank_list) do
		local var_62_0 = PushSnowBallRankTemplate.New(iter_62_1)

		table.insert(rank_list, var_62_0)
	end

	table.sort(rank_list, function(arg_63_0, arg_63_1)
		return arg_63_0.rank < arg_63_1.rank
	end)

	cur_rank = PushSnowBallRankTemplate.New(arg_62_1.my_rank)
	rank_total_people = arg_62_1.total
	rank_version = arg_62_1.version

	manager.notify:Invoke(ADVANCE_TEST_RANK_UPGRADE)
end

function var_0_0.InitGuildRankData(arg_64_0, arg_64_1)
	GuildAction.RequiredGuildMemberList(function()
		guild_rank_list = {}

		for iter_65_0, iter_65_1 in ipairs(arg_64_1.rank_list) do
			if GuildData:GetGuildMemberData(iter_65_1.user_id) then
				local var_65_0 = PushSnowBallRankTemplate.New(iter_65_1)

				table.insert(guild_rank_list, var_65_0)
			end
		end

		table.sort(guild_rank_list, function(arg_66_0, arg_66_1)
			return arg_66_0.rank < arg_66_1.rank
		end)

		local var_65_1 = PlayerData:GetPlayerInfo().userID

		guild_cur_rank = nil

		for iter_65_2, iter_65_3 in ipairs(guild_rank_list) do
			iter_65_3.rank = iter_65_2

			if tonumber(iter_65_3.user_id) == var_65_1 then
				guild_cur_rank = iter_65_3
			end
		end

		manager.notify:Invoke(ADVANCE_TEST_RANK_UPGRADE)
	end)
end

function var_0_0.ResetGuildRankData(arg_67_0)
	guild_rank_list = {}
	guild_cur_rank = nil
end

function var_0_0.GetRankList(arg_68_0)
	return rank_list
end

function var_0_0.GetCurRank(arg_69_0)
	return cur_rank
end

function var_0_0.GetGuildRankList(arg_70_0)
	return guild_rank_list
end

function var_0_0.GetGuildCurRank(arg_71_0)
	return guild_cur_rank
end

return var_0_0
