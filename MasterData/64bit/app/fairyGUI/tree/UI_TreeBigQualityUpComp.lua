local var_0_0 = {}

var_0_0.URL = "ui://d5b3cu3gwzpi3s"

function var_0_0:__ctor()
	self.m_showFinishController = self:getController("showFinish")
	self.m_nodeComp = self:getChild("nodeComp")
	self.m_nodeCompBefore = self:getChild("nodeCompBefore")
	self.m_beforeDesc = self:getChild("beforeDesc")
	self.m_afterDesc = self:getChild("afterDesc")
	self.m_extraName = self:getChild("extraName")
	self.m_attrList = self:getChild("attrList")
	self.m_extraAttrList = self:getChild("extraAttrList")
	self.m_extraTip = self:getChild("extraTip")
	self.m_enterTransition = self:getTransition("enter")
	self.m_enter2Transition = self:getTransition("enter2")
end

return var_0_0
