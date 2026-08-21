local var_0_0 = class("ChatRoomBubble", import(".ChatBubble"))

function var_0_0.init(arg_1_0)
	arg_1_0.nameTF = findTF(arg_1_0.tf, "desc/name"):GetComponent("Text")
	arg_1_0.circle = findTF(arg_1_0.tf, "shipicon/frame")
	arg_1_0.face = findTF(arg_1_0.tf, "face/content")
	arg_1_0.timeTF = findTF(arg_1_0.tf, "time"):GetComponent("Text")
	arg_1_0.headTF = findTF(arg_1_0.tf, "shipicon/icon"):GetComponent("Image")
	arg_1_0.stars = findTF(arg_1_0.tf, "shipicon/stars")
	arg_1_0.star = findTF(arg_1_0.stars, "star")
	arg_1_0.frame = findTF(arg_1_0.tf, "shipicon/frame"):GetComponent("Image")
	arg_1_0.chatBgWidth = 665

	return
end

return var_0_0
