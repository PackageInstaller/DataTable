local var_0_0 = {}

var_0_0.URL = "ui://x323b22nje0cb"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_specialController = self:getController("special")
	self.m_hasSelController = self:getController("hasSel")
	self.m_hideTalentController = self:getController("hideTalent")
	self.m_stage = self:getChild("stage")
	self.m_strengDescComp1 = self:getChild("strengDescComp1")
	self.m_strengDescComp2 = self:getChild("strengDescComp2")
	self.m_strengDescComp3 = self:getChild("strengDescComp3")
	self.m_strengDescComp4 = self:getChild("strengDescComp4")
	self.m_talentDesc = self:getChild("talentDesc")
	self.m_costIcon = self:getChild("costIcon")
	self.m_stageUpBtn = self:getChild("stageUpBtn")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

var_0_0.StateCtrl = {
	page1 = 1,
	page0 = 0
}
var_0_0.SpecialCtrl = {
	page1 = 1,
	page0 = 0
}
var_0_0.HasSelCtrl = {
	page1 = 1,
	page0 = 0
}
var_0_0.HideTalentCtrl = {
	has = 0,
	hide = 1
}

return var_0_0
