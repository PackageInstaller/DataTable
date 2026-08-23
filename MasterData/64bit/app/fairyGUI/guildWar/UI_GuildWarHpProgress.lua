local var_0_0 = {}

var_0_0.URL = "ui://m1cmgw9mab5ym6t"

function var_0_0:__ctor()
	self.m_colorController = self:getController("color")
	self.m_progress = self:getChild("progress")
	self.m_bar = self:getChild("bar")
end

var_0_0.ColorCtrl = {
	page2 = 2,
	page1 = 1,
	page0 = 0
}

return var_0_0
