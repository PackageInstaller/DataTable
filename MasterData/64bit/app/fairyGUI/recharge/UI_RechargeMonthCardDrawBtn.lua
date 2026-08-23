local var_0_0 = {}

var_0_0.URL = "ui://6r1mv52wgmjece"

function var_0_0:__ctor()
	self.m_statusController = self:getController("status")
	self.m_eff_get = self:getChild("eff_get")
end

var_0_0.StatusCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
