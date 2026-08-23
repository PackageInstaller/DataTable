local var_0_0 = {}

var_0_0.URL = "ui://b3ojz34okit92i"

function var_0_0:__ctor()
	self.m_scoreIcon = self:getChild("scoreIcon")
	self.m_scoreText = self:getChild("scoreText")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

return var_0_0
