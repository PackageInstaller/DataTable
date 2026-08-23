local var_0_0 = {}

var_0_0.URL = "ui://8l5kh88o6jgp9rrtx"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_descText = self:getChild("descText")
	self.m_valueText = self:getChild("valueText")
end

var_0_0.StateCtrl = {
	page0 = 0,
	page2 = 2,
	page1 = 1
}

return var_0_0
