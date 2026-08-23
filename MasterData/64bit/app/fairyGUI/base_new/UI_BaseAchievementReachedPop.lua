local var_0_0 = {}

var_0_0.URL = "ui://kvb3znepitc323"

function var_0_0:__ctor()
	self.m_achievementTypeController = self:getController("achievementType")
	self.m_name = self:getChild("name")
	self.m_effComp = self:getChild("effComp")
	self.m_enter_0Transition = self:getTransition("enter_0")
	self.m_enter_1Transition = self:getTransition("enter_1")
end

var_0_0.AchievementTypeCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
