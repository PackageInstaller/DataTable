local var_0_0 = {}

var_0_0.URL = "ui://2egchbz1ddca3g"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_icon = self:getChild("icon")
end

var_0_0.StateCtrl = {
	page0 = 0,
	page2 = 2,
	page1 = 1
}

return var_0_0
