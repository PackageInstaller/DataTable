

module("arena.ArenaRankRewardDataVo", Class.impl())

function parseData(self,refData)
	self.leftRank=refData.left_rank
	self.rightRank=refData.right_rank
	self.rewards=refData.rewards
end

function getRankDifference(self)
    return self.leftRank.."~"..self.rightRank
end

function getAwardlist(self)
    return AwardPackManager:getAwardListById(self.rewards)
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
