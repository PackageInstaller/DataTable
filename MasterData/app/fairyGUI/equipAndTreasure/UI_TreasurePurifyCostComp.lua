local var_0_0 = {}

var_0_0.URL = "ui://xoarmyu7lbh7cj"

function var_0_0:__ctor()
	self.m_costNumController = self:getController("costNum")
	self.m_isShowController = self:getController("isShow")
	self.m_costList = self:getChild("costList")
end

var_0_0.CostNumCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.IsShowCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
