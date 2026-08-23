local var_0_0 = {}

var_0_0.URL = "ui://2egchbz1jth63g"

function var_0_0:__ctor()
	self.m_nodeTypeController = self:getController("nodeType")
	self.m_isActiveController = self:getController("isActive")
	self.m_costNumController = self:getController("costNum")
	self.m_isBigNodeController = self:getController("isBigNode")
	self.m_hasConditionController = self:getController("hasCondition")
	self.m_bg = self:getChild("bg")
	self.m_talentIcon = self:getChild("talentIcon")
	self.m_talentName = self:getChild("talentName")
	self.m_attrList = self:getChild("attrList")
	self.m_bigNodeDescText = self:getChild("bigNodeDescText")
	self.m_conditionList = self:getChild("conditionList")
	self.m_resComp1 = self:getChild("resComp1")
	self.m_resComp2 = self:getChild("resComp2")
	self.m_activeBtn = self:getChild("activeBtn")
end

var_0_0.NodeTypeCtrl = {
	page0 = 0,
	page2 = 3,
	page1 = 1,
	page3 = 2
}
var_0_0.IsActiveCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.CostNumCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.IsBigNodeCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.HasConditionCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
