local var_0_0 = {}

var_0_0.URL = "ui://99hn3059po6mmw2xr1"

function var_0_0:__ctor()
	self.m_styleController = self:getController("style")
	self.m_bg = self:getChild("bg")
end

var_0_0.StyleCtrl = {
	page1 = 1,
	page0 = 0,
	page2 = 2
}

return var_0_0
