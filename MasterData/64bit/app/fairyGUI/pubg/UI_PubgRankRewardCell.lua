local var_0_0 = {}

var_0_0.URL = "ui://pbd24silwcih1e"

function var_0_0:__ctor()
	self.m_hasBgController = self:getController("hasBg")
	self.m_rankComp = self:getChild("rankComp")
	self.m_rewardList = self:getChild("rewardList")
end

return var_0_0
