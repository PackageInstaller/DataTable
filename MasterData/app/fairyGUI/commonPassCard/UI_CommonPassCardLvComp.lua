local var_0_0 = {}

var_0_0.URL = "ui://1b29hdofhh9b2i"

function var_0_0:__ctor()
	self.m_isShowBuyLvController = self:getController("isShowBuyLv")
	self.m_lvTxt = self:getChild("lvTxt")
	self.m_progressComp = self:getChild("progressComp")
	self.m_curProTxt = self:getChild("curProTxt")
	self.m_allProTxt = self:getChild("allProTxt")
	self.m_buyLvBtn = self:getChild("buyLvBtn")
end

var_0_0.IsShowBuyLvCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
