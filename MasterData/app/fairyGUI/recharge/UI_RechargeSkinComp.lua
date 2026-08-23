local var_0_0 = {}

var_0_0.URL = "ui://6r1mv52wt3hc6i"

function var_0_0:__ctor()
	self.m_isScreenController = self:getController("isScreen")
	self.m_isShowController = self:getController("isShow")
	self.m_isEmptyController = self:getController("isEmpty")
	self.m_isLimitController = self:getController("isLimit")
	self.m_isTimeLimitController = self:getController("isTimeLimit")
	self.m_canBuyController = self:getController("canBuy")
	self.m_knightPicComp2 = self:getChild("knightPicComp2")
	self.m_knightPicComp = self:getChild("knightPicComp")
	self.m_skinList = self:getChild("skinList")
	self.m_skinNameTxt = self:getChild("skinNameTxt")
	self.m_knightNameTxt = self:getChild("knightNameTxt")
	self.m_timeTxt = self:getChild("timeTxt")
	self.m_showBtn = self:getChild("showBtn")
	self.m_skinBookBtn = self:getChild("skinBookBtn")
	self.m_screenBtn = self:getChild("screenBtn")
	self.m_cancelScreenBtn = self:getChild("cancelScreenBtn")
	self.m_ticketScreenBtn = self:getChild("ticketScreenBtn")
	self.m_ticketScreenGroup = self:getChild("ticketScreenGroup")
	self.m_screenGroup = self:getChild("screenGroup")
	self.m_buyBtn = self:getChild("buyBtn")
	self.m_ticketBtn = self:getChild("ticketBtn")
	self.m_discountBuyBtn = self:getChild("discountBuyBtn")
	self.m_buyGroup = self:getChild("buyGroup")
	self.m_touchBg = self:getChild("touchBg")
	self.m_attrTxt = self:getChild("attrTxt")
	self.m_skinAttrGroup = self:getChild("skinAttrGroup")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
	self.m_switchTransition = self:getTransition("switch")
	self.m_showTransition = self:getTransition("show")
	self.m_hideTransition = self:getTransition("hide")
end

var_0_0.IsScreenCtrl = {
	page0 = 0,
	page1 = 2
}
var_0_0.IsShowCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.IsEmptyCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.IsLimitCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.IsTimeLimitCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.CanBuyCtrl = {
	page0 = 0,
	page2 = 3,
	page1 = 1
}

return var_0_0
