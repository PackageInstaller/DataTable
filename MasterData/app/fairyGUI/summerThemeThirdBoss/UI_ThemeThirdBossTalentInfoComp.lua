local var_0_0 = {}

var_0_0.URL = "ui://aeavo6obldv71p"

function var_0_0:__ctor()
	self.m_talentTypeController = self:getController("talentType")
	self.m_btnStateController = self:getController("btnState")
	self.m_talentIcon = self:getChild("talentIcon")
	self.m_talentName = self:getChild("talentName")
	self.m_talentDesc = self:getChild("talentDesc")
	self.m_attrList = self:getChild("attrList")
	self.m_resetBtn = self:getChild("resetBtn")
	self.m_resComp = self:getChild("resComp")
	self.m_activeBtn = self:getChild("activeBtn")
	self.m_activeUpBtn = self:getChild("activeUpBtn")
	self.m_activeDownBtn = self:getChild("activeDownBtn")
end

var_0_0.TalentTypeCtrl = {
	page0 = 0,
	page2 = 2,
	page1 = 1
}
var_0_0.BtnStateCtrl = {
	page0 = 0,
	page2 = 2,
	page1 = 1,
	page3 = 3
}

return var_0_0
