local var_0_0 = {}

var_0_0.URL = "ui://zr5xrl9wyx7im7"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_icon = self:getChild("icon")
end

var_0_0.StateCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
