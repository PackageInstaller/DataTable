-- @FileName:   GuildBossSeasonRewardConfigVo.lua
-- @Description:   文件描述
-- @Author: ZDH
-- @Date:   2023-11-09 15:49:25
-- @Copyright:   (LY) 2023 雷焰网络

module('guild.GuildBossSeasonRewardConfigVo', Class.impl())

function parseData(self, id, cusData)
    self.id = id
    self.minRank = cusData.left_rank
    self.maxRank = cusData.right_rank
    self.rewardPack = cusData.rewards
end

function getAwardlist(self)
    return AwardPackManager:getAwardListById(self.rewardPack)
end

return _M
