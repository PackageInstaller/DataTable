local var_0_0 = {}

var_0_0.URL = "ui://c64rm38ywczd20"

function var_0_0:__ctor()
	self.m_rewardList = self:getChild("rewardList")
	self.m_effNode = self:getChild("effNode")
	self.m_topBarComp = self:getChild("topBarComp")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

return var_0_0
