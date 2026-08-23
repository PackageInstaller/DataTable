local var_0_0 = {}

var_0_0.URL = "ui://6ljwas8lkxd0dd"

function var_0_0:__ctor()
	self.m_isDeadController = self:getController("isDead")
	self.m_iconComp = self:getChild("iconComp")
	self.m_hpProgress = self:getChild("hpProgress")
end

var_0_0.IsDeadCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
