local MoonCakeChatData = class("MoonCakeChatData", (import(".ChatNormalData")))

function MoonCakeChatData:Ctor(arg_1_1)
	self.chatType_ = arg_1_1
	self.chatRecordData_ = getModule("chatGuild" .. arg_1_1)
	self.chatSaveRecordList_ = {}
	self.chatRecordList_ = {}
	self.readMsgID_ = 0
	self.historyTipsFlag_ = false
	self.cacheContentList_ = {}
	self.tempChatData_ = {}
end

function MoonCakeChatData:AddChat(arg_2_1)
	self.tempChatData_[#self.tempChatData_ + 1] = self:ParseChat(arg_2_1)
end

function MoonCakeChatData:SortMsg()
	table.sort(self.tempChatData_, function(arg_4_0, arg_4_1)
		return arg_4_0.timestamp < arg_4_1.timestamp
	end)

	self.chatSaveRecordList_ = {}
	self.chatRecordList_ = {}
	self.cacheContentList_ = {}

	for iter_3_0 = 1, #self.tempChatData_ do
		self:SaveRecord(self.tempChatData_[iter_3_0])

		self.chatRecordList_[#self.chatRecordList_ + 1] = self.tempChatData_[iter_3_0]

		self:UpdateCacheContent(self.tempChatData_[iter_3_0])
	end

	self.tempChatData_ = {}
end

function MoonCakeChatData:RemoveChatContent(arg_5_1)
	local var_5_0 = 0

	if self.chatRecordList_ == nil then
		return var_5_0
	end

	for iter_5_0, iter_5_1 in ipairs(self.chatRecordList_) do
		if iter_5_1.id == arg_5_1.sender_uid then
			iter_5_1.recall = true
			var_5_0 = iter_5_0

			break
		end
	end

	for iter_5_2 = #self.cacheContentList_, 1, -1 do
		if self.cacheContentList_[iter_5_2].id == arg_5_1.sender_uid then
			if self.cacheContentList_[iter_5_2 + 1] == nil then
				table.remove(self.cacheContentList_, iter_5_2)

				if self.cacheContentList_[iter_5_2 - 1] then
					if self.cacheContentList_[iter_5_2 - 1].contentType == ChatConst.CHAT_CONTENT_TYPE.HISTORY_TIPS or self.cacheContentList_[iter_5_2 - 1].contentType == ChatConst.CHAT_CONTENT_TYPE.TIMESTAMP then
						table.remove(self.cacheContentList_, iter_5_2 - 1)

						if self.cacheContentList_[iter_5_2 - 2] and self.cacheContentList_[iter_5_2 - 2].contentType == ChatConst.CHAT_CONTENT_TYPE.HISTORY_TIPS then
							table.remove(self.cacheContentList_, iter_5_2 - 2)
						end
					end

					self.historyTipsFlag_ = false
				end

				break
			end

			table.remove(self.cacheContentList_, iter_5_2)

			break
		end
	end

	return var_5_0
end

function MoonCakeChatData:UpdateCacheContent(arg_6_1)
	if table.keyof(FriendsData:GetList(FriendsConst.FRIEND_TYPE.BLACKLIST), arg_6_1.id) then
		return
	end

	if self.historyTipsFlag_ ~= true then
		if arg_6_1.id ~= USER_ID then
			table.insert(self.cacheContentList_, {
				contentType = ChatConst.CHAT_CONTENT_TYPE.HISTORY_TIPS,
				timestamp = arg_6_1.timestamp
			})
		end

		self.historyTipsFlag_ = true
	end

	if #self.cacheContentList_ > 0 then
		if arg_6_1.timestamp - self.cacheContentList_[#self.cacheContentList_].timestamp > ChatConst.MESSAGE_SPACE then
			table.insert(self.cacheContentList_, {
				timestamp = arg_6_1.timestamp,
				contentType = ChatConst.CHAT_CONTENT_TYPE.TIMESTAMP
			})
		end
	end

	table.insert(self.cacheContentList_, arg_6_1)
end

return MoonCakeChatData
