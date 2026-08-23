local var_0_0 = {}

var_0_0.URL = "ui://c64rm38ywczdn"

function var_0_0:__ctor()
	self.m_isShowMaskController = self:getController("isShowMask")
	self.m_tipKnightBtn1 = self:getChild("tipKnightBtn1")
	self.m_maskLoader = self:getChild("maskLoader")
	self.m_leaderDescTxt = self:getChild("leaderDescTxt")
	self.m_timeTxt = self:getChild("timeTxt")
	self.m_limitTipLoader = self:getChild("limitTipLoader")
	self.m_recruitLimitTxt = self:getChild("recruitLimitTxt")
	self.m_raioText = self:getChild("raioText")
	self.m_titleLoader = self:getChild("titleLoader")
	self.m_detailBtn = self:getChild("detailBtn")
	self.m_recruitOneBtn = self:getChild("recruitOneBtn")
	self.m_recruitTenBtn = self:getChild("recruitTenBtn")
	self.m_giftBtn = self:getChild("giftBtn")
	self.m_leaderTaskBtn = self:getChild("leaderTaskBtn")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

var_0_0.IsShowMaskCtrl = {
	hide = 0,
	show = 1
}

return var_0_0
