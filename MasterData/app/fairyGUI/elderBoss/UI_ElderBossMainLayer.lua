local var_0_0 = {}

var_0_0.URL = "ui://8cx1i074d3i51e"

function var_0_0:__ctor()
	self.m_bossStateController = self:getController("bossState")
	self.m_mapComp = self:getChild("mapComp")
	self.m_maskLoader = self:getChild("maskLoader")
	self.m_activityTimeComp = self:getChild("activityTimeComp")
	self.m_bossHpComp = self:getChild("bossHpComp")
	self.m_infoComp = self:getChild("infoComp")
	self.m_honnorRankComp = self:getChild("honnorRankComp")
	self.m_playTimeComp = self:getChild("playTimeComp")
	self.m_battleStateComp = self:getChild("battleStateComp")
	self.m_deadStateComp = self:getChild("deadStateComp")
	self.m_formationBtn = self:getChild("formationBtn")
	self.m_shopBtn = self:getChild("shopBtn")
	self.m_reportBtn = self:getChild("reportBtn")
	self.m_rankBtn = self:getChild("rankBtn")
	self.m_awardBtn = self:getChild("awardBtn")
	self.m_topBarComp = self:getChild("topBarComp")
	self.m_enterTransition = self:getTransition("enter")
end

var_0_0.BossStateCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
