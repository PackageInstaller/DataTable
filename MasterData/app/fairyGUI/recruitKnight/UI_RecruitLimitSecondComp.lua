local var_0_0 = {}

var_0_0.URL = "ui://c64rm38ywczde"

function var_0_0:__ctor()
	self.m_effectHolder1 = self:getChild("effectHolder1")
	self.m_effectHolder2 = self:getChild("effectHolder2")
	self.m_effectHolder4 = self:getChild("effectHolder4")
	self.m_tipKnightBtn1 = self:getChild("tipKnightBtn1")
	self.m_detailBtn = self:getChild("detailBtn")
	self.m_effectHolder3 = self:getChild("effectHolder3")
	self.m_timeTxt = self:getChild("timeTxt")
	self.m_raioText = self:getChild("raioText")
	self.m_recruitOneBtn = self:getChild("recruitOneBtn")
	self.m_recruitTenBtn = self:getChild("recruitTenBtn")
	self.m_flagIcon = self:getChild("flagIcon")
	self.m_giftBtn = self:getChild("giftBtn")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

return var_0_0
