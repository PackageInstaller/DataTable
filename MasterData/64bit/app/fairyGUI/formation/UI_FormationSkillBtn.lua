local var_0_0 = {}

var_0_0.URL = "ui://iibfqm99fi8x14"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_styleController = self:getController("style")
	self.m_isOtherController = self:getController("isOther")
	self.m_skillIcon = self:getChild("skillIcon")
	self.m_addPic = self:getChild("addPic")
	self.m_redPointComp = self:getChild("redPointComp")
end

var_0_0.StateCtrl = {
	page2 = 2,
	page1 = 1,
	page0 = 0
}
var_0_0.StyleCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.IsOtherCtrl = {
	other = 1,
	normal = 0
}

return var_0_0
