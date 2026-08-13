class = var_0_10000

local var_0_0 = "MainChatRoomView4Mellow"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...theme_classic.view.MainChatRoomView"))

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.bgTr = arg_1_1:Find("bg")

	var_0_1.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	arg_1_0.MAX_COUNT = 1

	return
end

function var_0_1.GoChatView(arg_2_0, arg_2_1)
	if arg_2_0.exited then
		return
	end

	local var_2_0 = arg_2_0
	local var_2_1 = arg_2_0.emit

	NewMainMediator = var_1_10004

	var_2_1(var_2_0, var_1_10004.OPEN_CHATVIEW)

	return
end

function var_0_1.UpdateBtnState(arg_3_0)
	var_0_1.super.UpdateBtnState(arg_3_0)

	local var_3_0

	if arg_3_0.hideChatFlag then
		var_3_0 = arg_3_0.hideChatFlag == 1
	end

	setActive = var_2

	var_2(arg_3_0.bgTr, not var_3_0)

	return
end

function var_0_1.GetDirection(arg_4_0)
	Vector2 = var_1_10001

	return var_1_10001.zero
end

return var_0_1
