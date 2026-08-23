local var_0_0 = {}

var_0_0.URL = "ui://c64rm38yhnr5lgic5g"

function var_0_0:__ctor()
	self.m_otherKnightIcon1 = self:getChild("otherKnightIcon1")
	self.m_otherKnightIcon2 = self:getChild("otherKnightIcon2")
	self.m_knightIcon2 = self:getChild("knightIcon2")
	self.m_knightIcon1 = self:getChild("knightIcon1")
	self.m_tipKnightBtn1 = self:getChild("tipKnightBtn1")
	self.m_tipKnightBtn2 = self:getChild("tipKnightBtn2")
	self.m_detailBtn = self:getChild("detailBtn")
	self.m_timeTxt = self:getChild("timeTxt")
	self.m_recruitTenBtn = self:getChild("recruitTenBtn")
	self.m_drawTimeText = self:getChild("drawTimeText")
	self.m_wishMiniComp = self:getChild("wishMiniComp")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

return var_0_0
