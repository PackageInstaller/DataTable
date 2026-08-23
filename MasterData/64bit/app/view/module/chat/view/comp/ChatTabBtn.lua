local ChatTabBtn = class("ChatTabBtn", require("app.fairyGUI.chat.UI_ChatTabBtn"))

function ChatTabBtn:showEffect()
	self.m_effectHolder:addEffectSpine({
		isLoop = false,
		name = "eff_ui_chat_enter",
		scale = 1
	})
end

function ChatTabBtn:setRedId(arg_2_1)
	if arg_2_1 then
		self._redId = arg_2_1

		self.m_redPointComp:setId(arg_2_1)
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.CHAT_CLICK_REFRESH_RED_POINT)
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
			redPointComp = self.m_redPointComp
		})
	end
end

function ChatTabBtn:refreshRed()
	if self._redId then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.CHAT_CLICK_REFRESH_RED_POINT)
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
			redPointComp = self.m_redPointComp
		})
	end
end

return ChatTabBtn
