class = var_0_10000

local var_0_0 = "IslandCheaterTavernMonitor"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...Core.Net.IslandBaseMonitor"))

var_0_1.ADD_CHEATERTAVERN_PLAYER = "IslandCheaterTavernMonitor:ADD_CHEATERTAVERN_PLAYER"
var_0_1.INIT_PLAYER_DATA_DONE = "IslandCheaterTavernMonitor:INIT_PLAYER_DATA_DONE"

function var_0_1.register(arg_1_0)
	local var_1_0 = arg_1_0:GetIsland()

	arg_1_0.cheaterTavernAgency = var_1.GetCheaterTavernAgency(var_1_0)

	arg_1_0:on(23101, function(arg_2_0)
		local var_2_0 = arg_1_0.cheaterTavernAgency

		var_1.SetIsConnecting(var_2_0, true)

		IslandCheaterTavernConst = var_1

		if var_1.changeSeat then
			local var_2_1

			ipairs = var_2_0

			for iter_2_0, iter_2_1 in var_2_0(arg_2_0.player_list) do
				local var_2_2 = iter_2_1.user_id

				getProxy = var_2_10008
				PlayerProxy = var_2_10009
				var_2_10009 = var_2_10008(var_2_10009)

				if var_2_2 == var_2_10008.getRawData(var_2_10009).id then
					var_2_1 = iter_2_1.seat
				end
			end

			local function var_2_3(arg_3_0, arg_3_1, arg_3_2)
				return (arg_3_0 - arg_3_1 + arg_3_2 - 1) % 4 + 1
			end

			ipairs = var_3

			for iter_2_2, iter_2_3 in var_3(arg_2_0.player_list) do
				local var_2_4 = var_2_3
				local var_2_5 = iter_2_3.seat
				local var_2_6 = var_2_1

				IslandCheaterTavernConst = var_2_10011
				iter_2_3.seat = var_2_4(var_2_5, var_2_6, var_2_10011.currentMainSeat)
			end
		end

		local var_2_7 = arg_1_0.cheaterTavernAgency

		var_1.SetStartGameData(var_2_7, arg_2_0)

		local var_2_8 = arg_1_0.cheaterTavernAgency

		if var_1.IsUILoadOver(var_2_8) then
			local var_2_9 = arg_1_0

			var_1.StartCheaterTevernGame(var_2_9, arg_2_0)

			local var_2_10 = arg_1_0

			var_1.InitPlayerDate(var_2_10, arg_2_0)
		else
			local var_2_11 = arg_1_0.cheaterTavernAgency

			var_1.AddCacheFunc(var_2_11, function()
				local var_4_0 = arg_1_0

				var_0.StartCheaterTevernGame(var_4_0, arg_2_0)

				local var_4_1 = arg_1_0

				var_0.InitPlayerDate(var_4_1, arg_2_0)

				return
			end)
		end

		return
	end)
	arg_1_0:on(23102, function(arg_5_0)
		local var_5_0 = arg_1_0.cheaterTavernAgency

		if not var_1.IsConnecting(var_5_0) then
			return
		end

		local var_5_1 = arg_1_0

		var_1.CheaterTevernGameEveryRound(var_5_1, arg_5_0)

		return
	end)
	arg_1_0:on(23105, function(arg_6_0)
		local var_6_0 = arg_1_0.cheaterTavernAgency

		if not var_1.IsConnecting(var_6_0) then
			return
		end

		local var_6_1 = arg_1_0.cheaterTavernAgency

		if var_1.IsUILoadOver(var_6_1) then
			local var_6_2 = arg_1_0

			var_1.PlayOperateHandle(var_6_2, arg_6_0)
		else
			local var_6_3 = arg_1_0.cheaterTavernAgency

			var_1.AddCacheFunc(var_6_3, function()
				local var_7_0 = arg_1_0

				var_0.PlayOperateHandle(var_7_0, arg_6_0)

				return
			end)
		end

		return
	end)
	arg_1_0:on(23108, function(arg_8_0)
		local var_8_0 = arg_1_0.cheaterTavernAgency

		if not var_1.IsConnecting(var_8_0) then
			return
		end

		getProxy = var_1
		ActivityProxy = var_8_0

		local var_8_1 = var_1(var_8_0)

		getProxy = var_8_0
		ActivityProxy = var_2_10003

		local var_8_2 = var_8_0(var_2_10003)
		local var_8_3 = var_2.getActivityByType

		ActivityConst = var_2_10004

		local var_8_4 = var_8_3(var_8_2, var_2_10004.ACTIVITY_TYPE_ISLAND_CHEAT_BAR)
		local var_8_5
		local var_8_6 = arg_1_0.cheaterTavernAgency

		if var_4.GetRoomType(var_8_6) == 1 then
			var_8_5 = 0
		else
			var_8_5 = arg_8_0.cur_score - var_8_4.data1
			var_8_4.data1 = arg_8_0.cur_score
			math = var_4
			var_8_4.data2 = var_4.max(arg_8_0.cur_score, var_8_4.data2)

			var_8_1:updateActivity(var_8_4)
		end

		local var_8_7 = arg_1_0.cheaterTavernAgency
		local var_8_8 = var_4.GetMainPlayer(var_8_7)

		var_4.SetGameData(var_8_8, arg_8_0.rank, var_8_5)

		pg = var_5

		local var_8_9 = var_5.m02
		local var_8_10 = var_5.sendNotification

		GAME = var_7

		var_8_10(var_8_9, var_7.ISLAND_CHEATER_END_SCORE_NOTIFY, arg_8_0)

		getProxy = var_8_10
		ActivityTaskProxy = var_8_9

		local var_8_11 = var_8_10(var_8_9)
		local var_8_12 = var_5.getTaskById

		ActivityConst = var_7

		if var_8_12(var_8_11, var_7.ISLAND_BAR_SIGN_ACT_ID)[1] then
			pg = var_6

			local var_8_13 = var_6.m02
			local var_8_14 = var_6.sendNotification

			GAME = var_8

			local var_8_15 = var_8.MINI_GAME_TASK_PROGRESS_UPDATE
			local var_8_16 = {
				progressAdd = 1
			}

			ActivityConst = var_2_10010
			var_8_16.actId = var_2_10010.ISLAND_BAR_SIGN_ACT_ID
			var_8_16.taskId = var_5[1].id

			var_8_14(var_8_13, var_8_15, var_8_16)
		end

		return
	end)
	arg_1_0:on(23116, function(arg_9_0)
		local var_9_0 = arg_1_0.cheaterTavernAgency

		if not var_1.IsConnecting(var_9_0) then
			return
		end

		pg = var_1

		local var_9_1 = var_1.m02
		local var_9_2 = var_1.sendNotification

		GAME = var_2_10003

		var_9_2(var_9_1, var_2_10003.ISLAND_CHEATER_REAL_END_NOTIFY, arg_9_0)

		return
	end)
	arg_1_0:on(23115, function(arg_10_0)
		local var_10_0 = arg_1_0.cheaterTavernAgency

		if not var_1.IsConnecting(var_10_0) then
			return
		end

		local var_10_1 = arg_1_0.cheaterTavernAgency

		var_1.UpdatePlayerDelegateState(var_10_1, arg_10_0.user_id, arg_10_0.state)

		pg = var_1

		local var_10_2 = var_1.m02
		local var_10_3 = var_1.sendNotification

		GAME = var_3

		var_10_3(var_10_2, var_3.ISLAND_CHEATER_DELEGATE_NOTIFY)

		return
	end)
	arg_1_0:on(23117, function(arg_11_0)
		getProxy = var_2_10001
		ActivityProxy = var_2_10002

		local var_11_0 = var_2_10001(var_2_10002)

		getProxy = var_2_10002
		ActivityProxy = var_2_10003

		local var_11_1 = var_2_10002(var_2_10003)
		local var_11_2 = var_2.getActivityByType

		ActivityConst = var_2_10004

		local var_11_3 = var_11_2(var_11_1, var_2_10004.ACTIVITY_TYPE_ISLAND_CHEAT_BAR)
		local var_11_4 = arg_11_0.cur_score - var_11_3.data1

		var_11_3.data1 = arg_11_0.cur_score
		math = var_4
		var_11_3.data2 = var_4.max(arg_11_0.cur_score, var_11_3.data2)

		var_11_0:updateActivity(var_11_3)

		return
	end)

	return
end

function var_0_1.InitPlayerDate(arg_12_0, arg_12_1)
	ipairs = var_1_10002

	local var_12_0

	if not arg_12_1.player_list then
		var_12_0 = {}
	end

	for iter_12_0, iter_12_1 in var_1_10002(var_12_0) do
		local var_12_1 = iter_12_1.seat
		local var_12_2 = iter_12_1.player_info
		local var_12_3 = {}

		PlayRoomTools = var_1_10010
		var_12_3.user_view = var_1_10010.GetGameViewID(var_12_2.user_view)
		var_12_3.seat = var_12_1
		var_12_3.id = var_12_2.id

		local var_12_4 = arg_12_0:GetIsland()

		var_1_10010 = var_1_10010.DispatchEvent
		IslandCheaterTavernMonitor = var_1_10012

		var_1_10010(var_12_4, var_1_10012.ADD_CHEATERTAVERN_PLAYER, var_12_3)
	end

	local var_12_5 = arg_12_0:GetIsland()
	local var_12_6 = var_2.DispatchEvent

	IslandCheaterTavernMonitor = var_4

	var_12_6(var_12_5, var_4.INIT_PLAYER_DATA_DONE)

	return
end

function var_0_1.Init(arg_13_0)
	return
end

function var_0_1.StartCheaterTevernGame(arg_14_0, arg_14_1)
	local var_14_0 = {
		user_id = arg_14_1.user_id
	}

	IslandCheaterTavernConst = var_3
	var_14_0.operationType = var_3.PlayerCurrentOperateType.PutCard
	var_14_0.auto_time = arg_14_1.auto_time
	pg = var_3

	local var_14_1 = var_3.m02
	local var_14_2 = var_3.sendNotification

	GAME = var_1_10005

	var_14_2(var_14_1, var_1_10005.ISLAND_CHEATER_FIRSTROND_START, {
		operation = var_14_0
	})

	return
end

function var_0_1.CheaterTevernGameEveryRound(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_0.cheaterTavernAgency

	var_2.UpdateGameDataEveryRound(var_15_0, arg_15_1)

	local var_15_1 = {
		user_id = arg_15_1.user_id
	}

	IslandCheaterTavernConst = var_3
	var_15_1.operationType = var_3.PlayerCurrentOperateType.PutCard
	var_15_1.auto_time = arg_15_1.auto_time
	pg = var_3

	local var_15_2 = var_3.m02
	local var_15_3 = var_3.sendNotification

	GAME = var_1_10005

	var_15_3(var_15_2, var_1_10005.ISLAND_CHEATER_FIRSTROND_START, {
		operation = var_15_1
	})

	return
end

function var_0_1.PlayOperateHandle(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_1.user_id
	local var_16_1 = arg_16_1.return_list

	getProxy = var_1_10004
	PlayerProxy = var_1_10005

	local var_16_2 = var_1_10004(var_1_10005)
	local var_16_3 = var_4.getRawData(var_16_2).id
	local var_16_4

	switch = var_1_10006

	local var_16_5 = arg_16_1.type
	local var_16_6 = {}

	IslandCheaterTavernConst = var_1_10009
	var_16_6[var_1_10009.PlayerOperateType.PutCard] = function()
		local var_17_0 = var_16_1[1] == 1
		local var_17_1 = var_16_1[2]

		if var_17_0 then
			local var_17_2 = var_16_0

			getProxy = var_2_10003
			PlayerProxy = var_2_10004

			local var_17_3 = var_2_10003(var_2_10004)

			if var_17_2 == var_3.getRawData(var_17_3).id then
				local var_17_4 = arg_16_0.cheaterTavernAgency

				var_16_4 = var_2.GetMainPlayerAutoPutCard(var_17_4, var_17_1)

				local var_17_5 = arg_16_0.cheaterTavernAgency

				var_2.MainPlayerPutCard(var_17_5, var_16_4)
			end
		end

		local var_17_6 = arg_16_0.cheaterTavernAgency

		var_2.ReducePlayerCardNum(var_17_6, var_16_0, var_17_1)

		if var_16_0 == var_16_3 then
			IslandCheaterTavernRecordTools = var_2

			var_2.AddRoundCnt()

			IslandCheaterTavernRecordTools = var_2

			var_2.StopPutCardTime()
		end

		return
	end
	IslandCheaterTavernConst = var_9
	var_16_6[var_9.PlayerOperateType.Query] = function()
		return
	end
	IslandCheaterTavernConst = var_9
	var_16_6[var_9.PlayerOperateType.Shoot] = function()
		local var_19_0 = var_16_1[1]
		local var_19_1 = var_16_1[2]

		warning = var_2_10002
		tostring = var_2_10003

		local var_19_2 = var_2_10003(var_16_0)
		local var_19_3 = "PlayOperateHandle"

		tostring = var_2_10005

		var_2_10002(var_19_2 .. var_19_3 .. var_2_10005(var_19_0))

		local var_19_4 = arg_16_0.cheaterTavernAgency

		var_2.UpdatePlayerBombState(var_19_4, var_16_0, var_19_0, var_19_1)

		return
	end

	var_1_10006(var_16_5, var_16_6, function()
		return
	end)

	pg = var_1_10006

	local var_16_7 = var_1_10006.m02
	local var_16_8 = var_6.sendNotification

	GAME = var_16_6

	var_16_8(var_16_7, var_16_6.ISLAND_CHEATER_OPERATE_DONE_NOTIFY, {
		data = arg_16_1,
		putCard = var_16_4
	})

	return
end

return var_0_1
