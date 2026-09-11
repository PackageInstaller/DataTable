CooperationConst = {}
CooperationConst.State = {
	READY = 3,
	REPEAT = 2,
	COMMON = 4,
	ADJUSTMENT = 1
}
CooperationConst.INVITE_TYPE = {
	RECENT = 3,
	FRIEND = 1,
	GUILD = 2
}
CooperationConst.JOIN_ROOM_SOURCE = {
	INVET = 1,
	ROOM_ID = 0
}
CooperationRoomTemplate = class("CooperationRoomTemplate")

local var_0_0 = "0"

function CooperationRoomTemplate.Ctor(arg_1_0)
	arg_1_0.room_id = var_0_0
	arg_1_0.dest = -1
	arg_1_0.type = -1
	arg_1_0.available = true
	arg_1_0.activity_id = 0
	arg_1_0.room_player_id_list = {}
	arg_1_0.room_player_list = {}
end

function CooperationRoomTemplate:Init(arg_2_1)
	self.room_id = arg_2_1.room_id
	self.dest = arg_2_1.dest
	self.available = arg_2_1.available
	self.type = arg_2_1.type
	self.activity_id = arg_2_1.activity_id
	self.room_player_list = {}
	self.room_player_id_list = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1.player_list) do
		local var_2_0 = BattleTeamPlayerTemplate.New(iter_2_1)

		table.insert(self.room_player_id_list, var_2_0.playerID)

		self.room_player_list[var_2_0.playerID] = var_2_0
	end
end

function CooperationRoomTemplate:Update(arg_3_1)
	self.room_id = arg_3_1.room_id
	self.dest = arg_3_1.dest
	self.available = arg_3_1.available
	self.type = arg_3_1.type

	for iter_3_0, iter_3_1 in ipairs(arg_3_1.player_list) do
		if self.room_player_list[iter_3_1.player_id] then
			self.room_player_list[iter_3_1.player_id]:UpdateRoomData(iter_3_1.player_room_info)
		end
	end
end

function CooperationRoomTemplate:IsAvailable()
	return self.available
end

function CooperationRoomTemplate:GetRoomPlayerIdList()
	return clone(self.room_player_id_list)
end

function CooperationRoomTemplate:GetRoomPlayerData(arg_6_1)
	return self.room_player_list[arg_6_1]
end

function CooperationRoomTemplate:GetSelfHero()
	local var_7_0 = self.room_player_list[PlayerData:GetPlayerInfo().userID].heroList

	return var_7_0[1].id, var_7_0[1].trialID
end

function CooperationRoomTemplate:GetMasetPlayerId()
	for iter_8_0, iter_8_1 in pairs(self.room_player_list) do
		if iter_8_1.is_master == 1 then
			return iter_8_1.playerID
		end
	end

	return 0
end

function CooperationRoomTemplate:IsFull()
	return #self.room_player_list >= 3
end

function CooperationRoomTemplate:RepeatHero(arg_10_1)
	local var_10_0 = 0

	for iter_10_0, iter_10_1 in pairs(self.room_player_list) do
		if iter_10_1.heroList[1].id == arg_10_1 then
			var_10_0 = var_10_0 + 1
		end
	end

	return var_10_0 > 1
end

function CooperationRoomTemplate:GetBeLikedPlayerIds(arg_11_1)
	return (self.room_player_list[arg_11_1] or nil) and (self.room_player_list[arg_11_1].be_liked_uids or {})
end

CooperationInviteTemplate = class("CooperationInviteTemplate")

function CooperationInviteTemplate.Ctor(arg_12_0, arg_12_1)
	arg_12_0.invite_type = arg_12_1.type
	arg_12_0.uid = arg_12_1.uid
	arg_12_0.nick = arg_12_1.user_base_info.nick
	arg_12_0.icon = arg_12_1.user_base_info.icon
	arg_12_0.icon_frame = arg_12_1.user_base_info.icon_frame
	arg_12_0.level = arg_12_1.level
	arg_12_0.dest = arg_12_1.dest
	arg_12_0.timestamp = arg_12_1.timestamp
	arg_12_0.room_id = arg_12_1.room_id
	arg_12_0.refuse = false
	arg_12_0.battle_type = arg_12_1.battle_type
	arg_12_0.activity_id = arg_12_1.activity_id
end

function CooperationInviteTemplate.Refuse(arg_13_0)
	arg_13_0.refuse = true
end

function CooperationInviteTemplate:IsOverdue()
	return manager.time:GetServerTime() > self.timestamp + 300
end

CooperationRecentVisitTemplate = class("CooperationRecentVisitTemplate")

function CooperationRecentVisitTemplate.Ctor(arg_15_0, arg_15_1)
	arg_15_0.uid = arg_15_1.uid
	arg_15_0.nick = arg_15_1.user_base_info.nick
	arg_15_0.icon = arg_15_1.user_base_info.icon
	arg_15_0.icon_frame = arg_15_1.user_base_info.icon_frame
	arg_15_0.level = arg_15_1.level
	arg_15_0.timestamp = arg_15_1.timestamp
end
