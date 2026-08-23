local var_0_0 = g.core.config.mystery_chat_info
local MysteryTalkBubble = class("MysteryTalkBubble", require("app.fairyGUI.mystery.UI_MysteryTalkBubble"))

function MysteryTalkBubble:ctor()
	return
end

function MysteryTalkBubble:initTalkBubble(arg_2_1, arg_2_2)
	local var_2_0 = var_0_0.get(arg_2_1)

	if arg_2_2 then
		self:setIcon("icon/talk_pic/" .. var_2_0.expression .. ".png")
		self.m_typeController:setSelectedIndex(1)
	else
		self:setTitle(var_2_0.text)
		self.m_typeController:setSelectedIndex(0)
	end

	self.m_enterTransition:play()
end

return MysteryTalkBubble
