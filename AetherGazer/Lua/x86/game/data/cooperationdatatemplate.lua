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

function CooperationRoomTemplate.Init(arg_2_0, arg_2_1)
	arg_2_0.room_id = arg_2_1.room_id
	arg_2_0.dest = arg_2_1.dest
	arg_2_0.available = arg_2_1.available
	arg_2_0.type = arg_2_1.type
	arg_2_0.activity_id = arg_2_1.activity_id
	arg_2_0.room_player_list = {}
	arg_2_0.room_player_id_list = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1.player_list) do
		local var_2_0 = BattleTeamPlayerTemplate.New(iter_2_1)
		local var_2_1 = var_2_0.playerID

		table.insert(arg_2_0.room_player_id_list, var_2_1)

		arg_2_0.room_player_list[var_2_1] = var_2_0
	end
end

function CooperationRoomTemplate.Update(arg_3_0, arg_3_1)
	arg_3_0.room_id = arg_3_1.room_id
	arg_3_0.dest = arg_3_1.dest
	arg_3_0.available = arg_3_1.available
	arg_3_0.type = arg_3_1.type

	for iter_3_0, iter_3_1 in ipairs(arg_3_1.player_list) do
		local var_3_0 = iter_3_1.player_id
		local var_3_1 = arg_3_0.room_player_list[var_3_0]

		if var_3_1 then
			var_3_1:UpdateRoomData(iter_3_1.player_room_info)
		end
	end
end

function CooperationRoomTemplate.IsAvailable(arg_4_0)
	return arg_4_0.available
end

function CooperationRoomTemplate.GetRoomPlayerIdList(arg_5_0)
	return clone(arg_5_0.room_player_id_list)
end

function CooperationRoomTemplate.GetRoomPlayerData(arg_6_0, arg_6_1)
	return arg_6_0.room_player_list[arg_6_1]
end

function CooperationRoomTemplate.GetSelfHero(arg_7_0)
	local var_7_0 = PlayerData:GetPlayerInfo().userID
	local var_7_1 = arg_7_0.room_player_list[var_7_0].heroList

	return var_7_1[1].id, var_7_1[1].trialID
end

function CooperationRoomTemplate.GetMasetPlayerId(arg_8_0)
	for iter_8_0, iter_8_1 in pairs(arg_8_0.room_player_list) do
		if iter_8_1.is_master == 1 then
			return iter_8_1.playerID
		end
	end

	return 0
end

function CooperationRoomTemplate.IsFull(arg_9_0)
	return #arg_9_0.room_player_list >= 3
end

function CooperationRoomTemplate.RepeatHero(arg_10_0, arg_10_1)
	local var_10_0 = 0

	for iter_10_0, iter_10_1 in pairs(arg_10_0.room_player_list) do
		if iter_10_1.heroList[1].id == arg_10_1 then
			var_10_0 = var_10_0 + 1
		end
	end

	return var_10_0 > 1
end

function CooperationRoomTemplate.GetBeLikedPlayerIds(arg_11_0, arg_11_1)
	return arg_11_0.room_player_list[arg_11_1] and arg_11_0.room_player_list[arg_11_1].be_liked_uids or {}
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

function CooperationInviteTemplate.IsOverdue(arg_14_0)
	return manager.time:GetServerTime() > arg_14_0.timestamp + 300
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
