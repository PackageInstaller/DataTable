local var_0_0 = {}

var_0_0.URL = "ui://1rxs0yivjyr416"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_matIcon = self:getChild("matIcon")
end

var_0_0.StateCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
