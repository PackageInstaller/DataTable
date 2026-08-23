local var_0_0 = {}

var_0_0.URL = "ui://r7y8vwhafo7xw"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_knightPicComp = self:getChild("knightPicComp")
	self.m_monsterInfoComp = self:getChild("monsterInfoComp")
	self.m_playTimeComp = self:getChild("playTimeComp")
	self.m_ownCardComp = self:getChild("ownCardComp")
	self.m_chooseCardComp = self:getChild("chooseCardComp")
	self.m_goToBtn = self:getChild("goToBtn")
	self.m_costLoader = self:getChild("costLoader")
	self.m_costNum = self:getChild("costNum")
	self.m_costGroup = self:getChild("costGroup")
	self.m_battleBtn = self:getChild("battleBtn")
	self.m_formationBtn = self:getChild("formationBtn")
	self.m_skipBattleCheckBtn = self:getChild("skipBattleCheckBtn")
	self.m_hpText = self:getChild("hpText")
	self.m_userHpProgress = self:getChild("userHpProgress")
	self.m_topBarComp = self:getChild("topBarComp")
	self.m_enterTransition = self:getTransition("enter")
	self.m_battleTransition = self:getTransition("battle")
end

return var_0_0
