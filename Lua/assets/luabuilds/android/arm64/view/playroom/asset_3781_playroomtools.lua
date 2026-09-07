local var_0_0 = {
	FilterRoomType = function(arg_1_0, arg_1_1)
		if arg_1_1 == PlayRoomConst.PLAY_ROOM_TYPE.ALL then
			return Clone(arg_1_0)
		end

		local var_1_0 = {}

		for iter_1_0, iter_1_1 in ipairs(arg_1_0) do
			if iter_1_1.roomType == arg_1_1 then
				table.insert(var_1_0, iter_1_1)
			end
		end

		return var_1_0
	end,
	FilterRoomState = function(arg_2_0, arg_2_1)
		if arg_2_1 == PlayRoomConst.PLAY_ROOM_STATE.ALL then
			return Clone(arg_2_0)
		end

		local var_2_0 = {}

		for iter_2_0, iter_2_1 in ipairs(arg_2_0) do
			if iter_2_1.roomState == arg_2_1 then
				table.insert(var_2_0, iter_2_1)
			end
		end

		return var_2_0
	end,
	SortRoomList = function(arg_3_0, arg_3_1, arg_3_2)
		if PlayRoomConst.ROOM_SORT_TYPE.ROOM_CREATE_TIME == arg_3_1 then
			if arg_3_2 then
				return arg_3_0
			else
				return _.reverse(arg_3_0)
			end
		end

		table.sort(arg_3_0, function(arg_4_0, arg_4_1)
			return switch(arg_3_1, {
				[PlayRoomConst.ROOM_SORT_TYPE.ROOM_PLAYER_SUM] = function()
					if arg_4_0.teamCnt == arg_4_1.teamCnt then
						return arg_4_0.roomState < arg_4_1.roomState
					end

					if arg_3_2 then
						return arg_4_0.teamCnt < arg_4_1.teamCnt
					else
						return arg_4_0.teamCnt > arg_4_1.teamCnt
					end

					return
				end,
				[PlayRoomConst.ROOM_SORT_TYPE.ROOM_VIEWER_CNT] = function()
					if arg_4_0.viewerCnt == arg_4_1.viewerCnt then
						return arg_4_0.roomState < arg_4_1.roomState
					end

					if arg_3_2 then
						return arg_4_0.viewerCnt < arg_4_1.viewerCnt
					else
						return arg_4_0.viewerCnt > arg_4_1.viewerCnt
					end

					return
				end
			})
		end)

		return arg_3_0
	end,
	GetMaxTeamCnt = function(arg_7_0)
		local var_7_0 = 0

		for iter_7_0, iter_7_1 in ipairs(pg.mode_room[arg_7_0].count) do
			var_7_0 = var_7_0 + iter_7_1
		end

		return var_7_0
	end,
	GetMaxViewerCnt = function(arg_8_0)
		return pg.mode_room[arg_8_0].viewer_count
	end
}

function var_0_0.GetMaxPlayerCnt(arg_9_0)
	return var_0_0.GetMaxTeamCnt(arg_9_0)
end

function var_0_0.IsViewer()
	return table.contains(getProxy(PlayRoomProxy):GetRoomData().viewerList, (getProxy(PlayerProxy):getPlayerId()))
end

function var_0_0.IsPlayerFull()
	local var_11_0 = getProxy(PlayRoomProxy):GetRoomData()

	return #var_11_0.teamList >= var_0_0.GetMaxTeamCnt(var_11_0.gameType)
end

function var_0_0.IsViewerFull()
	local var_12_0 = getProxy(PlayRoomProxy):GetRoomData()

	return #var_12_0.viewerList >= var_0_0.GetMaxViewerCnt(var_12_0.gameType)
end

function var_0_0.GetUnfullTeamIndex(arg_13_0)
	local var_13_0 = getProxy(PlayRoomProxy):GetRoomData()

	for iter_13_0, iter_13_1 in ipairs(pg.mode_room[var_13_0.gameType].count) do
		if iter_13_1 > #var_13_0.teamPosList[iter_13_0] then
			return iter_13_0
		end
	end

	return nil
end

function var_0_0.GetHostID()
	return getProxy(PlayRoomProxy):GetRoomData().roomID
end

function var_0_0.CanStartGame()
	local var_15_0 = getProxy(PlayRoomProxy):GetRoomData()

	return #var_15_0.teamList == #var_15_0.readyList
end

function var_0_0.GetServerName(arg_16_0)
	local var_16_0 = bit.rshift(arg_16_0, 26)

	for iter_16_0, iter_16_1 in pairs(getProxy(ServerProxy):getData()) do
		if table.keyof(iter_16_1.ids, var_16_0) then
			return iter_16_1.name
		end
	end

	return i18n("match_ui_server_unkonw")
end

function var_0_0.GetPtScrore(arg_17_0)
	local var_17_0 = getProxy(ActivityProxy):getActivityByType((var_0_0.GameTypeToActivityType(arg_17_0)))

	return (var_17_0 or nil) and (var_17_0.data1 or 0)
end

function var_0_0.GetPtScoreIcon(arg_18_0)
	local var_18_0 = var_0_0.GameTypeToActivityType(arg_18_0)

	return switch(var_18_0, {
		[ActivityConst.ACTIVITY_TYPE_ISLAND_CHEAT_BAR] = function()
			local var_19_0 = getProxy(ActivityProxy):getActivityByType(var_18_0)
			local var_19_1

			if var_19_0 then
				var_19_1 = var_19_0.data1 or 0
			end

			local var_19_2

			for iter_19_0, iter_19_1 in ipairs(pg.island_integral_rank.all) do
				if var_19_1 >= pg.island_integral_rank[iter_19_1].lower_limit then
					var_19_2 = pg.island_integral_rank[iter_19_1].icon
				end
			end

			return var_19_2
		end
	}, function()
		assert(false, "非法activity类型")

		return
	end)
end

function var_0_0.GameTypeToActivityType(arg_21_0)
	return pg.mode_room[arg_21_0].activity_type
end

function var_0_0.SearchRoomList(arg_22_0)
	local var_22_0 = {}

	for iter_22_0, iter_22_1 in ipairs((getProxy(PlayRoomProxy):GetPlayRoomList())) do
		if string.match(arg_22_0, "^%d+$") ~= nil and iter_22_1.id == tonumber(arg_22_0) then
			table.insert(var_22_0, iter_22_1)
		end

		if iter_22_1.name == arg_22_0 then
			table.insert(var_22_0, iter_22_1)
		end
	end

	return var_22_0
end

function var_0_0.GetGameTypeID()
	return var_0_0.GameTypeID or PlayRoomConst.GAME_TYPE.CHEATER_TAVERN
end

function var_0_0.SetGameTypeID(arg_24_0)
	var_0_0.GameTypeID = arg_24_0

	return
end

function var_0_0.ShowPunishementBox(arg_25_0)
	local var_25_0 = pg.TimeMgr.GetInstance():GetServerTime()

	if arg_25_0 <= var_25_0 then
		return
	end

	pg.MsgboxMgr.GetInstance():ShowMsgBox({
		hideNo = true,
		content = i18n("match_ui_punishment1", arg_25_0 - var_25_0),
		yesText = i18n("match_ui_punishment2")
	})

	return
end

function var_0_0.GetGameViewID(arg_26_0)
	local var_26_0 = var_0_0.GetGameTypeID()

	for iter_26_0, iter_26_1 in ipairs(arg_26_0) do
		if iter_26_1.game_type == var_26_0 then
			return iter_26_1
		end
	end

	assert(false, "未找到对应游戏类型的角色装扮：" .. var_26_0)

	return
end

return var_0_0
