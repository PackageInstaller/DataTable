local var_0_0 = {}

var_0_0.URL = "ui://tbm73rkgra3m5ibl6"

function var_0_0:__ctor()
	self.m_showAddController = self:getController("showAdd")
	self.m_isShowVitController = self:getController("isShowVit")
	self.m_vitRecoverComp = self:getChild("vitRecoverComp")
	self.m_vitLabel = self:getChild("vitLabel")
	self.m_addBtnLoader = self:getChild("addBtnLoader")
end

var_0_0.ShowAddCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.IsShowVitCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
