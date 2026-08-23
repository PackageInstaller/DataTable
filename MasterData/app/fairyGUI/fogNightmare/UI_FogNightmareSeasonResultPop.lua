local var_0_0 = {}

var_0_0.URL = "ui://8l5kh88omi40rrmu"

function var_0_0:__ctor()
	self.m_titleLoader = self:getChild("titleLoader")
	self.m_rank1 = self:getChild("rank1")
	self.m_rank2 = self:getChild("rank2")
	self.m_rank3 = self:getChild("rank3")
	self.m_myRankText = self:getChild("myRankText")
	self.m_rankList = self:getChild("rankList")
	self.m_topBarComp = self:getChild("topBarComp")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
