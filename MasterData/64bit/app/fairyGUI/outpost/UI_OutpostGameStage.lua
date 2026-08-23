local var_0_0 = {}

var_0_0.URL = "ui://ziwfw8v5rcutp"

function var_0_0:__ctor()
	self.m_knightShowController = self:getController("knightShow")
	self.m_tipsNumController = self:getController("tipsNum")
	self.m_mapComp = self:getChild("mapComp")
	self.m_titleComp = self:getChild("titleComp")
	self.m_taskComp = self:getChild("taskComp")
	self.m_topBarComp = self:getChild("topBarComp")
	self.m_limitTaskBtn = self:getChild("limitTaskBtn")
	self.m_KnightBtn = self:getChild("KnightBtn")
	self.m_bossBtn = self:getChild("bossBtn")
	self.m_shopBtn = self:getChild("shopBtn")
	self.m_bagBtn = self:getChild("bagBtn")
	self.m_HomeBtn = self:getChild("HomeBtn")
	self.m_touchGraph = self:getChild("touchGraph")
	self.m_tip3Btn = self:getChild("tip3Btn")
	self.m_tip2Btn = self:getChild("tip2Btn")
	self.m_tip1Btn = self:getChild("tip1Btn")
	self.m_knightShowComp = self:getChild("knightShowComp")
	self.m_speedBtn = self:getChild("speedBtn")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
