local var_0_0 = {}

var_0_0.URL = "ui://zr5xrl9wr5pq6t"

function var_0_0:__ctor()
	self.m_oneBtn = self:getChild("oneBtn")
	self.m_tenBtn = self:getChild("tenBtn")
	self.m_btnGroup = self:getChild("btnGroup")
	self.m_shopBtn = self:getChild("shopBtn")
	self.m_taskBtn = self:getChild("taskBtn")
	self.m_redPointComp = self:getChild("redPointComp")
	self.m_redPointComp1 = self:getChild("redPointComp1")
	self.m_timeTxt = self:getChild("timeTxt")
	self.m_nextStageComp = self:getChild("nextStageComp")
	self.m_SComp = self:getChild("SComp")
	self.m_AComp = self:getChild("AComp")
	self.m_BComp = self:getChild("BComp")
	self.m_sRewardTimesTxt = self:getChild("sRewardTimesTxt")
	self.m_eff = self:getChild("eff")
	self.m_progressTaskComp = self:getChild("progressTaskComp")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
