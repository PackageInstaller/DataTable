local var_0_0 = {}

var_0_0.URL = "ui://bphbd4thipewr9b"

function var_0_0:__ctor()
	self.m_previewList = self:getChild("previewList")
	self.m_chatComp = self:getChild("chatComp")
	self.m_rankBtn = self:getChild("rankBtn")
	self.m_progChestComp = self:getChild("progChestComp")
	self.m_edenGardenBtn = self:getChild("edenGardenBtn")
	self.m_youngBtn = self:getChild("youngBtn")
	self.m_registBtn = self:getChild("registBtn")
	self.m_achievementBtn = self:getChild("achievementBtn")
	self.m_normalSkipFight = self:getChild("normalSkipFight")
	self.m_skipTxt = self:getChild("skipTxt")
	self.m_eff = self:getChild("eff")
	self.m_autoChallengeBtn = self:getChild("autoChallengeBtn")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

return var_0_0
