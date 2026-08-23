local var_0_0 = {}

var_0_0.URL = "ui://2qeh40nk8llxmibym"

function var_0_0:__ctor()
	self.m_hasAwardController = self:getController("hasAward")
	self.m_rewardList = self:getChild("rewardList")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
