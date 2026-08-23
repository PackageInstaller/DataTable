local var_0_0 = {}

var_0_0.URL = "ui://6ljwas8lzqgm2l"

function var_0_0:__ctor()
	self.m_isShowDiffController = self:getController("isShowDiff")
	self.m_diffLoader = self:getChild("diffLoader")
	self.m_fightValueText = self:getChild("fightValueText")
	self.m_enemyList = self:getChild("enemyList")
	self.m_awardList = self:getChild("awardList")
	self.m_costLoader = self:getChild("costLoader")
	self.m_costTxt = self:getChild("costTxt")
	self.m_battleBtn = self:getChild("battleBtn")
end

var_0_0.IsShowDiffCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
