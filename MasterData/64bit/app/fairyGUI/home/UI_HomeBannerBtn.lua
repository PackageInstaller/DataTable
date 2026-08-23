local var_0_0 = {}

var_0_0.URL = "ui://tbm73rkgd85e5ibhw"

function var_0_0:__ctor()
	self.m_sizeController = self:getController("size")
	self.m_banner = self:getChild("banner")
end

var_0_0.SizeCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
