local NcPlayChatBubble = class("NcPlayChatBubble", import("..base.NodeCanvasBaseTask"))

function NcPlayChatBubble:OnExecute()
	self:DoAction(self:GetStringArg("storyName"), function()
		self:EndAction()

		return
	end)

	return
end

function NcPlayChatBubble:DoAction(arg_3_1, arg_3_2)
	self:SendEvent(ISLAND_EVT.PLAY_BUBBLE, {
		name = arg_3_1,
		callback = arg_3_2
	})

	return
end

return NcPlayChatBubble
