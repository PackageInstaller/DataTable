local ChatTimeView = class("ChatTimeView", ChatBaseItemView)

function ChatTimeView:IsTimeBar()
	return true
end

function ChatTimeView:SetData(arg_2_1, arg_2_2)
	self.textTimeStamp_.text = manager.time:FormatTime(arg_2_1.timestamp)
	self.index_ = arg_2_2

	self:Show(true)
end

return ChatTimeView
