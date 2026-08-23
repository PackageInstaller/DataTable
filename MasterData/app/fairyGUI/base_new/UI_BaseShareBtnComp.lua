local var_0_0 = {}

var_0_0.URL = "ui://kvb3zneptiigwkk31d"

function var_0_0:__ctor()
	self.m_show_awardController = self:getController("show_award")
	self.m_showRightController = self:getController("showRight")
	self.m_shareBtn = self:getChild("shareBtn")
	self.m_resComp = self:getChild("resComp")
	self.m_rewardGroup = self:getChild("rewardGroup")
	self.m_resComp1 = self:getChild("resComp1")
	self.m_rewardGroup1 = self:getChild("rewardGroup1")
	self.m_fadeOutTransition = self:getTransition("fadeOut")
end

var_0_0.Show_awardCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.ShowRightCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
