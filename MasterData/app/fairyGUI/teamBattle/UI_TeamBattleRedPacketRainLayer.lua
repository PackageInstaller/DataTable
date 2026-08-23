local var_0_0 = {}

var_0_0.URL = "ui://6ljwas8lueup66"

function var_0_0:__ctor()
	self.m_bgDi = self:getChild("bgDi")
	self.m_redPacketHolder = self:getChild("redPacketHolder")
	self.m_topBarComp = self:getChild("topBarComp")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
