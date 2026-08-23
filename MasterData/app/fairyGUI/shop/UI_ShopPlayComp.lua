local var_0_0 = {}

var_0_0.URL = "ui://454a48jpluqov"

function var_0_0:__ctor()
	self.m_isShowSubController = self:getController("isShowSub")
	self.m_showTipController = self:getController("showTip")
	self.m_showTypeController = self:getController("showType")
	self.m_isSeasonController = self:getController("isSeason")
	self.m_seasonStatusController = self:getController("seasonStatus")
	self.m_isBountyController = self:getController("isBounty")
	self.m_isEmptyController = self:getController("isEmpty")
	self.m_oneKeyBtnStateController = self:getController("oneKeyBtnState")
	self.m_knightComp = self:getChild("knightComp")
	self.m_tabList = self:getChild("tabList")
	self.m_shopName = self:getChild("shopName")
	self.m_subheadTxt = self:getChild("subheadTxt")
	self.m_descTxt = self:getChild("descTxt")
	self.m_lastTimeTxt = self:getChild("lastTimeTxt")
	self.m_seasonLastTime = self:getChild("seasonLastTime")
	self.m_itemList = self:getChild("itemList")
	self.m_tipTxt = self:getChild("tipTxt")
	self.m_tipsTxt = self:getChild("tipsTxt")
	self.m_tipsTxt2 = self:getChild("tipsTxt2")
	self.m_timeTips = self:getChild("timeTips")
	self.m_clickArea = self:getChild("clickArea")
	self.m_oneKeyBuyBtn = self:getChild("oneKeyBuyBtn")
	self.m_enterTransition = self:getTransition("enter")
end

var_0_0.IsShowSubCtrl = {
	page0 = 0,
	page2 = 2,
	page1 = 1
}
var_0_0.ShowTipCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.ShowTypeCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.IsSeasonCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.SeasonStatusCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.IsBountyCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.IsEmptyCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.OneKeyBtnStateCtrl = {
	不可用 = 0,
	可用 = 1
}

return var_0_0
