local var_0_0 = {}

var_0_0.URL = "ui://akds0szaf4702"

function var_0_0:__ctor()
	self.m_isCaptainController = self:getController("isCaptain")
	self.m_isReadyController = self:getController("isReady")
	self.m_bgLoader = self:getChild("bgLoader")
	self.m_effHolder = self:getChild("effHolder")
	self.m_mapComp = self:getChild("mapComp")
	self.m_screenBtn = self:getChild("screenBtn")
	self.m_enterBattleBtn = self:getChild("enterBattleBtn")
	self.m_tipsTxt = self:getChild("tipsTxt")
	self.m_chatBtn = self:getChild("chatBtn")
	self.m_inviteBtn = self:getChild("inviteBtn")
	self.m_deployBtn = self:getChild("deployBtn")
	self.m_mapInfoComp = self:getChild("mapInfoComp")
	self.m_autoJoinBtn = self:getChild("autoJoinBtn")
	self.m_memberNum = self:getChild("memberNum")
	self.m_challengesNumComp = self:getChild("challengesNumComp")
	self.m_topBarComp = self:getChild("topBarComp")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
