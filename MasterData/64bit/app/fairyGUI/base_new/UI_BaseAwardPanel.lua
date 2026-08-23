local var_0_0 = {}

var_0_0.URL = "ui://kvb3znep10hvs9p"

function var_0_0:__ctor()
	self.m_showTipsController = self:getController("showTips")
	self.m_tipsText = self:getChild("tipsText")
	self.m_awardList = self:getChild("awardList")
	self.m_openTransition = self:getTransition("open")
	self.m_closeTransition = self:getTransition("close")
end

var_0_0.ShowTipsCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
