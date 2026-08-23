local var_0_0 = {}

var_0_0.URL = "ui://whf5j5b58llx19"

function var_0_0:__ctor()
	self.m_tabController = self:getController("tab")
	self.m_btnTextController = self:getController("btnText")
	self.m_knightPicComp = self:getChild("knightPicComp")
	self.m_starComp = self:getChild("starComp")
	self.m_monsterName = self:getChild("monsterName")
	self.m_progressComp = self:getChild("progressComp")
	self.m_tab1 = self:getChild("tab1")
	self.m_tab2 = self:getChild("tab2")
	self.m_tab3 = self:getChild("tab3")
	self.m_fightValueText = self:getChild("fightValueText")
	self.m_descTxt = self:getChild("descTxt")
	self.m_enemyList = self:getChild("enemyList")
	self.m_awardList = self:getChild("awardList")
	self.m_formationBtn = self:getChild("formationBtn")
	self.m_battleBtn = self:getChild("battleBtn")
	self.m_lastChallengeCount = self:getChild("lastChallengeCount")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

return var_0_0
