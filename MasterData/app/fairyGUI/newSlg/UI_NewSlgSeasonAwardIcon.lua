local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9l28f969kp"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_icon = self:getChild("icon")
	self.m_eff = self:getChild("eff")
end

var_0_0.StateCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
