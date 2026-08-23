local var_0_0 = {}

var_0_0.URL = "ui://d5b3cu3gwzpi3w"

function var_0_0:__ctor()
	self.m_isCenterController = self:getController("isCenter")
	self.m_nodeComp = self:getChild("nodeComp")
	self.m_extraName = self:getChild("extraName")
	self.m_extraAttrList = self:getChild("extraAttrList")
	self.m_extraTip = self:getChild("extraTip")
	self.m_curCount = self:getChild("curCount")
	self.m_maxCount = self:getChild("maxCount")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
