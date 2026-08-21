FriendStruct = class("FriendStruct")

function FriendStruct.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.user_id = arg_1_1.user_id
	arg_1_0.online_state = arg_1_1.online_state or 0
	arg_1_0.sign = (arg_1_1.sign or ""):gsub("\n", "")
	arg_1_0.timestamp = arg_1_1.timestamp or 0
	arg_1_0.level = arg_1_1.level
	arg_1_0.bg = arg_1_1.info_background or 0
	arg_1_0.relationship = arg_1_2

	local var_1_0 = arg_1_1.base_info

	arg_1_0.nick = var_1_0 and var_1_0.nick or ""
	arg_1_0.icon = var_1_0 and var_1_0.icon or 0
	arg_1_0.icon_frame = var_1_0 and var_1_0.icon_frame or 0

	local var_1_1 = arg_1_1.ip_location

	arg_1_0.ip = (var_1_1 == nil or var_1_1 == "") and GetTips("IP_UNKNOWN") or var_1_1
	arg_1_0.bubbleID = arg_1_1.chat_bubble or GameSetting.profile_chat_bubble_default.value[1]

	local var_1_2, var_1_3, var_1_4 = FriendsData:GetChatInfo(arg_1_1.user_id)

	arg_1_0.lastChat = var_1_2
	arg_1_0.lastChatTime = var_1_3
	arg_1_0.unReadMsgCnt = var_1_4
	arg_1_0.isDeal = false
end

local var_0_0 = singletonClass("FriendsData")
local var_0_1 = {}
local var_0_2 = {}
local var_0_3 = {}
local var_0_4 = {}
local var_0_5 = {}
local var_0_6 = {}
local var_0_7 = {}
local var_0_8 = 100
local var_0_9 = {}
local var_0_10 = false
local var_0_11 = false

function var_0_0.Init(arg_2_0)
	var_0_1 = {}
	var_0_2 = {}
	var_0_3 = {}
	var_0_4 = {}
	var_0_5 = {}
	var_0_6 = {}
	var_0_9 = {}
	var_0_11 = false
end

function var_0_0.FriendsDataInit(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	var_0_10 = false
	var_0_2 = {}
	var_0_3 = {}
	var_0_4 = {}
	arg_3_3 = {}

	for iter_3_0, iter_3_1 in ipairs(arg_3_1) do
		local var_3_0 = var_0_1[iter_3_1.user_id]

		if not var_3_0 or var_3_0.relationship ~= FriendsConst.FRIEND_TYPE.MY_FRIENDS then
			var_0_1[iter_3_1.user_id] = FriendStruct.New(iter_3_1, FriendsConst.FRIEND_TYPE.MY_FRIENDS)
		end

		table.insert(var_0_2, iter_3_1.user_id)
		ChatTools.LoadFriendLocalChatCache(iter_3_1.user_id)
	end

	for iter_3_2, iter_3_3 in ipairs(arg_3_2) do
		local var_3_1 = var_0_1[iter_3_3.user_id]

		if not var_3_1 or var_3_1.relationship ~= FriendsConst.FRIEND_TYPE.MY_FRIENDS then
			var_0_1[iter_3_3.user_id] = FriendStruct.New(iter_3_3, FriendsConst.FRIEND_TYPE.FRIEND_REQUESTS)
		end

		table.insert(var_0_4, iter_3_3.user_id)
	end

	for iter_3_4, iter_3_5 in ipairs(arg_3_3) do
		local var_3_2 = var_0_1[iter_3_5]

		if not var_3_2 or var_3_2.relationship ~= FriendsConst.FRIEND_TYPE.BLACKLIST then
			var_0_1[iter_3_5] = FriendStruct.New({
				user_id = iter_3_5
			}, FriendsConst.FRIEND_TYPE.BLACKLIST)
		end

		table.insert(arg_3_3, iter_3_5)
	end
end

function var_0_0.RefreshFriendsDataList(arg_4_0, arg_4_1, arg_4_2)
	var_0_10 = true

	for iter_4_0, iter_4_1 in ipairs(arg_4_1) do
		arg_4_0:RefreshFriendsData(iter_4_1, arg_4_2)
	end
end

function var_0_0.RefreshFriendsData(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = arg_5_1.user_id
	local var_5_1 = var_0_1[var_5_0]

	if not var_5_1 then
		var_0_1[var_5_0] = FriendStruct.New(arg_5_1, arg_5_2)

		arg_5_0:InsertID(var_5_0, arg_5_2)
	else
		var_5_1.online_state = arg_5_1.online_state
		var_5_1.sign = (arg_5_1.sign or ""):gsub("\n", "")
		var_5_1.timestamp = arg_5_1.timestamp
		var_5_1.level = arg_5_1.level
		var_5_1.bg = arg_5_1.info_background or 0
		var_5_1.bubbleID = arg_5_1.chat_bubble or GameSetting.profile_chat_bubble_default.value[1]

		local var_5_2 = arg_5_1.base_info

		var_5_1.nick = var_5_2 and var_5_2.nick or ""
		var_5_1.icon = var_5_2 and var_5_2.icon or 0
		var_5_1.icon_frame = var_5_2 and var_5_2.icon_frame or 0

		local var_5_3 = arg_5_1.ip_location

		var_5_1.ip = (var_5_3 == nil or var_5_3 == "") and GetTips("IP_UNKNOWN") or var_5_3

		arg_5_0:DelectID(var_5_0)
		arg_5_0:InsertID(var_5_0, arg_5_2)

		var_5_1.relationship = arg_5_2
	end
end

function var_0_0.InsertID(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_2 == FriendsConst.FRIEND_TYPE.MY_FRIENDS then
		table.insert(var_0_2, arg_6_1)
	elseif arg_6_2 == FriendsConst.FRIEND_TYPE.NEW_FRIENDS then
		table.insert(var_0_3, arg_6_1)
	elseif arg_6_2 == FriendsConst.FRIEND_TYPE.FRIEND_REQUESTS then
		table.insert(var_0_4, arg_6_1)
	elseif arg_6_2 == FriendsConst.FRIEND_TYPE.BLACKLIST then
		table.insert(var_0_5, arg_6_1)
	elseif arg_6_2 == FriendsConst.FRIEND_TYPE.SEARCH then
		table.insert(var_0_6, arg_6_1)
	end
end

function var_0_0.DelectID(arg_7_0, arg_7_1)
	local var_7_0 = var_0_1[arg_7_1]

	if not var_7_0 then
		return
	end

	local var_7_1 = {}
	local var_7_2 = var_7_0.relationship

	if var_7_2 == FriendsConst.FRIEND_TYPE.MY_FRIENDS then
		var_7_1 = var_0_2
	elseif var_7_2 == FriendsConst.FRIEND_TYPE.NEW_FRIENDS then
		var_7_1 = var_0_3
	elseif var_7_2 == FriendsConst.FRIEND_TYPE.FRIEND_REQUESTS then
		var_7_1 = var_0_4
	elseif var_7_2 == FriendsConst.FRIEND_TYPE.BLACKLIST then
		var_7_1 = var_0_5
	elseif var_7_2 == FriendsConst.FRIEND_TYPE.SEARCH then
		var_7_1 = var_0_6
	end

	local var_7_3 = table.indexof(var_7_1, arg_7_1)

	if var_7_3 then
		table.remove(var_7_1, var_7_3)
	end
end

function var_0_0.DelectFriendsData(arg_8_0, arg_8_1)
	if not var_0_1[arg_8_1] then
		return
	end

	arg_8_0:DelectID(arg_8_1)

	var_0_7[arg_8_1] = nil
	var_0_1[arg_8_1] = nil

	arg_8_0:TryToRemoveRequest(arg_8_1)
end

function var_0_0.TryToRemoveRequest(arg_9_0, arg_9_1)
	local var_9_0 = table.indexof(var_0_9, arg_9_1)

	if var_9_0 then
		table.remove(var_0_9, var_9_0)
	end
end

function var_0_0.RequestToFriend(arg_10_0, arg_10_1)
	local var_10_0 = var_0_1[arg_10_1]

	if var_10_0 and (var_10_0.relationship == FriendsConst.FRIEND_TYPE.NEW_FRIENDS or var_10_0.relationship == FriendsConst.FRIEND_TYPE.SEARCH) then
		var_10_0.isDeal = true
	end
end

function var_0_0.TryToAddRequest(arg_11_0, arg_11_1)
	if #var_0_9 >= var_0_8 then
		table.remove(var_0_9, 1)
	end

	table.insert(var_0_9, arg_11_1)
end

function var_0_0.AllAcceptRequestList(arg_12_0, arg_12_1, arg_12_2)
	for iter_12_0, iter_12_1 in ipairs(arg_12_1) do
		arg_12_0:DealRequest(iter_12_1.user_id, arg_12_2, iter_12_1)
	end
end

function var_0_0.AllRefuseRequestList(arg_13_0)
	for iter_13_0 = #var_0_4, 1, -1 do
		local var_13_0 = var_0_4[iter_13_0]

		arg_13_0:DelectFriendsData(var_13_0)
	end
end

function var_0_0.DealRequest(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	if arg_14_2 == 1 then
		arg_14_0:DelectID(arg_14_1)

		local var_14_0 = var_0_1[arg_14_1]

		if not var_14_0 then
			var_0_1[arg_14_1] = FriendStruct.New(arg_14_3, FriendsConst.FRIEND_TYPE.MY_FRIENDS)
		else
			var_14_0.online_state = arg_14_3.online_state
			var_14_0.sign = (arg_14_3.sign or ""):gsub("\n", "")
			var_14_0.timestamp = arg_14_3.timestamp
			var_14_0.level = arg_14_3.level
			var_14_0.bg = arg_14_3.info_background or 0
			var_14_0.bubbleID = arg_14_3.chat_bubble or GameSetting.profile_chat_bubble_default.value[1]

			local var_14_1 = arg_14_3.base_info

			var_14_0.nick = var_14_1 and var_14_1.nick or ""
			var_14_0.icon = var_14_1 and var_14_1.icon or 0
			var_14_0.icon_frame = var_14_1 and var_14_1.icon_frame or 0

			local var_14_2 = arg_14_3.ip_location

			var_14_0.ip = (var_14_2 == nil or var_14_2 == "") and GetTips("IP_UNKNOWN") or var_14_2
			var_14_0.relationship = FriendsConst.FRIEND_TYPE.MY_FRIENDS
		end

		arg_14_0:InsertID(arg_14_1, FriendsConst.FRIEND_TYPE.MY_FRIENDS)
	else
		arg_14_0:DelectFriendsData(arg_14_1)
	end
end

function var_0_0.IsRequesting(arg_15_0)
	local var_15_0 = manager.time:GetServerTime()
	local var_15_1 = 0

	for iter_15_0, iter_15_1 in ipairs(var_0_4) do
		if var_15_0 - (var_0_1[iter_15_1].timestamp or 0) < 604800 then
			return true
		end
	end

	return false
end

function var_0_0.DelectFromBlackList(arg_16_0, arg_16_1, arg_16_2)
	if arg_16_2 == 1 then
		ShowTips("FRIEND_APPLY_SEND")

		local var_16_0 = var_0_1[arg_16_1]

		if var_16_0 then
			arg_16_0:RefreshFriendsData(var_16_0, FriendsConst.FRIEND_TYPE.NEW_FRIENDS)
			arg_16_0:RequestToFriend(arg_16_1)
			arg_16_0:TryToAddRequest(arg_16_1)
		end
	else
		arg_16_0:DelectFriendsData(arg_16_1)
	end
end

function var_0_0.SetSearchList(arg_17_0, arg_17_1)
	local var_17_0 = var_0_6[1]
	local var_17_1 = var_0_1[var_17_0]

	if var_17_1 and var_17_1.relationship == FriendsConst.FRIEND_TYPE.SEARCH then
		arg_17_0:DelectFriendsData(var_17_0)
	end

	var_0_6 = {}

	if arg_17_1 == nil then
		return
	end

	local var_17_2 = arg_17_1.user_id

	if not var_0_1[var_17_2] then
		var_0_1[var_17_2] = FriendStruct.New(arg_17_1, FriendsConst.FRIEND_TYPE.SEARCH)
	end

	arg_17_0:InsertID(var_17_2, FriendsConst.FRIEND_TYPE.SEARCH)
end

function var_0_0.RefreshNewFriendsList(arg_18_0, arg_18_1, arg_18_2)
	if arg_18_2 == 2 then
		for iter_18_0 = #var_0_3, 1, -1 do
			local var_18_0 = var_0_3[iter_18_0]

			arg_18_0:DelectFriendsData(var_18_0)
		end
	end

	arg_18_0:RefreshFriendsDataList(arg_18_1, FriendsConst.FRIEND_TYPE.NEW_FRIENDS)
end

function var_0_0.ChatInit(arg_19_0)
	var_0_7 = {}

	for iter_19_0, iter_19_1 in ipairs(var_0_2) do
		local var_19_0 = ChatFriendData:GetLastMsgData(iter_19_1)

		if var_19_0 ~= nil then
			local var_19_1 = var_19_0.content

			if var_19_0.contentType == ChatConst.CHAT_CONTENT_TYPE.STICKER then
				var_19_1 = string.format("[%s]", GetI18NText(ChatStickerCfg[tonumber(var_19_0.content)].name))
			end

			var_0_7[iter_19_1] = {
				lastChat = var_19_1,
				lastChatTime = var_19_0.timestamp,
				unReadMsgCnt = ChatFriendData:GetUnreadMsgCnt(iter_19_1)
			}
		end
	end
end

function var_0_0.GetChatList(arg_20_0)
	return var_0_7
end

function var_0_0.GetChatInfo(arg_21_0, arg_21_1)
	if var_0_7[arg_21_1] ~= nil then
		return var_0_7[arg_21_1].lastChat, var_0_7[arg_21_1].lastChatTime, var_0_7[arg_21_1].unReadMsgCnt
	end

	return "", nil, 0
end

function var_0_0.RefreshChat(arg_22_0, arg_22_1, arg_22_2, arg_22_3)
	if var_0_7[arg_22_1] then
		var_0_7[arg_22_1].lastChat = arg_22_2
		var_0_7[arg_22_1].lastChatTime = arg_22_3
	else
		var_0_7[arg_22_1] = {
			unReadMsgCnt = 0,
			lastChat = arg_22_2,
			lastChatTime = arg_22_3
		}
	end
end

function var_0_0.RefreshUnread(arg_23_0, arg_23_1, arg_23_2)
	if var_0_7[arg_23_1] then
		var_0_7[arg_23_1].unReadMsgCnt = arg_23_2
	else
		var_0_7[arg_23_1] = {
			lastChat = "",
			unReadMsgCnt = arg_23_2
		}
	end
end

function var_0_0.IsCanBeFriend(arg_24_0, arg_24_1)
	if arg_24_1 == tostring(PlayerData:GetPlayerInfo().userID) then
		ShowTips("CANNOT_ADD_SELF")

		return false
	end

	local var_24_0 = var_0_1[arg_24_1]

	if var_24_0 and var_24_0.relationship == FriendsConst.FRIEND_TYPE.MY_FRIENDS then
		ShowTips("ERROR_FRIEND_EXIST_FRIEND")

		return false
	end

	if #var_0_2 >= GameSetting.user_friend_num_max.value[1] then
		ShowTips("ERROR_FRIEND_NUM_LIMIT_ME")

		return false
	end

	if var_24_0 and var_24_0.relationship == FriendsConst.FRIEND_TYPE.BLACKLIST then
		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = GetTips("ADD_BLACKLIST_FRIEND_COMFIRMATION"),
			OkCallback = function()
				FriendsAction:TryToDelectFromBlackList(arg_24_1, 1)
			end
		})

		return false
	end

	return true
end

function var_0_0.IsCanBeBlackList(arg_26_0, arg_26_1)
	if #var_0_5 >= GameSetting.user_black_num_max.value[1] then
		ShowTips("FRIEND_MOVE_TO_BLACLIST_NOTE_LIMIT")

		return false
	end

	local var_26_0 = var_0_1[arg_26_1]

	if var_26_0 and var_26_0.relationship == FriendsConst.FRIEND_TYPE.BLACKLIST then
		ShowTips("ERROR_FRIEND_EXIST_BLACK_TARGET")

		return false
	end

	return true
end

function var_0_0.GetList(arg_27_0, arg_27_1)
	if arg_27_1 == FriendsConst.FRIEND_TYPE.MY_FRIENDS then
		return var_0_2
	elseif arg_27_1 == FriendsConst.FRIEND_TYPE.NEW_FRIENDS then
		return var_0_3
	elseif arg_27_1 == FriendsConst.FRIEND_TYPE.FRIEND_REQUESTS then
		local var_27_0 = {}
		local var_27_1 = manager.time:GetServerTime()

		for iter_27_0 = #var_0_4, 1, -1 do
			local var_27_2 = var_0_4[iter_27_0]

			if var_27_1 - var_0_1[var_27_2].timestamp > 604800 then
				arg_27_0:DelectFriendsData(var_27_2)
			else
				table.insert(var_27_0, var_27_2)
			end
		end

		return var_0_4
	elseif arg_27_1 == FriendsConst.FRIEND_TYPE.BLACKLIST then
		return var_0_5
	elseif arg_27_1 == FriendsConst.FRIEND_TYPE.SEARCH then
		return var_0_6
	end
end

function var_0_0.GetListLength(arg_28_0, arg_28_1)
	if arg_28_1 == FriendsConst.FRIEND_TYPE.MY_FRIENDS then
		return #var_0_2
	elseif arg_28_1 == FriendsConst.FRIEND_TYPE.NEW_FRIENDS then
		return #var_0_3
	elseif arg_28_1 == FriendsConst.FRIEND_TYPE.FRIEND_REQUESTS then
		return #var_0_4
	elseif arg_28_1 == FriendsConst.FRIEND_TYPE.BLACKLIST then
		return #var_0_5
	elseif arg_28_1 == FriendsConst.FRIEND_TYPE.SEARCH then
		return #var_0_6
	end
end

function var_0_0.GetInfoByID(arg_29_0, arg_29_1)
	local var_29_0 = var_0_1[arg_29_1]

	return var_29_0 ~= nil and var_29_0 or false
end

function var_0_0.GetFriendsOnLineCount(arg_30_0)
	local var_30_0 = 0

	for iter_30_0, iter_30_1 in ipairs(var_0_2) do
		if var_0_1[iter_30_1].online_state == 0 then
			var_30_0 = var_30_0 + 1
		end
	end

	return var_30_0
end

function var_0_0.GetFreshFlag(arg_31_0)
	return var_0_10
end

function var_0_0.IsInRequest(arg_32_0, arg_32_1)
	return table.indexof(var_0_9, arg_32_1) ~= false
end

function var_0_0.IsFriend(arg_33_0, arg_33_1)
	return var_0_1[arg_33_1] and var_0_1[arg_33_1].relationship == FriendsConst.FRIEND_TYPE.MY_FRIENDS
end

function var_0_0.GetHadFreshNewFriend(arg_34_0)
	return var_0_11
end

return var_0_0
