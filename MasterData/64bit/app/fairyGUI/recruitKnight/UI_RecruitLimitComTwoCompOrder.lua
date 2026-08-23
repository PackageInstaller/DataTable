local var_0_0 = {}

var_0_0.URL = "ui://c64rm38ywczdq"

function var_0_0:__ctor()
	self.m_tipKnightBtn2 = self:getChild("tipKnightBtn2")
	self.m_tipKnightBtn1 = self:getChild("tipKnightBtn1")
	self.m_timeTxt = self:getChild("timeTxt")
	self.m_limitTipLoader = self:getChild("limitTipLoader")
	self.m_raioText = self:getChild("raioText")
	self.m_recruitOneBtn = self:getChild("recruitOneBtn")
	self.m_recruitTenBtn = self:getChild("recruitTenBtn")
	self.m_detailBtn = self:getChild("detailBtn")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

return var_0_0
