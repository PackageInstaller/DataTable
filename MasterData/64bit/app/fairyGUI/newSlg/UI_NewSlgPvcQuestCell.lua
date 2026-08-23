local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt97vxb61"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_awardList = self:getChild("awardList")
	self.m_getBtn = self:getChild("getBtn")
	self.m_routeBtn = self:getChild("routeBtn")
	self.m_taskDescTxt = self:getChild("taskDescTxt")
	self.m_nameTxt = self:getChild("nameTxt")
end

var_0_0.StateCtrl = {
	page0 = 0,
	page2 = 2,
	page1 = 1
}

return var_0_0
