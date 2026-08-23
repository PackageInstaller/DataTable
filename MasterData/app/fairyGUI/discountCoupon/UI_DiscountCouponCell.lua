local var_0_0 = {}

var_0_0.URL = "ui://0843cu29m4io9"

function var_0_0:__ctor()
	self.m_appTypeController = self:getController("appType")
	self.m_BuyBtn = self:getChild("BuyBtn")
	self.m_countDown = self:getChild("countDown")
	self.m_itemNum = self:getChild("itemNum")
	self.m_discountNum = self:getChild("discountNum")
	self.m_enterEff = self:getChild("enterEff")
	self.m_moneyUnit = self:getChild("moneyUnit")
	self.m_moneyNum = self:getChild("moneyNum")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
