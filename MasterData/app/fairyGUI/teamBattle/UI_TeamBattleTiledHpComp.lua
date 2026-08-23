local var_0_0 = {}

var_0_0.URL = "ui://6ljwas8lo3z8f3"

function var_0_0:__ctor()
	self.m_isLockController = self:getController("isLock")
	self.m_hpBar = self:getChild("hpBar")
	self.m_proText = self:getChild("proText")
	self.m_eff = self:getChild("eff")
	self.m_showTransition = self:getTransition("show")
	self.m_showEndTransition = self:getTransition("showEnd")
	self.m_hideTransition = self:getTransition("hide")
	self.m_hideEndTransition = self:getTransition("hideEnd")
end

var_0_0.IsLockCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
