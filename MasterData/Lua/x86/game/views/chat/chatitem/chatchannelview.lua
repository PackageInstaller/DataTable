local ChatChannelView = class("ChatChannelView", ChatBaseItemView)

function ChatChannelView:SetData(arg_1_1, arg_1_2)
	self.textTitle_.text = string.format(GetTips("ENTER_CHAT_CHANNEL"), GetI18NText(arg_1_1.content))
	self.index_ = arg_1_2

	self:Show(true)
end

return ChatChannelView
