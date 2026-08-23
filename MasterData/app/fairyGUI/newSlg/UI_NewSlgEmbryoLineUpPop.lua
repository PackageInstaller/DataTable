local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9hyzz4i"

function var_0_0:__ctor()
	self.m_mainCityComp = self:getChild("mainCityComp")
	self.m_knightBtn = self:getChild("knightBtn")
	self.m_artifactBtn = self:getChild("artifactBtn")
	self.m_petBtn = self:getChild("petBtn")
	self.m_uniteTokenBtn = self:getChild("uniteTokenBtn")
	self.m_succubaBtn = self:getChild("succubaBtn")
	self.m_eff = self:getChild("eff")
	self.m_topBarComp = self:getChild("topBarComp")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

return var_0_0
