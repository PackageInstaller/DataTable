local var_0_0 = {}

var_0_0.URL = "ui://hw835jy1s4k46"

function var_0_0:__ctor()
	self.m_hideGiftController = self:getController("hideGift")
	self.m_isLimitController = self:getController("isLimit")
	self.m_suitBtn1 = self:getChild("suitBtn1")
	self.m_suitBtn2 = self:getChild("suitBtn2")
	self.m_titleLoader = self:getChild("titleLoader")
	self.m_recruitOneBtn = self:getChild("recruitOneBtn")
	self.m_recruitTenBtn = self:getChild("recruitTenBtn")
	self.m_detailBtn = self:getChild("detailBtn")
	self.m_giftBtn = self:getChild("giftBtn")
	self.m_timeTxt = self:getChild("timeTxt")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

return var_0_0
