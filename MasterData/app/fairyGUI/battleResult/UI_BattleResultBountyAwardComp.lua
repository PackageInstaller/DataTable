local var_0_0 = {}

var_0_0.URL = "ui://2qeh40nkcneqmiby2"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_awardList = self:getChild("awardList")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
