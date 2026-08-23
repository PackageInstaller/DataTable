local var_0_0 = {}

var_0_0.URL = "ui://5c0f8ijkpmhr11"

function var_0_0:__ctor()
	self.m_tabIndexController = self:getController("tabIndex")
	self.m_isCanExchangeController = self:getController("isCanExchange")
	self.m_convertNumTxt = self:getChild("convertNumTxt")
	self.m_exchangeList = self:getChild("exchangeList")
	self.m_rewardList = self:getChild("rewardList")
	self.m_convertBtn = self:getChild("convertBtn")
	self.m_tabList = self:getChild("tabList")
	self.m_enterTransition = self:getTransition("enter")
	self.m_switchTransition = self:getTransition("switch")
end

return var_0_0
