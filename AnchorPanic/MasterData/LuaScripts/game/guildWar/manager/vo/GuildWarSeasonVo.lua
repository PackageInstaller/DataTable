module('guildWar.GuildWarSeasonVo', Class.impl())

function parseData(self, id, cusData)
    self.id = id
    self:parseSeasonData(cusData.season_reward)
end

function parseSeasonData(self, seasonReward)
    self.seasonReward = {}
    for k,v in pairs( seasonReward) do
        local vo = LuaPoolMgr:poolGet(guildWar.GuildWarAwardVo)
        vo:parseData(k, v)
        table.insert(self.seasonReward, vo)
    end

    table.sort(self.seasonReward,function(a,b) return a.id < b.id end)
end

function getSeasonData(self)
    return self.seasonReward
end

-- function getRankDifference(self)
--     if self.rightRank == 0 then
--         return ">="..self.leftRank 
--     elseif self.rightRank == self.leftRank then
--         return self.rightRank    
--     else
--         return self.leftRank .. "~" .. self.rightRank
--     end
-- end

-- function getAwardlist(self)
--     return AwardPackManager:getAwardListById(self.rewards)
-- end

return _M