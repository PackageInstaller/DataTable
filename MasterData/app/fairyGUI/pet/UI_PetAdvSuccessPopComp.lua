local var_0_0 = {}

var_0_0.URL = "ui://ko1uzjo7r85o1emigac"

function var_0_0:__ctor()
	self.m_passiveActiveController = self:getController("passiveActive")
	self.m_passiveChangeController = self:getController("passiveChange")
	self.m_lastLevelTxt = self:getChild("lastLevelTxt")
	self.m_levelTxt = self:getChild("levelTxt")
	self.m_talentNameLbl = self:getChild("talentNameLbl")
	self.m_talentDescTxt = self:getChild("talentDescTxt")
	self.m_passiveNameLbl = self:getChild("passiveNameLbl")
	self.m_passiveDescVerScrollLbl = self:getChild("passiveDescVerScrollLbl")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
