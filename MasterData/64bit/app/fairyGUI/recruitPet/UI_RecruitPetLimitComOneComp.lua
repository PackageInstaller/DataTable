local var_0_0 = {}

var_0_0.URL = "ui://3wkhfdlxirwglgicia"

function var_0_0:__ctor()
	self.m_isShowMaskController = self:getController("isShowMask")
	self.m_leftBgLoader = self:getChild("leftBgLoader")
	self.m_rightBgLoader = self:getChild("rightBgLoader")
	self.m_knightBtn1 = self:getChild("knightBtn1")
	self.m_maskLoader = self:getChild("maskLoader")
	self.m_timeTxt = self:getChild("timeTxt")
	self.m_limitTipLoader = self:getChild("limitTipLoader")
	self.m_raioText = self:getChild("raioText")
	self.m_titleLoader = self:getChild("titleLoader")
	self.m_detailBtn = self:getChild("detailBtn")
	self.m_recruitOneBtn = self:getChild("recruitOneBtn")
	self.m_recruitTenBtn = self:getChild("recruitTenBtn")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

return var_0_0
