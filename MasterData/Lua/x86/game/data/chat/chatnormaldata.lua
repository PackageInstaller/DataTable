local ChatNormalData = class("ChatNormalData")

function ChatNormalData:Ctor(arg_1_1)
	self.chatType_ = arg_1_1
	self.chatRecordData_ = getModule("chatGuild" .. arg_1_1)
	self.chatSaveRecordList_ = {}
	self.chatRecordList_ = {}
	self.readMsgID_ = 0
	self.historyTipsFlag_ = false
	self.cacheContentList_ = {}
end

function ChatNormalData:GetContent()
	return self.chatRecordList_
end

function ChatNormalData:AddChat(arg_3_1)
	if self:IsOldMsg(arg_3_1.msg.msg_id) then
		return
	end

	local var_3_0 = self:ParseChat(arg_3_1)

	self:SaveRecord(var_3_0)
	table.insert(self.chatRecordList_, var_3_0)
	self:UpdateCacheContent(arg_3_1)
end

function ChatNormalData:IsOldMsg(arg_4_1)
	for iter_4_0 = 0, 9 do
		if self.chatRecordList_[((self.chatRecordList_ or nil) and (#self.chatRecordList_ or 0)) - iter_4_0] and self.chatRecordList_[((self.chatRecordList_ or nil) and (#self.chatRecordList_ or 0)) - iter_4_0].msgID == arg_4_1 then
			return true
		end
	end

	return false
end

function ChatNormalData:ParseChat(arg_5_1)
	local var_5_0 = {}

	ChatTools.ParseChat(var_5_0, arg_5_1)

	return var_5_0
end

function ChatNormalData:RemoveChatData()
	self.chatRecordList_ = {}
	self.cacheContentList_ = {}
	self.historyTipsFlag_ = false
	self.readMsgID_ = 0

	saveData("chatGuild" .. self.chatType_, "readMsgID", 0)
	ChatTools.DeleteChannelChatCache(self.chatType_)
end

function ChatNormalData:SaveRecord(arg_7_1)
	self.chatSaveRecordList_ = self.chatSaveRecordList_ or {}

	table.insert(self.chatSaveRecordList_, arg_7_1)
end

function ChatNormalData:SaveRecordCnt(arg_8_1)
	local var_8_0 = self.cacheContentList_[#self.cacheContentList_ - (arg_8_1 or 0)]

	if self.cacheContentList_[#self.cacheContentList_ - (arg_8_1 or 0)] and (var_8_0.contentType == ChatConst.CHAT_CONTENT_TYPE.TEXT or var_8_0.contentType == ChatConst.CHAT_CONTENT_TYPE.STICKER) then
		self.readMsgID_ = var_8_0.msgID

		local var_8_1 = #self.chatSaveRecordList_

		for iter_8_0 = #self.chatSaveRecordList_, 1, -1 do
			if self.chatSaveRecordList_[iter_8_0] and self.chatSaveRecordList_[iter_8_0].msgID == var_8_0.msgID then
				var_8_1 = iter_8_0

				break
			end
		end

		local var_8_2 = FriendsData:GetList(FriendsConst.FRIEND_TYPE.BLACKLIST)

		for iter_8_1 = var_8_1 + 1, #self.chatSaveRecordList_ do
			if self.chatSaveRecordList_[iter_8_1] and table.keyof(var_8_2, self.chatSaveRecordList_[iter_8_1].id) then
				self.readMsgID_ = self.chatSaveRecordList_[iter_8_1].msgID
			else
				break
			end
		end

		saveData("chatGuild" .. self.chatType_, "readMsgID_" .. self.chatType_, var_8_0.msgID)
	end
end

function ChatNormalData:RemoveChatContent(arg_9_1)
	local var_9_0 = 0

	if self.chatRecordList_ == nil then
		return var_9_0
	end

	for iter_9_0, iter_9_1 in ipairs(self.chatRecordList_) do
		if iter_9_1.contentType == ChatConst.CHAT_CONTENT_TYPE.TEXT and iter_9_1.msgID == arg_9_1.msgID then
			iter_9_1.recall = true

			ChatTools.ResaveChannelChatCache(self.chatType_)

			var_9_0 = iter_9_0

			break
		end
	end

	for iter_9_2 = #self.cacheContentList_, 1, -1 do
		if self.cacheContentList_[iter_9_2].contentType == ChatConst.CHAT_CONTENT_TYPE.TEXT and self.cacheContentList_[iter_9_2].msgID == arg_9_1.msgID then
			if self.cacheContentList_[iter_9_2 + 1] == nil then
				table.remove(self.cacheContentList_, iter_9_2)

				if self.cacheContentList_[iter_9_2 - 1] then
					if self.cacheContentList_[iter_9_2 - 1].contentType == ChatConst.CHAT_CONTENT_TYPE.HISTORY_TIPS or self.cacheContentList_[iter_9_2 - 1].contentType == ChatConst.CHAT_CONTENT_TYPE.TIMESTAMP then
						table.remove(self.cacheContentList_, iter_9_2 - 1)

						if self.cacheContentList_[iter_9_2 - 2] and self.cacheContentList_[iter_9_2 - 2].contentType == ChatConst.CHAT_CONTENT_TYPE.HISTORY_TIPS then
							table.remove(self.cacheContentList_, iter_9_2 - 2)
						end
					end

					self.historyTipsFlag_ = false
				end

				break
			end

			table.remove(self.cacheContentList_, iter_9_2)

			break
		end
	end

	return var_9_0
end

function ChatNormalData:InitCacheContent()
	local var_10_1 = clone(self.chatRecordList_ or {})

	self.historyTipsFlag_ = false

	if self.readMsgID_ == 0 then
		self.historyTipsFlag_ = true
	end

	local var_10_2 = 0

	for iter_10_0 = #var_10_1, 1, -1 do
		if var_10_1[iter_10_0].recall == true then
			table.remove(var_10_1, iter_10_0)
		end
	end

	self.cacheContentList_ = {}

	local var_10_3 = FriendsData:GetList(FriendsConst.FRIEND_TYPE.BLACKLIST)

	for iter_10_1, iter_10_2 in ipairs(var_10_1) do
		if iter_10_1 == 1 or iter_10_2.timestamp - var_10_1[iter_10_1 - 1].timestamp > ChatConst.MESSAGE_SPACE then
			if not table.keyof(var_10_3, iter_10_2.id) then
				table.insert(self.cacheContentList_, {
					timestamp = iter_10_2.timestamp,
					contentType = ChatConst.CHAT_CONTENT_TYPE.TIMESTAMP
				})
			end
		end

		if not table.keyof(var_10_3, iter_10_2.id) then
			table.insert(self.cacheContentList_, iter_10_2)
		end

		if self.readMsgID_ ~= 0 and var_10_1[iter_10_1].msgID == self.readMsgID_ and var_10_1[iter_10_1 + 1] and not table.keyof(var_10_3, var_10_1[iter_10_1 + 1].id) then
			self.historyTipsFlag_ = true

			table.insert(self.cacheContentList_, {
				contentType = ChatConst.CHAT_CONTENT_TYPE.HISTORY_TIPS,
				timestamp = var_10_1[iter_10_1].timestamp
			})

			var_10_2 = #self.cacheContentList_
		end
	end

	return var_10_2 ~= 0 and var_10_2 or #self.cacheContentList_
end

function ChatNormalData:UpdateCacheContent(arg_11_1)
	if table.keyof(FriendsData:GetList(FriendsConst.FRIEND_TYPE.BLACKLIST), arg_11_1.msg.id) then
		return
	end

	if self.historyTipsFlag_ ~= true then
		if arg_11_1.msg.id ~= USER_ID then
			table.insert(self.cacheContentList_, {
				contentType = ChatConst.CHAT_CONTENT_TYPE.HISTORY_TIPS,
				timestamp = arg_11_1.msg.timestamp
			})
		end

		self.historyTipsFlag_ = true
	end

	if #self.cacheContentList_ > 0 then
		if arg_11_1.msg.timestamp - self.cacheContentList_[#self.cacheContentList_].timestamp > ChatConst.MESSAGE_SPACE then
			table.insert(self.cacheContentList_, {
				timestamp = arg_11_1.msg.timestamp,
				contentType = ChatConst.CHAT_CONTENT_TYPE.TIMESTAMP
			})
		end
	end

	table.insert(self.cacheContentList_, self:ParseChat(arg_11_1))
end

function ChatNormalData:GetCacheContent()
	return self.cacheContentList_
end

function ChatNormalData:GetUnreadMsgCnt()
	if self.chatRecordList_ then
		local var_13_0 = 0

		for iter_13_0 = #self.chatRecordList_, 1, -1 do
			if self.chatRecordList_[iter_13_0].msgID == self.readMsgID_ then
				break
			end

			if self.chatRecordList_[iter_13_0].recall == false then
				var_13_0 = var_13_0 + 1
			end
		end

		return var_13_0
	else
		return 0
	end
end

function ChatNormalData:GetLastMsgData()
	if self.chatRecordList_ then
		for iter_14_0 = #self.chatRecordList_, 1, -1 do
			if self.chatRecordList_[iter_14_0].recall == false then
				return self.chatRecordList_[iter_14_0]
			end
		end
	end

	return {
		content = ""
	}
end

function ChatNormalData:SetLastRequireMsgTimestamp(arg_15_1)
	self.lastRequireMsgTimestamp_ = arg_15_1
end

function ChatNormalData:GetLastRequireMsgTimestamp()
	return self.lastRequireMsgTimestamp_ or 0
end

function ChatNormalData:GetSaveRecordList()
	return self.chatSaveRecordList_ or {}
end

function ChatNormalData:SetSaveRecordList(arg_18_1)
	self.chatSaveRecordList_ = arg_18_1
end

function ChatNormalData:InitChannelContnent(arg_19_1)
	self.chatRecordList_ = {}

	for iter_19_0, iter_19_1 in ipairs(arg_19_1) do
		table.insert(self.chatRecordList_, iter_19_1)
	end

	self:InitCacheContent()

	self.readMsgID_ = self.chatRecordData_["readMsgID_" .. self.chatType_] or 0
end

return ChatNormalData
