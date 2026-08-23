local var_0_0 = {}

var_0_0.URL = "ui://9j4hqll0homfafc"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_iconLoader = self:getChild("iconLoader")
	self.m_numTxt = self:getChild("numTxt")
	self.m_enterTransition = self:getTransition("enter")
	self.m_getTransition = self:getTransition("get")
end

var_0_0.StateCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
