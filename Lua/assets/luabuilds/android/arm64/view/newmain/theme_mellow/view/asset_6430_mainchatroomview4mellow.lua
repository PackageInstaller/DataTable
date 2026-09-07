local MainChatRoomView4Mellow = class("MainChatRoomView4Mellow", import("...theme_classic.view.MainChatRoomView"))

function MainChatRoomView4Mellow:Ctor(arg_1_1, arg_1_2)
	self.bgTr = arg_1_1:Find("bg")

	MainChatRoomView4Mellow.super.Ctor(self, arg_1_1, arg_1_2)

	self.MAX_COUNT = 1

	return
end

function MainChatRoomView4Mellow:GoChatView(arg_2_1)
	if self.exited then
		return
	end

	self:emit(NewMainMediator.OPEN_CHATVIEW)

	return
end

function MainChatRoomView4Mellow:UpdateBtnState()
	MainChatRoomView4Mellow.super.UpdateBtnState(self)
	setActive(self.bgTr, not (self.hideChatFlag and self.hideChatFlag == 1))

	return
end

function MainChatRoomView4Mellow:GetDirection()
	return Vector2.zero
end

return MainChatRoomView4Mellow
