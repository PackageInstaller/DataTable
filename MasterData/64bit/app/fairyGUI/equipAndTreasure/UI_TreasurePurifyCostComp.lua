local var_0_0 = {}

var_0_0.URL = "ui://xoarmyu7lbh7cj"

function var_0_0:__ctor()
	self.m_costNumController = self:getController("costNum")
	self.m_isShowController = self:getController("isShow")
	self.m_costList = self:getChild("costList")
end

var_0_0.CostNumCtrl = {
	page1 = 1,
	page0 = 0
}
var_0_0.IsShowCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
