local var_0_0 = {}

var_0_0.URL = "ui://ugwozn2smu7u0"

function var_0_0:__ctor()
	self.m_detailComp = self:getChild("detailComp")
	self.m_rightComp = self:getChild("rightComp")
	self.m_rankBtn = self:getChild("rankBtn")
	self.m_shopBtn = self:getChild("shopBtn")
	self.m_taskBtn = self:getChild("taskBtn")
	self.m_topBarComp = self:getChild("topBarComp")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
