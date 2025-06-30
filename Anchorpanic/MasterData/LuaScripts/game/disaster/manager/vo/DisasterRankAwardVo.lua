module('disaster.DisasterRankAwardVo', Class.impl())

function parseData(self, id, cusData)
    self.id = id
    self.leftRank = cusData.left_rank
    self.rightRank = cusData.right_rank
    self.rewards = cusData.rewards
end

function getRankDifference(self)
    if self.rightRank == 0 then
        return ">="..self.leftRank 
    elseif self.rightRank == self.leftRank then
        return self.rightRank    
    else
        return self.leftRank .. "~" .. self.rightRank
    end
   
end

function getAwardlist(self)
    return AwardPackManager:getAwardListById(self.rewards)
end
return _M
