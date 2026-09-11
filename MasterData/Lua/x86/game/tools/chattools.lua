local var_0_0 = {}
local cjson = require("cjson")

var_0_0.defaultDirectory = Application.persistentDataPath

function var_0_0.LoadFriendLocalChatCache(arg_1_0)
	local var_1_0 = FileStreamMgr.inst:ReadlAllLine((var_0_0.GetFriendChatFile(arg_1_0)))
	local var_1_1 = {}

	for iter_1_0 = 0, var_1_0.Count - 1 do
		table.insert(var_1_1, cjson.decode(var_1_0[iter_1_0]))
	end

	ChatFriendData:InitFriendContnent(arg_1_0, var_1_1)
end

function var_0_0.GetFriendChatFile(arg_2_0)
	return string.format("%s/chat/%s/friend/%s.txt", var_0_0.defaultDirectory, PlayerData:GetPlayerInfo().userID, arg_2_0)
end

function var_0_0.SaveFriendsCache(arg_3_0)
	for iter_3_0, iter_3_1 in ipairs(arg_3_0) do
		var_0_0.SaveFriendChatCache(iter_3_1)
	end
end

function var_0_0.SaveFriendChatCache(arg_4_0)
	local var_4_0 = {}

	for iter_4_0, iter_4_1 in ipairs((ChatFriendData:GetSaveRecordList(arg_4_0))) do
		table.insert(var_4_0, cjson.encode(iter_4_1))
	end

	FileStreamMgr.inst:AppendLines(var_0_0.GetFriendChatFile(arg_4_0), var_4_0)
	ChatFriendData:SetSaveRecordList(arg_4_0, {})
end

function var_0_0.ResaveFriendChatCache(arg_5_0)
	local var_5_0 = ChatFriendData:GetFriendContent(arg_5_0)
	local var_5_1 = {}

	for iter_5_0 = #var_5_0, 1, -1 do
		table.insert(var_5_1, 1, cjson.encode(var_5_0[iter_5_0]))

		if GameSetting.chat_length_max.value[1] < #var_5_1 then
			break
		end
	end

	FileStreamMgr.inst:AppendLines(var_0_0.GetFriendChatFile(arg_5_0), var_5_1, false)
end

function var_0_0.DeleteFriendChatCache(arg_6_0)
	FileStreamMgr.inst:DeleteFile((var_0_0.GetFriendChatFile(arg_6_0)))
end

function var_0_0.DeleteFriendChatRecord(arg_7_0)
	if GameSetting.chat_length_max.value[1] + 20 < #ChatFriendData:GetFriendContent(arg_7_0) then
		var_0_0.ResaveFriendChatCache(arg_7_0)
	end
end

function var_0_0.LoadGuildLocalChatCache(arg_8_0)
	local var_8_0 = FileStreamMgr.inst:ReadlAllLine((var_0_0.GetGuildChatFile(arg_8_0)))
	local var_8_1 = {}

	for iter_8_0 = 0, var_8_0.Count - 1 do
		table.insert(var_8_1, cjson.decode(var_8_0[iter_8_0]))
	end

	ChatGuildData:InitGuildContnent(var_8_1)
end

function var_0_0.GetGuildChatFile(arg_9_0)
	return string.format("%s/chat/%s/guild/%s.txt", var_0_0.defaultDirectory, PlayerData:GetPlayerInfo().userID, arg_9_0)
end

function var_0_0.SaveGuildChatCache(arg_10_0)
	local var_10_0 = {}

	for iter_10_0, iter_10_1 in ipairs((ChatGuildData:GetSaveRecordList())) do
		table.insert(var_10_0, cjson.encode(iter_10_1))
	end

	FileStreamMgr.inst:AppendLines(var_0_0.GetGuildChatFile(arg_10_0), var_10_0)
	ChatGuildData:SetSaveRecordList({})
end

function var_0_0.ResaveGuildChatCache()
	local var_11_0 = GuildData:GetGuildInfo().id

	if var_11_0 == nil then
		return
	end

	local var_11_1 = ChatGuildData:GetContent()
	local var_11_2 = {}

	for iter_11_0 = #var_11_1, 1, -1 do
		table.insert(var_11_2, 1, cjson.encode(var_11_1[iter_11_0]))

		if GameSetting.chat_length_max.value[1] < #var_11_2 then
			break
		end
	end

	FileStreamMgr.inst:AppendLines(var_0_0.GetGuildChatFile(var_11_0), var_11_2, false)
end

function var_0_0.DeleteGuildChatCache()
	FileStreamMgr.inst:DeleteDirectory((string.format("%s/chat/%s/guild", var_0_0.defaultDirectory, PlayerData:GetPlayerInfo().userID)))
end

function var_0_0.DeleteGuildChatRecord(arg_13_0)
	if GameSetting.chat_length_max.value[1] + 20 < #ChatGuildData:GetContent() then
		var_0_0.ResaveGuildChatCache(arg_13_0)
	end
end

function var_0_0.LoadLocalChatCache(arg_14_0)
	local var_14_0 = FileStreamMgr.inst:ReadlAllLine((var_0_0.GetChannelChatFile(arg_14_0)))
	local var_14_1 = {}

	for iter_14_0 = 0, var_14_0.Count - 1 do
		table.insert(var_14_1, cjson.decode(var_14_0[iter_14_0]))
	end

	ChatChannelData:InitChannelContnent(arg_14_0, var_14_1)
end

function var_0_0.GetChannelChatFile(arg_15_0)
	return string.format("%s/chat/%s/channel/%s.txt", var_0_0.defaultDirectory, PlayerData:GetPlayerInfo().userID, arg_15_0)
end

function var_0_0.SaveChannelChatCache(arg_16_0)
	local var_16_0 = {}

	for iter_16_0, iter_16_1 in ipairs((ChatChannelData:GetSaveRecordList(arg_16_0))) do
		table.insert(var_16_0, cjson.encode(iter_16_1))
	end

	FileStreamMgr.inst:AppendLines(var_0_0.GetChannelChatFile(arg_16_0), var_16_0)
	ChatChannelData:SetSaveRecordList(arg_16_0, {})
end

function var_0_0.ResaveChannelChatCache(arg_17_0)
	local var_17_0 = ChatChannelData:GetContent(arg_17_0)
	local var_17_1 = {}

	for iter_17_0 = #var_17_0, 1, -1 do
		table.insert(var_17_1, 1, cjson.encode(var_17_0[iter_17_0]))

		if GameSetting.chat_length_max.value[1] < #var_17_1 then
			break
		end
	end

	FileStreamMgr.inst:AppendLines(var_0_0.GetChannelChatFile(arg_17_0), var_17_1, false)
end

function var_0_0.DeleteChannelChatCache(arg_18_0)
	FileStreamMgr.inst:DeleteFile((var_0_0.GetChannelChatFile(arg_18_0)))
end

function var_0_0.DeleteChannelChatRecord(arg_19_0)
	if GameSetting.chat_length_max.value[1] + 20 < #ChatChannelData:GetContent(arg_19_0) then
		var_0_0.ResaveChannelChatCache(arg_19_0)
	end
end

function var_0_0.IsOpenChatChannel(arg_20_0)
	local var_20_0 = ChatToggleCfg[arg_20_0]

	for iter_20_0, iter_20_1 in ipairs(ChatToggleCfg[arg_20_0].open_condition) do
		if not not JumpTools.IsConditionLocked(iter_20_1) then
			return false
		end
	end

	return ActivityTools.GetActivityStatus(var_20_0.activity_id) == 1
end

function var_0_0.ParseJumpLink(arg_21_0)
	arg_21_0 = arg_21_0 or ""

	local var_21_0 = {}

	for iter_21_0, iter_21_1 in ipairs((string.split(arg_21_0, "_"))) do
		var_21_0[#var_21_0 + 1] = tonumber(iter_21_1)
	end

	return var_21_0
end

function var_0_0.ParseChat(arg_22_0, arg_22_1)
	arg_22_0.msgID = arg_22_1.msg.msg_id
	arg_22_0.id = arg_22_1.msg.id
	arg_22_0.nick = arg_22_1.msg.user_profile_base.nick
	arg_22_0.icon = arg_22_1.msg.user_profile_base.icon
	arg_22_0.iconFrame = arg_22_1.msg.user_profile_base.icon_frame
	arg_22_0.timestamp = arg_22_1.msg.timestamp
	arg_22_0.contentType = arg_22_1.msg.type
	arg_22_0.content = arg_22_1.msg.content
	arg_22_0.recall = false
	arg_22_0.ip = arg_22_1.msg.ip_location or GetTips("IP_UNKNOWN")
	arg_22_0.bubbleID = arg_22_1.msg.chat_bubble or GameSetting.profile_chat_bubble_default.value[1]

	if arg_22_1.msg.jump_link then
		arg_22_0.jumpLink = ChatTools.ParseJumpLink(arg_22_1.msg.jump_link)
	end

	return true
end

return var_0_0
