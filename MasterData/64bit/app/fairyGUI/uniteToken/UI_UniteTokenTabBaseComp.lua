local var_0_0 = {}

var_0_0.URL = "ui://3yl23vbxj4mi1k"

function var_0_0:__ctor()
	self.m_showPassiveController = self:getController("showPassive")
	self.m_skillRangeTxt = self:getChild("skillRangeTxt")
	self.m_totalAttrComp1 = self:getChild("totalAttrComp1")
	self.m_totalAttrComp2 = self:getChild("totalAttrComp2")
	self.m_totalAttrComp3 = self:getChild("totalAttrComp3")
	self.m_totalAttrComp4 = self:getChild("totalAttrComp4")
	self.m_skillIcon = self:getChild("skillIcon")
	self.m_skillNameText = self:getChild("skillNameText")
	self.m_skillDescComp = self:getChild("skillDescComp")
	self.m_passiveIcon = self:getChild("passiveIcon")
	self.m_passiveName = self:getChild("passiveName")
	self.m_passiveDesc = self:getChild("passiveDesc")
	self.m_descText = self:getChild("descText")
end

var_0_0.ShowPassiveCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
