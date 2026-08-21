local var_0_0 = class("GuildChatBubble", import(".ChatBubble"))

function var_0_0.init(arg_1_0)
	arg_1_0.nameTF = findTF(arg_1_0.tf, "name_bg/name"):GetComponent("Text")
	arg_1_0.face = findTF(arg_1_0.tf, "face/content")
	arg_1_0.circle = findTF(arg_1_0.tf, "shipicon/frame")
	arg_1_0.timeTF = findTF(arg_1_0.tf, "time"):GetComponent("Text")
	arg_1_0.headTF = findTF(arg_1_0.tf, "shipicon/icon"):GetComponent("Image")
	arg_1_0.stars = findTF(arg_1_0.tf, "shipicon/stars")
	arg_1_0.star = findTF(arg_1_0.stars, "star")
	arg_1_0.frame = findTF(arg_1_0.tf, "shipicon/frame"):GetComponent("Image")
	arg_1_0.dutyTF = findTF(arg_1_0.tf, "name_bg/duty")
	arg_1_0.chatBgWidth = 550

	return
end

function var_0_0.OnChatFrameLoaded(arg_2_0, arg_2_1)
	local var_2_0 = tf(arg_2_1):Find("Text"):GetComponent(typeof(Text))

	arg_2_0.prevChatFrameColor = arg_2_0.prevChatFrameColor or var_2_0.color
	arg_2_0.charFrameTxt = var_2_0

	return
end

function var_0_0.dispose(arg_3_0)
	var_0_0.super.dispose(arg_3_0)

	if arg_3_0.charFrameTxt and arg_3_0.prevChatFrameColor then
		arg_3_0.charFrameTxt.color = arg_3_0.prevChatFrameColor
	end

	return
end

return var_0_0
