local var_0_0 = {}

var_0_0.URL = "ui://14huq3sfhob8u"

function var_0_0:__ctor()
	self.m_bgComp = self:getChild("bgComp")
	self.m_tip2 = self:getChild("tip2")
	self.m_attrDesc = self:getChild("attrDesc")
	self.m_passiveIcon = self:getChild("passiveIcon")
	self.m_textLoader = self:getChild("textLoader")
	self.m_userSignComp = self:getChild("userSignComp")
	self.m_knightSignComp = self:getChild("knightSignComp")
	self.m_timeText = self:getChild("timeText")
	self.m_reviewBtn = self:getChild("reviewBtn")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
