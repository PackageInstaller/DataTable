local var_0_0 = {}

var_0_0.URL = "ui://3ggec6qritsp62"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_iconComp = self:getChild("iconComp")
	self.m_selectIcon = self:getChild("selectIcon")
end

var_0_0.StateCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
