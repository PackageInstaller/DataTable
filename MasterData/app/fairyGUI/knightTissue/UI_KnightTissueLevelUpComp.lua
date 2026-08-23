local var_0_0 = {}

var_0_0.URL = "ui://gntkqnnjb4obbnp"

function var_0_0:__ctor()
	self.m_attrCountController = self:getController("attrCount")
	self.m_noPassiveController = self:getController("noPassive")
	self.m_activateStateController = self:getController("activateState")
	self.m_lastLevelText = self:getChild("lastLevelText")
	self.m_levelText = self:getChild("levelText")
	self.m_attr1 = self:getChild("attr1")
	self.m_attr2 = self:getChild("attr2")
	self.m_attr3 = self:getChild("attr3")
	self.m_nameActiveTxt = self:getChild("nameActiveTxt")
	self.m_skillNameTxt = self:getChild("skillNameTxt")
	self.m_descText = self:getChild("descText")
	self.m_passiveGroup = self:getChild("passiveGroup")
	self.m_openTransition = self:getTransition("open")
end

var_0_0.AttrCountCtrl = {
	page0 = 0,
	page2 = 2,
	page1 = 1
}
var_0_0.NoPassiveCtrl = {
	无被动 = 0,
	有被动 = 1
}
var_0_0.ActivateStateCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
