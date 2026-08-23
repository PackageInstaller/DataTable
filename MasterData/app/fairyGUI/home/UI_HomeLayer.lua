local var_0_0 = {}

var_0_0.URL = "ui://tbm73rkgd85e5ibhi"

function var_0_0:__ctor()
	self.m_assistantComp = self:getChild("assistantComp")
	self.m_phoneBarComp = self:getChild("phoneBarComp")
	self.m_userInfoComp = self:getChild("userInfoComp")
	self.m_passComp = self:getChild("passComp")
	self.m_activityComp = self:getChild("activityComp")
	self.m_mainQuestComp = self:getChild("mainQuestComp")
	self.m_settingComp = self:getChild("settingComp")
	self.m_entranceComp = self:getChild("entranceComp")
	self.m_resItemComp = self:getChild("resItemComp")
	self.m_themeComp = self:getChild("themeComp")
	self.m_otherComp = self:getChild("otherComp")
	self.m_bannerComp = self:getChild("bannerComp")
	self.m_taskComp = self:getChild("taskComp")
	self.m_effComp = self:getChild("effComp")
	self.m_linesText = self:getChild("linesText")
	self.m_talkGroup = self:getChild("talkGroup")
	self.m_mainGroup = self:getChild("mainGroup")
	self.m_t0Transition = self:getTransition("t0")
	self.m_hideTransition = self:getTransition("hide")
	self.m_showTransition = self:getTransition("show")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
