local var_0_0 = class("PlayRoomData")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.id
	arg_1_0.gameType = arg_1_1.game_type
	arg_1_0.name = arg_1_1.name
	arg_1_0.roomType = arg_1_1.type
	arg_1_0.teamCnt = arg_1_1.player_num or 0
	arg_1_0.viewerCnt = arg_1_1.viewer_num or 0
	arg_1_0.roomState = arg_1_1.play_flag or PlayRoomConst.PLAY_ROOM_STATE.WAIT

	return
end

function var_0_0.GetPlayer(arg_2_0, arg_2_1)
	if arg_2_0.playerDataList then
		return arg_2_0.playerDataList[arg_2_1] or nil
	end
end

local var_0_1 = class("PlayerData")

class("PlayerData").Ctor = function(arg_3_0, arg_3_1)
	arg_3_0.id = arg_3_1.id
	arg_3_0.level = arg_3_1.level
	arg_3_0.name = arg_3_1.name
	arg_3_0.guildName = arg_3_1.guild_name
	arg_3_0.display = arg_3_1.display
	arg_3_0.user_view = arg_3_1.user_view

	return
end

local var_0_2 = class("PlayRoomInfoData")

function var_0_2.UpdateRoomData(arg_4_0, arg_4_1)
	arg_4_0.roomID = arg_4_1.id
	arg_4_0.roomType = arg_4_1.type
	arg_4_0.gameType = arg_4_1.game_type
	arg_4_0.roomState = arg_4_1.play_flag or PlayRoomConst.PLAY_ROOM_STATE.WAIT

	arg_4_0:UpdatePlayerList(arg_4_1.id, arg_4_1.player_list, arg_4_1.team_list, arg_4_1.ready_list)

	return
end

function var_0_2.UpdatePlayerList(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	arg_5_0.playerList = {}
	arg_5_0.playerDataList = {}

	for iter_5_0, iter_5_1 in ipairs(arg_5_2) do
		table.insert(arg_5_0.playerList, iter_5_1.id)

		arg_5_0.playerDataList[iter_5_1.id] = var_0_1.New(iter_5_1)
	end

	arg_5_0.teamList = {}
	arg_5_0.teamPosList = {}

	for iter_5_2, iter_5_3 in ipairs(arg_5_3) do
		arg_5_0.teamPosList[iter_5_2] = {}

		for iter_5_4, iter_5_5 in ipairs(iter_5_3.user_id_list) do
			if iter_5_5 ~= 0 then
				table.insert(arg_5_0.teamList, iter_5_5)
				table.insert(arg_5_0.teamPosList[iter_5_2], iter_5_5)
			end
		end
	end

	arg_5_0.readyList = {}

	for iter_5_6, iter_5_7 in ipairs(arg_5_4) do
		table.insert(arg_5_0.readyList, iter_5_7)
	end

	arg_5_0.viewerList = {}

	for iter_5_8, iter_5_9 in ipairs(arg_5_0.playerList) do
		if not table.contains(arg_5_0.teamList, iter_5_9) then
			table.insert(arg_5_0.viewerList, iter_5_9)
		elseif iter_5_9 == arg_5_1 then
			table.insert(arg_5_0.readyList, iter_5_9)
		end
	end

	return
end

function var_0_2.GetPlayer(arg_6_0, arg_6_1)
	if arg_6_0.playerDataList then
		return arg_6_0.playerDataList[arg_6_1] or nil
	end
end

local var_0_3 = class("MatchReadyRoom")

function var_0_3.UpdateRoomData(arg_7_0, arg_7_1)
	arg_7_0.gameType = arg_7_1.game_type
	arg_7_0.endTimestamp = arg_7_1.time

	arg_7_0:UpdatePlayerList(arg_7_1.player_list, arg_7_1.team_list, arg_7_1.ready_list)

	return
end

function var_0_3.UpdatePlayerList(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	arg_8_0.playerList = {}
	arg_8_0.playerDataList = {}

	for iter_8_0, iter_8_1 in ipairs(arg_8_1) do
		table.insert(arg_8_0.playerList, iter_8_1.id)

		arg_8_0.playerDataList[iter_8_1.id] = var_0_1.New(iter_8_1)
	end

	arg_8_0.teamList = {}
	arg_8_0.teamPosList = {}

	for iter_8_2, iter_8_3 in ipairs(arg_8_2) do
		arg_8_0.teamPosList[iter_8_2] = {}

		for iter_8_4, iter_8_5 in ipairs(iter_8_3.user_id_list) do
			if iter_8_5 ~= 0 then
				table.insert(arg_8_0.teamList, iter_8_5)
				table.insert(arg_8_0.teamPosList[iter_8_2], iter_8_5)
			end
		end
	end

	arg_8_0.readyList = {}

	for iter_8_6, iter_8_7 in ipairs(arg_8_3) do
		table.insert(arg_8_0.readyList, iter_8_7)
	end

	return
end

function var_0_3.GetPlayer(arg_9_0, arg_9_1)
	if arg_9_0.playerDataList then
		return arg_9_0.playerDataList[arg_9_1] or nil
	end
end

local var_0_4 = class("GameLoadData")

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

	for iter_11_0, iter_11_1 in ipairs(arg_11_1) do
		table.insert(arg_11_0.playerList, iter_11_1.id)

		arg_11_0.playerDataList[iter_11_1.id] = var_0_1.New(iter_11_1)
	end

	arg_11_0.teamList = {}
	arg_11_0.teamPosList = {}

	for iter_11_2, iter_11_3 in ipairs(arg_11_2) do
		arg_11_0.teamPosList[iter_11_2] = {}

		for iter_11_4, iter_11_5 in ipairs(iter_11_3.user_id_list) do
			if iter_11_5 ~= 0 then
				table.insert(arg_11_0.teamList, iter_11_5)
				table.insert(arg_11_0.teamPosList[iter_11_2], iter_11_5)
			end
		end
	end

	arg_11_0.loadList = {}

	for iter_11_6, iter_11_7 in ipairs(arg_11_3) do
		arg_11_0.loadList[iter_11_7.user_id] = iter_11_7.load

		if iter_11_7.load < 100 then
			arg_11_0.isAllLoadOver = false
		end
	end

	return
end

local var_0_5 = class("RankData")

class("RankData").UpdateData = function(arg_12_0, arg_12_1, arg_12_2)
	arg_12_0.playerData = var_0_1.New(arg_12_1.player)
	arg_12_0.score = arg_12_1.score
	arg_12_0.rankIndex = arg_12_2

	return
end

local var_0_6 = class("PlayRoomProxy", import(".NetProxy"))

var_0_6.CHAT_MSG_UPDATE = "PlayRoomProxy.CHAT_MSG_UPDATE"

function var_0_6.register(arg_13_0)
	arg_13_0.playRoomList = {}

	arg_13_0:on(23099, function(arg_14_0)
		if arg_13_0.roomData == nil then
			return
		end

		arg_13_0:UpdateRoomData(arg_14_0.room)

		return
	end)
	arg_13_0:on(23096, function(arg_15_0)
		if arg_15_0.reason == 1 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("match_ui_room_out"))
		end

		if arg_13_0.roomData and arg_13_0.roomData.roomType == PlayRoomConst.PLAY_ROOM_TYPE.MATCH then
			if arg_13_0.matchReadyRoom == nil then
				arg_13_0:ExitRoom()
			else
				local var_15_0 = table.keyof(arg_13_0.matchReadyRoom.readyList, (getProxy(PlayerProxy):getPlayerId()))

				arg_13_0:ExitMatchReadyRoom()

				if arg_13_0.matchStartTime then
					pg.GameTrackerMgr.GetInstance():Record(GameTrackerBuilder.BuildPlayRoomMatch("bar", 2, 1, pg.TimeMgr.GetInstance():GetServerTime() - arg_13_0.matchStartTime, 2))

					arg_13_0.matchStartTime = nil
				end

				arg_13_0:sendNotification(GAME.PLAY_ROOM_EXIT_MATCH_READY_ROOM)

				if arg_15_0.reason == 3 then
					arg_13_0:sendNotification(GAME.PLAY_ROOM_CREATE_ROOM, {
						type = PlayRoomConst.PLAY_ROOM_TYPE.MATCH,
						gameType = arg_13_0.roomData.gameType
					})
					arg_13_0:sendNotification(GAME.PLAY_ROOM_START_GAME)
				else
					arg_13_0:ExitRoom()
				end
			end
		else
			arg_13_0:ExitRoom()
			arg_13_0:sendNotification(GAME.PLAY_ROOM_EXIT_ROOM_DONE)
		end

		return
	end)
	arg_13_0:on(23097, function(arg_16_0)
		arg_13_0:AddInviteList(arg_16_0)

		return
	end)
	arg_13_0:on(23095, function(arg_17_0)
		arg_13_0:UpdateMatchRoomData(arg_17_0)

		return
	end)
	arg_13_0:on(23094, function(arg_18_0)
		arg_13_0:UpdateGameLoadData(arg_18_0)

		return
	end)

	arg_13_0.inviteList = {}
	arg_13_0.inviteRecordList = {}

	arg_13_0:on(50116, function(arg_19_0)
		arg_13_0:AddChatMsg(arg_19_0)

		return
	end)

	arg_13_0.chatMsgs = {}
	arg_13_0.rankList = {}
	arg_13_0.selfRankData = {}
	arg_13_0.matchCD = 0
	arg_13_0.isPlayingGame = false

	return
end

function var_0_6.GetPlayRoomList(arg_20_0)
	return arg_20_0.playRoomList
end

function var_0_6.UpdateRoomList(arg_21_0, arg_21_1)
	arg_21_0.playRoomList = {}

	for iter_21_0, iter_21_1 in ipairs(arg_21_1) do
		table.insert(arg_21_0.playRoomList, var_0_0.New(iter_21_1))
	end

	return
end

function var_0_6.UpdateRoomData(arg_22_0, arg_22_1)
	if arg_22_0.roomData == nil then
		arg_22_0.roomData = var_0_2.New()

		arg_22_0:ClearChatMsgList()
	end

	arg_22_0.roomData:UpdateRoomData(arg_22_1)

	if not arg_22_0.isPlayingGame then
		arg_22_0:sendNotification(GAME.PLAY_ROOM_REDAY_ROOM_REFRESH)
	end

	return
end

function var_0_6.GetRoomData(arg_23_0)
	return arg_23_0.roomData
end

function var_0_6.ExitRoom(arg_24_0)
	arg_24_0:SetStartMatch(false)

	if arg_24_0.matchStartTime then
		pg.GameTrackerMgr.GetInstance():Record(GameTrackerBuilder.BuildPlayRoomMatch("bar", 2, 1, pg.TimeMgr.GetInstance():GetServerTime() - arg_24_0.matchStartTime, 1))

		arg_24_0.matchStartTime = nil
	end

	arg_24_0.roomData = nil

	return
end

function var_0_6.SetPlayingGameState(arg_25_0, arg_25_1)
	arg_25_0.isPlayingGame = arg_25_1

	return
end

function var_0_6.GetPlayingGameState(arg_26_0)
	return arg_26_0.isPlayingGame
end

function var_0_6.AddInviteList(arg_27_0, arg_27_1)
	if arg_27_0.roomData then
		pg.GameTrackerMgr.GetInstance():Record(GameTrackerBuilder.BuildPlayRoomInvate("bar", arg_27_1.invitor.id, 3))

		return
	end

	local var_27_1 = {
		roomData = var_0_0.New(arg_27_1.room),
		invitor = var_0_1.New(arg_27_1.invitor)
	}

	var_27_1.timestamp = pg.TimeMgr.GetInstance():GetServerTime()

	var_27_0(arg_27_0.inviteList, var_27_1)

	return
end

function var_0_6.GetInviteList(arg_28_0)
	local var_28_0 = pg.TimeMgr.GetInstance():GetServerTime()

	for iter_28_0 = #arg_28_0.inviteList, 1, -1 do
		if var_28_0 - arg_28_0.inviteList[iter_28_0].timestamp > pg.gameset.match_refuseCD.key_value then
			table.remove(arg_28_0.inviteList, 1)
		end
	end

	return arg_28_0.inviteList
end

function var_0_6.RefuseInvite(arg_29_0, arg_29_1)
	for iter_29_0, iter_29_1 in ipairs(arg_29_0.inviteList) do
		if iter_29_1.roomData.id == arg_29_1 then
			table.remove(arg_29_0.inviteList, iter_29_0)

			break
		end
	end

	return
end

function var_0_6.ClearInviteList(arg_30_0)
	arg_30_0.inviteList = {}

	return
end

function var_0_6.AddInviteRecord(arg_31_0, arg_31_1)
	({
		id = arg_31_1
	}).timestamp = pg.TimeMgr.GetInstance():GetServerTime()

	table.insert(arg_31_0.inviteRecordList, {
		id = arg_31_1
	})

	return
end

function var_0_6.RemoveInviteRecord(arg_32_0, arg_32_1)
	for iter_32_0, iter_32_1 in ipairs(arg_32_0.inviteRecordList) do
		if iter_32_1.id == arg_32_1 then
			table.remove(arg_32_0.inviteRecordList, iter_32_0)

			return
		end
	end

	return
end

function var_0_6.GetInviteRecordList(arg_33_0)
	local var_33_0 = pg.TimeMgr.GetInstance():GetServerTime()

	for iter_33_0 = #arg_33_0.inviteRecordList, 1, -1 do
		if var_33_0 >= arg_33_0.inviteRecordList[iter_33_0].timestamp + pg.gameset.match_refuseCD.key_value then
			table.remove(arg_33_0.inviteRecordList, iter_33_0)
		end
	end

	return arg_33_0.inviteRecordList
end

function var_0_6.GetInviteRecordByID(arg_34_0, arg_34_1)
	for iter_34_0, iter_34_1 in ipairs(arg_34_0.inviteRecordList) do
		if iter_34_1.id == arg_34_1 then
			return iter_34_1
		end
	end

	return
end

function var_0_6.ClearInviteRecordList(arg_35_0)
	arg_35_0.inviteRecordList = {}

	return
end

function var_0_6.UpdateMatchRoomData(arg_36_0, arg_36_1)
	local var_36_0 = false

	if arg_36_0.matchReadyRoom == nil then
		var_36_0 = true
		arg_36_0.matchReadyRoom = var_0_3.New()

		arg_36_0:SetStartMatch(false)

		if arg_36_0.matchStartTime then
			pg.GameTrackerMgr.GetInstance():Record(GameTrackerBuilder.BuildPlayRoomMatch("bar", 2, 1, pg.TimeMgr.GetInstance():GetServerTime() - arg_36_0.matchStartTime, 3))

			arg_36_0.matchStartTime = nil
		end
	end

	arg_36_0.matchReadyRoom:UpdateRoomData(arg_36_1)

	if var_36_0 then
		arg_36_0:sendNotification(GAME.PLAY_ROOM_MATCH_ENTER_READY_ROOM)
	else
		arg_36_0:sendNotification(GAME.PLAY_ROOM_MATCH_REDAY_ROOM_REFRESH)
	end

	return
end

function var_0_6.GetMatchRoomData(arg_37_0)
	return arg_37_0.matchReadyRoom
end

function var_0_6.ExitMatchReadyRoom(arg_38_0)
	arg_38_0.matchReadyRoom = nil

	return
end

function var_0_6.GetMatchTime(arg_39_0)
	return arg_39_0.matchEndTime or 0
end

function var_0_6.SetStartMatch(arg_40_0, arg_40_1)
	if arg_40_1 then
		arg_40_0:RefreshMatchTime()
	else
		arg_40_0.matchEndTime = nil
	end

	return
end

function var_0_6.GetMatchFlag(arg_41_0)
	if arg_41_0.matchReadyRoom == nil then
		local var_41_0 = arg_41_0:GetMatchTime() >= pg.TimeMgr.GetInstance():GetServerTime()

		return var_41_0
	end
end

function var_0_6.RefreshMatchTime(arg_42_0)
	arg_42_0.matchStartTime = pg.TimeMgr.GetInstance():GetServerTime() - 1
	arg_42_0.matchEndTime = arg_42_0.matchStartTime + pg.gameset.level_get_proficency.key_value

	return
end

function var_0_6.GetMatchStarTime(arg_43_0)
	return arg_43_0.matchStartTime or pg.TimeMgr.GetInstance():GetServerTime()
end

function var_0_6.SetExitMatchFlag(arg_44_0, arg_44_1)
	arg_44_0.exitMatchFlag = arg_44_1 == 0

	return
end

function var_0_6.SetMatchCD(arg_45_0, arg_45_1)
	if arg_45_1 <= 0 then
		return
	end

	arg_45_0.matchCD = arg_45_1

	return
end

function var_0_6.GetMatchCD(arg_46_0)
	return arg_46_0.matchCD
end

function var_0_6.UpdateGameLoadData(arg_47_0, arg_47_1)
	local var_47_0 = false

	if arg_47_0.gameLoadData == nil then
		var_47_0 = true
		arg_47_0.gameLoadData = var_0_4.New()
	end

	arg_47_0.gameLoadData:UpdateData(arg_47_1)

	if var_47_0 and arg_47_0.roomData then
		arg_47_0.roomData.roomState = PlayRoomConst.PLAY_ROOM_STATE.PLAYING

		arg_47_0:ExitMatchReadyRoom()
		arg_47_0:sendNotification(GAME.PLAY_ROOM_CLOSE_MATCH_READY)
		arg_47_0:sendNotification(GAME.PLAY_ROOM_ENTER_LOAD)
	end

	if arg_47_0.gameLoadData.isAllLoadOver then
		arg_47_0.gameLoadData = nil

		arg_47_0:sendNotification(GAME.PLAY_ROOM_ALL_LOAD_OVER)
		arg_47_0:SetPlayingGameState(true)
	end

	return
end

function var_0_6.GetGameLoadData(arg_48_0)
	return arg_48_0.gameLoadData
end

function var_0_6.GetLoadOverTime(arg_49_0)
	return arg_49_0.gameLoadData.overTime
end

function var_0_6.AddChatMsg(arg_50_0, arg_50_1)
	local var_50_0 = ChatMsg.New(ChatConst.ChannelPlayRoom, (ChatProxy.InjectPublicMsg(arg_50_1.content, Player.New(arg_50_1.player))))

	var_50_0.typePlayRoom = arg_50_1.type

	table.insert(arg_50_0.chatMsgs, var_50_0)
	arg_50_0:sendNotification(PlayRoomProxy.CHAT_MSG_UPDATE, {
		msg = var_50_0
	})

	return
end

function var_0_6.GetChatMsgs(arg_51_0)
	return underscore.to_array(arg_51_0.chatMsgs)
end

function var_0_6.ClearChatMsgList(arg_52_0)
	arg_52_0.chatMsgs = {}

	return
end

function var_0_6.UpdateRankData(arg_53_0, arg_53_1, arg_53_2)
	arg_53_0.rankList[arg_53_1] = {}
	arg_53_0.selfRankData[arg_53_1] = var_0_5.New()

	local var_53_0 = getProxy(PlayerProxy):getPlayerId()

	for iter_53_0, iter_53_1 in ipairs(arg_53_2.rank_list) do
		local var_53_1 = var_0_5.New()

		var_53_1:UpdateData(iter_53_1, iter_53_0)
		table.insert(arg_53_0.rankList[arg_53_1], var_53_1)

		if iter_53_1.player.id == var_53_0 then
			arg_53_0.selfRankData[arg_53_1]:UpdateData(iter_53_1, iter_53_0)
		end
	end

	return
end

function var_0_6.GetRankData(arg_54_0, arg_54_1)
	return arg_54_0.rankList[arg_54_1] or {}
end

function var_0_6.GetSelfRankData(arg_55_0, arg_55_1)
	if arg_55_0.selfRankData[arg_55_1].rankIndex then
		return arg_55_0.selfRankData[arg_55_1]
	end

	local var_55_0 = getProxy(PlayerProxy):getData()
	local var_55_1 = getProxy(GuildProxy):getData()
	local var_55_2 = arg_55_0.selfRankData[arg_55_1]
	local var_55_4 = {
		score = PlayRoomTools.GetPtScrore(arg_55_1)
	}
	local var_55_5 = {
		id = var_55_0.id,
		level = var_55_0.level,
		name = var_55_0.name
	}

	if var_55_1 then
		var_55_5.guild_name = var_55_1.name or ""
		var_55_5.display = var_55_0.displayInfo
		var_55_4.player = var_55_5

		var_55_3(var_55_2, var_55_4, 0)

		return arg_55_0.selfRankData[arg_55_1]
	end
end

return var_0_6
