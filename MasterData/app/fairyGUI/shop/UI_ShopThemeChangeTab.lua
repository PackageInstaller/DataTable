local var_0_0 = {}

var_0_0.URL = "ui://454a48jpu75v1spemie"

function var_0_0:__ctor()
	self.m_isSelectController = self:getController("isSelect")
	self.m_stateController = self:getController("state")
	self.m_unSelectLoader = self:getChild("unSelectLoader")
	self.m_selectLoader = self:getChild("selectLoader")
end

var_0_0.IsSelectCtrl = {
	down = 1,
	up = 0
}
var_0_0.StateCtrl = {
	page0 = 0,
	page2 = 2,
	page1 = 1
}

return var_0_0
