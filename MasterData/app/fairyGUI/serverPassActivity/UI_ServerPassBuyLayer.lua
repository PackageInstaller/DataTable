local var_0_0 = {}

var_0_0.URL = "ui://dy04zo9niea8t"

function var_0_0:__ctor()
	self.m_knightHoldNode = self:getChild("knightHoldNode")
	self.m_passItem1 = self:getChild("passItem1")
	self.m_passItem2 = self:getChild("passItem2")
	self.m_topBar = self:getChild("topBar")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
