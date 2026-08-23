local var_0_0 = {}

var_0_0.URL = "ui://vhnpxv25nbgf8a"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_skillIcon = self:getChild("skillIcon")
	self.m_addPic = self:getChild("addPic")
	self.m_redPointComp = self:getChild("redPointComp")
end

var_0_0.StateCtrl = {
	page0 = 0,
	page2 = 2,
	page1 = 1
}

return var_0_0
