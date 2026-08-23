local var_0_0 = {}

var_0_0.URL = "ui://d5b3cu3gt62o10"

function var_0_0:__ctor()
	self.m_isActiveController = self:getController("isActive")
	self.m_hideStarAndBgController = self:getController("hideStarAndBg")
	self.m_hideRedController = self:getController("hideRed")
	self.m_qualityBg = self:getChild("qualityBg")
	self.m_icon = self:getChild("icon")
	self.m_nodeName = self:getChild("nodeName")
	self.m_eff = self:getChild("eff")
	self.m_node1 = self:getChild("node1")
	self.m_node2 = self:getChild("node2")
	self.m_node3 = self:getChild("node3")
	self.m_redPointComp = self:getChild("redPointComp")
	self.m_upTransition = self:getTransition("up")
end

return var_0_0
