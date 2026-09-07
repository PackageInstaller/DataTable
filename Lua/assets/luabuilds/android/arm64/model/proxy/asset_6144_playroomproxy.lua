local PlayRoomData = class("PlayRoomData")

function PlayRoomData:Ctor(arg_1_1)
	self.id = arg_1_1.id
	self.gameType = arg_1_1.game_type
	self.name = arg_1_1.name
	self.roomType = arg_1_1.type
	self.teamCnt = arg_1_1.player_num or 0
	self.viewerCnt = arg_1_1.viewer_num or 0
	self.roomState = arg_1_1.play_flag or PlayRoomConst.PLAY_ROOM_STATE.WAIT

	return
end

function PlayRoomData:GetPlayer(arg_2_1)
	return (self.playerDataList or nil) and (self.playerDataList[arg_2_1] or nil)
end

local PlayerData = class("PlayerData")

function PlayerData:Ctor(arg_3_1)
	self.id = arg_3_1.id
	self.level = arg_3_1.level
	self.name = arg_3_1.name
	self.guildName = arg_3_1.guild_name
	self.display = arg_3_1.display
	self.user_view = arg_3_1.user_view

	return
end

local PlayRoomInfoData = class("PlayRoomInfoData")

function PlayRoomInfoData:UpdateRoomData(arg_4_1)
	self.roomID = arg_4_1.id
	self.roomType = arg_4_1.type
	self.gameType = arg_4_1.game_type
	self.roomState = arg_4_1.play_flag or PlayRoomConst.PLAY_ROOM_STATE.WAIT

	self:UpdatePlayerList(arg_4_1.id, arg_4_1.player_list, arg_4_1.team_list, arg_4_1.ready_list)

	return
end

function PlayRoomInfoData:UpdatePlayerList(arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	self.playerList = {}
	self.playerDataList = {}

	for iter_5_0, iter_5_1 in ipairs(arg_5_2) do
		table.insert(self.playerList, iter_5_1.id)

		self.playerDataList[iter_5_1.id] = PlayerData.New(iter_5_1)
	end

	self.teamList = {}
	self.teamPosList = {}

	for iter_5_2, iter_5_3 in ipairs(arg_5_3) do
		self.teamPosList[iter_5_2] = {}

		for iter_5_4, iter_5_5 in ipairs(iter_5_3.user_id_list) do
			if iter_5_5 ~= 0 then
				table.insert(self.teamList, iter_5_5)
				table.insert(self.teamPosList[iter_5_2], iter_5_5)
			end
		end
	end

	self.readyList = {}

	for iter_5_6, iter_5_7 in ipairs(arg_5_4) do
		table.insert(self.readyList, iter_5_7)
	end

	self.viewerList = {}

	for iter_5_8, iter_5_9 in ipairs(self.playerList) do
		if not table.contains(self.teamList, iter_5_9) then
			table.insert(self.viewerList, iter_5_9)
		elseif iter_5_9 == arg_5_1 then
			table.insert(self.readyList, iter_5_9)
		end
	end

	return
end

function PlayRoomInfoData:GetPlayer(arg_6_1)
	return (self.playerDataList or nil) and (self.playerDataList[arg_6_1] or nil)
end

local MatchReadyRoom = class("MatchReadyRoom")

function MatchReadyRoom:UpdateRoomData(arg_7_1)
	self.gameType = arg_7_1.game_type
	self.endTimestamp = arg_7_1.time

	self:UpdatePlayerList(arg_7_1.player_list, arg_7_1.team_list, arg_7_1.ready_list)

	return
end

function MatchReadyRoom:UpdatePlayerList(arg_8_1, arg_8_2, arg_8_3)
	self.playerList = {}
	self.playerDataList = {}

	for iter_8_0, iter_8_1 in ipairs(arg_8_1) do
		table.insert(self.playerList, iter_8_1.id)

		self.playerDataList[iter_8_1.id] = PlayerData.New(iter_8_1)
	end

	self.teamList = {}
	self.teamPosList = {}

	for iter_8_2, iter_8_3 in ipairs(arg_8_2) do
		self.teamPosList[iter_8_2] = {}

		for iter_8_4, iter_8_5 in ipairs(iter_8_3.user_id_list) do
			if iter_8_5 ~= 0 then
				table.insert(self.teamList, iter_8_5)
				table.insert(self.teamPosList[iter_8_2], iter_8_5)
			end
		end
	end

	self.readyList = {}

	for iter_8_6, iter_8_7 in ipairs(arg_8_3) do
		table.insert(self.readyList, iter_8_7)
	end

	return
end

function MatchReadyRoom:GetPlayer(arg_9_1)
	return (self.playerDataList or nil) and (self.playerDataList[arg_9_1] or nil)
end

local GameLoadData = class("GameLoadData")

function GameLoadData:UpdateData(arg_10_1)
	self.gameType = arg_10_1.game_type
	self.isAllLoadOver = true

	self:UpdatePlayerList(arg_10_1.player_list, arg_10_1.team_list, arg_10_1.load_list)

	self.overTime = arg_10_1.time

	return
end

function GameLoadData:UpdatePlayerList(arg_11_1, arg_11_2, arg_11_3)
	self.playerList = {}
	self.playerDataList = {}

	for iter_11_0, iter_11_1 in ipairs(arg_11_1) do
		table.insert(self.playerList, iter_11_1.id)

		self.playerDataList[iter_11_1.id] = PlayerData.New(iter_11_1)
	end

	self.teamList = {}
	self.teamPosList = {}

	for iter_11_2, iter_11_3 in ipairs(arg_11_2) do
		self.teamPosList[iter_11_2] = {}

		for iter_11_4, iter_11_5 in ipairs(iter_11_3.user_id_list) do
			if iter_11_5 ~= 0 then
				table.insert(self.teamList, iter_11_5)
				table.insert(self.teamPosList[iter_11_2], iter_11_5)
			end
		end
	end

	self.loadList = {}

	for iter_11_6, iter_11_7 in ipairs(arg_11_3) do
		self.loadList[iter_11_7.user_id] = iter_11_7.load

		if iter_11_7.load < 100 then
			self.isAllLoadOver = false
		end
	end

	return
end

local RankData = class("RankData")

function RankData:UpdateData(arg_12_1, arg_12_2)
	self.playerData = PlayerData.New(arg_12_1.player)
	self.score = arg_12_1.score
	self.rankIndex = arg_12_2

	return
end

local PlayRoomProxy = class("PlayRoomProxy", import(".NetProxy"))

PlayRoomProxy.CHAT_MSG_UPDATE = "PlayRoomProxy.CHAT_MSG_UPDATE"

function PlayRoomProxy:register()
	self.playRoomList = {}

	self:on(23099, function(arg_14_0)
		if self.roomData == nil then
			return
		end

		self:UpdateRoomData(arg_14_0.room)

		return
	end)
	self:on(23096, function(arg_15_0)
		if arg_15_0.reason == 1 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("match_ui_room_out"))
		end

		if self.roomData and self.roomData.roomType == PlayRoomConst.PLAY_ROOM_TYPE.MATCH then
			if self.matchReadyRoom == nil then
				self:ExitRoom()
			else
				local var_15_0 = table.keyof(self.matchReadyRoom.readyList, (getProxy(PlayerProxy):getPlayerId()))

				self:ExitMatchReadyRoom()

				if self.matchStartTime then
					pg.GameTrackerMgr.GetInstance():Record(GameTrackerBuilder.BuildPlayRoomMatch("bar", 2, 1, pg.TimeMgr.GetInstance():GetServerTime() - self.matchStartTime, 2))

					self.matchStartTime = nil
				end

				self:sendNotification(GAME.PLAY_ROOM_EXIT_MATCH_READY_ROOM)

				if arg_15_0.reason == 3 then
					self:sendNotification(GAME.PLAY_ROOM_CREATE_ROOM, {
						type = PlayRoomConst.PLAY_ROOM_TYPE.MATCH,
						gameType = self.roomData.gameType
					})
					self:sendNotification(GAME.PLAY_ROOM_START_GAME)
				else
					self:ExitRoom()
				end
			end
		else
			self:ExitRoom()
			self:sendNotification(GAME.PLAY_ROOM_EXIT_ROOM_DONE)
		end

		return
	end)
	self:on(23097, function(arg_16_0)
		self:AddInviteList(arg_16_0)

		return
	end)
	self:on(23095, function(arg_17_0)
		self:UpdateMatchRoomData(arg_17_0)

		return
	end)
	self:on(23094, function(arg_18_0)
		self:UpdateGameLoadData(arg_18_0)

		return
	end)

	self.inviteList = {}
	self.inviteRecordList = {}

	self:on(50116, function(arg_19_0)
		self:AddChatMsg(arg_19_0)

		return
	end)

	self.chatMsgs = {}
	self.rankList = {}
	self.selfRankData = {}
	self.matchCD = 0
	self.isPlayingGame = false

	return
end

function PlayRoomProxy:GetPlayRoomList()
	return self.playRoomList
end

function PlayRoomProxy:UpdateRoomList(arg_21_1)
	self.playRoomList = {}

	for iter_21_0, iter_21_1 in ipairs(arg_21_1) do
		table.insert(self.playRoomList, PlayRoomData.New(iter_21_1))
	end

	return
end

function PlayRoomProxy:UpdateRoomData(arg_22_1)
	if self.roomData == nil then
		self.roomData = PlayRoomInfoData.New()

		self:ClearChatMsgList()
	end

	self.roomData:UpdateRoomData(arg_22_1)

	if not self.isPlayingGame then
		self:sendNotification(GAME.PLAY_ROOM_REDAY_ROOM_REFRESH)
	end

	return
end

function PlayRoomProxy:GetRoomData()
	return self.roomData
end

function PlayRoomProxy:ExitRoom()
	self:SetStartMatch(false)

	if self.matchStartTime then
		pg.GameTrackerMgr.GetInstance():Record(GameTrackerBuilder.BuildPlayRoomMatch("bar", 2, 1, pg.TimeMgr.GetInstance():GetServerTime() - self.matchStartTime, 1))

		self.matchStartTime = nil
	end

	self.roomData = nil

	return
end

function PlayRoomProxy:SetPlayingGameState(arg_25_1)
	self.isPlayingGame = arg_25_1

	return
end

function PlayRoomProxy:GetPlayingGameState()
	return self.isPlayingGame
end

function PlayRoomProxy:AddInviteList(arg_27_1)
	if self.roomData then
		pg.GameTrackerMgr.GetInstance():Record(GameTrackerBuilder.BuildPlayRoomInvate("bar", arg_27_1.invitor.id, 3))

		return
	end

	local var_27_0 = {
		roomData = PlayRoomData.New(arg_27_1.room),
		invitor = PlayerData.New(arg_27_1.invitor)
	}

	var_27_0.timestamp = pg.TimeMgr.GetInstance():GetServerTime()

	table.insert(self.inviteList, var_27_0)

	return
end

function PlayRoomProxy:GetInviteList()
	local var_28_0 = pg.TimeMgr.GetInstance():GetServerTime()

	for iter_28_0 = #self.inviteList, 1, -1 do
		if var_28_0 - self.inviteList[iter_28_0].timestamp > pg.gameset.match_refuseCD.key_value then
			table.remove(self.inviteList, 1)
		end
	end

	return self.inviteList
end

function PlayRoomProxy:RefuseInvite(arg_29_1)
	for iter_29_0, iter_29_1 in ipairs(self.inviteList) do
		if iter_29_1.roomData.id == arg_29_1 then
			table.remove(self.inviteList, iter_29_0)

			break
		end
	end

	return
end

function PlayRoomProxy:ClearInviteList()
	self.inviteList = {}

	return
end

function PlayRoomProxy:AddInviteRecord(arg_31_1)
	local var_31_0 = {
		id = arg_31_1
	}

	var_31_0.timestamp = pg.TimeMgr.GetInstance():GetServerTime()

	table.insert(self.inviteRecordList, var_31_0)

	return
end

function PlayRoomProxy:RemoveInviteRecord(arg_32_1)
	for iter_32_0, iter_32_1 in ipairs(self.inviteRecordList) do
		if iter_32_1.id == arg_32_1 then
			table.remove(self.inviteRecordList, iter_32_0)

			return
		end
	end

	return
end

function PlayRoomProxy:GetInviteRecordList()
	local var_33_0 = pg.TimeMgr.GetInstance():GetServerTime()

	for iter_33_0 = #self.inviteRecordList, 1, -1 do
		if var_33_0 >= self.inviteRecordList[iter_33_0].timestamp + pg.gameset.match_refuseCD.key_value then
			table.remove(self.inviteRecordList, iter_33_0)
		end
	end

	return self.inviteRecordList
end

function PlayRoomProxy:GetInviteRecordByID(arg_34_1)
	for iter_34_0, iter_34_1 in ipairs(self.inviteRecordList) do
		if iter_34_1.id == arg_34_1 then
			return iter_34_1
		end
	end

	return
end

function PlayRoomProxy:ClearInviteRecordList()
	self.inviteRecordList = {}

	return
end

function PlayRoomProxy:UpdateMatchRoomData(arg_36_1)
	local var_36_0 = false

	if self.matchReadyRoom == nil then
		var_36_0 = true
		self.matchReadyRoom = MatchReadyRoom.New()

		self:SetStartMatch(false)

		if self.matchStartTime then
			pg.GameTrackerMgr.GetInstance():Record(GameTrackerBuilder.BuildPlayRoomMatch("bar", 2, 1, pg.TimeMgr.GetInstance():GetServerTime() - self.matchStartTime, 3))

			self.matchStartTime = nil
		end
	end

	self.matchReadyRoom:UpdateRoomData(arg_36_1)

	if var_36_0 then
		self:sendNotification(GAME.PLAY_ROOM_MATCH_ENTER_READY_ROOM)
	else
		self:sendNotification(GAME.PLAY_ROOM_MATCH_REDAY_ROOM_REFRESH)
	end

	return
end

function PlayRoomProxy:GetMatchRoomData()
	return self.matchReadyRoom
end

function PlayRoomProxy:ExitMatchReadyRoom()
	self.matchReadyRoom = nil

	return
end

function PlayRoomProxy:GetMatchTime()
	return self.matchEndTime or 0
end

function PlayRoomProxy:SetStartMatch(arg_40_1)
	if arg_40_1 then
		self:RefreshMatchTime()
	else
		self.matchEndTime = nil
	end

	return
end

function PlayRoomProxy:GetMatchFlag()
	local var_41_0

	if self.matchReadyRoom == nil then
		if self:GetMatchTime() < pg.TimeMgr.GetInstance():GetServerTime() then
			var_41_0 = false

			goto label_41_0
		end
	end

	::label_41_0::

	return true
end

function PlayRoomProxy:RefreshMatchTime()
	self.matchStartTime = pg.TimeMgr.GetInstance():GetServerTime() - 1
	self.matchEndTime = self.matchStartTime + pg.gameset.level_get_proficency.key_value

	return
end

function PlayRoomProxy:GetMatchStarTime()
	return self.matchStartTime or pg.TimeMgr.GetInstance():GetServerTime()
end

function PlayRoomProxy:SetExitMatchFlag(arg_44_1)
	self.exitMatchFlag = arg_44_1 == 0

	return
end

function PlayRoomProxy:SetMatchCD(arg_45_1)
	if arg_45_1 <= 0 then
		return
	end

	self.matchCD = arg_45_1

	return
end

function PlayRoomProxy:GetMatchCD()
	return self.matchCD
end

function PlayRoomProxy:UpdateGameLoadData(arg_47_1)
	local var_47_0 = false

	if self.gameLoadData == nil then
		var_47_0 = true
		self.gameLoadData = GameLoadData.New()
	end

	self.gameLoadData:UpdateData(arg_47_1)

	if var_47_0 and self.roomData then
		self.roomData.roomState = PlayRoomConst.PLAY_ROOM_STATE.PLAYING

		self:ExitMatchReadyRoom()
		self:sendNotification(GAME.PLAY_ROOM_CLOSE_MATCH_READY)
		self:sendNotification(GAME.PLAY_ROOM_ENTER_LOAD)
	end

	if self.gameLoadData.isAllLoadOver then
		self.gameLoadData = nil

		self:sendNotification(GAME.PLAY_ROOM_ALL_LOAD_OVER)
		self:SetPlayingGameState(true)
	end

	return
end

function PlayRoomProxy:GetGameLoadData()
	return self.gameLoadData
end

function PlayRoomProxy:GetLoadOverTime()
	return self.gameLoadData.overTime
end

function PlayRoomProxy:AddChatMsg(arg_50_1)
	local var_50_0 = ChatMsg.New(ChatConst.ChannelPlayRoom, (ChatProxy.InjectPublicMsg(arg_50_1.content, Player.New(arg_50_1.player))))

	var_50_0.typePlayRoom = arg_50_1.type

	table.insert(self.chatMsgs, var_50_0)
	self:sendNotification(PlayRoomProxy.CHAT_MSG_UPDATE, {
		msg = var_50_0
	})

	return
end

function PlayRoomProxy:GetChatMsgs()
	return underscore.to_array(self.chatMsgs)
end

function PlayRoomProxy:ClearChatMsgList()
	self.chatMsgs = {}

	return
end

function PlayRoomProxy:UpdateRankData(arg_53_1, arg_53_2)
	self.rankList[arg_53_1] = {}
	self.selfRankData[arg_53_1] = RankData.New()

	local var_53_0 = getProxy(PlayerProxy):getPlayerId()

	for iter_53_0, iter_53_1 in ipairs(arg_53_2.rank_list) do
		local var_53_1 = RankData.New()

		var_53_1:UpdateData(iter_53_1, iter_53_0)
		table.insert(self.rankList[arg_53_1], var_53_1)

		if iter_53_1.player.id == var_53_0 then
			self.selfRankData[arg_53_1]:UpdateData(iter_53_1, iter_53_0)
		end
	end

	return
end

function PlayRoomProxy:GetRankData(arg_54_1)
	return self.rankList[arg_54_1] or {}
end

function PlayRoomProxy:GetSelfRankData(arg_55_1)
	if self.selfRankData[arg_55_1].rankIndex then
		return self.selfRankData[arg_55_1]
	end

	local var_55_0 = getProxy(PlayerProxy):getData()
	local var_55_1 = getProxy(GuildProxy):getData()
	local var_55_2 = {
		score = PlayRoomTools.GetPtScrore(arg_55_1)
	}
	local var_55_3 = {
		id = var_55_0.id,
		level = var_55_0.level,
		name = var_55_0.name
	}

	if var_55_1 then
		var_55_3.guild_name = var_55_1.name or ""
	end

	var_55_3.display = var_55_0.displayInfo
	var_55_2.player = var_55_3

	self.selfRankData[arg_55_1]:UpdateData(var_55_2, 0)

	return self.selfRankData[arg_55_1]
end

return PlayRoomProxy
