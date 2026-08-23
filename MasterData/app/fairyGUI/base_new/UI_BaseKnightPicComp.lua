local var_0_0 = {}

var_0_0.URL = "ui://kvb3znephoj5kk2qi"

function var_0_0:__ctor()
	self.m_isNeedDownloadController = self:getController("isNeedDownload")
	self.m_knightImg = self:getChild("knightImg")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
	self.m_blackWhiteTransition = self:getTransition("blackWhite")
end

var_0_0.IsNeedDownloadCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
