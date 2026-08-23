local var_0_0 = {}

var_0_0.URL = "ui://b3ojz34oiurh0"

function var_0_0:__ctor()
	self.m_tabSelController = self:getController("tabSel")
	self.m_isShowRankController = self:getController("isShowRank")
	self.m_isEmptyController = self:getController("isEmpty")
	self.m_localBtn = self:getChild("localBtn")
	self.m_crossBtn = self:getChild("crossBtn")
	self.m_serverBtn = self:getChild("serverBtn")
	self.m_screenCross = self:getChild("screenCross")
	self.m_topCell1 = self:getChild("topCell1")
	self.m_topCell2 = self:getChild("topCell2")
	self.m_topCell3 = self:getChild("topCell3")
	self.m_otherRankList = self:getChild("otherRankList")
	self.m_myRank = self:getChild("myRank")
	self.m_noRankTxt = self:getChild("noRankTxt")
	self.m_myScore = self:getChild("myScore")
	self.m_tipTxt = self:getChild("tipTxt")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
