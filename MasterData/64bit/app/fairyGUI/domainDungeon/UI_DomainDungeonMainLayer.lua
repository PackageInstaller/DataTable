local var_0_0 = {}

var_0_0.URL = "ui://z48x0zjhofajg"

function var_0_0:__ctor()
	self.m_knightComp = self:getChild("knightComp")
	self.m_stageComp1 = self:getChild("stageComp1")
	self.m_stageComp2 = self:getChild("stageComp2")
	self.m_stageComp3 = self:getChild("stageComp3")
	self.m_stageComp4 = self:getChild("stageComp4")
	self.m_stageComp5 = self:getChild("stageComp5")
	self.m_stageComp6 = self:getChild("stageComp6")
	self.m_stageComp7 = self:getChild("stageComp7")
	self.m_leftGroup = self:getChild("leftGroup")
	self.m_enemyComp = self:getChild("enemyComp")
	self.m_stageInfoComp = self:getChild("stageInfoComp")
	self.m_leftCountTxt = self:getChild("leftCountTxt")
	self.m_shopBtn = self:getChild("shopBtn")
	self.m_lineUpBtn = self:getChild("lineUpBtn")
	self.m_battleBtn = self:getChild("battleBtn")
	self.m_attackEff = self:getChild("attackEff")
	self.m_guideHolderComp = self:getChild("guideHolderComp")
	self.m_topBarComp = self:getChild("topBarComp")
	self.m_enterTransition = self:getTransition("enter")
	self.m_switchTransition = self:getTransition("switch")
	self.m_resetTransition = self:getTransition("reset")
end

return var_0_0
