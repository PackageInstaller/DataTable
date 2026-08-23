local var_0_0 = {}

var_0_0.URL = "ui://9n9qtghbk8ln5"

function var_0_0:__ctor()
	self.m_openFinalBossController = self:getController("openFinalBoss")
	self.m_mapComp = self:getChild("mapComp")
	self.m_chatComp = self:getChild("chatComp")
	self.m_relicBtn = self:getChild("relicBtn")
	self.m_siteInfoComp = self:getChild("siteInfoComp")
	self.m_redPointComp = self:getChild("redPointComp")
	self.m_knightBtn = self:getChild("knightBtn")
	self.m_shopBtn = self:getChild("shopBtn")
	self.m_instituteBtn = self:getChild("instituteBtn")
	self.m_taskBtn = self:getChild("taskBtn")
	self.m_miniMapBtn = self:getChild("miniMapBtn")
	self.m_topBarComp = self:getChild("topBarComp")
	self.m_buffComp = self:getChild("buffComp")
	self.m_idleRewardBtn = self:getChild("idleRewardBtn")
	self.m_effBox = self:getChild("effBox")
	self.m_rewardGroup = self:getChild("rewardGroup")
	self.m_finalBossBtn = self:getChild("finalBossBtn")
	self.m_effShowBtn = self:getChild("effShowBtn")
	self.m_preFormationBtn = self:getChild("preFormationBtn")
	self.m_playerIcon = self:getChild("playerIcon")
	self.m_stageRankBtn = self:getChild("stageRankBtn")
	self.m_infoBtn = self:getChild("infoBtn")
	self.m_finalBossRankBtn = self:getChild("finalBossRankBtn")
	self.m_fundBtn = self:getChild("fundBtn")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
