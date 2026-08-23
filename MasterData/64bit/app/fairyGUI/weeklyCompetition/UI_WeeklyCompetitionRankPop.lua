local var_0_0 = {}

var_0_0.URL = "ui://b3ojz34ou53x24"

function var_0_0:__ctor()
	self.m_isMyRankController = self:getController("isMyRank")
	self.m_hasRankListController = self:getController("hasRankList")
	self.m_rankList = self:getChild("rankList")
	self.m_downBg = self:getChild("downBg")
	self.m_rankValueText = self:getChild("rankValueText")
	self.m_topBg1 = self:getChild("topBg1")
	self.m_topBarComp = self:getChild("topBarComp")
end

return var_0_0
