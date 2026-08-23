local var_0_0 = {}

var_0_0.URL = "ui://5c0f8ijkv4o80"

function var_0_0:__ctor()
	self.m_pageController = self:getController("page")
	self.m_bg = self:getChild("bg")
	self.m_effBg = self:getChild("effBg")
	self.m_rightPanel = self:getChild("rightPanel")
	self.m_increaseComp = self:getChild("increaseComp")
	self.m_exchangeComp = self:getChild("exchangeComp")
	self.m_topBarComp = self:getChild("topBarComp")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
