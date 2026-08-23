local var_0_0 = {}

var_0_0.URL = "ui://8cx1i074d3i51f"

function var_0_0:__ctor()
	self.m_bossPlaceComp = self:getChild("bossPlaceComp")
	self.m_maskLoader = self:getChild("maskLoader")
	self.m_rankComp = self:getChild("rankComp")
	self.m_shopBtn = self:getChild("shopBtn")
	self.m_reportBtn = self:getChild("reportBtn")
	self.m_rankBtn = self:getChild("rankBtn")
	self.m_awardBtn = self:getChild("awardBtn")
	self.m_bossInfoComp = self:getChild("bossInfoComp")
	self.m_topBarComp = self:getChild("topBarComp")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
