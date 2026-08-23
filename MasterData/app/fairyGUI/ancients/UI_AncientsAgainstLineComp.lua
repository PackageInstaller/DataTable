local var_0_0 = {}

var_0_0.URL = "ui://18k9xvs2gdro5v"

function var_0_0:__ctor()
	self.m_typeController = self:getController("type")
	self.m_stateController = self:getController("state")
	self.m_effDi = self:getChild("effDi")
end

var_0_0.TypeCtrl = {
	page0 = 0,
	page2 = 2,
	page1 = 1,
	page3 = 3
}
var_0_0.StateCtrl = {
	page0 = 0,
	page2 = 2,
	page1 = 1
}

return var_0_0
