local var_0_0 = import(".ChatNormalData")
local var_0_1 = class("MoonCakeChatData", var_0_0)

function var_0_1.Ctor(arg_1_0, arg_1_1)
	arg_1_0.chatType_ = arg_1_1
	arg_1_0.chatRecordData_ = getModule("chatGuild" .. arg_1_1)
	arg_1_0.chatSaveRecordList_ = {}
	arg_1_0.chatRecordList_ = {}
	arg_1_0.readMsgID_ = 0
	arg_1_0.historyTipsFlag_ = false
	arg_1_0.cacheContentList_ = {}
	arg_1_0.tempChatData_ = {}
end

function var_0_1.AddChat(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_0:ParseChat(arg_2_1)

	arg_2_0.tempChatData_[#arg_2_0.tempChatData_ + 1] = var_2_0
end

function var_0_1.SortMsg(arg_3_0)
	table.sort(arg_3_0.tempChatData_, function(arg_4_0, arg_4_1)
		return arg_4_0.timestamp < arg_4_1.timestamp
	end)

	arg_3_0.chatSaveRecordList_ = {}
	arg_3_0.chatRecordList_ = {}
	arg_3_0.cacheContentList_ = {}

	for iter_3_0 = 1, #arg_3_0.tempChatData_ do
		local var_3_0 = arg_3_0.tempChatData_[iter_3_0]

		arg_3_0:SaveRecord(var_3_0)

		arg_3_0.chatRecordList_[#arg_3_0.chatRecordList_ + 1] = var_3_0

		arg_3_0:UpdateCacheContent(var_3_0)
	end

	arg_3_0.tempChatData_ = {}
end

function var_0_1.RemoveChatContent(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_1.sender_uid
	local var_5_1 = 0

	if arg_5_0.chatRecordList_ == nil then
		return var_5_1
	end

	for iter_5_0, iter_5_1 in ipairs(arg_5_0.chatRecordList_) do
		if iter_5_1.id == var_5_0 then
			iter_5_1.recall = true
			var_5_1 = iter_5_0

			break
		end
	end

	for iter_5_2 = #arg_5_0.cacheContentList_, 1, -1 do
		if arg_5_0.cacheContentList_[iter_5_2].id == var_5_0 then
			if arg_5_0.cacheContentList_[iter_5_2 + 1] == nil then
				table.remove(arg_5_0.cacheContentList_, iter_5_2)

				if arg_5_0.cacheContentList_[iter_5_2 - 1] then
					if arg_5_0.cacheContentList_[iter_5_2 - 1].contentType == ChatConst.CHAT_CONTENT_TYPE.HISTORY_TIPS or arg_5_0.cacheContentList_[iter_5_2 - 1].contentType == ChatConst.CHAT_CONTENT_TYPE.TIMESTAMP then
						table.remove(arg_5_0.cacheContentList_, iter_5_2 - 1)

						if arg_5_0.cacheContentList_[iter_5_2 - 2] and arg_5_0.cacheContentList_[iter_5_2 - 2].contentType == ChatConst.CHAT_CONTENT_TYPE.HISTORY_TIPS then
							table.remove(arg_5_0.cacheContentList_, iter_5_2 - 2)
						end
					end

					arg_5_0.historyTipsFlag_ = false
				end

				break
			end

			table.remove(arg_5_0.cacheContentList_, iter_5_2)

			break
		end
	end

	return var_5_1
end

function var_0_1.UpdateCacheContent(arg_6_0, arg_6_1)
	local var_6_0 = USER_ID
	local var_6_1 = FriendsData:GetList(FriendsConst.FRIEND_TYPE.BLACKLIST)

	if table.keyof(var_6_1, arg_6_1.id) then
		return
	end

	if arg_6_0.historyTipsFlag_ ~= true then
		if arg_6_1.id ~= var_6_0 then
			table.insert(arg_6_0.cacheContentList_, {
				contentType = ChatConst.CHAT_CONTENT_TYPE.HISTORY_TIPS,
				timestamp = arg_6_1.timestamp
			})
		end

		arg_6_0.historyTipsFlag_ = true
	end

	if #arg_6_0.cacheContentList_ <= 0 or arg_6_1.timestamp - arg_6_0.cacheContentList_[#arg_6_0.cacheContentList_].timestamp > ChatConst.MESSAGE_SPACE then
		local var_6_2 = {
			timestamp = arg_6_1.timestamp,
			contentType = ChatConst.CHAT_CONTENT_TYPE.TIMESTAMP
		}

		table.insert(arg_6_0.cacheContentList_, var_6_2)
	end

	table.insert(arg_6_0.cacheContentList_, arg_6_1)
end

return var_0_1
