local var_0_0 = {}

var_0_0.URL = "ui://tbm73rkgg6b55iblf"

function var_0_0:__ctor()
	self.m_unlockedController = self:getController("unlocked")
	self.m_stateController = self:getController("state")
	self.m_redPointComp = self:getChild("redPointComp")
	self.m_cdTxt = self:getChild("cdTxt")
end

var_0_0.UnlockedCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.StateCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
