local var_0_0 = {}

var_0_0.URL = "ui://671qywx2vx7p1u"

function var_0_0:__ctor()
	self.m_rotateComp = self:getChild("rotateComp")
	self.m_suitNameComp = self:getChild("suitNameComp")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
