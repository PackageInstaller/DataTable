local var_0_0 = {}

var_0_0.URL = "ui://1b29hdofhh9b32"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_iconComp = self:getChild("iconComp")
	self.m_redPointComp = self:getChild("redPointComp")
	self.m_numTxt = self:getChild("numTxt")
	self.m_eff = self:getChild("eff")
end

var_0_0.StateCtrl = {
	page3 = 3,
	page2 = 0,
	page1 = 1,
	page0 = 2
}

return var_0_0
