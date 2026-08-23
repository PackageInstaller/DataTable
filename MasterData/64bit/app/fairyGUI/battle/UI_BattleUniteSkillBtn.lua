local var_0_0 = {}

var_0_0.URL = "ui://dj6vjom2hcfpq"

function var_0_0:__ctor()
	self.m_hasSkillController = self:getController("hasSkill")
	self.m_lockStatusController = self:getController("lockStatus")
	self.m_effActivated = self:getChild("effActivated")
	self.m_iconComp = self:getChild("iconComp")
	self.m_maskImg1 = self:getChild("maskImg1")
	self.m_effSkillRefresh = self:getChild("effSkillRefresh")
	self.m_costText = self:getChild("costText")
	self.m_maskImg2 = self:getChild("maskImg2")
	self.m_cdText = self:getChild("cdText")
	self.m_lockImg = self:getChild("lockImg")
	self.m_activatedTransition = self:getTransition("activated")
end

var_0_0.HasSkillCtrl = {
	page1 = 1,
	page0 = 0
}
var_0_0.LockStatusCtrl = {
	unlock = 0,
	lock = 1
}

return var_0_0
