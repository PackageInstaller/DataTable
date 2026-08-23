local var_0_0 = {}

var_0_0.URL = "ui://c64rm38yic2xlgic6n"

function var_0_0:__ctor()
	self.m_titleLoader = self:getChild("titleLoader")
	self.m_tipKnightBtn1 = self:getChild("tipKnightBtn1")
	self.m_tipKnightBtn3 = self:getChild("tipKnightBtn3")
	self.m_tipKnightBtn2 = self:getChild("tipKnightBtn2")
	self.m_detailBtn = self:getChild("detailBtn")
	self.m_recruitOneBtn = self:getChild("recruitOneBtn")
	self.m_recruitTenBtn = self:getChild("recruitTenBtn")
	self.m_timeTxt = self:getChild("timeTxt")
	self.m_raioText = self:getChild("raioText")
	self.m_wishComp = self:getChild("wishComp")
	self.m_luckBtn = self:getChild("luckBtn")
	self.m_luckIcon = self:getChild("luckIcon")
	self.m_curLuckText = self:getChild("curLuckText")
	self.m_maxLuckText = self:getChild("maxLuckText")
	self.m_extLuckText = self:getChild("extLuckText")
	self.m_effLoop = self:getChild("effLoop")
	self.m_prog = self:getChild("prog")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

return var_0_0
