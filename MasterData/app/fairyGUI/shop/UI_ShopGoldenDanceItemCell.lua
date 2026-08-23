local var_0_0 = {}

var_0_0.URL = "ui://454a48jpsq3awkk35m"

function var_0_0:__ctor()
	self.m_typeController = self:getController("type")
	self.m_cornerController = self:getController("corner")
	self.m_isUnBuyController = self:getController("isUnBuy")
	self.m_isShopUnLockController = self:getController("isShopUnLock")
	self.m_isTimeLimitController = self:getController("isTimeLimit")
	self.m_isFragController = self:getController("isFrag")
	self.m_qualityBg = self:getChild("qualityBg")
	self.m_cellBg = self:getChild("cellBg")
	self.m_item = self:getChild("item")
	self.m_comfortBgImg = self:getChild("comfortBgImg")
	self.m_comfortIconLoader = self:getChild("comfortIconLoader")
	self.m_comfortTxt = self:getChild("comfortTxt")
	self.m_comfortGroup = self:getChild("comfortGroup")
	self.m_tips = self:getChild("tips")
	self.m_num = self:getChild("num")
	self.m_cornerTxt = self:getChild("cornerTxt")
	self.m_nameTxt = self:getChild("nameTxt")
	self.m_limitTimeTxt = self:getChild("limitTimeTxt")
	self.m_oneCostComp = self:getChild("oneCostComp")
	self.m_twoCostComp = self:getChild("twoCostComp")
	self.m_freeTxt = self:getChild("freeTxt")
	self.m_limitTxt = self:getChild("limitTxt")
	self.m_touchBg = self:getChild("touchBg")
	self.m_redPointComp = self:getChild("redPointComp")
end

var_0_0.TypeCtrl = {
	page2 = 2,
	page1 = 1,
	page4 = 4,
	page0 = 0,
	page3 = 3
}
var_0_0.CornerCtrl = {
	page0 = 0,
	page2 = 2,
	page1 = 1,
	page3 = 3
}
var_0_0.IsUnBuyCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.IsShopUnLockCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.IsTimeLimitCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.IsFragCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
