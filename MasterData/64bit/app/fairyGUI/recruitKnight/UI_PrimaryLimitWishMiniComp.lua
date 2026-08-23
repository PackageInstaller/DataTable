local var_0_0 = {}

var_0_0.URL = "ui://c64rm38y8vsrlgic6g"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_lockTipTxt = self:getChild("lockTipTxt")
	self.m_stateLoader = self:getChild("stateLoader")
	self.m_nameTxt = self:getChild("nameTxt")
	self.m_addLoader = self:getChild("addLoader")
	self.m_eff = self:getChild("eff")
	self.m_iconComp = self:getChild("iconComp")
end

var_0_0.StateCtrl = {
	page2 = 2,
	page1 = 1,
	page0 = 0
}

return var_0_0
