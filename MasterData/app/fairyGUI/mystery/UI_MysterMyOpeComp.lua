local var_0_0 = {}

var_0_0.URL = "ui://f0eypm8esv5l51"

function var_0_0:__ctor()
	self.m_state1Controller = self:getController("state1")
	self.m_state2Controller = self:getController("state2")
	self.m_moreBtn = self:getChild("moreBtn")
	self.m_charBtn = self:getChild("charBtn")
	self.m_imgBtn = self:getChild("imgBtn")
	self.m_emoteIcon1 = self:getChild("emoteIcon1")
	self.m_emoteIcon2 = self:getChild("emoteIcon2")
	self.m_emoteIcon3 = self:getChild("emoteIcon3")
	self.m_emoteIcon4 = self:getChild("emoteIcon4")
	self.m_emoteIcon5 = self:getChild("emoteIcon5")
	self.m_emoteIcon6 = self:getChild("emoteIcon6")
	self.m_emote = self:getChild("emote")
	self.m_charComp1 = self:getChild("charComp1")
	self.m_charComp2 = self:getChild("charComp2")
	self.m_charComp3 = self:getChild("charComp3")
	self.m_charComp4 = self:getChild("charComp4")
	self.m_charComp5 = self:getChild("charComp5")
	self.m_charComp6 = self:getChild("charComp6")
	self.m_char = self:getChild("char")
	self.m_enterTransition = self:getTransition("enter")
	self.m_switchTransition = self:getTransition("switch")
end

return var_0_0
