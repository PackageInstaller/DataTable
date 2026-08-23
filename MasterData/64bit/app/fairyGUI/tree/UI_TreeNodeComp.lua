local var_0_0 = {}

var_0_0.URL = "ui://d5b3cu3gqsng31"

function var_0_0:__ctor()
	self.m_nodeTypeController = self:getController("nodeType")
	self.m_node1 = self:getChild("node1")
	self.m_node2 = self:getChild("node2")
	self.m_node3 = self:getChild("node3")
	self.m_qualityTop = self:getChild("qualityTop")
	self.m_nodeName = self:getChild("nodeName")
end

return var_0_0
