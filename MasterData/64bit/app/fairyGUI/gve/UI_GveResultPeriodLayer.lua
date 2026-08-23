local var_0_0 = {}

var_0_0.URL = "ui://9n9qtghby7pq4c"

function var_0_0:__ctor()
	self.m_knightPicComp = self:getChild("knightPicComp")
	self.m_bestTeamComp = self:getChild("bestTeamComp")
	self.m_seasonRankComp = self:getChild("seasonRankComp")
	self.m_rankBtn = self:getChild("rankBtn")
	self.m_shopBtn = self:getChild("shopBtn")
	self.m_topBarComp = self:getChild("topBarComp")
	self.m_finalBossRankBtn = self:getChild("finalBossRankBtn")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
