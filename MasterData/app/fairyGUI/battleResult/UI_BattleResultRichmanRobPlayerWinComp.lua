local var_0_0 = {}

var_0_0.URL = "ui://2qeh40nkjxnsmibyc"

function var_0_0:__ctor()
	self.m_winStateController = self:getController("winState")
	self.m_rewardList = self:getChild("rewardList")
	self.m_withOutAward = self:getChild("withOutAward")
end

return var_0_0
