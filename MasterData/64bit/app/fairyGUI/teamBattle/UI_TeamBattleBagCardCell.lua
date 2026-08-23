local var_0_0 = {}

var_0_0.URL = "ui://6ljwas8lhtqy2a"

function var_0_0:__ctor()
	self.m_isDeadController = self:getController("isDead")
	self.m_knightIcon = self:getChild("knightIcon")
	self.m_quality = self:getChild("quality")
	self.m_starComp = self:getChild("starComp")
	self.m_hpProgress = self:getChild("hpProgress")
end

var_0_0.IsDeadCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
