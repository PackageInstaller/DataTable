local var_0_0 = {}

var_0_0.URL = "ui://akds0szaf4700"

function var_0_0:__ctor()
	self.m_bgLoader = self:getChild("bgLoader")
	self.m_guideBtn = self:getChild("guideBtn")
	self.m_mapName = self:getChild("mapName")
	self.m_mapDesc = self:getChild("mapDesc")
	self.m_rankLoader = self:getChild("rankLoader")
	self.m_rankName = self:getChild("rankName")
	self.m_honorNum = self:getChild("honorNum")
	self.m_crossRank = self:getChild("crossRank")
	self.m_matchBtn = self:getChild("matchBtn")
	self.m_createTeamBtn = self:getChild("createTeamBtn")
	self.m_deployBtn = self:getChild("deployBtn")
	self.m_shopBtn = self:getChild("shopBtn")
	self.m_rankBtn = self:getChild("rankBtn")
	self.m_taskBtn = self:getChild("taskBtn")
	self.m_chatBtn = self:getChild("chatBtn")
	self.m_leftTimeTxt = self:getChild("leftTimeTxt")
	self.m_challengesNumComp = self:getChild("challengesNumComp")
	self.m_topBarComp = self:getChild("topBarComp")
	self.m_guide_3 = self:getChild("guide_3")
	self.m_guide_1 = self:getChild("guide_1")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
