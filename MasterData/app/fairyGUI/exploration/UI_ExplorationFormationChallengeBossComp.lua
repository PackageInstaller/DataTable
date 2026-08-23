local var_0_0 = {}

var_0_0.URL = "ui://vhnpxv25vio48m"

function var_0_0:__ctor()
	self.m_isMulTeamController = self:getController("isMulTeam")
	self.m_isEnoughController = self:getController("isEnough")
	self.m_enemyList = self:getChild("enemyList")
	self.m_awardList = self:getChild("awardList")
	self.m_costTxt = self:getChild("costTxt")
	self.m_battleBtn = self:getChild("battleBtn")
	self.m_rankBtn = self:getChild("rankBtn")
end

var_0_0.IsMulTeamCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.IsEnoughCtrl = {
	page0 = 1,
	page1 = 0
}

return var_0_0
