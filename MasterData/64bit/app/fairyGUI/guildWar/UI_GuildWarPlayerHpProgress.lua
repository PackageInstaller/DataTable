local var_0_0 = {}

var_0_0.URL = "ui://m1cmgw9mqloym6o"

function var_0_0:__ctor()
	self.m_colorController = self:getController("color")
	self.m_bg = self:getChild("bg")
end

var_0_0.ColorCtrl = {
	page1 = 1,
	page0 = 0,
	page2 = 2
}

return var_0_0
