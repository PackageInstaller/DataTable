local var_0_0 = singletonClass("ChatCooperationData")

function var_0_0:Init()
	self.chatRecordData_ = getModule("chatCooperation")
	self.chatRecordCnt_ = self.chatRecordData_.chatRecordCnt or 0
	self.readMsgID_ = 0
	self.historyTipsFlag_ = false
	self.chatRecordList_ = self:ParseLocalRecord(self.chatRecordData_)
	self.cacheContentList_ = {}

	self:InitCacheCooperationContent()
end

function var_0_0:GetContent()
	return self.chatRecordList_
end

function var_0_0:AddChat(arg_3_1)
	if self:IsOldMsg(arg_3_1.msg_id) then
		return
	end

	local var_3_0 = self:ParseChat(arg_3_1)

	self:SaveRecord(var_3_0)
	table.insert(self.chatRecordList_, var_3_0)
	self:UpdateCacheCooperationContent(arg_3_1)
end

function var_0_0:IsOldMsg(arg_4_1)
	for iter_4_0 = 0, 9 do
		if self.chatRecordList_[((self.chatRecordList_ or nil) and (#self.chatRecordList_ or 0)) - iter_4_0] and self.chatRecordList_[((self.chatRecordList_ or nil) and (#self.chatRecordList_ or 0)) - iter_4_0].msgID == arg_4_1 then
			return true
		end
	end

	return false
end

function var_0_0:ParseChat(arg_5_1)
	self.chatRecordCnt_ = self.chatRecordCnt_ + 1

	local var_5_0 = {
		recall = false,
		msgID = arg_5_1.msg_id,
		id = arg_5_1.id,
		nick = arg_5_1.user_profile_base.nick,
		icon = arg_5_1.user_profile_base.icon,
		iconFrame = arg_5_1.user_profile_base.icon_frame,
		timestamp = arg_5_1.timestamp,
		contentType = arg_5_1.type,
		content = arg_5_1.content,
		index = self.chatRecordCnt_
	}

	var_5_0.ip = (arg_5_1.ip_location == nil or arg_5_1.ip_location == "") and GetTips("IP_UNKNOWN") or arg_5_1.ip_location

	return var_5_0
end

function var_0_0.RemoveChatData(arg_6_0)
	arg_6_0.chatRecordList_ = {}
	arg_6_0.cacheContentList_ = {}
	arg_6_0.historyTipsFlag_ = false
	arg_6_0.readMsgID_ = 0

	saveData("chatCooperation", "readMsgID", 0)

	arg_6_0.chatRecordCnt_ = 0

	saveData("chatCooperation", "chatRecordCnt", 0)
end

function var_0_0:ParseLocalRecord(arg_7_1)
	local var_7_0 = {}

	for iter_7_0 = 1, self.chatRecordCnt_ do
		if arg_7_1["msgIndex_" .. iter_7_0] then
			table.insert(var_7_0, arg_7_1["msgIndex_" .. iter_7_0])
		end
	end

	self.readMsgID_ = getData("chatCooperation", "readMsgID") or 0

	return var_7_0
end

function var_0_0:SaveRecord(arg_8_1)
	saveData("chatCooperation", "msgIndex_" .. self.chatRecordCnt_, arg_8_1)
	saveData("chatCooperation", "chatRecordCnt", self.chatRecordCnt_)
end

function var_0_0:SaveRecordCnt(arg_9_1)
	local var_9_0 = self.cacheContentList_[#self.cacheContentList_ - (arg_9_1 or 0)]

	if self.cacheContentList_[#self.cacheContentList_ - (arg_9_1 or 0)] and (var_9_0.contentType == ChatConst.CHAT_CONTENT_TYPE.TEXT or var_9_0.contentType == ChatConst.CHAT_CONTENT_TYPE.STICKER) then
		self.readMsgID_ = var_9_0.msgID

		saveData("chatCooperation", "readMsgID", var_9_0.msgID)
	end
end

function var_0_0:RemoveCooperationChatContent(arg_10_1)
	local var_10_0 = 0

	if self.chatRecordList_ == nil then
		return var_10_0
	end

	for iter_10_0, iter_10_1 in ipairs(self.chatRecordList_) do
		if iter_10_1.contentType == ChatConst.CHAT_CONTENT_TYPE.TEXT and iter_10_1.msgID == arg_10_1 then
			iter_10_1.recall = true

			saveData("chatCooperation", "msgIndex_" .. iter_10_1.index, iter_10_1)

			var_10_0 = iter_10_0

			break
		end
	end

	for iter_10_2 = #self.cacheContentList_, 1, -1 do
		if self.cacheContentList_[iter_10_2].contentType == ChatConst.CHAT_CONTENT_TYPE.TEXT and self.cacheContentList_[iter_10_2].msgID == arg_10_1 then
			if self.cacheContentList_[iter_10_2 + 1] == nil then
				table.remove(self.cacheContentList_, iter_10_2)

				if self.cacheContentList_[iter_10_2 - 1] then
					if self.cacheContentLit[iter_10_2 - 1].contentType == ChatConst.CHAT_CONTENT_TYPE.HISTORY_TIPS or self.cacheContentLit[iter_10_2 - 1].contentType == ChatConst.CHAT_CONTENT_TYPE.TIMESTAMP then
						table.remove(self.cacheContentList_, iter_10_2 - 1)

						if cacheContentList_[iter_10_2 - 2].contentType == ChatConst.CHAT_CONTENT_TYPE.HISTORY_TIPS then
							table.remove(self.cacheContentList_, iter_10_2 - 2)
						end
					end

					self.historyTipsFlag_ = false
				end

				break
			end

			table.remove(self.cacheContentList_, iter_10_2)

			break
		end
	end

	return var_10_0
end

function var_0_0:InitCacheCooperationContent()
	local var_11_1 = clone(self.chatRecordList_ or {})

	self.historyTipsFlag_ = false

	if self.readMsgID_ == 0 then
		self.historyTipsFlag_ = true
	end

	local var_11_2 = 0

	for iter_11_0 = #var_11_1, 1, -1 do
		if var_11_1[iter_11_0].recall == true then
			table.remove(var_11_1, iter_11_0)
		end
	end

	self.cacheContentList_ = {}

	for iter_11_1, iter_11_2 in ipairs(var_11_1) do
		if iter_11_1 ~= 1 then
			if iter_11_2.timestamp - var_11_1[iter_11_1 - 1].timestamp > ChatConst.MESSAGE_SPACE then
				table.insert(self.cacheContentList_, {
					timestamp = iter_11_2.timestamp,
					contentType = ChatConst.CHAT_CONTENT_TYPE.TIMESTAMP
				})
			end
		end

		table.insert(self.cacheContentList_, iter_11_2)

		if self.readMsgID_ ~= 0 and var_11_1[iter_11_1].msgID == self.readMsgID_ and var_11_1[iter_11_1 + 1] then
			self.historyTipsFlag_ = true

			table.insert(self.cacheContentList_, {
				contentType = ChatConst.CHAT_CONTENT_TYPE.HISTORY_TIPS,
				timestamp = var_11_1[iter_11_1].timestamp
			})

			var_11_2 = #self.cacheContentList_
		end
	end

	return var_11_2 ~= 0 and var_11_2 or #self.cacheContentList_
end

function var_0_0:UpdateCacheCooperationContent(arg_12_1)
	if self.historyTipsFlag_ ~= true then
		if arg_12_1.sender_uid ~= USER_ID then
			table.insert(self.cacheContentList_, {
				contentType = ChatConst.CHAT_CONTENT_TYPE.HISTORY_TIPS,
				timestamp = arg_12_1.timestamp
			})
		end

		self.historyTipsFlag_ = true
	end

	if #self.cacheContentList_ > 0 then
		if arg_12_1.timestamp - self.cacheContentList_[#self.cacheContentList_].timestamp > ChatConst.MESSAGE_SPACE then
			table.insert(self.cacheContentList_, {
				timestamp = arg_12_1.timestamp,
				contentType = ChatConst.CHAT_CONTENT_TYPE.TIMESTAMP
			})
		end
	end

	table.insert(self.cacheContentList_, self:ParseChat(arg_12_1))
end

function var_0_0:GetCacheContent()
	return self.cacheContentList_
end

function var_0_0:GetUnreadMsgCnt()
	if self.chatRecordList_ then
		local var_14_0 = 0

		for iter_14_0 = #self.chatRecordList_, 1, -1 do
			if self.chatRecordList_[iter_14_0].msgID == self.readMsgID_ then
				break
			end

			if self.chatRecordList_[iter_14_0].recall == false then
				var_14_0 = var_14_0 + 1
			end
		end

		return var_14_0
	else
		return 0
	end
end

function var_0_0:GetLastMsgData()
	if self.chatRecordList_ then
		for iter_15_0 = #self.chatRecordList_, 1, -1 do
			if self.chatRecordList_[iter_15_0].recall == false then
				return self.chatRecordList_[iter_15_0]
			end
		end
	end

	return {
		content = ""
	}
end

return var_0_0
