local var_0_0 = {}

var_0_0.URL = "ui://iibfqm99lrv6kk2no"

function var_0_0:__ctor()
	self.m_styleController = self:getController("style")
	self.m_skillComp2 = self:getChild("skillComp2")
	self.m_partnerComp1 = self:getChild("partnerComp1")
	self.m_partnerComp2 = self:getChild("partnerComp2")
	self.m_changeBtn = self:getChild("changeBtn")
	self.m_skillComp1 = self:getChild("skillComp1")
	self.m_cut1Transition = self:getTransition("cut1")
	self.m_cut2Transition = self:getTransition("cut2")
end

var_0_0.StyleCtrl = {
	page0 = 0,
	page2 = 2,
	page1 = 1
}

return var_0_0
