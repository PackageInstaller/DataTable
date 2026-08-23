local var_0_0 = {}

var_0_0.URL = "ui://c64rm38ywczd2f"

function var_0_0:__ctor()
	self.m_childComp1 = self:getChild("childComp1")
	self.m_childComp = self:getChild("childComp")
	self.m_primaryComp = self:getChild("primaryComp")
	self.m_topBarComp = self:getChild("topBarComp")
	self.m_moveComp = self:getChild("moveComp")
	self.m_leftNode = self:getChild("leftNode")
	self.m_ssrComp = self:getChild("ssrComp")
	self.m_backTransition = self:getTransition("back")
	self.m_enterTransition = self:getTransition("enter")
	self.m_shadowShowTransition = self:getTransition("shadowShow")
	self.m_ssr2Transition = self:getTransition("ssr2")
	self.m_ssr1Transition = self:getTransition("ssr1")
	self.m_bgTransition = self:getTransition("bg")
	self.m_teamIconTransition = self:getTransition("teamIcon")
end

return var_0_0
