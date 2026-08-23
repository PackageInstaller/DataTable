local var_0_0 = {}

var_0_0.URL = "ui://16fa1nlapz8f51"

function var_0_0:__ctor()
	self.m_typeController = self:getController("type")
	self.m_effBg = self:getChild("effBg")
	self.m_tipKnightBtn3 = self:getChild("tipKnightBtn3")
	self.m_tipKnightBtn1 = self:getChild("tipKnightBtn1")
	self.m_tipKnightBtn2 = self:getChild("tipKnightBtn2")
	self.m_detailBtn = self:getChild("detailBtn")
	self.m_raioText = self:getChild("raioText")
	self.m_timeTxt = self:getChild("timeTxt")
	self.m_wishComp = self:getChild("wishComp")
	self.m_luckBtn = self:getChild("luckBtn")
	self.m_luckIcon = self:getChild("luckIcon")
	self.m_curLuckText = self:getChild("curLuckText")
	self.m_maxLuckText = self:getChild("maxLuckText")
	self.m_effLoop = self:getChild("effLoop")
	self.m_prog = self:getChild("prog")
	self.m_extLuckText = self:getChild("extLuckText")
	self.m_drawTimeText = self:getChild("drawTimeText")
	self.m_awardList = self:getChild("awardList")
	self.m_recruitOneBtn = self:getChild("recruitOneBtn")
	self.m_recruitTenBtn = self:getChild("recruitTenBtn")
	self.m_giftBtn = self:getChild("giftBtn")
	self.m_moveComp = self:getChild("moveComp")
	self.m_ssrComp = self:getChild("ssrComp")
	self.m_topBarComp = self:getChild("topBarComp")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

var_0_0.TypeCtrl = {
	page2 = 2,
	page5 = 5,
	page1 = 1,
	page4 = 4,
	page0 = 0,
	page6 = 6,
	page3 = 3
}

return var_0_0
