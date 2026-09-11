local ChatNormalData = import(".ChatNormalData")
local MoonCakeChatData = import(".MoonCakeChatData")
local var_0_2 = singletonClass("ChatChannelData")

function var_0_2.Init(arg_1_0)
	arg_1_0.chatChannelList_ = {}
end

function var_0_2:CheckChatChannelList(arg_2_1)
	if self.chatChannelList_[arg_2_1] == nil then
		self.chatChannelList_[arg_2_1] = arg_2_1 == ChatConst.CHAT_CHANNEL_MOON_CAKE and MoonCakeChatData.New(arg_2_1) or ChatNormalData.New(arg_2_1)
	end
end

function var_0_2:GetContent(arg_3_1)
	self:CheckChatChannelList(arg_3_1)

	return self.chatChannelList_[arg_3_1]:GetContent()
end

function var_0_2:AddChat(arg_4_1, arg_4_2)
	self:CheckChatChannelList(arg_4_1)
	self.chatChannelList_[arg_4_1]:AddChat(arg_4_2)
end

function var_0_2:RemoveChatData(arg_5_1)
	self:CheckChatChannelList(arg_5_1)
	self.chatChannelList_[arg_5_1]:RemoveChatData()
end

function var_0_2:RemoveChatContent(arg_6_1)
	self:CheckChatChannelList(arg_6_1.channel_type)

	return self.chatChannelList_[arg_6_1.channel_type]:RemoveChatContent(arg_6_1)
end

function var_0_2:InitCacheContent(arg_7_1)
	self:CheckChatChannelList(arg_7_1)
	self.chatChannelList_[arg_7_1]:InitCacheContent()
end

function var_0_2:GetCacheContent(arg_8_1)
	self:CheckChatChannelList(arg_8_1)

	return self.chatChannelList_[arg_8_1]:GetCacheContent()
end

function var_0_2:SaveRecordCnt(arg_9_1, arg_9_2)
	self:CheckChatChannelList(arg_9_1)
	self.chatChannelList_[arg_9_1]:SaveRecordCnt(arg_9_2)
end

function var_0_2:GetUnreadMsgCnt(arg_10_1)
	self:CheckChatChannelList(arg_10_1)

	return self.chatChannelList_[arg_10_1]:GetUnreadMsgCnt()
end

function var_0_2:GetSaveRecordList(arg_11_1)
	self:CheckChatChannelList(arg_11_1)

	return self.chatChannelList_[arg_11_1]:GetSaveRecordList()
end

function var_0_2:SetSaveRecordList(arg_12_1, arg_12_2)
	self:CheckChatChannelList(arg_12_1)
	self.chatChannelList_[arg_12_1]:SetSaveRecordList(arg_12_2)
end

function var_0_2:InitChannelContnent(arg_13_1, arg_13_2)
	self:CheckChatChannelList(arg_13_1)
	self.chatChannelList_[arg_13_1]:InitChannelContnent(arg_13_2)
end

function var_0_2:SetLastRequireMsgTimestamp(arg_14_1, arg_14_2)
	self:CheckChatChannelList(arg_14_1)
	self.chatChannelList_[arg_14_1]:SetLastRequireMsgTimestamp(arg_14_2)
end

function var_0_2:GetLastRequireMsgTimestamp(arg_15_1)
	self:CheckChatChannelList(arg_15_1)

	return self.chatChannelList_[arg_15_1]:GetLastRequireMsgTimestamp()
end

function var_0_2:SortMsg(arg_16_1)
	self:CheckChatChannelList(arg_16_1)
	self.chatChannelList_[arg_16_1]:SortMsg()
end

return var_0_2
