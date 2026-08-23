local var_0_0 = {}

var_0_0.URL = "ui://454a48jpfxqys"

function var_0_0:__ctor()
	self.m_styleController = self:getController("style")
	self.m_redPointComp = self:getChild("redPointComp")
end

var_0_0.StyleCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
