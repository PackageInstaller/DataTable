local var_0_0 = {}

var_0_0.URL = "ui://pbd24sill6sa5r"

function var_0_0:__ctor()
	self.m_isDownController = self:getController("isDown")
	self.m_myRankText = self:getChild("myRankText")
	self.m_myScoreText = self:getChild("myScoreText")
	self.m_rankList = self:getChild("rankList")
	self.m_downBtn = self:getChild("downBtn")
end

return var_0_0
