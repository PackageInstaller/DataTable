local var_0_0 = {}

var_0_0.URL = "ui://zr5xrl9wpusucr"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_privilegeList = self:getChild("privilegeList")
	self.m_rechargeBtn = self:getChild("rechargeBtn")
	self.m_priceText = self:getChild("priceText")
	self.m_rechargeAwardList = self:getChild("rechargeAwardList")
	self.m_dailyAwardList = self:getChild("dailyAwardList")
	self.m_enterTransition = self:getTransition("enter")
end

var_0_0.StateCtrl = {
	page0 = 0,
	page2 = 2,
	page1 = 1
}

return var_0_0
