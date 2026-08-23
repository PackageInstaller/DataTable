local var_0_0 = {}

var_0_0.URL = "ui://lom3h0lcjyex47"

function var_0_0:__ctor()
	self.m_typeController = self:getController("type")
	self.m_topBarComp = self:getChild("topBarComp")
	self.m_dailyTaskTab = self:getChild("dailyTaskTab")
	self.m_achievementTab = self:getChild("achievementTab")
	self.m_coutdown = self:getChild("coutdown")
	self.m_dailyTaskList = self:getChild("dailyTaskList")
	self.m_achievementTaskList = self:getChild("achievementTaskList")
	self.m_enterTransition = self:getTransition("enter")
end

var_0_0.TypeCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
