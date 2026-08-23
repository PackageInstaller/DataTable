local var_0_0 = {}

var_0_0.URL = "ui://n47h6oaghuis12"

function var_0_0:__ctor()
	self.m_isSwitchController = self:getController("isSwitch")
	self.m_btnEffect = self:getChild("btnEffect")
	self.m_redPointComp = self:getChild("redPointComp")
end

var_0_0.IsSwitchCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
