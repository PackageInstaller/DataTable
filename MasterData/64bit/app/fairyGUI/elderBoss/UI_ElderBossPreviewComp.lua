local var_0_0 = {}

var_0_0.URL = "ui://8cx1i074z7w4o"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_descTxt = self:getChild("descTxt")
	self.m_openTimeTxt = self:getChild("openTimeTxt")
	self.m_clearEff = self:getChild("clearEff")
	self.m_stateTxt = self:getChild("stateTxt")
end

var_0_0.StateCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
