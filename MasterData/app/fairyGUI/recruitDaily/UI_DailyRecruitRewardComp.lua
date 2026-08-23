local var_0_0 = {}

var_0_0.URL = "ui://3w60uerptdy26"

function var_0_0:__ctor()
	self.m_qualityController = self:getController("quality")
	self.m_showTypeController = self:getController("showType")
	self.m_hasLinkController = self:getController("hasLink")
	self.m_isNewController = self:getController("isNew")
	self.m_effDown = self:getChild("effDown")
	self.m_effDownIdle = self:getChild("effDownIdle")
	self.m_itemIcon = self:getChild("itemIcon")
	self.m_linkComp = self:getChild("linkComp")
	self.m_effUp = self:getChild("effUp")
	self.m_effIdle = self:getChild("effIdle")
	self.m_miniIcon = self:getChild("miniIcon")
	self.m_sizeText = self:getChild("sizeText")
	self.m_nameTxt = self:getChild("nameTxt")
	self.m_enter0Transition = self:getTransition("enter0")
	self.m_enter1Transition = self:getTransition("enter1")
	self.m_enter2Transition = self:getTransition("enter2")
	self.m_switchTransition = self:getTransition("switch")
end

return var_0_0
