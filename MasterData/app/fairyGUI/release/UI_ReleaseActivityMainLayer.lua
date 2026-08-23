local var_0_0 = {}

var_0_0.URL = "ui://ltl1fuv2rjab0"

function var_0_0:__ctor()
	self.m_knightBtn = self:getChild("knightBtn")
	self.m_spinnerComp = self:getChild("spinnerComp")
	self.m_accumulateComp = self:getChild("accumulateComp")
	self.m_previewComp = self:getChild("previewComp")
	self.m_activityTime = self:getChild("activityTime")
	self.m_taskBtn = self:getChild("taskBtn")
	self.m_giftBtn = self:getChild("giftBtn")
	self.m_giftNameTxt = self:getChild("giftNameTxt")
	self.m_giftEff = self:getChild("giftEff")
	self.m_giftGroup = self:getChild("giftGroup")
	self.m_recordBtn = self:getChild("recordBtn")
	self.m_drawOnceBtn = self:getChild("drawOnceBtn")
	self.m_drawMoreBtn = self:getChild("drawMoreBtn")
	self.m_topBarComp = self:getChild("topBarComp")
	self.m_clickIgnoreMask = self:getChild("clickIgnoreMask")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
