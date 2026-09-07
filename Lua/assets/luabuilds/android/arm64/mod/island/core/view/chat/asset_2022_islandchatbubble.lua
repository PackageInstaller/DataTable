local IslandChatBubble = class("IslandChatBubble", import("view.main.ChatBubble"))

function IslandChatBubble:init()
	IslandChatBubble.super.init(self)

	self.chatBgWidth = 655
	self.isTradeLink = false

	return
end

function IslandChatBubble:GetAttireFrameRes(arg_2_1, arg_2_2, arg_2_3)
	local var_2_0 = AttireFrame.attireFrameRes(arg_2_1, arg_2_2, AttireConst.TYPE_CHAT_FRAME, arg_2_3)

	if var_2_0 == "0_self" then
		return "island_self"
	end

	if var_2_0 == "0_other" then
		return "island_other"
	end

	return var_2_0
end

function IslandChatBubble:UpdateChannel(arg_3_1)
	setImageSprite(self.channel, GetSpriteFromAtlas("channel", ChatConst.GetChannelSprite(arg_3_1.type) .. "_mel"), true)

	return
end

function IslandChatBubble:UpdateContent(arg_4_1, arg_4_2)
	self.isTradeLink = false

	if string.find(arg_4_2, IslandConst.TRADE_SHARE_CODE) then
		local var_4_0 = string.split(arg_4_2, "*")

		arg_4_2 = i18n("island_trade_send_msg_label", var_4_0[2], var_4_0[3])
		arg_4_1.supportRichText = true
		self.isTradeLink = true
	end

	arg_4_1.text = arg_4_2

	return
end

return IslandChatBubble
