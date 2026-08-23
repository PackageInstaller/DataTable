local var_0_0 = {}

var_0_0.URL = "ui://99hn3059hzxc1spemod"

function var_0_0:__ctor()
	self.m_isSelectController = self:getController("isSelect")
	self.m_stateController = self:getController("state")
	self.m_unSelectLoader = self:getChild("unSelectLoader")
	self.m_selectLoader = self:getChild("selectLoader")
	self.m_knightIcon = self:getChild("knightIcon")
	self.m_endStateMask = self:getChild("endStateMask")
end

var_0_0.IsSelectCtrl = {
	up = 2,
	down = 3
}
var_0_0.StateCtrl = {
	page2 = 2,
	page1 = 1,
	page0 = 0
}

return var_0_0
