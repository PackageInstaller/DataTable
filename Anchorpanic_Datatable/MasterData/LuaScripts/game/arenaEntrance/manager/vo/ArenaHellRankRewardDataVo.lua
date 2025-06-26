module("arenaEntrance.ArenaHellRankRewardDataVo", Class.impl())

function parseData(self,refData)
	self.leftRank=refData.left_rank
	self.rightRank=refData.right_rank
	self.rewards=refData.rewards
	self.week_rewards=refData.week_rewards
end

function getRankDifference(self)
    return self.leftRank.."~"..self.rightRank
end

function getAwardlist(self)
    return AwardPackManager:getAwardListById(self.rewards)
end

function getWeekAwardlist(self)
    return AwardPackManager:getAwardListById(self.week_rewards)
end

return _M