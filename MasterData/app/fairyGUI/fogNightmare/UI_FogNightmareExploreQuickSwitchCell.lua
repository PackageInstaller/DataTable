local var_0_0 = {}

var_0_0.URL = "ui://8l5kh88oadkwrrnp"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_titleText = self:getChild("titleText")
	self.m_knightList = self:getChild("knightList")
	self.m_effectNode = self:getChild("effectNode")
end

var_0_0.StateCtrl = {
	fight = 1,
	normal = 0
}

return var_0_0
