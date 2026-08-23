local var_0_0 = {}

var_0_0.URL = "ui://7x1mja7yeslbl5ibld"

function var_0_0:__ctor()
	self.m_fightValueRate = self:getChild("fightValueRate")
	self.m_winCount = self:getChild("winCount")
	self.m_winRate = self:getChild("winRate")
	self.m_averageRound = self:getChild("averageRound")
	self.m_maxRound = self:getChild("maxRound")
	self.m_highRoundList = self:getChild("highRoundList")
end

return var_0_0
