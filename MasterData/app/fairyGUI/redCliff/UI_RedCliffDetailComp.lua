local var_0_0 = {}

var_0_0.URL = "ui://ugwozn2smu7u2"

function var_0_0:__ctor()
	self.m_desc = self:getChild("desc")
	self.m_ladderTimeTxt = self:getChild("ladderTimeTxt")
	self.m_finalTimeTxt = self:getChild("finalTimeTxt")
	self.m_ruleBtn = self:getChild("ruleBtn")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
