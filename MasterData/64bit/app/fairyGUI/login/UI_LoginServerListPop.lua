local var_0_0 = {}

var_0_0.URL = "ui://xigti88c8prx3i"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_isShowGroupController = self:getController("isShowGroup")
	self.m_topBar = self:getChild("topBar")
	self.m_kindTree = self:getChild("kindTree")
	self.m_serverList = self:getChild("serverList")
	self.m_groupList = self:getChild("groupList")
end

var_0_0.StateCtrl = {
	page1 = 1,
	page0 = 0
}
var_0_0.IsShowGroupCtrl = {
	hide = 0,
	show = 1
}

return var_0_0
