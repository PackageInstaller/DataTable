local var_0_0 = {}

var_0_0.URL = "ui://8cx1i074z7w4b"

function var_0_0:__ctor()
	self.m_bgLoader = self:getChild("bgLoader")
	self.m_bossPlace = self:getChild("bossPlace")
	self.m_bossDescComp = self:getChild("bossDescComp")
	self.m_group1 = self:getChild("group1")
	self.m_group2 = self:getChild("group2")
	self.m_group3 = self:getChild("group3")
	self.m_group4 = self:getChild("group4")
	self.m_group5 = self:getChild("group5")
	self.m_openTimeTxt = self:getChild("openTimeTxt")
	self.m_serverListTouchArea = self:getChild("serverListTouchArea")
	self.m_rankBtn = self:getChild("rankBtn")
	self.m_topBarComp = self:getChild("topBarComp")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
