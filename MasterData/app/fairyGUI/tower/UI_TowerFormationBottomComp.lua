local var_0_0 = {}

var_0_0.URL = "ui://foyq921sgc0k64"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_posController = self:getController("pos")
	self.m_effectNode = self:getChild("effectNode")
end

var_0_0.StateCtrl = {
	page0 = 0,
	page2 = 2,
	page1 = 1
}
var_0_0.PosCtrl = {
	page2 = 2,
	page5 = 5,
	page1 = 1,
	page4 = 4,
	page0 = 0,
	page3 = 3
}

return var_0_0
