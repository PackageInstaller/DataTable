local var_0_0 = {}

var_0_0.URL = "ui://pbd24silwcih1b"

function var_0_0:__ctor()
	self.m_topSelController = self:getController("topSel")
	self.m_topTab = self:getChild("topTab")
	self.m_rankList = self:getChild("rankList")
	self.m_rewardList = self:getChild("rewardList")
	self.m_passGroup = self:getChild("passGroup")
	self.m_rewardHead = self:getChild("rewardHead")
	self.m_rankTxt = self:getChild("rankTxt")
	self.m_topBarComp = self:getChild("topBarComp")
	self.m_noPlayerComp = self:getChild("noPlayerComp")
end

return var_0_0
