local var_0_0 = {}

var_0_0.URL = "ui://f0eypm8efhgqj"

function var_0_0:__ctor()
	self.m_isEliteController = self:getController("isElite")
	self.m_fightValueText = self:getChild("fightValueText")
	self.m_descTxt = self:getChild("descTxt")
	self.m_enemyList = self:getChild("enemyList")
	self.m_awardList = self:getChild("awardList")
	self.m_battleBtn = self:getChild("battleBtn")
	self.m_formationBtn = self:getChild("formationBtn")
end

return var_0_0
