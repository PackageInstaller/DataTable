local var_0_0 = {}

var_0_0.URL = "ui://ugwozn2snviq5s"

function var_0_0:__ctor()
	self.m_hasPlayerController = self:getController("hasPlayer")
	self.m_hasBgController = self:getController("hasBg")
	self.m_rankTxt = self:getChild("rankTxt")
	self.m_rewardList = self:getChild("rewardList")
end

return var_0_0
