local var_0_0 = g.core.config.mystery_chat_info
local MysteryMyOpeComp = class("MysteryMyOpeComp", require("app.fairyGUI.mystery.UI_MysteryMyOpeComp"))

function MysteryMyOpeComp:ctor()
	self.m_moreBtn:addClickListener(handler(self, self._onClickMore))
	self:initOperation()
end

function MysteryMyOpeComp:setShowState(arg_2_1)
	if arg_2_1 then
		self:setVisible(true)
		self.m_enterTransition:play()
	else
		self:setVisible(false)
	end
end

function MysteryMyOpeComp:initOperation()
	for iter_3_0, iter_3_1 in var_0_0.ipairs() do
		self["m_charComp" .. iter_3_0]:setTitle(iter_3_1.text)
		self["m_charComp" .. iter_3_0]:setMysteryChatData(iter_3_1.id, false)
		self["m_emoteIcon" .. iter_3_0]:setIcon("icon/talk_pic/" .. iter_3_1.expression .. ".png")
		self["m_emoteIcon" .. iter_3_0]:setMysteryChatData(iter_3_1.id, true)
	end
end

function MysteryMyOpeComp:resetSelfState()
	self.m_state1Controller:setSelectedIndex(0)
end

function MysteryMyOpeComp:resetSelfState()
	self.m_state1Controller:setSelectedIndex(0)
end

function MysteryMyOpeComp:_onClickMore()
	self.m_state1Controller:setSelectedIndex(1)
end

return MysteryMyOpeComp
