local var_0_0 = {}

var_0_0.URL = "ui://d5b3cu3gt62o1"

function var_0_0:__ctor()
	self.m_root = self:getChild("root")
	self.m_maxNode = self:getChild("maxNode")
	self.m_nodeComp = self:getChild("nodeComp")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
