local var_0_0 = {}

var_0_0.URL = "ui://5c0f8ijkv4o810"

function var_0_0:__ctor()
	self.m_lastLevelText = self:getChild("lastLevelText")
	self.m_levelText = self:getChild("levelText")
	self.m_attrComp1 = self:getChild("attrComp1")
	self.m_attrComp2 = self:getChild("attrComp2")
	self.m_attrComp3 = self:getChild("attrComp3")
	self.m_attrComp4 = self:getChild("attrComp4")
	self.m_nameActiveTxt = self:getChild("nameActiveTxt")
	self.m_talentNameTxt = self:getChild("talentNameTxt")
	self.m_talentDescTxt = self:getChild("talentDescTxt")
	self.m_passiveGroup = self:getChild("passiveGroup")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
