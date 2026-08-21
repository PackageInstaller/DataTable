local var_0_0 = class("MainChatRoomView4Mellow", import("...theme_classic.view.MainChatRoomView"))

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.bgTr = arg_1_1:Find("bg")

	var_0_0.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	arg_1_0.MAX_COUNT = 1

	return
end

function var_0_0.GoChatView(arg_2_0, arg_2_1)
	if arg_2_0.exited then
		return
	end

	arg_2_0:emit(NewMainMediator.OPEN_CHATVIEW)

	return
end

function var_0_0.UpdateBtnState(arg_3_0)
	var_0_0.super.UpdateBtnState(arg_3_0)

	local var_3_0 = arg_3_0.hideChatFlag and arg_3_0.hideChatFlag == 1

	setActive(arg_3_0.bgTr, not var_3_0)

	return
end

function var_0_0.GetDirection(arg_4_0)
	return Vector2.zero
end

return var_0_0
