local var_0_0 = {}

var_0_0.URL = "ui://2qeh40nku9hbmibz4"

function var_0_0:__ctor()
	self.m_idleList = self:getChild("idleList")
	self.m_awardList = self:getChild("awardList")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
