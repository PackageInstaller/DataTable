local var_0_0 = {}

var_0_0.URL = "ui://454a48jpfxqys"

function var_0_0:__ctor()
	self.m_styleController = self:getController("style")
	self.m_redPointComp = self:getChild("redPointComp")
end

var_0_0.StyleCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
