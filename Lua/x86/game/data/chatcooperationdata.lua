local var_0_0 = singletonClass("ChatCooperationData")

function var_0_0.Init(arg_1_0)
	arg_1_0.chatRecordData_ = getModule("chatCooperation")
	arg_1_0.chatRecordCnt_ = arg_1_0.chatRecordData_.chatRecordCnt or 0
	arg_1_0.readMsgID_ = 0
	arg_1_0.historyTipsFlag_ = false
	arg_1_0.chatRecordList_ = arg_1_0:ParseLocalRecord(arg_1_0.chatRecordData_)
	arg_1_0.cacheContentList_ = {}

	arg_1_0:InitCacheCooperationContent()
end

function var_0_0.GetContent(arg_2_0)
	return arg_2_0.chatRecordList_
end

function var_0_0.AddChat(arg_3_0, arg_3_1)
	if arg_3_0:IsOldMsg(arg_3_1.msg_id) then
		return
	end

	local var_3_0 = arg_3_0:ParseChat(arg_3_1)

	arg_3_0:SaveRecord(var_3_0)
	table.insert(arg_3_0.chatRecordList_, var_3_0)
	arg_3_0:UpdateCacheCooperationContent(arg_3_1)
end

function var_0_0.IsOldMsg(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0.chatRecordList_ and #arg_4_0.chatRecordList_ or 0

	for iter_4_0 = 0, 9 do
		local var_4_1 = arg_4_0.chatRecordList_[var_4_0 - iter_4_0]

		if var_4_1 and var_4_1.msgID == arg_4_1 then
			return true
		end
	end

	return false
end

function var_0_0.ParseChat(arg_5_0, arg_5_1)
	arg_5_0.chatRecordCnt_ = arg_5_0.chatRecordCnt_ + 1

	return {
		recall = false,
		msgID = arg_5_1.msg_id,
		id = arg_5_1.id,
		nick = arg_5_1.user_profile_base.nick,
		icon = arg_5_1.user_profile_base.icon,
		iconFrame = arg_5_1.user_profile_base.icon_frame,
		timestamp = arg_5_1.timestamp,
		contentType = arg_5_1.type,
		content = arg_5_1.content,
		index = arg_5_0.chatRecordCnt_,
		ip = (arg_5_1.ip_location == nil or arg_5_1.ip_location == "") and GetTips("IP_UNKNOWN") or arg_5_1.ip_location
	}
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

function var_0_0.ParseLocalRecord(arg_7_0, arg_7_1)
	local var_7_0 = {}

	for iter_7_0 = 1, arg_7_0.chatRecordCnt_ do
		if arg_7_1["msgIndex_" .. iter_7_0] then
			local var_7_1 = arg_7_1["msgIndex_" .. iter_7_0]

			table.insert(var_7_0, var_7_1)
		end
	end

	arg_7_0.readMsgID_ = getData("chatCooperation", "readMsgID") or 0

	return var_7_0
end

function var_0_0.SaveRecord(arg_8_0, arg_8_1)
	saveData("chatCooperation", "msgIndex_" .. arg_8_0.chatRecordCnt_, arg_8_1)
	saveData("chatCooperation", "chatRecordCnt", arg_8_0.chatRecordCnt_)
end

function var_0_0.SaveRecordCnt(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_1 or 0
	local var_9_1 = arg_9_0.cacheContentList_[#arg_9_0.cacheContentList_ - var_9_0]

	if var_9_1 and (var_9_1.contentType == ChatConst.CHAT_CONTENT_TYPE.TEXT or var_9_1.contentType == ChatConst.CHAT_CONTENT_TYPE.STICKER) then
		arg_9_0.readMsgID_ = var_9_1.msgID

		saveData("chatCooperation", "readMsgID", var_9_1.msgID)
	end
end

function var_0_0.RemoveCooperationChatContent(arg_10_0, arg_10_1)
	local var_10_0 = 0

	if arg_10_0.chatRecordList_ == nil then
		return var_10_0
	end

	for iter_10_0, iter_10_1 in ipairs(arg_10_0.chatRecordList_) do
		if iter_10_1.contentType == ChatConst.CHAT_CONTENT_TYPE.TEXT and iter_10_1.msgID == arg_10_1 then
			iter_10_1.recall = true

			saveData("chatCooperation", "msgIndex_" .. iter_10_1.index, iter_10_1)

			var_10_0 = iter_10_0

			break
		end
	end

	for iter_10_2 = #arg_10_0.cacheContentList_, 1, -1 do
		local var_10_1 = arg_10_0.cacheContentList_[iter_10_2]

		if var_10_1.contentType == ChatConst.CHAT_CONTENT_TYPE.TEXT and var_10_1.msgID == arg_10_1 then
			if arg_10_0.cacheContentList_[iter_10_2 + 1] == nil then
				table.remove(arg_10_0.cacheContentList_, iter_10_2)

				if arg_10_0.cacheContentList_[iter_10_2 - 1] then
					if arg_10_0.cacheContentLit[iter_10_2 - 1].contentType == ChatConst.CHAT_CONTENT_TYPE.HISTORY_TIPS or arg_10_0.cacheContentLit[iter_10_2 - 1].contentType == ChatConst.CHAT_CONTENT_TYPE.TIMESTAMP then
						table.remove(arg_10_0.cacheContentList_, iter_10_2 - 1)

						if cacheContentList_[iter_10_2 - 2].contentType == ChatConst.CHAT_CONTENT_TYPE.HISTORY_TIPS then
							table.remove(arg_10_0.cacheContentList_, iter_10_2 - 2)
						end
					end

					arg_10_0.historyTipsFlag_ = false
				end

				break
			end

			table.remove(arg_10_0.cacheContentList_, iter_10_2)

			break
		end
	end

	return var_10_0
end

function var_0_0.InitCacheCooperationContent(arg_11_0)
	local var_11_0 = clone(arg_11_0.chatRecordList_ or {})

	arg_11_0.historyTipsFlag_ = false

	if arg_11_0.readMsgID_ == 0 then
		arg_11_0.historyTipsFlag_ = true
	end

	local var_11_1 = 0

	for iter_11_0 = #var_11_0, 1, -1 do
		if var_11_0[iter_11_0].recall == true then
			table.remove(var_11_0, iter_11_0)
		end
	end

	arg_11_0.cacheContentList_ = {}

	for iter_11_1, iter_11_2 in ipairs(var_11_0) do
		if iter_11_1 == 1 or iter_11_2.timestamp - var_11_0[iter_11_1 - 1].timestamp > ChatConst.MESSAGE_SPACE then
			local var_11_2 = {
				timestamp = iter_11_2.timestamp,
				contentType = ChatConst.CHAT_CONTENT_TYPE.TIMESTAMP
			}

			table.insert(arg_11_0.cacheContentList_, var_11_2)
		end

		table.insert(arg_11_0.cacheContentList_, iter_11_2)

		if arg_11_0.readMsgID_ ~= 0 and var_11_0[iter_11_1].msgID == arg_11_0.readMsgID_ and var_11_0[iter_11_1 + 1] then
			arg_11_0.historyTipsFlag_ = true

			table.insert(arg_11_0.cacheContentList_, {
				contentType = ChatConst.CHAT_CONTENT_TYPE.HISTORY_TIPS,
				timestamp = var_11_0[iter_11_1].timestamp
			})

			var_11_1 = #arg_11_0.cacheContentList_
		end
	end

	return var_11_1 ~= 0 and var_11_1 or #arg_11_0.cacheContentList_
end

function var_0_0.UpdateCacheCooperationContent(arg_12_0, arg_12_1)
	local var_12_0 = USER_ID

	if arg_12_0.historyTipsFlag_ ~= true then
		if arg_12_1.sender_uid ~= var_12_0 then
			table.insert(arg_12_0.cacheContentList_, {
				contentType = ChatConst.CHAT_CONTENT_TYPE.HISTORY_TIPS,
				timestamp = arg_12_1.timestamp
			})
		end

		arg_12_0.historyTipsFlag_ = true
	end

	if #arg_12_0.cacheContentList_ <= 0 or arg_12_1.timestamp - arg_12_0.cacheContentList_[#arg_12_0.cacheContentList_].timestamp > ChatConst.MESSAGE_SPACE then
		local var_12_1 = {
			timestamp = arg_12_1.timestamp,
			contentType = ChatConst.CHAT_CONTENT_TYPE.TIMESTAMP
		}

		table.insert(arg_12_0.cacheContentList_, var_12_1)
	end

	table.insert(arg_12_0.cacheContentList_, arg_12_0:ParseChat(arg_12_1))
end

function var_0_0.GetCacheContent(arg_13_0)
	return arg_13_0.cacheContentList_
end

function var_0_0.GetUnreadMsgCnt(arg_14_0)
	if arg_14_0.chatRecordList_ then
		local var_14_0 = 0

		for iter_14_0 = #arg_14_0.chatRecordList_, 1, -1 do
			if arg_14_0.chatRecordList_[iter_14_0].msgID == arg_14_0.readMsgID_ then
				break
			end

			if arg_14_0.chatRecordList_[iter_14_0].recall == false then
				var_14_0 = var_14_0 + 1
			end
		end

		return var_14_0
	else
		return 0
	end
end

function var_0_0.GetLastMsgData(arg_15_0)
	if arg_15_0.chatRecordList_ then
		for iter_15_0 = #arg_15_0.chatRecordList_, 1, -1 do
			if arg_15_0.chatRecordList_[iter_15_0].recall == false then
				return arg_15_0.chatRecordList_[iter_15_0]
			end
		end
	end

	return {
		content = ""
	}
end

return var_0_0
