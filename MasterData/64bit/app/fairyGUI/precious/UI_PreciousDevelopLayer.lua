local var_0_0 = {}

var_0_0.URL = "ui://671qywx2c9i116"

function var_0_0:__ctor()
	self.m_bgLoader = self:getChild("bgLoader")
	self.m_suitComp = self:getChild("suitComp")
	self.m_devComp = self:getChild("devComp")
	self.m_leftBtn = self:getChild("leftBtn")
	self.m_rightBtn = self:getChild("rightBtn")
	self.m_topBar = self:getChild("topBar")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
