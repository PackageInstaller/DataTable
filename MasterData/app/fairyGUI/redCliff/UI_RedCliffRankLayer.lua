local var_0_0 = {}

var_0_0.URL = "ui://ugwozn2snviq5l"

function var_0_0:__ctor()
	self.m_rankTypeController = self:getController("rankType")
	self.m_topSelController = self:getController("topSel")
	self.m_showAllSvrController = self:getController("showAllSvr")
	self.m_topTab = self:getChild("topTab")
	self.m_leftTab = self:getChild("leftTab")
	self.m_rankList = self:getChild("rankList")
	self.m_rewardList = self:getChild("rewardList")
	self.m_passGroup = self:getChild("passGroup")
	self.m_rewardHead = self:getChild("rewardHead")
	self.m_rankTxt = self:getChild("rankTxt")
	self.m_topBarComp = self:getChild("topBarComp")
end

return var_0_0
