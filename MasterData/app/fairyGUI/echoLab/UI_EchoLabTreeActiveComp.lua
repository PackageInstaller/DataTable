local var_0_0 = {}

var_0_0.URL = "ui://2egchbz1npa53p"

function var_0_0:__ctor()
	self.m_isEmptyController = self:getController("isEmpty")
	self.m_isBigController = self:getController("isBig")
	self.m_eff = self:getChild("eff")
	self.m_descText = self:getChild("descText")
	self.m_levelText = self:getChild("levelText")
	self.m_levelGroup = self:getChild("levelGroup")
	self.m_talentIcon = self:getChild("talentIcon")
	self.m_nameText = self:getChild("nameText")
	self.m_attrText = self:getChild("attrText")
	self.m_enterTransition = self:getTransition("enter")
end

var_0_0.IsEmptyCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.IsBigCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
