local var_0_0 = {
	FilterRoomType = function(arg_1_0, arg_1_1)
		PlayRoomConst = var_1_10002

		if arg_1_1 == var_1_10002.PLAY_ROOM_TYPE.ALL then
			Clone = var_2

			return var_2(arg_1_0)
		end

		local var_1_0 = {}

		ipairs = var_1_10003

		for iter_1_0, iter_1_1 in var_1_10003(arg_1_0) do
			if iter_1_1.roomType == arg_1_1 then
				table = var_8

				var_8.insert(var_1_0, iter_1_1)
			end
		end

		return var_1_0
	end,
	FilterRoomState = function(arg_2_0, arg_2_1)
		PlayRoomConst = var_1_10002

		if arg_2_1 == var_1_10002.PLAY_ROOM_STATE.ALL then
			Clone = var_2

			return var_2(arg_2_0)
		end

		local var_2_0 = {}

		ipairs = var_1_10003

		for iter_2_0, iter_2_1 in var_1_10003(arg_2_0) do
			if iter_2_1.roomState == arg_2_1 then
				table = var_8

				var_8.insert(var_2_0, iter_2_1)
			end
		end

		return var_2_0
	end,
	SortRoomList = function(arg_3_0, arg_3_1, arg_3_2)
		PlayRoomConst = var_1_10003

		if var_1_10003.ROOM_SORT_TYPE.ROOM_CREATE_TIME == arg_3_1 then
			if arg_3_2 then
				return arg_3_0
			else
				_ = var_3

				return var_3.reverse(arg_3_0)
			end
		end

		table = var_3

		var_3.sort(arg_3_0, function(arg_4_0, arg_4_1)
			switch = var_2_10002

			local var_4_0 = arg_3_1
			local var_4_1 = {}

			PlayRoomConst = var_2_10006
			var_4_1[var_2_10006.ROOM_SORT_TYPE.ROOM_PLAYER_SUM] = function()
				if arg_4_0.teamCnt == arg_4_1.teamCnt then
					return arg_4_0.roomState < arg_4_1.roomState
				end

				if arg_3_2 then
					return arg_4_0.teamCnt < arg_4_1.teamCnt
				else
					return arg_4_0.teamCnt > arg_4_1.teamCnt
				end

				return
			end
			PlayRoomConst = var_6
			var_4_1[var_6.ROOM_SORT_TYPE.ROOM_VIEWER_CNT] = function()
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

			return var_2_10002(var_4_0, var_4_1)
		end)

		return arg_3_0
	end,
	GetMaxTeamCnt = function(arg_7_0)
		pg = var_1_10001

		local var_7_0 = var_1_10001.mode_room[arg_7_0].count
		local var_7_1 = 0

		ipairs = var_1_10003

		for iter_7_0, iter_7_1 in var_1_10003(var_7_0) do
			var_7_1 = var_7_1 + iter_7_1
		end

		return var_7_1
	end,
	GetMaxViewerCnt = function(arg_8_0)
		pg = var_1_10001

		return var_1_10001.mode_room[arg_8_0].viewer_count
	end
}

function var_0_0.GetMaxPlayerCnt(arg_9_0)
	return var_0_0.GetMaxTeamCnt(arg_9_0)
end

function var_0_0.IsViewer()
	getProxy = var_1_10000
	PlayRoomProxy = var_1_10002

	local var_10_0 = var_1_10000(var_1_10002)
	local var_10_1 = var_0.GetRoomData(var_10_0)

	getProxy = var_1_10002
	PlayerProxy = var_1_10004

	local var_10_2 = var_1_10002(var_1_10004)
	local var_10_3 = var_2.getPlayerId(var_10_2)

	table = var_10_0

	return var_10_0.contains(var_10_1.viewerList, var_10_3)
end

function var_0_0.IsPlayerFull()
	getProxy = var_1_10000
	PlayRoomProxy = var_1_10002

	local var_11_0 = var_1_10000(var_1_10002)

	return #var_0.GetRoomData(var_11_0).teamList >= var_0_0.GetMaxTeamCnt(var_1.gameType)
end

function var_0_0.IsViewerFull()
	getProxy = var_1_10000
	PlayRoomProxy = var_1_10002

	local var_12_0 = var_1_10000(var_1_10002)

	return #var_0.GetRoomData(var_12_0).viewerList >= var_0_0.GetMaxViewerCnt(var_1.gameType)
end

function var_0_0.GetUnfullTeamIndex(arg_13_0)
	getProxy = var_1_10001
	PlayRoomProxy = var_1_10003

	local var_13_0 = var_1_10001(var_1_10003)
	local var_13_1 = var_1.GetRoomData(var_13_0)

	pg = var_1_10003

	local var_13_2 = var_1_10003.mode_room[var_13_1.gameType].count

	ipairs = var_4

	for iter_13_0, iter_13_1 in var_4(var_13_2) do
		if iter_13_1 > #var_13_1.teamPosList[iter_13_0] then
			return iter_13_0
		end
	end

	return nil
end

function var_0_0.GetHostID()
	getProxy = var_1_10000
	PlayRoomProxy = var_1_10002

	local var_14_0 = var_1_10000(var_1_10002)

	return var_0.GetRoomData(var_14_0).roomID
end

function var_0_0.CanStartGame()
	getProxy = var_1_10000
	PlayRoomProxy = var_1_10002

	local var_15_0 = var_1_10000(var_1_10002)

	return #var_0.GetRoomData(var_15_0).teamList == #var_1.readyList
end

function var_0_0.GetServerName(arg_16_0)
	bit = var_1_10001

	local var_16_0 = var_1_10001.rshift(arg_16_0, 26)

	pairs = var_1_10002
	getProxy = var_4
	ServerProxy = var_1_10006

	local var_16_1 = var_4(var_1_10006)

	for iter_16_0, iter_16_1 in var_1_10002(var_4.getData(var_16_1)) do
		table = var_1_10007

		if var_1_10007.keyof(iter_16_1.ids, var_16_0) then
			return iter_16_1.name
		end
	end

	i18n = var_2

	return var_2("match_ui_server_unkonw")
end

function var_0_0.GetPtScrore(arg_17_0)
	local var_17_0 = var_0_0.GameTypeToActivityType(arg_17_0)

	getProxy = var_1_10002
	ActivityProxy = var_1_10004

	local var_17_1 = var_1_10002(var_1_10004)
	local var_17_2

	if not var_2.getActivityByType(var_17_1, var_17_0) or not var_2.data1 then
		var_17_2 = 0
	end

	return var_17_2
end

function var_0_0.GetPtScoreIcon(arg_18_0)
	local var_18_0 = var_0_0.GameTypeToActivityType(arg_18_0)

	switch = var_1_10002

	local var_18_1 = var_18_0
	local var_18_2 = {}

	ActivityConst = var_1_10006
	var_18_2[var_1_10006.ACTIVITY_TYPE_ISLAND_CHEAT_BAR] = function()
		getProxy = var_2_10000
		ActivityProxy = var_2_10002

		local var_19_0 = var_2_10000(var_2_10002)
		local var_19_1

		if not var_0.getActivityByType(var_19_0, var_18_0) or not var_0.data1 then
			var_19_1 = 0
		end

		local var_19_2

		ipairs = var_3
		pg = var_2_10005

		for iter_19_0, iter_19_1 in var_3(var_2_10005.island_integral_rank.all) do
			pg = var_2_10008

			if var_19_1 >= var_2_10008.island_integral_rank[iter_19_1].lower_limit then
				var_19_2 = var_2_10008.icon
			end
		end

		return var_19_2
	end

	return var_1_10002(var_18_1, var_18_2, function()
		assert = var_2_10000

		var_2_10000(false, "非法activity类型")

		return
	end)
end

function var_0_0.GameTypeToActivityType(arg_21_0)
	pg = var_1_10001

	return var_1_10001.mode_room[arg_21_0].activity_type
end

function var_0_0.SearchRoomList(arg_22_0)
	local var_22_0 = {}

	getProxy = var_1_10002
	PlayRoomProxy = var_1_10004

	local var_22_1 = var_1_10002(var_1_10004)
	local var_22_2 = var_2.GetPlayRoomList(var_22_1)

	ipairs = var_1_10003

	for iter_22_0, iter_22_1 in var_1_10003(var_22_2) do
		string = var_1_10008

		if var_1_10008.match(arg_22_0, "^%d+$") ~= nil then
			tonumber = var_1_10008
			var_1_10008 = var_1_10008(arg_22_0)

			if iter_22_1.id == var_1_10008 then
				table = var_9

				var_9.insert(var_22_0, iter_22_1)
			end
		end

		if iter_22_1.name == arg_22_0 then
			table = var_1_10008

			var_1_10008.insert(var_22_0, iter_22_1)
		end
	end

	return var_22_0
end

function var_0_0.GetGameTypeID()
	local var_23_0

	if not var_0_0.GameTypeID then
		PlayRoomConst = var_23_0
		var_23_0 = var_23_0.GAME_TYPE.CHEATER_TAVERN
	end

	return var_23_0
end

function var_0_0.SetGameTypeID(arg_24_0)
	var_0_0.GameTypeID = arg_24_0

	return
end

function var_0_0.ShowPunishementBox(arg_25_0)
	pg = var_1_10001

	local var_25_0 = var_1_10001.TimeMgr.GetInstance()

	if arg_25_0 <= var_1.GetServerTime(var_25_0) then
		return
	end

	pg = var_1_10002

	local var_25_1 = var_1_10002.MsgboxMgr.GetInstance()
	local var_25_2 = var_2.ShowMsgBox
	local var_25_3 = {
		hideNo = true
	}

	i18n = var_1_10006
	var_25_3.content = var_1_10006("match_ui_punishment1", arg_25_0 - var_1)
	i18n = var_6
	var_25_3.yesText = var_6("match_ui_punishment2")

	var_25_2(var_25_1, var_25_3)

	return
end

function var_0_0.GetGameViewID(arg_26_0)
	local var_26_0 = var_0_0.GetGameTypeID()

	ipairs = var_1_10002

	for iter_26_0, iter_26_1 in var_1_10002(arg_26_0) do
		if iter_26_1.game_type == var_26_0 then
			return iter_26_1
		end
	end

	assert = var_2

	var_2(false, "未找到对应游戏类型的角色装扮：" .. var_26_0)

	return
end

return var_0_0
