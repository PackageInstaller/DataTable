local var_0_0 = {}

var_0_0.URL = "ui://tbm73rkgk8ni5ibo4"

function var_0_0:__ctor()
	self.m_cell1 = self:getChild("cell1")
	self.m_cell2 = self:getChild("cell2")
	self.m_cell3 = self:getChild("cell3")
	self.m_cell4 = self:getChild("cell4")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
