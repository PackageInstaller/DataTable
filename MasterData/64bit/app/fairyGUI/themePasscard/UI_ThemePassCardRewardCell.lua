local var_0_0 = {}

var_0_0.URL = "ui://tpt7g5qxpaduf"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_isLimitBuyController = self:getController("isLimitBuy")
	self.m_isBuyController = self:getController("isBuy")
	self.m_starIcon = self:getChild("starIcon")
	self.m_rankText = self:getChild("rankText")
	self.m_freeList = self:getChild("freeList")
	self.m_payList = self:getChild("payList")
	self.m_btn = self:getChild("btn")
	self.m_btnText = self:getChild("btnText")
	self.m_buyLimitText = self:getChild("buyLimitText")
	self.m_redPointComp = self:getChild("redPointComp")
end

var_0_0.StateCtrl = {
	received = 2,
	match = 1,
	lock = 0
}
var_0_0.IsLimitBuyCtrl = {
	limit = 1,
	normal = 0
}
var_0_0.IsBuyCtrl = {
	buy = 1,
	normal = 0
}

return var_0_0
