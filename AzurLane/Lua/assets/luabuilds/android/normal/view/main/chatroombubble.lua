class = var_0_10000

local var_0_0 = "ChatRoomBubble"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".ChatBubble"))

function var_0_1.init(arg_1_0)
	findTF = var_1_10001

	local var_1_0 = var_1_10001(arg_1_0.tf, "desc/name")

	arg_1_0.nameTF = var_1.GetComponent(var_1_0, "Text")
	findTF = var_1
	arg_1_0.circle = var_1(arg_1_0.tf, "shipicon/frame")
	findTF = var_1
	arg_1_0.face = var_1(arg_1_0.tf, "face/content")
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
	arg_1_0.chatBgWidth = 665

	return
end

return var_0_1
