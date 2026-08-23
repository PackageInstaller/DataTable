local var_0_0 = {}

var_0_0.URL = "ui://454a48jphzxc1spemj7"

function var_0_0:__ctor()
	self.m_isSelectController = self:getController("isSelect")
	self.m_stateController = self:getController("state")
	self.m_unSelectLoader = self:getChild("unSelectLoader")
	self.m_selectLoader = self:getChild("selectLoader")
end

var_0_0.IsSelectCtrl = {
	up = 0,
	down = 1
}
var_0_0.StateCtrl = {
	page1 = 1,
	page0 = 0,
	page2 = 2
}

return var_0_0
