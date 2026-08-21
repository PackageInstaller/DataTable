local var_0_0 = class("IslandCheaterTavernMonitor", import("...Core.Net.IslandBaseMonitor"))

var_0_0.ADD_CHEATERTAVERN_PLAYER = "IslandCheaterTavernMonitor:ADD_CHEATERTAVERN_PLAYER"
var_0_0.INIT_PLAYER_DATA_DONE = "IslandCheaterTavernMonitor:INIT_PLAYER_DATA_DONE"

function var_0_0.register(arg_1_0)
	arg_1_0.cheaterTavernAgency = arg_1_0:GetIsland():GetCheaterTavernAgency()

	arg_1_0:on(23101, function(arg_2_0)
		arg_1_0.cheaterTavernAgency:SetIsConnecting(true)

		if IslandCheaterTavernConst.changeSeat then
			local var_2_0

			for iter_2_0, iter_2_1 in ipairs(arg_2_0.player_list) do
				local var_2_1 = getProxy(PlayerProxy)

				if iter_2_1.user_id == var_2_1:getRawData().id then
					var_2_0 = iter_2_1.seat
				end
			end

			for iter_2_2, iter_2_3 in ipairs(arg_2_0.player_list) do
				iter_2_3.seat = (function(arg_3_0, arg_3_1, arg_3_2)
					return (arg_3_0 - arg_3_1 + arg_3_2 - 1) % 4 + 1
				end)(iter_2_3.seat, var_2_0, IslandCheaterTavernConst.currentMainSeat)
			end
		end

		arg_1_0.cheaterTavernAgency:SetStartGameData(arg_2_0)

		if arg_1_0.cheaterTavernAgency:IsUILoadOver() then
			arg_1_0:StartCheaterTevernGame(arg_2_0)
			arg_1_0:InitPlayerDate(arg_2_0)
		else
			arg_1_0.cheaterTavernAgency:AddCacheFunc(function()
				arg_1_0:StartCheaterTevernGame(arg_2_0)
				arg_1_0:InitPlayerDate(arg_2_0)

				return
			end)
		end

		return
	end)
	arg_1_0:on(23102, function(arg_5_0)
		if not arg_1_0.cheaterTavernAgency:IsConnecting() then
			return
		end

		arg_1_0:CheaterTevernGameEveryRound(arg_5_0)

		return
	end)
	arg_1_0:on(23105, function(arg_6_0)
		if not arg_1_0.cheaterTavernAgency:IsConnecting() then
			return
		end

		if arg_1_0.cheaterTavernAgency:IsUILoadOver() then
			arg_1_0:PlayOperateHandle(arg_6_0)
		else
			arg_1_0.cheaterTavernAgency:AddCacheFunc(function()
				arg_1_0:PlayOperateHandle(arg_6_0)

				return
			end)
		end

		return
	end)
	arg_1_0:on(23108, function(arg_8_0)
		if not arg_1_0.cheaterTavernAgency:IsConnecting() then
			return
		end

		local var_8_0 = getProxy(ActivityProxy)
		local var_8_1 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_ISLAND_CHEAT_BAR)
		local var_8_2

		if arg_1_0.cheaterTavernAgency:GetRoomType() == 1 then
			var_8_2 = 0
		else
			var_8_2 = arg_8_0.cur_score - var_8_1.data1
			var_8_1.data1 = arg_8_0.cur_score
			var_8_1.data2 = math.max(arg_8_0.cur_score, var_8_1.data2)

			var_8_0:updateActivity(var_8_1)
		end

		arg_1_0.cheaterTavernAgency:GetMainPlayer():SetGameData(arg_8_0.rank, var_8_2)
		pg.m02:sendNotification(GAME.ISLAND_CHEATER_END_SCORE_NOTIFY, arg_8_0)

		local var_8_3 = getProxy(ActivityTaskProxy):getTaskById(ActivityConst.ISLAND_BAR_SIGN_ACT_ID)

		if var_8_3[1] then
			pg.m02:sendNotification(GAME.MINI_GAME_TASK_PROGRESS_UPDATE, {
				progressAdd = 1,
				actId = ActivityConst.ISLAND_BAR_SIGN_ACT_ID,
				taskId = var_8_3[1].id
			})
		end

		return
	end)
	arg_1_0:on(23116, function(arg_9_0)
		if not arg_1_0.cheaterTavernAgency:IsConnecting() then
			return
		end

		pg.m02:sendNotification(GAME.ISLAND_CHEATER_REAL_END_NOTIFY, arg_9_0)

		return
	end)
	arg_1_0:on(23115, function(arg_10_0)
		if not arg_1_0.cheaterTavernAgency:IsConnecting() then
			return
		end

		arg_1_0.cheaterTavernAgency:UpdatePlayerDelegateState(arg_10_0.user_id, arg_10_0.state)
		pg.m02:sendNotification(GAME.ISLAND_CHEATER_DELEGATE_NOTIFY)

		return
	end)
	arg_1_0:on(23117, function(arg_11_0)
		local var_11_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_ISLAND_CHEAT_BAR)

		var_11_0.data1 = arg_11_0.cur_score
		var_11_0.data2 = math.max(arg_11_0.cur_score, var_11_0.data2)

		getProxy(ActivityProxy):updateActivity(var_11_0)

		return
	end)

	return
end

function var_0_0.InitPlayerDate(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_1.player_list or {}

	for iter_12_0, iter_12_1 in ipairs(var_12_0) do
		arg_12_0:GetIsland():DispatchEvent(IslandCheaterTavernMonitor.ADD_CHEATERTAVERN_PLAYER, {
			user_view = PlayRoomTools.GetGameViewID(iter_12_1.player_info.user_view),
			seat = iter_12_1.seat,
			id = iter_12_1.player_info.id
		})
	end

	arg_12_0:GetIsland():DispatchEvent(IslandCheaterTavernMonitor.INIT_PLAYER_DATA_DONE)

	return
end

function var_0_0.Init(arg_13_0)
	return
end

function var_0_0.StartCheaterTevernGame(arg_14_0, arg_14_1)
	pg.m02:sendNotification(GAME.ISLAND_CHEATER_FIRSTROND_START, {
		operation = {
			user_id = arg_14_1.user_id,
			operationType = IslandCheaterTavernConst.PlayerCurrentOperateType.PutCard,
			auto_time = arg_14_1.auto_time
		}
	})

	return
end

function var_0_0.CheaterTevernGameEveryRound(arg_15_0, arg_15_1)
	arg_15_0.cheaterTavernAgency:UpdateGameDataEveryRound(arg_15_1)
	pg.m02:sendNotification(GAME.ISLAND_CHEATER_FIRSTROND_START, {
		operation = {
			user_id = arg_15_1.user_id,
			operationType = IslandCheaterTavernConst.PlayerCurrentOperateType.PutCard,
			auto_time = arg_15_1.auto_time
		}
	})

	return
end

function var_0_0.PlayOperateHandle(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_1.user_id
	local var_16_1 = arg_16_1.return_list
	local var_16_2 = getProxy(PlayerProxy):getRawData().id
	local var_16_3

	switch(arg_16_1.type, {
		[IslandCheaterTavernConst.PlayerOperateType.PutCard] = function()
			local var_17_0 = var_16_1[2]

			if var_16_1[1] == 1 then
				if var_16_0 == getProxy(PlayerProxy):getRawData().id then
					var_16_3 = arg_16_0.cheaterTavernAgency:GetMainPlayerAutoPutCard(var_17_0)

					arg_16_0.cheaterTavernAgency:MainPlayerPutCard(var_16_3)
				end
			end

			arg_16_0.cheaterTavernAgency:ReducePlayerCardNum(var_16_0, var_17_0)

			if var_16_0 == var_16_2 then
				IslandCheaterTavernRecordTools.AddRoundCnt()
				IslandCheaterTavernRecordTools.StopPutCardTime()
			end

			return
		end,
		[IslandCheaterTavernConst.PlayerOperateType.Query] = function()
			return
		end,
		[IslandCheaterTavernConst.PlayerOperateType.Shoot] = function()
			warning(tostring(var_16_0) .. "PlayOperateHandle" .. tostring(var_16_1[1]))
			arg_16_0.cheaterTavernAgency:UpdatePlayerBombState(var_16_0, var_16_1[1], var_16_1[2])

			return
		end
	}, function()
		return
	end)
	pg.m02:sendNotification(GAME.ISLAND_CHEATER_OPERATE_DONE_NOTIFY, {
		data = arg_16_1,
		putCard = nil
	})

	return
end

return var_0_0
