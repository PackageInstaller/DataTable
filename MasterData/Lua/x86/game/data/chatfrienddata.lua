local var_0_0 = singletonClass("ChatFriendData")
local cjson = require("cjson")

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

function var_0_0:InitReadMsgCnt(arg_2_1)
	self.readMsgID_[arg_2_1] = self.readMsgID_[arg_2_1] or 0
end

function var_0_0:InitCacheChatList()
	for iter_3_0, iter_3_1 in pairs(self.chatRecordList_) do
		if not table.indexof(self.cacheHeroList_, iter_3_0) and self:GetUnreadMsgCnt(iter_3_0) > 0 then
			self.friendList_[iter_3_0] = {
				readSeek = 0,
				id = iter_3_0,
				timestamp = iter_3_1[#iter_3_1].timestamp
			}

			table.insert(self.cacheHeroList_, iter_3_0)
		end
	end

	table.sort(self.cacheHeroList_, function(arg_4_0, arg_4_1)
		return self.friendList_[arg_4_0].timestamp > self.friendList_[arg_4_1].timestamp
	end)
end

function var_0_0:AddCacheFriend(arg_5_1)
	if table.keyof(self.cacheHeroList_, arg_5_1) then
		return
	end

	table.insert(self.cacheHeroList_, 1, arg_5_1)

	self.friendList_[arg_5_1] = {
		reedSeek_ = 0,
		id = arg_5_1,
		timestamp = manager.time:GetServerTime()
	}
end

function var_0_0:GetCacheHeroList()
	return self.cacheHeroList_
end

function var_0_0:GetFriendList(arg_7_1)
	return self.friendList_[arg_7_1]
end

function var_0_0:GetAllFriendContent()
	return self.chatRecordList_
end

function var_0_0:GetFriendContent(arg_9_1)
	return self.chatRecordList_[arg_9_1] or {}
end

function var_0_0:AddChat(arg_10_1)
	local var_10_0

	if USER_ID == arg_10_1.chat_base_info.id then
		var_10_0 = arg_10_1.receive_uid or arg_10_1.chat_base_info.id
	end

	self.chatRecordList_[var_10_0] = self.chatRecordList_[var_10_0] or {}

	if self:IsOldMsg(var_10_0, arg_10_1.chat_base_info.msg_id) then
		return
	end

	if self.lockFriendID_ == var_10_0 then
		self:UpdateCacheFriendContent(arg_10_1)
	end

	local var_10_1 = self:ParseChat(arg_10_1)

	self:SaveRecord(var_10_1)
	table.insert(self.chatRecordList_[var_10_0], var_10_1)
	self:UpdateTimestamp(arg_10_1)
end

function var_0_0:IsOldMsg(arg_11_1, arg_11_2)
	for iter_11_0 = 0, 9 do
		if self.chatRecordList_[arg_11_1][((self.chatRecordList_[arg_11_1] or nil) and (#self.chatRecordList_[arg_11_1] or 0)) - iter_11_0] and self.chatRecordList_[arg_11_1][((self.chatRecordList_[arg_11_1] or nil) and (#self.chatRecordList_[arg_11_1] or 0)) - iter_11_0].msgID == arg_11_2 then
			return true
		end
	end

	return false
end

function var_0_0:DeleteInvalidContent(arg_12_1, arg_12_2)
	for iter_12_0 = 1, arg_12_2 do
		table.remove(self.chatRecordList_[arg_12_1], 1)
	end
end

function var_0_0.ParseChat(arg_13_0, arg_13_1)
	return {
		recall = false,
		msgID = arg_13_1.chat_base_info.msg_id,
		friendID = (USER_ID == arg_13_1.chat_base_info.id or nil) and (arg_13_1.receive_uid or arg_13_1.chat_base_info.id),
		senderID = arg_13_1.chat_base_info.id,
		timestamp = arg_13_1.chat_base_info.timestamp,
		contentType = arg_13_1.chat_base_info.type,
		content = arg_13_1.chat_base_info.content
	}
end

function var_0_0:UpdateTimestamp(arg_14_1)
	local var_14_0

	if USER_ID == arg_14_1.chat_base_info.id then
		var_14_0 = arg_14_1.receive_uid or arg_14_1.chat_base_info.id
	end

	table.removebyvalue(self.cacheHeroList_, var_14_0)
	table.insert(self.cacheHeroList_, 1, var_14_0)

	if self.friendList_[var_14_0] == nil then
		self.friendList_[var_14_0] = {
			reedSeek_ = 0,
			id = var_14_0,
			timestamp = arg_14_1.chat_base_info.timestamp
		}
	else
		self.friendList_[var_14_0].timestamp = arg_14_1.chat_base_info.timestamp
	end
end

function var_0_0:RemoveCacheHero(arg_15_1)
	table.removebyvalue(self.cacheHeroList_, arg_15_1)
end

function var_0_0:RemoveChatData(arg_16_1)
	self.chatRecordList_[arg_16_1] = {}
	self.cacheContentList_[arg_16_1] = {}
	self.historyTipsFlag_[arg_16_1] = false

	if self.lockFriendID_ == arg_16_1 then
		self.lockFriendID_ = 0
	end

	self.readMsgID_[arg_16_1] = 0

	saveData("chatFriend", "readMsgID_" .. arg_16_1, 0)
	ChatTools.DeleteFriendChatCache(arg_16_1)
end

function var_0_0:UpdateSeek(arg_17_1)
	self.friendList_[arg_17_1].readSeek = #self.chatRecordList_[arg_17_1]
end

function var_0_0:LockFriendID(arg_18_1)
	self.lockFriendID_ = arg_18_1

	if arg_18_1 ~= 0 then
		self:InitCacheFriendContent(arg_18_1)
	end
end

function var_0_0:SaveRecord(arg_19_1)
	self.chatSaveRecordList_[arg_19_1.friendID] = self.chatSaveRecordList_[arg_19_1.friendID] or {}

	table.insert(self.chatSaveRecordList_[arg_19_1.friendID], arg_19_1)
end

function var_0_0:SaveRecordCnt(arg_20_1, arg_20_2)
	local var_20_0 = self.cacheContentList_[arg_20_1][#self.cacheContentList_[arg_20_1] - (arg_20_2 or 0)]

	if self.cacheContentList_[arg_20_1][#self.cacheContentList_[arg_20_1] - (arg_20_2 or 0)] and (var_20_0.contentType == ChatConst.CHAT_CONTENT_TYPE.TEXT or var_20_0.contentType == ChatConst.CHAT_CONTENT_TYPE.STICKER) then
		self.readMsgID_[arg_20_1] = var_20_0.msgID

		saveData("chatFriend", "readMsgID_" .. arg_20_1, var_20_0.msgID)
	end
end

function var_0_0:RemoveFriendChatContent(arg_21_1, arg_21_2)
	local var_21_0 = 0

	if self.chatRecordList_[arg_21_2] == nil then
		return var_21_0
	end

	for iter_21_0, iter_21_1 in ipairs(self.chatRecordList_[arg_21_2]) do
		if iter_21_1.contentType == ChatConst.CHAT_CONTENT_TYPE.TEXT and iter_21_1.msgID == arg_21_1 then
			iter_21_1.recall = true

			ChatTools.ResaveFriendChatCache(arg_21_2)

			var_21_0 = iter_21_0

			break
		end
	end

	if self.cacheContentList_[arg_21_2] then
		for iter_21_2, iter_21_3 in ipairs(self.cacheContentList_[arg_21_2]) do
			if iter_21_3.contentType == ChatConst.CHAT_CONTENT_TYPE.TEXT and iter_21_3.msgID == arg_21_1 then
				if self.cacheContentList_[arg_21_2][iter_21_2 + 1] == nil and self.cacheContentList_[arg_21_2][iter_21_2 - 1] and self.cacheContentList_[arg_21_2][iter_21_2 - 1].contentType == ChatConst.CHAT_CONTENT_TYPE.HISTORY_TIPS then
					table.remove(self.cacheContentList_[arg_21_2], iter_21_2)
					table.remove(self.cacheContentList_[arg_21_2], iter_21_2 - 1)

					self.historyTipsFlag_[arg_21_2] = false

					break
				end

				table.remove(self.cacheContentList_[arg_21_2], iter_21_2)

				break
			end
		end
	end

	return var_21_0
end

function var_0_0:InitCacheFriendContent(arg_22_1)
	local var_22_1 = clone(self.chatRecordList_[arg_22_1] or {})

	self.historyTipsFlag_[arg_22_1] = false

	if self.readMsgID_ == 0 then
		self.historyTipsFlag_[arg_22_1] = true
	end

	for iter_22_0 = #var_22_1, 1, -1 do
		if self.readMsgID_[arg_22_1] ~= 0 and var_22_1[iter_22_0].msgID == self.readMsgID_[arg_22_1] and var_22_1[iter_22_0 + 1] then
			self.historyTipsFlag_[arg_22_1] = true

			table.insert(var_22_1, iter_22_0 + 1, {
				friendID = arg_22_1,
				contentType = ChatConst.CHAT_CONTENT_TYPE.HISTORY_TIPS
			})
		end

		if var_22_1[iter_22_0].recall == true then
			table.remove(var_22_1, iter_22_0)
		end
	end

	self.cacheContentList_[arg_22_1] = var_22_1
end

function var_0_0:UpdateCacheFriendContent(arg_23_1)
	local var_23_0

	if USER_ID == arg_23_1.chat_base_info.id then
		var_23_0 = arg_23_1.receive_uid or arg_23_1.chat_base_info.id

		if self.historyTipsFlag_[var_23_0] ~= true then
			if arg_23_1.chat_base_info.id ~= USER_ID then
				table.insert(self.cacheContentList_[var_23_0], {
					friendID = var_23_0,
					contentType = ChatConst.CHAT_CONTENT_TYPE.HISTORY_TIPS
				})
			end

			self.historyTipsFlag_[var_23_0] = true
		end
	end

	table.insert(self.cacheContentList_[var_23_0], self:ParseChat(arg_23_1))
end

function var_0_0:GetCacheContent(arg_24_1)
	return self.cacheContentList_[arg_24_1]
end

function var_0_0:GetUnreadMsgCnt(arg_25_1)
	if self.chatRecordList_[arg_25_1] then
		local var_25_0 = 0

		for iter_25_0 = #self.chatRecordList_[arg_25_1], 1, -1 do
			if self.chatRecordList_[arg_25_1][iter_25_0].msgID == self.readMsgID_[arg_25_1] then
				break
			end

			if self.chatRecordList_[arg_25_1][iter_25_0].recall == false and self.chatRecordList_[arg_25_1][iter_25_0].senderID == arg_25_1 then
				var_25_0 = var_25_0 + 1
			end
		end

		return var_25_0
	else
		return 0
	end
end

function var_0_0:GetLastMsgData(arg_26_1)
	if self.chatRecordList_[arg_26_1] then
		for iter_26_0 = #self.chatRecordList_[arg_26_1], 1, -1 do
			if self.chatRecordList_[arg_26_1][iter_26_0].recall == false then
				return self.chatRecordList_[arg_26_1][iter_26_0]
			end
		end
	end

	return {
		content = ""
	}
end

function var_0_0:GetSaveRecordList(arg_27_1)
	return self.chatSaveRecordList_[arg_27_1] or {}
end

function var_0_0:SetSaveRecordList(arg_28_1, arg_28_2)
	self.chatSaveRecordList_[arg_28_1] = arg_28_2
end

function var_0_0:InitFriendContnent(arg_29_1, arg_29_2)
	self.chatRecordList_[arg_29_1] = {}

	for iter_29_0, iter_29_1 in ipairs(arg_29_2) do
		table.insert(self.chatRecordList_[arg_29_1], iter_29_1)
	end

	self:InitCacheChatList()

	self.readMsgID_[arg_29_1] = self.chatRecordData_["readMsgID_" .. arg_29_1] or 0
end

return var_0_0
