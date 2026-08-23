local var_0_0 = {}

var_0_0.URL = "ui://kvb3znepgii1ibo2"

function var_0_0:__ctor()
	self.m_titleHideController = self:getController("titleHide")
	self.m_helpHideController = self:getController("helpHide")
	self.m_homeHideController = self:getController("homeHide")
	self.m_resCountController = self:getController("resCount")
	self.m_pushGiftShowController = self:getController("pushGiftShow")
	self.m_newPushGiftController = self:getController("newPushGift")
	self.m_returnBtn = self:getChild("returnBtn")
	self.m_helpBtn = self:getChild("helpBtn")
	self.m_homeBtn = self:getChild("homeBtn")
	self.m_pushGiftBtn = self:getChild("pushGiftBtn")
	self.m_pushGiftRedPointComp = self:getChild("pushGiftRedPointComp")
	self.m_newPic = self:getChild("newPic")
	self.m_primaryDrawBtn = self:getChild("primaryDrawBtn")
	self.m_navGroup = self:getChild("navGroup")
	self.m_resComp3 = self:getChild("resComp3")
	self.m_resComp2 = self:getChild("resComp2")
	self.m_resComp1 = self:getChild("resComp1")
	self.m_resComp4 = self:getChild("resComp4")
	self.m_resComp5 = self:getChild("resComp5")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

var_0_0.TitleHideCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.HelpHideCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.HomeHideCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.ResCountCtrl = {
	page5 = 5,
	page1 = 1,
	page0 = 0,
	page4 = 4,
	page3 = 3,
	page2 = 2
}
var_0_0.PushGiftShowCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.NewPushGiftCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
