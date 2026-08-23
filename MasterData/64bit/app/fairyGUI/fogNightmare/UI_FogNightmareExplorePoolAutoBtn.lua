local var_0_0 = {}

var_0_0.URL = "ui://8l5kh88ou8jrrrj6"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_tipText = self:getChild("tipText")
end

var_0_0.StateCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
