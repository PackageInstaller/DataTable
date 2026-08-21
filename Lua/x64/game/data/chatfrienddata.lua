local var_0_0 = singletonClass("ChatFriendData")
local var_0_1 = require("cjson")

function var_0_0.Init(arg_1_0)
	arg_1_0.chatRecordData_ = getModule("chatFriend")
	arg_1_0.chatSaveRecordList_ = {}
	arg_1_0.readMsgID_ = {}
	arg_1_0.historyTipsFlag_ = {}
	arg_1_0.lockFriendID_ = 0
	arg_1_0.chatRecordList_ = {}
	arg_1_0.friendList_ = {}
	arg_1_0.cacheHeroList_ = {}
	arg_1_0.cacheContentList_ = {}
end

function var_0_0.InitReadMsgCnt(arg_2_0, arg_2_1)
	arg_2_0.readMsgID_[arg_2_1] = arg_2_0.readMsgID_[arg_2_1] or 0
end

function var_0_0.InitCacheChatList(arg_3_0)
	for iter_3_0, iter_3_1 in pairs(arg_3_0.chatRecordList_) do
		if not table.indexof(arg_3_0.cacheHeroList_, iter_3_0) and arg_3_0:GetUnreadMsgCnt(iter_3_0) > 0 then
			arg_3_0.friendList_[iter_3_0] = {
				readSeek = 0,
				id = iter_3_0,
				timestamp = iter_3_1[#iter_3_1].timestamp
			}

			table.insert(arg_3_0.cacheHeroList_, iter_3_0)
		end
	end

	table.sort(arg_3_0.cacheHeroList_, function(arg_4_0, arg_4_1)
		return arg_3_0.friendList_[arg_4_0].timestamp > arg_3_0.friendList_[arg_4_1].timestamp
	end)
end

function var_0_0.AddCacheFriend(arg_5_0, arg_5_1)
	if table.keyof(arg_5_0.cacheHeroList_, arg_5_1) then
		return
	end

	table.insert(arg_5_0.cacheHeroList_, 1, arg_5_1)

	arg_5_0.friendList_[arg_5_1] = {
		reedSeek_ = 0,
		id = arg_5_1,
		timestamp = manager.time:GetServerTime()
	}
end

function var_0_0.GetCacheHeroList(arg_6_0)
	return arg_6_0.cacheHeroList_
end

function var_0_0.GetFriendList(arg_7_0, arg_7_1)
	return arg_7_0.friendList_[arg_7_1]
end

function var_0_0.GetAllFriendContent(arg_8_0)
	return arg_8_0.chatRecordList_
end

function var_0_0.GetFriendContent(arg_9_0, arg_9_1)
	return arg_9_0.chatRecordList_[arg_9_1] or {}
end

function var_0_0.AddChat(arg_10_0, arg_10_1)
	local var_10_0 = USER_ID == arg_10_1.chat_base_info.id and arg_10_1.receive_uid or arg_10_1.chat_base_info.id

	arg_10_0.chatRecordList_[var_10_0] = arg_10_0.chatRecordList_[var_10_0] or {}

	if arg_10_0:IsOldMsg(var_10_0, arg_10_1.chat_base_info.msg_id) then
		return
	end

	if arg_10_0.lockFriendID_ == var_10_0 then
		arg_10_0:UpdateCacheFriendContent(arg_10_1)
	end

	local var_10_1 = arg_10_0:ParseChat(arg_10_1)

	arg_10_0:SaveRecord(var_10_1)
	table.insert(arg_10_0.chatRecordList_[var_10_0], var_10_1)
	arg_10_0:UpdateTimestamp(arg_10_1)
end

function var_0_0.IsOldMsg(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = arg_11_0.chatRecordList_[arg_11_1] and #arg_11_0.chatRecordList_[arg_11_1] or 0

	for iter_11_0 = 0, 9 do
		local var_11_1 = arg_11_0.chatRecordList_[arg_11_1][var_11_0 - iter_11_0]

		if var_11_1 and var_11_1.msgID == arg_11_2 then
			return true
		end
	end

	return false
end

function var_0_0.DeleteInvalidContent(arg_12_0, arg_12_1, arg_12_2)
	for iter_12_0 = 1, arg_12_2 do
		table.remove(arg_12_0.chatRecordList_[arg_12_1], 1)
	end
end

function var_0_0.ParseChat(arg_13_0, arg_13_1)
	local var_13_0 = USER_ID == arg_13_1.chat_base_info.id and arg_13_1.receive_uid or arg_13_1.chat_base_info.id

	return {
		recall = false,
		msgID = arg_13_1.chat_base_info.msg_id,
		friendID = var_13_0,
		senderID = arg_13_1.chat_base_info.id,
		timestamp = arg_13_1.chat_base_info.timestamp,
		contentType = arg_13_1.chat_base_info.type,
		content = arg_13_1.chat_base_info.content
	}
end

function var_0_0.UpdateTimestamp(arg_14_0, arg_14_1)
	local var_14_0 = USER_ID == arg_14_1.chat_base_info.id and arg_14_1.receive_uid or arg_14_1.chat_base_info.id

	table.removebyvalue(arg_14_0.cacheHeroList_, var_14_0)
	table.insert(arg_14_0.cacheHeroList_, 1, var_14_0)

	if arg_14_0.friendList_[var_14_0] == nil then
		arg_14_0.friendList_[var_14_0] = {
			reedSeek_ = 0,
			id = var_14_0,
			timestamp = arg_14_1.chat_base_info.timestamp
		}
	else
		arg_14_0.friendList_[var_14_0].timestamp = arg_14_1.chat_base_info.timestamp
	end
end

function var_0_0.RemoveCacheHero(arg_15_0, arg_15_1)
	table.removebyvalue(arg_15_0.cacheHeroList_, arg_15_1)
end

function var_0_0.RemoveChatData(arg_16_0, arg_16_1)
	arg_16_0.chatRecordList_[arg_16_1] = {}
	arg_16_0.cacheContentList_[arg_16_1] = {}
	arg_16_0.historyTipsFlag_[arg_16_1] = false

	if arg_16_0.lockFriendID_ == arg_16_1 then
		arg_16_0.lockFriendID_ = 0
	end

	arg_16_0.readMsgID_[arg_16_1] = 0

	saveData("chatFriend", "readMsgID_" .. arg_16_1, 0)
	ChatTools.DeleteFriendChatCache(arg_16_1)
end

function var_0_0.UpdateSeek(arg_17_0, arg_17_1)
	arg_17_0.friendList_[arg_17_1].readSeek = #arg_17_0.chatRecordList_[arg_17_1]
end

function var_0_0.LockFriendID(arg_18_0, arg_18_1)
	arg_18_0.lockFriendID_ = arg_18_1

	if arg_18_1 ~= 0 then
		arg_18_0:InitCacheFriendContent(arg_18_1)
	end
end

function var_0_0.SaveRecord(arg_19_0, arg_19_1)
	arg_19_0.chatSaveRecordList_[arg_19_1.friendID] = arg_19_0.chatSaveRecordList_[arg_19_1.friendID] or {}

	table.insert(arg_19_0.chatSaveRecordList_[arg_19_1.friendID], arg_19_1)
end

function var_0_0.SaveRecordCnt(arg_20_0, arg_20_1, arg_20_2)
	local var_20_0 = arg_20_2 or 0
	local var_20_1 = arg_20_0.cacheContentList_[arg_20_1][#arg_20_0.cacheContentList_[arg_20_1] - var_20_0]

	if var_20_1 and (var_20_1.contentType == ChatConst.CHAT_CONTENT_TYPE.TEXT or var_20_1.contentType == ChatConst.CHAT_CONTENT_TYPE.STICKER) then
		arg_20_0.readMsgID_[arg_20_1] = var_20_1.msgID

		saveData("chatFriend", "readMsgID_" .. arg_20_1, var_20_1.msgID)
	end
end

function var_0_0.RemoveFriendChatContent(arg_21_0, arg_21_1, arg_21_2)
	local var_21_0 = 0

	if arg_21_0.chatRecordList_[arg_21_2] == nil then
		return var_21_0
	end

	for iter_21_0, iter_21_1 in ipairs(arg_21_0.chatRecordList_[arg_21_2]) do
		if iter_21_1.contentType == ChatConst.CHAT_CONTENT_TYPE.TEXT and iter_21_1.msgID == arg_21_1 then
			iter_21_1.recall = true

			ChatTools.ResaveFriendChatCache(arg_21_2)

			var_21_0 = iter_21_0

			break
		end
	end

	if arg_21_0.cacheContentList_[arg_21_2] then
		for iter_21_2, iter_21_3 in ipairs(arg_21_0.cacheContentList_[arg_21_2]) do
			if iter_21_3.contentType == ChatConst.CHAT_CONTENT_TYPE.TEXT and iter_21_3.msgID == arg_21_1 then
				if arg_21_0.cacheContentList_[arg_21_2][iter_21_2 + 1] == nil and arg_21_0.cacheContentList_[arg_21_2][iter_21_2 - 1] and arg_21_0.cacheContentList_[arg_21_2][iter_21_2 - 1].contentType == ChatConst.CHAT_CONTENT_TYPE.HISTORY_TIPS then
					table.remove(arg_21_0.cacheContentList_[arg_21_2], iter_21_2)
					table.remove(arg_21_0.cacheContentList_[arg_21_2], iter_21_2 - 1)

					arg_21_0.historyTipsFlag_[arg_21_2] = false

					break
				end

				table.remove(arg_21_0.cacheContentList_[arg_21_2], iter_21_2)

				break
			end
		end
	end

	return var_21_0
end

function var_0_0.InitCacheFriendContent(arg_22_0, arg_22_1)
	local var_22_0 = clone(arg_22_0.chatRecordList_[arg_22_1] or {})

	arg_22_0.historyTipsFlag_[arg_22_1] = false

	if arg_22_0.readMsgID_ == 0 then
		arg_22_0.historyTipsFlag_[arg_22_1] = true
	end

	for iter_22_0 = #var_22_0, 1, -1 do
		if arg_22_0.readMsgID_[arg_22_1] ~= 0 and var_22_0[iter_22_0].msgID == arg_22_0.readMsgID_[arg_22_1] and var_22_0[iter_22_0 + 1] then
			arg_22_0.historyTipsFlag_[arg_22_1] = true

			table.insert(var_22_0, iter_22_0 + 1, {
				friendID = arg_22_1,
				contentType = ChatConst.CHAT_CONTENT_TYPE.HISTORY_TIPS
			})
		end

		if var_22_0[iter_22_0].recall == true then
			table.remove(var_22_0, iter_22_0)
		end
	end

	arg_22_0.cacheContentList_[arg_22_1] = var_22_0
end

function var_0_0.UpdateCacheFriendContent(arg_23_0, arg_23_1)
	local var_23_0 = USER_ID
	local var_23_1 = var_23_0 == arg_23_1.chat_base_info.id and arg_23_1.receive_uid or arg_23_1.chat_base_info.id

	if arg_23_0.historyTipsFlag_[var_23_1] ~= true then
		if arg_23_1.chat_base_info.id ~= var_23_0 then
			table.insert(arg_23_0.cacheContentList_[var_23_1], {
				friendID = var_23_1,
				contentType = ChatConst.CHAT_CONTENT_TYPE.HISTORY_TIPS
			})
		end

		arg_23_0.historyTipsFlag_[var_23_1] = true
	end

	table.insert(arg_23_0.cacheContentList_[var_23_1], arg_23_0:ParseChat(arg_23_1))
end

function var_0_0.GetCacheContent(arg_24_0, arg_24_1)
	return arg_24_0.cacheContentList_[arg_24_1]
end

function var_0_0.GetUnreadMsgCnt(arg_25_0, arg_25_1)
	if arg_25_0.chatRecordList_[arg_25_1] then
		local var_25_0 = 0

		for iter_25_0 = #arg_25_0.chatRecordList_[arg_25_1], 1, -1 do
			if arg_25_0.chatRecordList_[arg_25_1][iter_25_0].msgID == arg_25_0.readMsgID_[arg_25_1] then
				break
			end

			if arg_25_0.chatRecordList_[arg_25_1][iter_25_0].recall == false and arg_25_0.chatRecordList_[arg_25_1][iter_25_0].senderID == arg_25_1 then
				var_25_0 = var_25_0 + 1
			end
		end

		return var_25_0
	else
		return 0
	end
end

function var_0_0.GetLastMsgData(arg_26_0, arg_26_1)
	if arg_26_0.chatRecordList_[arg_26_1] then
		for iter_26_0 = #arg_26_0.chatRecordList_[arg_26_1], 1, -1 do
			if arg_26_0.chatRecordList_[arg_26_1][iter_26_0].recall == false then
				return arg_26_0.chatRecordList_[arg_26_1][iter_26_0]
			end
		end
	end

	return {
		content = ""
	}
end

function var_0_0.GetSaveRecordList(arg_27_0, arg_27_1)
	return arg_27_0.chatSaveRecordList_[arg_27_1] or {}
end

function var_0_0.SetSaveRecordList(arg_28_0, arg_28_1, arg_28_2)
	arg_28_0.chatSaveRecordList_[arg_28_1] = arg_28_2
end

function var_0_0.InitFriendContnent(arg_29_0, arg_29_1, arg_29_2)
	arg_29_0.chatRecordList_[arg_29_1] = {}

	for iter_29_0, iter_29_1 in ipairs(arg_29_2) do
		table.insert(arg_29_0.chatRecordList_[arg_29_1], iter_29_1)
	end

	arg_29_0:InitCacheChatList()

	arg_29_0.readMsgID_[arg_29_1] = arg_29_0.chatRecordData_["readMsgID_" .. arg_29_1] or 0
end

return var_0_0
