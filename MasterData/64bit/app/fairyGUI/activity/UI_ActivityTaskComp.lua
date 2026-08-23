local var_0_0 = {}

var_0_0.URL = "ui://zr5xrl9wy8kt5y"

function var_0_0:__ctor()
	self.m_completeController = self:getController("complete")
	self.m_name = self:getChild("name")
	self.m_num = self:getChild("num")
	self.m_routeBtn = self:getChild("routeBtn")
end

var_0_0.CompleteCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
