local var_0_0 = {}

var_0_0.URL = "ui://q8j59504n6sm30"

function var_0_0:__ctor()
	self.m_topSelController = self:getController("topSel")
	self.m_topTab = self:getChild("topTab")
	self.m_rankList = self:getChild("rankList")
	self.m_rewardList = self:getChild("rewardList")
	self.m_passGroup = self:getChild("passGroup")
	self.m_rewardHead = self:getChild("rewardHead")
	self.m_rankTxt = self:getChild("rankTxt")
	self.m_noPlayerComp = self:getChild("noPlayerComp")
	self.m_topBarComp = self:getChild("topBarComp")
end

var_0_0.TopSelCtrl = {
	rank = 0,
	reward = 1
}

return var_0_0
