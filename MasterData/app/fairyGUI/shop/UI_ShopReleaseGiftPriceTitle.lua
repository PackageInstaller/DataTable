local var_0_0 = {}

var_0_0.URL = "ui://454a48jpk15o1spemb0"

function var_0_0:__ctor()
	self.m_colorController = self:getController("color")
	self.m_diamond = self:getChild("diamond")
end

var_0_0.ColorCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
