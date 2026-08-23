local var_0_0 = {}

var_0_0.URL = "ui://q8j59504n6sm2z"

function var_0_0:__ctor()
	self.m_canCollectController = self:getController("canCollect")
	self.m_isCrossController = self:getController("isCross")
	self.m_haveRankController = self:getController("haveRank")
	self.m_canBossController = self:getController("canBoss")
	self.m_bgEff = self:getChild("bgEff")
	self.m_spireItem1 = self:getChild("spireItem1")
	self.m_spireItem2 = self:getChild("spireItem2")
	self.m_spireItem3 = self:getChild("spireItem3")
	self.m_timeText = self:getChild("timeText")
	self.m_titleEff = self:getChild("titleEff")
	self.m_titleGroup = self:getChild("titleGroup")
	self.m_bossComp = self:getChild("bossComp")
	self.m_bossNameText = self:getChild("bossNameText")
	self.m_bannerEff = self:getChild("bannerEff")
	self.m_bossTipsText = self:getChild("bossTipsText")
	self.m_bossClickLoader = self:getChild("bossClickLoader")
	self.m_bossGroup = self:getChild("bossGroup")
	self.m_matchServerBtn = self:getChild("matchServerBtn")
	self.m_serverGroup = self:getChild("serverGroup")
	self.m_shopBtn = self:getChild("shopBtn")
	self.m_shopGroup = self:getChild("shopGroup")
	self.m_rankBtn = self:getChild("rankBtn")
	self.m_rankGroup = self:getChild("rankGroup")
	self.m_collectBtn = self:getChild("collectBtn")
	self.m_collectEffLoader = self:getChild("collectEffLoader")
	self.m_btnGroup = self:getChild("btnGroup")
	self.m_collectGetGroup = self:getChild("collectGetGroup")
	self.m_topBarComp = self:getChild("topBarComp")
	self.m_enterTransition = self:getTransition("enter")
	self.m_getBoxTransition = self:getTransition("getBox")
end

var_0_0.CanCollectCtrl = {
	page2 = 2,
	page1 = 1,
	page0 = 0
}
var_0_0.IsCrossCtrl = {
	page1 = 1,
	page0 = 0
}
var_0_0.HaveRankCtrl = {
	page1 = 1,
	page0 = 0
}
var_0_0.CanBossCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
