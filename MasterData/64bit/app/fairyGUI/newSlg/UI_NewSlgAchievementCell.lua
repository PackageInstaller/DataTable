local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9xbwf9697k"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_taskDesc = self:getChild("taskDesc")
	self.m_awardList = self:getChild("awardList")
	self.m_getBtn = self:getChild("getBtn")
	self.m_routeBtn = self:getChild("routeBtn")
end

var_0_0.StateCtrl = {
	page1 = 1,
	page0 = 0,
	page2 = 2
}

return var_0_0
