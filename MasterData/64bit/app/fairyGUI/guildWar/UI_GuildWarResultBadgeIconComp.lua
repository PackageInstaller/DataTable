local var_0_0 = {}

var_0_0.URL = "ui://m1cmgw9mft98m6d"

function var_0_0:__ctor()
	self.m_isShowScoreController = self:getController("isShowScore")
	self.m_showIcon = self:getChild("showIcon")
	self.m_descText = self:getChild("descText")
	self.m_scoreText = self:getChild("scoreText")
	self.m_enterTransition = self:getTransition("enter")
end

var_0_0.IsShowScoreCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
