local MysteryClickScript = class("MysteryClickScript")

function MysteryClickScript:ctor()
	self:addClickListener(handler(self, self.onClick))
end

function MysteryClickScript:setMysteryChatData(arg_2_1, arg_2_2)
	self._mysteryChatData = {
		id = arg_2_1,
		isEmotion = arg_2_2
	}
end

function MysteryClickScript:onClick()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.MYSTERY_CHAT_BUBBLE, false, self._mysteryChatData)
end

return MysteryClickScript
