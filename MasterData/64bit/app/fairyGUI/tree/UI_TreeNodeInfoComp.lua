local var_0_0 = {}

var_0_0.URL = "ui://d5b3cu3gz2du2w"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_nodeComp = self:getChild("nodeComp")
	self.m_nodeCompAfter = self:getChild("nodeCompAfter")
	self.m_attrList = self:getChild("attrList")
	self.m_extraBtn = self:getChild("extraBtn")
	self.m_extraName = self:getChild("extraName")
	self.m_attrDesc = self:getChild("attrDesc")
	self.m_tips = self:getChild("tips")
	self.m_conditionList = self:getChild("conditionList")
	self.m_conditionGroup = self:getChild("conditionGroup")
	self.m_subAddComp = self:getChild("subAddComp")
	self.m_upgradeBtn = self:getChild("upgradeBtn")
	self.m_resComp = self:getChild("resComp")
	self.m_resGroup = self:getChild("resGroup")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
