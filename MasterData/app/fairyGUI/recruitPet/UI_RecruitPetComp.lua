local var_0_0 = {}

var_0_0.URL = "ui://3wkhfdlxmp9elgicf0"

function var_0_0:__ctor()
	self.m_rightBigLoader = self:getChild("rightBigLoader")
	self.m_leftBigLoader = self:getChild("leftBigLoader")
	self.m_leftLoader = self:getChild("leftLoader")
	self.m_rightLoader = self:getChild("rightLoader")
	self.m_knightBtn1 = self:getChild("knightBtn1")
	self.m_knightBtn2 = self:getChild("knightBtn2")
	self.m_effectNode = self:getChild("effectNode")
	self.m_detailBtn = self:getChild("detailBtn")
	self.m_recruitOneBtn = self:getChild("recruitOneBtn")
	self.m_recruitTenBtn = self:getChild("recruitTenBtn")
	self.m_shopBtn = self:getChild("shopBtn")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

return var_0_0
