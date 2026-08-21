local var_0_0 = class("IslandChatBubble", import("view.main.ChatBubble"))

function var_0_0.init(arg_1_0)
	var_0_0.super.init(arg_1_0)

	arg_1_0.chatBgWidth = 655
	arg_1_0.isTradeLink = false

	return
end

function var_0_0.GetAttireFrameRes(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	local var_2_0 = AttireFrame.attireFrameRes(arg_2_1, arg_2_2, AttireConst.TYPE_CHAT_FRAME, arg_2_3)

	if var_2_0 == "0_self" then
		return "island_self"
	end

	if var_2_0 == "0_other" then
		return "island_other"
	end

	return var_2_0
end

function var_0_0.UpdateChannel(arg_3_0, arg_3_1)
	setImageSprite(arg_3_0.channel, GetSpriteFromAtlas("channel", ChatConst.GetChannelSprite(arg_3_1.type) .. "_mel"), true)

	return
end

function var_0_0.UpdateContent(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0.isTradeLink = false

	if string.find(arg_4_2, IslandConst.TRADE_SHARE_CODE) then
		local var_4_0 = string.split(arg_4_2, "*")

		arg_4_2 = i18n("island_trade_send_msg_label", var_4_0[2], var_4_0[3])
		arg_4_1.supportRichText = true
		arg_4_0.isTradeLink = true
	end

	arg_4_1.text = arg_4_2

	return
end

return var_0_0
