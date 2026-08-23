local var_0_0 = {}

var_0_0.URL = "ui://zr5xrl9wo2389e"

function var_0_0:__ctor()
	self.m_allReceiveController = self:getController("allReceive")
	self.m_numTxt = self:getChild("numTxt")
	self.m_hideGroup = self:getChild("hideGroup")
	self.m_tipGroup = self:getChild("tipGroup")
	self.m_progTxt = self:getChild("progTxt")
	self.m_progressBar = self:getChild("progressBar")
	self.m_progressGroup = self:getChild("progressGroup")
	self.m_receiveBtn = self:getChild("receiveBtn")
	self.m_valueTxt = self:getChild("valueTxt")
	self.m_awardList = self:getChild("awardList")
	self.m_progressAwardGroup = self:getChild("progressAwardGroup")
	self.m_buyBtn = self:getChild("buyBtn")
	self.m_giftList = self:getChild("giftList")
	self.m_progressGiftGroup = self:getChild("progressGiftGroup")
	self.m_returnBtn = self:getChild("returnBtn")
	self.m_rightBtn = self:getChild("rightBtn")
	self.m_leftBtn = self:getChild("leftBtn")
	self.m_rechargeBtn = self:getChild("rechargeBtn")
	self.m_preLevel = self:getChild("preLevel")
	self.m_nextLevel = self:getChild("nextLevel")
	self.m_leftClick = self:getChild("leftClick")
	self.m_rightClick = self:getChild("rightClick")
	self.m_enterTransition = self:getTransition("enter")
	self.m_rightTransition = self:getTransition("right")
	self.m_leftTransition = self:getTransition("left")
end

var_0_0.AllReceiveCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
