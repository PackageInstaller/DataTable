class = var_0_10000

local var_0_0 = var_0_10000("PlayRoomData")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.id
	arg_1_0.gameType = arg_1_1.game_type
	arg_1_0.name = arg_1_1.name
	arg_1_0.roomType = arg_1_1.type

	local var_1_0

	if not arg_1_1.player_num then
		var_1_0 = 0
	end

	arg_1_0.teamCnt = var_1_0

	local var_1_1

	if not arg_1_1.viewer_num then
		var_1_1 = 0
	end

	arg_1_0.viewerCnt = var_1_1

	local var_1_2

	if not arg_1_1.play_flag then
		PlayRoomConst = var_1_2
		var_1_2 = var_1_2.PLAY_ROOM_STATE.WAIT
	end

	arg_1_0.roomState = var_1_2

	return
end

function var_0_0.GetPlayer(arg_2_0, arg_2_1)
	local var_2_0

	if not arg_2_0.playerDataList or not arg_2_0.playerDataList[arg_2_1] then
		var_2_0 = nil
	end

	return var_2_0
end

class = var_1

local var_0_1 = var_1("PlayerData")

function var_0_1.Ctor(arg_3_0, arg_3_1)
	arg_3_0.id = arg_3_1.id
	arg_3_0.level = arg_3_1.level
	arg_3_0.name = arg_3_1.name
	arg_3_0.guildName = arg_3_1.guild_name
	arg_3_0.display = arg_3_1.display
	arg_3_0.user_view = arg_3_1.user_view

	return
end

class = var_2

local var_0_2 = var_2("PlayRoomInfoData")

function var_0_2.UpdateRoomData(arg_4_0, arg_4_1)
	arg_4_0.roomID = arg_4_1.id
	arg_4_0.roomType = arg_4_1.type
	arg_4_0.gameType = arg_4_1.game_type

	local var_4_0

	if not arg_4_1.play_flag then
		PlayRoomConst = var_4_0
		var_4_0 = var_4_0.PLAY_ROOM_STATE.WAIT
	end

	arg_4_0.roomState = var_4_0

	arg_4_0:UpdatePlayerList(arg_4_1.id, arg_4_1.player_list, arg_4_1.team_list, arg_4_1.ready_list)

	return
end

function var_0_2.UpdatePlayerList(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	arg_5_0.playerList = {}
	arg_5_0.playerDataList = {}
	ipairs = var_5

	for iter_5_0, iter_5_1 in var_5(arg_5_2) do
		var_1_10010 = iter_5_1.id
		table = var_1_10011

		var_1_10011.insert(arg_5_0.playerList, var_1_10010)

		var_1_10011 = arg_5_0.playerDataList
		var_1_10011[var_1_10010] = var_0_1.New(iter_5_1)
	end

	arg_5_0.teamList = {}
	arg_5_0.teamPosList = {}
	ipairs = var_5

	for iter_5_2, iter_5_3 in var_5(arg_5_3) do
		var_1_10010 = arg_5_0.teamPosList
		var_1_10010[iter_5_2] = {}
		ipairs = var_1_10010

		for iter_5_4, iter_5_5 in var_1_10010(iter_5_3.user_id_list) do
			if iter_5_5 ~= 0 then
				table = var_1_10015

				var_1_10015.insert(arg_5_0.teamList, iter_5_5)

				table = var_1_10015

				var_1_10015.insert(arg_5_0.teamPosList[iter_5_2], iter_5_5)
			end
		end
	end

	arg_5_0.readyList = {}
	ipairs = var_5

	for iter_5_6, iter_5_7 in var_5(arg_5_4) do
		table = var_1_10010

		var_1_10010.insert(arg_5_0.readyList, iter_5_7)
	end

	arg_5_0.viewerList = {}
	ipairs = var_5

	for iter_5_8, iter_5_9 in var_5(arg_5_0.playerList) do
		table = var_1_10010

		if not var_1_10010.contains(arg_5_0.teamList, iter_5_9) then
			table = var_1_10010

			var_1_10010.insert(arg_5_0.viewerList, iter_5_9)
		elseif iter_5_9 == arg_5_1 then
			table = var_1_10010

			var_1_10010.insert(arg_5_0.readyList, iter_5_9)
		end
	end

	return
end

function var_0_2.GetPlayer(arg_6_0, arg_6_1)
	local var_6_0

	if not arg_6_0.playerDataList or not arg_6_0.playerDataList[arg_6_1] then
		var_6_0 = nil
	end

	return var_6_0
end

class = var_3

local var_0_3 = var_3("MatchReadyRoom")

function var_0_3.UpdateRoomData(arg_7_0, arg_7_1)
	arg_7_0.gameType = arg_7_1.game_type
	arg_7_0.endTimestamp = arg_7_1.time

	arg_7_0:UpdatePlayerList(arg_7_1.player_list, arg_7_1.team_list, arg_7_1.ready_list)

	return
end

function var_0_3.UpdatePlayerList(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	arg_8_0.playerList = {}
	arg_8_0.playerDataList = {}
	ipairs = var_4

	for iter_8_0, iter_8_1 in var_4(arg_8_1) do
		var_1_10009 = iter_8_1.id
		table = var_1_10010

		var_1_10010.insert(arg_8_0.playerList, var_1_10009)

		var_1_10010 = arg_8_0.playerDataList
		var_1_10010[var_1_10009] = var_0_1.New(iter_8_1)
	end

	arg_8_0.teamList = {}
	arg_8_0.teamPosList = {}
	ipairs = var_4

	for iter_8_2, iter_8_3 in var_4(arg_8_2) do
		var_1_10009 = arg_8_0.teamPosList
		var_1_10009[iter_8_2] = {}
		ipairs = var_1_10009

		for iter_8_4, iter_8_5 in var_1_10009(iter_8_3.user_id_list) do
			if iter_8_5 ~= 0 then
				table = var_1_10014

				var_1_10014.insert(arg_8_0.teamList, iter_8_5)

				table = var_1_10014

				var_1_10014.insert(arg_8_0.teamPosList[iter_8_2], iter_8_5)
			end
		end
	end

	arg_8_0.readyList = {}
	ipairs = var_4

	for iter_8_6, iter_8_7 in var_4(arg_8_3) do
		table = var_1_10009

		var_1_10009.insert(arg_8_0.readyList, iter_8_7)
	end

	return
end

function var_0_3.GetPlayer(arg_9_0, arg_9_1)
	local var_9_0

	if not arg_9_0.playerDataList or not arg_9_0.playerDataList[arg_9_1] then
		var_9_0 = nil
	end

	return var_9_0
end

class = var_4

local var_0_4 = var_4("GameLoadData")

function var_0_4.UpdateData(arg_10_0, arg_10_1)
	arg_10_0.gameType = arg_10_1.game_type
	arg_10_0.isAllLoadOver = true

	arg_10_0:UpdatePlayerList(arg_10_1.player_list, arg_10_1.team_list, arg_10_1.load_list)

	arg_10_0.overTime = arg_10_1.time

	return
end

function var_0_4.UpdatePlayerList(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	arg_11_0.playerList = {}
	arg_11_0.playerDataList = {}
	ipairs = var_4

	for iter_11_0, iter_11_1 in var_4(arg_11_1) do
		local var_11_0 = iter_11_1.id

		table = var_1_10010

		var_1_10010.insert(arg_11_0.playerList, var_11_0)

		var_1_10010 = arg_11_0.playerDataList
		var_1_10010[var_11_0] = var_0_1.New(iter_11_1)
	end

	arg_11_0.teamList = {}
	arg_11_0.teamPosList = {}
	ipairs = var_4

	for iter_11_2, iter_11_3 in var_4(arg_11_2) do
		local var_11_1 = arg_11_0.teamPosList

		var_11_1[iter_11_2] = {}
		ipairs = var_11_1

		for iter_11_4, iter_11_5 in var_11_1(iter_11_3.user_id_list) do
			if iter_11_5 ~= 0 then
				table = var_1_10014

				var_1_10014.insert(arg_11_0.teamList, iter_11_5)

				table = var_1_10014

				var_1_10014.insert(arg_11_0.teamPosList[iter_11_2], iter_11_5)
			end
		end
	end

	arg_11_0.loadList = {}
	ipairs = var_4

	for iter_11_6, iter_11_7 in var_4(arg_11_3) do
		arg_11_0.loadList[iter_11_7.user_id] = iter_11_7.load

		if iter_11_7.load < 100 then
			arg_11_0.isAllLoadOver = false
		end
	end

	return
end

class = var_5

local var_0_5 = var_5("RankData")

function var_0_5.UpdateData(arg_12_0, arg_12_1, arg_12_2)
	arg_12_0.playerData = var_0_1.New(arg_12_1.player)
	arg_12_0.score = arg_12_1.score
	arg_12_0.rankIndex = arg_12_2

	return
end

class = var_6

local var_0_6 = "PlayRoomProxy"

import = var_0_10009

local var_0_7 = var_6(var_0_6, var_0_10009(".NetProxy"))

var_0_7.CHAT_MSG_UPDATE = "PlayRoomProxy.CHAT_MSG_UPDATE"

function var_0_7.register(arg_13_0)
	arg_13_0.playRoomList = {}

	arg_13_0:on(23099, function(arg_14_0)
		if arg_13_0.roomData == nil then
			return
		end

		local var_14_0 = arg_13_0

		var_1.UpdateRoomData(var_14_0, arg_14_0.room)

		return
	end)
	arg_13_0:on(23096, function(arg_15_0)
		if arg_15_0.reason == 1 then
			pg = var_1
			var_2_10003 = var_1.TipsMgr.GetInstance()

			local var_15_0 = var_1.ShowTips

			i18n = var_2_10004

			var_15_0(var_2_10003, var_2_10004("match_ui_room_out"))
		end

		if arg_13_0.roomData then
			local var_15_1 = arg_13_0.roomData.roomType

			PlayRoomConst = var_2_10002

			if var_15_1 == var_2_10002.PLAY_ROOM_TYPE.MATCH then
				if arg_13_0.matchReadyRoom == nil then
					var_2_10003 = arg_13_0

					var_1.ExitRoom(var_2_10003)
				else
					local var_15_2 = arg_13_0.matchReadyRoom.readyList

					getProxy = var_2
					PlayerProxy = var_2_10004
					var_2_10004 = var_2(var_2_10004)

					local var_15_3 = var_2.getPlayerId(var_2_10004)

					table = var_2_10003

					local var_15_4 = var_2_10003.keyof(var_15_2, var_15_3)

					var_2_10004 = arg_13_0.matchReadyRoom.endTimestamp

					local var_15_5 = arg_13_0

					var_5.ExitMatchReadyRoom(var_15_5)

					if arg_13_0.matchStartTime then
						pg = var_5

						local var_15_6 = var_5.TimeMgr.GetInstance()
						local var_15_7 = var_5.GetServerTime(var_15_6) - arg_13_0.matchStartTime

						pg = var_6
						var_2_10008 = var_6.GameTrackerMgr.GetInstance()

						local var_15_8 = var_6.Record

						GameTrackerBuilder = var_2_10009

						var_15_8(var_2_10008, var_2_10009.BuildPlayRoomMatch("bar", 2, 1, var_15_7, 2))

						arg_13_0.matchStartTime = nil
					end

					local var_15_9 = arg_13_0
					local var_15_10 = var_5.sendNotification

					GAME = var_2_10008

					var_15_10(var_15_9, var_2_10008.PLAY_ROOM_EXIT_MATCH_READY_ROOM)

					if arg_15_0.reason == 3 then
						local var_15_11 = arg_13_0
						local var_15_12 = var_5.sendNotification

						GAME = var_8

						local var_15_13 = var_8.PLAY_ROOM_CREATE_ROOM
						local var_15_14 = {}

						PlayRoomConst = var_2_10010
						var_15_14.type = var_2_10010.PLAY_ROOM_TYPE.MATCH
						var_15_14.gameType = arg_13_0.roomData.gameType

						var_15_12(var_15_11, var_15_13, var_15_14)

						local var_15_15 = arg_13_0
						local var_15_16 = var_5.sendNotification

						GAME = var_15_13

						var_15_16(var_15_15, var_15_13.PLAY_ROOM_START_GAME)
					else
						local var_15_17 = arg_13_0

						var_5.ExitRoom(var_15_17)
					end
				end

				goto label_15_0
			end
		end

		do
			local var_15_18 = arg_13_0

			var_1.ExitRoom(var_15_18)

			local var_15_19 = arg_13_0
			local var_15_20 = var_1.sendNotification

			GAME = var_2_10004

			var_15_20(var_15_19, var_2_10004.PLAY_ROOM_EXIT_ROOM_DONE)
		end

		::label_15_0::

		return
	end)
	arg_13_0:on(23097, function(arg_16_0)
		local var_16_0 = arg_13_0

		var_1.AddInviteList(var_16_0, arg_16_0)

		return
	end)
	arg_13_0:on(23095, function(arg_17_0)
		local var_17_0 = arg_13_0

		var_1.UpdateMatchRoomData(var_17_0, arg_17_0)

		return
	end)
	arg_13_0:on(23094, function(arg_18_0)
		local var_18_0 = arg_13_0

		var_1.UpdateGameLoadData(var_18_0, arg_18_0)

		return
	end)

	arg_13_0.inviteList = {}
	arg_13_0.inviteRecordList = {}

	arg_13_0:on(50116, function(arg_19_0)
		local var_19_0 = arg_13_0

		var_1.AddChatMsg(var_19_0, arg_19_0)

		return
	end)

	arg_13_0.chatMsgs = {}
	arg_13_0.rankList = {}
	arg_13_0.selfRankData = {}
	arg_13_0.matchCD = 0
	arg_13_0.isPlayingGame = false

	return
end

function var_0_7.GetPlayRoomList(arg_20_0)
	return arg_20_0.playRoomList
end

function var_0_7.UpdateRoomList(arg_21_0, arg_21_1)
	arg_21_0.playRoomList = {}
	ipairs = var_2

	for iter_21_0, iter_21_1 in var_2(arg_21_1) do
		table = var_1_10007

		var_1_10007.insert(arg_21_0.playRoomList, var_0_0.New(iter_21_1))
	end

	return
end

function var_0_7.UpdateRoomData(arg_22_0, arg_22_1)
	if arg_22_0.roomData == nil then
		arg_22_0.roomData = var_0_2.New()

		arg_22_0:ClearChatMsgList()
	end

	local var_22_0 = arg_22_0.roomData

	var_2.UpdateRoomData(var_22_0, arg_22_1)

	if not arg_22_0.isPlayingGame then
		local var_22_1 = arg_22_0
		local var_22_2 = arg_22_0.sendNotification

		GAME = var_5

		var_22_2(var_22_1, var_5.PLAY_ROOM_REDAY_ROOM_REFRESH)
	end

	return
end

function var_0_7.GetRoomData(arg_23_0)
	return arg_23_0.roomData
end

function var_0_7.ExitRoom(arg_24_0)
	arg_24_0:SetStartMatch(false)

	if arg_24_0.matchStartTime then
		pg = var_1

		local var_24_0 = var_1.TimeMgr.GetInstance()
		local var_24_1 = var_1.GetServerTime(var_24_0) - arg_24_0.matchStartTime

		pg = var_2

		local var_24_2 = var_2.GameTrackerMgr.GetInstance()
		local var_24_3 = var_2.Record

		GameTrackerBuilder = var_1_10005

		var_24_3(var_24_2, var_1_10005.BuildPlayRoomMatch("bar", 2, 1, var_24_1, 1))

		arg_24_0.matchStartTime = nil
	end

	arg_24_0.roomData = nil

	return
end

function var_0_7.SetPlayingGameState(arg_25_0, arg_25_1)
	arg_25_0.isPlayingGame = arg_25_1

	return
end

function var_0_7.GetPlayingGameState(arg_26_0)
	return arg_26_0.isPlayingGame
end

function var_0_7.AddInviteList(arg_27_0, arg_27_1)
	local var_27_1

	if arg_27_0.roomData then
		pg = var_27_1

		local var_27_0 = var_27_1.GameTrackerMgr.GetInstance()

		var_27_1 = var_27_1.Record
		GameTrackerBuilder = var_1_10005

		var_27_1(var_27_0, var_1_10005.BuildPlayRoomInvate("bar", arg_27_1.invitor.id, 3))

		return
	end

	table = var_27_1

	local var_27_2 = var_27_1.insert
	local var_27_3 = arg_27_0.inviteList
	local var_27_4 = {
		roomData = var_0_0.New(arg_27_1.room),
		invitor = var_0_1.New(arg_27_1.invitor)
	}

	pg = var_6

	local var_27_5 = var_6.TimeMgr.GetInstance()

	var_27_4.timestamp = var_6.GetServerTime(var_27_5)

	var_27_2(var_27_3, var_27_4)

	return
end

function var_0_7.GetInviteList(arg_28_0)
	pg = var_1_10001

	local var_28_0 = var_1_10001.TimeMgr.GetInstance()
	local var_28_1 = var_1.GetServerTime(var_28_0)

	for iter_28_0 = #arg_28_0.inviteList, 1, -1 do
		local var_28_2 = var_28_1 - arg_28_0.inviteList[iter_28_0].timestamp

		pg = var_1_10008

		if var_1_10008.gameset.match_refuseCD.key_value < var_28_2 then
			table = var_28_2

			var_28_2.remove(arg_28_0.inviteList, 1)
		end
	end

	return arg_28_0.inviteList
end

function var_0_7.RefuseInvite(arg_29_0, arg_29_1)
	ipairs = var_1_10002

	for iter_29_0, iter_29_1 in var_1_10002(arg_29_0.inviteList) do
		if iter_29_1.roomData.id == arg_29_1 then
			table = var_7

			var_7.remove(arg_29_0.inviteList, iter_29_0)

			break
		end
	end

	return
end

function var_0_7.ClearInviteList(arg_30_0)
	arg_30_0.inviteList = {}

	return
end

function var_0_7.AddInviteRecord(arg_31_0, arg_31_1)
	table = var_1_10002

	local var_31_0 = var_1_10002.insert
	local var_31_1 = arg_31_0.inviteRecordList
	local var_31_2 = {
		id = arg_31_1
	}

	pg = var_1_10006

	local var_31_3 = var_1_10006.TimeMgr.GetInstance()

	var_31_2.timestamp = var_6.GetServerTime(var_31_3)

	var_31_0(var_31_1, var_31_2)

	return
end

function var_0_7.RemoveInviteRecord(arg_32_0, arg_32_1)
	ipairs = var_1_10002

	for iter_32_0, iter_32_1 in var_1_10002(arg_32_0.inviteRecordList) do
		if iter_32_1.id == arg_32_1 then
			table = var_7

			var_7.remove(arg_32_0.inviteRecordList, iter_32_0)

			return
		end
	end

	return
end

function var_0_7.GetInviteRecordList(arg_33_0)
	pg = var_1_10001

	local var_33_0 = var_1_10001.gameset.match_refuseCD.key_value

	pg = var_1_10002

	local var_33_1 = var_1_10002.TimeMgr.GetInstance()
	local var_33_2 = var_2.GetServerTime(var_33_1)

	for iter_33_0 = #arg_33_0.inviteRecordList, 1, -1 do
		if arg_33_0.inviteRecordList[iter_33_0].timestamp + var_33_0 <= var_33_2 then
			table = var_7

			var_7.remove(arg_33_0.inviteRecordList, iter_33_0)
		end
	end

	return arg_33_0.inviteRecordList
end

function var_0_7.GetInviteRecordByID(arg_34_0, arg_34_1)
	ipairs = var_1_10002

	for iter_34_0, iter_34_1 in var_1_10002(arg_34_0.inviteRecordList) do
		if iter_34_1.id == arg_34_1 then
			return iter_34_1
		end
	end

	return
end

function var_0_7.ClearInviteRecordList(arg_35_0)
	arg_35_0.inviteRecordList = {}

	return
end

function var_0_7.UpdateMatchRoomData(arg_36_0, arg_36_1)
	local var_36_0 = false

	if arg_36_0.matchReadyRoom == nil then
		var_36_0 = true
		arg_36_0.matchReadyRoom = var_0_3.New()

		arg_36_0:SetStartMatch(false)

		if arg_36_0.matchStartTime then
			pg = var_3

			local var_36_1 = var_3.TimeMgr.GetInstance()
			local var_36_2 = var_3.GetServerTime(var_36_1) - arg_36_0.matchStartTime

			pg = var_4

			local var_36_3 = var_4.GameTrackerMgr.GetInstance()
			local var_36_4 = var_4.Record

			GameTrackerBuilder = var_1_10007

			var_36_4(var_36_3, var_1_10007.BuildPlayRoomMatch("bar", 2, 1, var_36_2, 3))

			arg_36_0.matchStartTime = nil
		end
	end

	local var_36_5 = arg_36_0.matchReadyRoom

	var_3.UpdateRoomData(var_36_5, arg_36_1)

	if var_36_0 then
		local var_36_6 = arg_36_0
		local var_36_7 = arg_36_0.sendNotification

		GAME = var_6

		var_36_7(var_36_6, var_6.PLAY_ROOM_MATCH_ENTER_READY_ROOM)
	else
		local var_36_8 = arg_36_0
		local var_36_9 = arg_36_0.sendNotification

		GAME = var_6

		var_36_9(var_36_8, var_6.PLAY_ROOM_MATCH_REDAY_ROOM_REFRESH)
	end

	return
end

function var_0_7.GetMatchRoomData(arg_37_0)
	return arg_37_0.matchReadyRoom
end

function var_0_7.ExitMatchReadyRoom(arg_38_0)
	arg_38_0.matchReadyRoom = nil

	return
end

function var_0_7.GetMatchTime(arg_39_0)
	local var_39_0

	if not arg_39_0.matchEndTime then
		var_39_0 = 0
	end

	return var_39_0
end

function var_0_7.SetStartMatch(arg_40_0, arg_40_1)
	if arg_40_1 then
		arg_40_0:RefreshMatchTime()
	else
		arg_40_0.matchEndTime = nil
	end

	return
end

function var_0_7.GetMatchFlag(arg_41_0)
	if arg_41_0.matchReadyRoom == nil then
		local var_41_0 = arg_41_0:GetMatchTime()

		pg = var_1_10002

		local var_41_1 = var_1_10002.TimeMgr.GetInstance()
		local var_41_2

		if not (var_41_0 >= var_2.GetServerTime(var_41_1)) then
			var_41_2 = false
		else
			var_41_2 = true
		end

		return var_41_2
	end
end

function var_0_7.RefreshMatchTime(arg_42_0)
	pg = var_1_10001

	local var_42_0 = var_1_10001.TimeMgr.GetInstance()

	arg_42_0.matchStartTime = var_1.GetServerTime(var_42_0) - 1

	local var_42_1 = arg_42_0.matchStartTime

	pg = var_1_10002
	arg_42_0.matchEndTime = var_42_1 + var_1_10002.gameset.level_get_proficency.key_value

	return
end

function var_0_7.GetMatchStarTime(arg_43_0)
	local var_43_1

	if not arg_43_0.matchStartTime then
		pg = var_43_1

		local var_43_0 = var_43_1.TimeMgr.GetInstance()

		var_43_1 = var_43_1.GetServerTime(var_43_0)
	end

	return var_43_1
end

function var_0_7.SetExitMatchFlag(arg_44_0, arg_44_1)
	arg_44_0.exitMatchFlag = arg_44_1 == 0

	return
end

function var_0_7.SetMatchCD(arg_45_0, arg_45_1)
	if arg_45_1 <= 0 then
		return
	end

	arg_45_0.matchCD = arg_45_1

	return
end

function var_0_7.GetMatchCD(arg_46_0)
	return arg_46_0.matchCD
end

function var_0_7.UpdateGameLoadData(arg_47_0, arg_47_1)
	local var_47_0 = false

	if arg_47_0.gameLoadData == nil then
		var_47_0 = true
		arg_47_0.gameLoadData = var_0_4.New()
	end

	local var_47_1 = arg_47_0.gameLoadData

	var_3.UpdateData(var_47_1, arg_47_1)

	if var_47_0 and arg_47_0.roomData then
		local var_47_2 = arg_47_0.roomData

		PlayRoomConst = var_1_10004
		var_47_2.roomState = var_1_10004.PLAY_ROOM_STATE.PLAYING

		arg_47_0:ExitMatchReadyRoom()

		local var_47_3 = arg_47_0
		local var_47_4 = arg_47_0.sendNotification

		GAME = var_6

		var_47_4(var_47_3, var_6.PLAY_ROOM_CLOSE_MATCH_READY)

		local var_47_5 = arg_47_0
		local var_47_6 = arg_47_0.sendNotification

		GAME = var_6

		var_47_6(var_47_5, var_6.PLAY_ROOM_ENTER_LOAD)
	end

	if arg_47_0.gameLoadData.isAllLoadOver then
		arg_47_0.gameLoadData = nil

		local var_47_7 = arg_47_0
		local var_47_8 = arg_47_0.sendNotification

		GAME = var_6

		var_47_8(var_47_7, var_6.PLAY_ROOM_ALL_LOAD_OVER)
		arg_47_0:SetPlayingGameState(true)
	end

	return
end

function var_0_7.GetGameLoadData(arg_48_0)
	return arg_48_0.gameLoadData
end

function var_0_7.GetLoadOverTime(arg_49_0)
	return arg_49_0.gameLoadData.overTime
end

function var_0_7.AddChatMsg(arg_50_0, arg_50_1)
	ChatProxy = var_1_10002

	local var_50_0 = var_1_10002.InjectPublicMsg
	local var_50_1 = arg_50_1.content

	Player = var_1_10005

	local var_50_2 = var_50_0(var_50_1, var_1_10005.New(arg_50_1.player))

	ChatMsg = var_1_10003

	local var_50_3 = var_1_10003.New

	ChatConst = var_5

	local var_50_4 = var_50_3(var_5.ChannelPlayRoom, var_50_2)

	var_50_4.typePlayRoom = arg_50_1.type
	table = var_4

	var_4.insert(arg_50_0.chatMsgs, var_50_4)

	local var_50_5 = arg_50_0
	local var_50_6 = arg_50_0.sendNotification

	PlayRoomProxy = var_7

	var_50_6(var_50_5, var_7.CHAT_MSG_UPDATE, {
		msg = var_50_4
	})

	return
end

function var_0_7.GetChatMsgs(arg_51_0)
	underscore = var_1_10001

	return var_1_10001.to_array(arg_51_0.chatMsgs)
end

function var_0_7.ClearChatMsgList(arg_52_0)
	arg_52_0.chatMsgs = {}

	return
end

function var_0_7.UpdateRankData(arg_53_0, arg_53_1, arg_53_2)
	arg_53_0.rankList[arg_53_1] = {}

	local var_53_0 = arg_53_0.selfRankData

	var_53_0[arg_53_1] = var_0_5.New()
	getProxy = var_53_0
	PlayerProxy = var_1_10005

	local var_53_1 = var_53_0(var_1_10005)
	local var_53_2 = var_3.getPlayerId(var_53_1)

	ipairs = var_4

	for iter_53_0, iter_53_1 in var_4(arg_53_2.rank_list) do
		local var_53_3 = var_0_5.New()

		var_9.UpdateData(var_53_3, iter_53_1, iter_53_0)

		table = var_10

		var_10.insert(arg_53_0.rankList[arg_53_1], var_9)

		if iter_53_1.player.id == var_53_2 then
			local var_53_4 = arg_53_0.selfRankData[arg_53_1]

			var_10.UpdateData(var_53_4, iter_53_1, iter_53_0)
		end
	end

	return
end

function var_0_7.GetRankData(arg_54_0, arg_54_1)
	local var_54_0

	if not arg_54_0.rankList[arg_54_1] then
		var_54_0 = {}
	end

	return var_54_0
end

function var_0_7.GetSelfRankData(arg_55_0, arg_55_1)
	if arg_55_0.selfRankData[arg_55_1].rankIndex then
		return arg_55_0.selfRankData[arg_55_1]
	end

	getProxy = var_2
	PlayerProxy = var_1_10004

	local var_55_0 = var_2(var_1_10004)
	local var_55_1 = var_2.getData(var_55_0)

	getProxy = var_1_10003
	GuildProxy = var_1_10005

	local var_55_2 = var_1_10003(var_1_10005)
	local var_55_3 = var_3.getData(var_55_2)
	local var_55_4 = arg_55_0.selfRankData[arg_55_1]
	local var_55_5 = var_4.UpdateData
	local var_55_6 = {}

	PlayRoomTools = var_1_10008
	var_55_6.score = var_1_10008.GetPtScrore(arg_55_1)

	local var_55_7 = {
		id = var_55_1.id,
		level = var_55_1.level,
		name = var_55_1.name
	}
	local var_55_8

	if not var_55_3 or not var_55_3.name then
		var_55_8 = ""
	end

	var_55_7.guild_name = var_55_8
	var_55_7.display = var_55_1.displayInfo
	var_55_6.player = var_55_7

	var_55_5(var_55_4, var_55_6, 0)

	return arg_55_0.selfRankData[arg_55_1]
end

return var_0_7
