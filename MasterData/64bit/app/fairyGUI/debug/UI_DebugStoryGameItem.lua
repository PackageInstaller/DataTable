local var_0_0 = {}

var_0_0.URL = "ui://7x1mja7ybud85ibje"

function var_0_0:__ctor()
	self.m_activeController = self:getController("active")
	self.m_radius = self:getChild("radius")
end

var_0_0.ActiveCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
