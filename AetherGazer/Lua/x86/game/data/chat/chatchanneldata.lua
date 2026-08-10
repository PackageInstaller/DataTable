local var_0_0 = import(".ChatNormalData")
local var_0_1 = import(".MoonCakeChatData")
local var_0_2 = singletonClass("ChatChannelData")

function var_0_2.Init(arg_1_0)
	arg_1_0.chatChannelList_ = {}
end

function var_0_2.CheckChatChannelList(arg_2_0, arg_2_1)
	if arg_2_0.chatChannelList_[arg_2_1] == nil then
		if arg_2_1 == ChatConst.CHAT_CHANNEL_MOON_CAKE then
			arg_2_0.chatChannelList_[arg_2_1] = var_0_1.New(arg_2_1)
		else
			arg_2_0.chatChannelList_[arg_2_1] = var_0_0.New(arg_2_1)
		end
	end
end

function var_0_2.GetContent(arg_3_0, arg_3_1)
	arg_3_0:CheckChatChannelList(arg_3_1)

	return arg_3_0.chatChannelList_[arg_3_1]:GetContent()
end

function var_0_2.AddChat(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0:CheckChatChannelList(arg_4_1)
	arg_4_0.chatChannelList_[arg_4_1]:AddChat(arg_4_2)
end

function var_0_2.RemoveChatData(arg_5_0, arg_5_1)
	arg_5_0:CheckChatChannelList(arg_5_1)
	arg_5_0.chatChannelList_[arg_5_1]:RemoveChatData()
end

function var_0_2.RemoveChatContent(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_1.channel_type

	arg_6_0:CheckChatChannelList(var_6_0)

	return arg_6_0.chatChannelList_[var_6_0]:RemoveChatContent(arg_6_1)
end

function var_0_2.InitCacheContent(arg_7_0, arg_7_1)
	arg_7_0:CheckChatChannelList(arg_7_1)
	arg_7_0.chatChannelList_[arg_7_1]:InitCacheContent()
end

function var_0_2.GetCacheContent(arg_8_0, arg_8_1)
	arg_8_0:CheckChatChannelList(arg_8_1)

	return arg_8_0.chatChannelList_[arg_8_1]:GetCacheContent()
end

function var_0_2.SaveRecordCnt(arg_9_0, arg_9_1, arg_9_2)
	arg_9_0:CheckChatChannelList(arg_9_1)
	arg_9_0.chatChannelList_[arg_9_1]:SaveRecordCnt(arg_9_2)
end

function var_0_2.GetUnreadMsgCnt(arg_10_0, arg_10_1)
	arg_10_0:CheckChatChannelList(arg_10_1)

	return arg_10_0.chatChannelList_[arg_10_1]:GetUnreadMsgCnt()
end

function var_0_2.GetSaveRecordList(arg_11_0, arg_11_1)
	arg_11_0:CheckChatChannelList(arg_11_1)

	return arg_11_0.chatChannelList_[arg_11_1]:GetSaveRecordList()
end

function var_0_2.SetSaveRecordList(arg_12_0, arg_12_1, arg_12_2)
	arg_12_0:CheckChatChannelList(arg_12_1)
	arg_12_0.chatChannelList_[arg_12_1]:SetSaveRecordList(arg_12_2)
end

function var_0_2.InitChannelContnent(arg_13_0, arg_13_1, arg_13_2)
	arg_13_0:CheckChatChannelList(arg_13_1)
	arg_13_0.chatChannelList_[arg_13_1]:InitChannelContnent(arg_13_2)
end

function var_0_2.SetLastRequireMsgTimestamp(arg_14_0, arg_14_1, arg_14_2)
	arg_14_0:CheckChatChannelList(arg_14_1)
	arg_14_0.chatChannelList_[arg_14_1]:SetLastRequireMsgTimestamp(arg_14_2)
end

function var_0_2.GetLastRequireMsgTimestamp(arg_15_0, arg_15_1)
	arg_15_0:CheckChatChannelList(arg_15_1)

	return arg_15_0.chatChannelList_[arg_15_1]:GetLastRequireMsgTimestamp()
end

function var_0_2.SortMsg(arg_16_0, arg_16_1)
	arg_16_0:CheckChatChannelList(arg_16_1)
	arg_16_0.chatChannelList_[arg_16_1]:SortMsg()
end

return var_0_2
