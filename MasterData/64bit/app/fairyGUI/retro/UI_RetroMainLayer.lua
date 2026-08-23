local var_0_0 = {}

var_0_0.URL = "ui://e2ymx4wan8ajv"

function var_0_0:__ctor()
	self.m_timeComp = self:getChild("timeComp")
	self.m_stageComp = self:getChild("stageComp")
	self.m_poolComp = self:getChild("poolComp")
	self.m_refreshBtn = self:getChild("refreshBtn")
	self.m_refreshAllBtn = self:getChild("refreshAllBtn")
	self.m_knight1 = self:getChild("knight1")
	self.m_knight2 = self:getChild("knight2")
	self.m_knight3 = self:getChild("knight3")
	self.m_shopBtn = self:getChild("shopBtn")
	self.m_taskBtn = self:getChild("taskBtn")
	self.m_giftBtn = self:getChild("giftBtn")
	self.m_guaranteeNumTxt = self:getChild("guaranteeNumTxt")
	self.m_guaranteeNumTxt1 = self:getChild("guaranteeNumTxt1")
	self.m_topBarComp = self:getChild("topBarComp")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
