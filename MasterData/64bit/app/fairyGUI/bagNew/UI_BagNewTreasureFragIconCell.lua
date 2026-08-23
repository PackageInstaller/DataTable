local var_0_0 = {}

var_0_0.URL = "ui://3ggec6qroto34p"

function var_0_0:__ctor()
	self.m_haveController = self:getController("have")
	self.m_iconComp = self:getChild("iconComp")
end

var_0_0.HaveCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
