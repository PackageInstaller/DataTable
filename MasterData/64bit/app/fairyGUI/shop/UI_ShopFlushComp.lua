local var_0_0 = {}

var_0_0.URL = "ui://454a48jpluqoy"

function var_0_0:__ctor()
	self.m_isLimitTimeController = self:getController("isLimitTime")
	self.m_canFlushController = self:getController("canFlush")
	self.m_knightComp = self:getChild("knightComp")
	self.m_shopName = self:getChild("shopName")
	self.m_freeTimeTxt = self:getChild("freeTimeTxt")
	self.m_itemList = self:getChild("itemList")
	self.m_flushBtn = self:getChild("flushBtn")
	self.m_enterTransition = self:getTransition("enter")
end

var_0_0.IsLimitTimeCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.CanFlushCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
