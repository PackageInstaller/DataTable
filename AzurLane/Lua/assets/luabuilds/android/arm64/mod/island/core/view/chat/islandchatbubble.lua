class = var_0_10000

local var_0_0 = "IslandChatBubble"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.main.ChatBubble"))

function var_0_1.init(arg_1_0)
	var_0_1.super.init(arg_1_0)

	arg_1_0.chatBgWidth = 655
	arg_1_0.isTradeLink = false

	return
end

function var_0_1.GetAttireFrameRes(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	AttireFrame = var_1_10004

	local var_2_0 = var_1_10004.attireFrameRes
	local var_2_1 = arg_2_1
	local var_2_2 = arg_2_2

	AttireConst = var_1_10008

	if var_2_0(var_2_1, var_2_2, var_1_10008.TYPE_CHAT_FRAME, arg_2_3) == "0_self" then
		return "island_self"
	end

	if var_4 == "0_other" then
		return "island_other"
	end

	return var_4
end

function var_0_1.UpdateChannel(arg_3_0, arg_3_1)
	GetSpriteFromAtlas = var_1_10002

	local var_3_0 = "channel"

	ChatConst = var_1_10005

	local var_3_1 = var_1_10002(var_3_0, var_1_10005.GetChannelSprite(arg_3_1.type) .. "_mel")

	setImageSprite = var_1_10003

	var_1_10003(arg_3_0.channel, var_3_1, true)

	return
end

function var_0_1.UpdateContent(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0.isTradeLink = false
	string = var_3

	local var_4_0 = var_3.find
	local var_4_1 = arg_4_2

	IslandConst = var_1_10006

	if var_4_0(var_4_1, var_1_10006.TRADE_SHARE_CODE) then
		string = var_3

		local var_4_2 = var_3.split(arg_4_2, "*")

		i18n = var_1_10004
		arg_4_2 = var_1_10004("island_trade_send_msg_label", var_4_2[2], var_4_2[3])
		arg_4_1.supportRichText = true
		arg_4_0.isTradeLink = true
	end

	arg_4_1.text = arg_4_2

	return
end

return var_0_1
