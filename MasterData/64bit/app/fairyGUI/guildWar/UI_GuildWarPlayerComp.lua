local var_0_0 = {}

var_0_0.URL = "ui://m1cmgw9mjwtuh"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_isMineController = self:getController("isMine")
	self.m_userIcon = self:getChild("userIcon")
	self.m_hpProgress = self:getChild("hpProgress")
	self.m_redPointComp = self:getChild("redPointComp")
end

var_0_0.StateCtrl = {
	page1 = 1,
	page0 = 0,
	page2 = 2
}
var_0_0.IsMineCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
