local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9jgu4969id"

function var_0_0:__ctor()
	self.m_talentTypeController = self:getController("talentType")
	self.m_btnStateController = self:getController("btnState")
	self.m_talentName = self:getChild("talentName")
	self.m_nodeIcon = self:getChild("nodeIcon")
	self.m_activeBtn = self:getChild("activeBtn")
	self.m_unlockDesc = self:getChild("unlockDesc")
	self.m_attrList = self:getChild("attrList")
	self.m_condList = self:getChild("condList")
	self.m_resComp1 = self:getChild("resComp1")
	self.m_res1 = self:getChild("res1")
	self.m_resComp2 = self:getChild("resComp2")
	self.m_res2 = self:getChild("res2")
	self.m_activeToBtn = self:getChild("activeToBtn")
	self.m_activeTopBtn = self:getChild("activeTopBtn")
	self.m_activeButtonBtn = self:getChild("activeButtonBtn")
	self.m_activeCurBtn = self:getChild("activeCurBtn")
	self.m_activeAutoBtn = self:getChild("activeAutoBtn")
end

var_0_0.TalentTypeCtrl = {
	page0 = 0,
	page2 = 2,
	page1 = 1
}
var_0_0.BtnStateCtrl = {
	page2 = 4,
	page5 = 6,
	page1 = 3,
	page4 = 5,
	page0 = 0,
	page6 = 7,
	page3 = 1
}

return var_0_0
