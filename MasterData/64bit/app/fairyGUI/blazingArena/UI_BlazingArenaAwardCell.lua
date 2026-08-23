local var_0_0 = {}

var_0_0.URL = "ui://7ex6tye9iqj727"

function var_0_0:__ctor()
	self.m_isTopThreeController = self:getController("isTopThree")
	self.m_isShowBgController = self:getController("isShowBg")
	self.m_rankIndexComp = self:getChild("rankIndexComp")
	self.m_rankText = self:getChild("rankText")
	self.m_awardList = self:getChild("awardList")
end

return var_0_0
