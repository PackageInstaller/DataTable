local var_0_0 = {}

var_0_0.URL = "ui://iibfqm99lrv6kk2nq"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_knightIcon = self:getChild("knightIcon")
	self.m_addPic = self:getChild("addPic")
	self.m_openText = self:getChild("openText")
	self.m_redPointComp = self:getChild("redPointComp")
end

var_0_0.StateCtrl = {
	page0 = 0,
	page2 = 2,
	page1 = 1,
	page3 = 3
}

return var_0_0
