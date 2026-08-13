class = var_0_10000

local var_0_0 = "GuildChatBubble"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".ChatBubble"))

function var_0_1.init(arg_1_0)
	findTF = var_1_10001

	local var_1_0 = var_1_10001(arg_1_0.tf, "name_bg/name")

	arg_1_0.nameTF = var_1.GetComponent(var_1_0, "Text")
	findTF = var_1
	arg_1_0.face = var_1(arg_1_0.tf, "face/content")
	findTF = var_1
	arg_1_0.circle = var_1(arg_1_0.tf, "shipicon/frame")
	findTF = var_1

	local var_1_1 = var_1(arg_1_0.tf, "time")

	arg_1_0.timeTF = var_1.GetComponent(var_1_1, "Text")
	findTF = var_1

	local var_1_2 = var_1(arg_1_0.tf, "shipicon/icon")

	arg_1_0.headTF = var_1.GetComponent(var_1_2, "Image")
	findTF = var_1
	arg_1_0.stars = var_1(arg_1_0.tf, "shipicon/stars")
	findTF = var_1
	arg_1_0.star = var_1(arg_1_0.stars, "star")
	findTF = var_1

	local var_1_3 = var_1(arg_1_0.tf, "shipicon/frame")

	arg_1_0.frame = var_1.GetComponent(var_1_3, "Image")
	findTF = var_1
	arg_1_0.dutyTF = var_1(arg_1_0.tf, "name_bg/duty")
	arg_1_0.chatBgWidth = 550

	return
end

function var_0_1.OnChatFrameLoaded(arg_2_0, arg_2_1)
	tf = var_1_10002

	local var_2_0 = var_1_10002(arg_2_1)
	local var_2_1 = var_2.Find(var_2_0, "Text")
	local var_2_2 = var_2.GetComponent

	typeof = var_4
	Text = var_1_10005

	local var_2_3 = var_2_2(var_2_1, var_4(var_1_10005))

	if not arg_2_0.prevChatFrameColor then
		arg_2_0.prevChatFrameColor = var_2_3.color
	end

	arg_2_0.charFrameTxt = var_2_3

	return
end

function var_0_1.dispose(arg_3_0)
	var_0_1.super.dispose(arg_3_0)

	if arg_3_0.charFrameTxt and arg_3_0.prevChatFrameColor then
		arg_3_0.charFrameTxt.color = arg_3_0.prevChatFrameColor
	end

	return
end

return var_0_1
