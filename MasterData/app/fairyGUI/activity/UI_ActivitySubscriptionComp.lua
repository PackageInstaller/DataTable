local var_0_0 = {}

var_0_0.URL = "ui://zr5xrl9whs8u2a"

function var_0_0:__ctor()
	self.m_buyStateController = self:getController("buyState")
	self.m_rewardStateController = self:getController("rewardState")
	self.m_knightPicComp = self:getChild("knightPicComp")
	self.m_rewardBtn = self:getChild("rewardBtn")
	self.m_rewardList = self:getChild("rewardList")
	self.m_descList = self:getChild("descList")
	self.m_rechargeBtn = self:getChild("rechargeBtn")
	self.m_priceTxt = self:getChild("priceTxt")
	self.m_buyedTxt = self:getChild("buyedTxt")
	self.m_buyDescTxt = self:getChild("buyDescTxt")
	self.m_enterTransition = self:getTransition("enter")
end

var_0_0.BuyStateCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.RewardStateCtrl = {
	page0 = 0,
	page2 = 2,
	page1 = 1
}

return var_0_0
