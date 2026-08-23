local var_0_0 = {}

var_0_0.URL = "ui://671qywx2e2zg2b"

function var_0_0:__ctor()
	self.m_lastLevelText = self:getChild("lastLevelText")
	self.m_levelText = self:getChild("levelText")
	self.m_nameActiveTxt = self:getChild("nameActiveTxt")
	self.m_talentNameTxt = self:getChild("talentNameTxt")
	self.m_talentDescTxt = self:getChild("talentDescTxt")
	self.m_passiveGroup = self:getChild("passiveGroup")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
