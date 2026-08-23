local var_0_0 = {}

var_0_0.URL = "ui://cw1w6t2bwczd4"

function var_0_0:__ctor()
	self.m_openWishController = self:getController("openWish")
	self.m_soulTipBtn = self:getChild("soulTipBtn")
	self.m_detailBtn = self:getChild("detailBtn")
	self.m_recruitOneBtn = self:getChild("recruitOneBtn")
	self.m_recruitTenBtn = self:getChild("recruitTenBtn")
	self.m_countDownTxt = self:getChild("countDownTxt")
	self.m_countDown = self:getChild("countDown")
	self.m_wishComp = self:getChild("wishComp")
	self.m_minimumText = self:getChild("minimumText")
	self.m_bigTitle = self:getChild("bigTitle")
	self.m_enterEffect = self:getChild("enterEffect")
	self.m_touchEffect = self:getChild("touchEffect")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

return var_0_0
