local var_0_0 = {}

var_0_0.URL = "ui://3yl23vbxo4o41t"

function var_0_0:__ctor()
	self.m_showPassiveController = self:getController("showPassive")
	self.m_starComp = self:getChild("starComp")
	self.m_passiveIcon = self:getChild("passiveIcon")
	self.m_totalAttrComp1 = self:getChild("totalAttrComp1")
	self.m_totalAttrComp2 = self:getChild("totalAttrComp2")
	self.m_totalAttrComp3 = self:getChild("totalAttrComp3")
	self.m_totalAttrComp4 = self:getChild("totalAttrComp4")
	self.m_propertyGroup = self:getChild("propertyGroup")
	self.m_skillIcon = self:getChild("skillIcon")
	self.m_skillLevelTxt = self:getChild("skillLevelTxt")
	self.m_passiveLevel = self:getChild("passiveLevel")
	self.m_enterTransition = self:getTransition("enter")
end

var_0_0.ShowPassiveCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
