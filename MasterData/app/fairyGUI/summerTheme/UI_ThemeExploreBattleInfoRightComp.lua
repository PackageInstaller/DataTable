local var_0_0 = {}

var_0_0.URL = "ui://99hn3059lz1jkk348"

function var_0_0:__ctor()
	self.m_showLineController = self:getController("showLine")
	self.m_lackController = self:getController("lack")
	self.m_knightPicComp = self:getChild("knightPicComp")
	self.m_nameTxt = self:getChild("nameTxt")
	self.m_fightValueTxt = self:getChild("fightValueTxt")
	self.m_costLoader = self:getChild("costLoader")
	self.m_costTxt = self:getChild("costTxt")
	self.m_enemyList = self:getChild("enemyList")
	self.m_descComp = self:getChild("descComp")
	self.m_lineupBtn = self:getChild("lineupBtn")
	self.m_battleBtn = self:getChild("battleBtn")
	self.m_guideHolderComp = self:getChild("guideHolderComp")
	self.m_monsterTaklTxt = self:getChild("monsterTaklTxt")
	self.m_effUiAudio = self:getChild("effUiAudio")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

var_0_0.ShowLineCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.LackCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
