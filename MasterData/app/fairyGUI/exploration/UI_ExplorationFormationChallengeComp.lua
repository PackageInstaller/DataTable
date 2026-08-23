local var_0_0 = {}

var_0_0.URL = "ui://vhnpxv25nbgf7q"

function var_0_0:__ctor()
	self.m_isMulTeamController = self:getController("isMulTeam")
	self.m_hasBuffController = self:getController("hasBuff")
	self.m_isDebuffController = self:getController("isDebuff")
	self.m_isDiffTipController = self:getController("isDiffTip")
	self.m_hasProfessPassiveController = self:getController("hasProfessPassive")
	self.m_fightValueText = self:getChild("fightValueText")
	self.m_enemyList = self:getChild("enemyList")
	self.m_debuffDesText = self:getChild("debuffDesText")
	self.m_debuffBtn = self:getChild("debuffBtn")
	self.m_teamList = self:getChild("teamList")
	self.m_awardList = self:getChild("awardList")
	self.m_buffIcon = self:getChild("buffIcon")
	self.m_buffClickComp = self:getChild("buffClickComp")
	self.m_buffCountText = self:getChild("buffCountText")
	self.m_battleBtn = self:getChild("battleBtn")
	self.m_skill1 = self:getChild("skill1")
	self.m_skill2 = self:getChild("skill2")
	self.m_skill3 = self:getChild("skill3")
	self.m_diffTipBtn = self:getChild("diffTipBtn")
	self.m_skipTip = self:getChild("skipTip")
end

var_0_0.IsMulTeamCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.HasBuffCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.IsDebuffCtrl = {
	debuff = 1,
	normal = 0
}
var_0_0.IsDiffTipCtrl = {
	tip = 1,
	normal = 0
}
var_0_0.HasProfessPassiveCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
