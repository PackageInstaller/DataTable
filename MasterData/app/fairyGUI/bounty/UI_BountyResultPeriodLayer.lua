local var_0_0 = {}

var_0_0.URL = "ui://1v7lxemfqr6v2w"

function var_0_0:__ctor()
	self.m_isEmptyController = self:getController("isEmpty")
	self.m_knightPicComp = self:getChild("knightPicComp")
	self.m_bestTeamComp = self:getChild("bestTeamComp")
	self.m_seasonRankComp = self:getChild("seasonRankComp")
	self.m_shareBtn = self:getChild("shareBtn")
	self.m_pointBtn = self:getChild("pointBtn")
	self.m_shopBtn = self:getChild("shopBtn")
	self.m_rankBtn = self:getChild("rankBtn")
	self.m_shareRedPointComp = self:getChild("shareRedPointComp")
	self.m_topBarComp = self:getChild("topBarComp")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
