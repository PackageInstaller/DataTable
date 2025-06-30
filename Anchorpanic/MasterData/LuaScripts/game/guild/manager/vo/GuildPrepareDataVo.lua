module('guild.GuildPrepareDataVo', Class.impl())

function parseData(self,id,cusData)
    self.id = id 
    --筹备消耗
    self.prepareCost = cusData.cost[1]
    --筹备奖励
    self.prepareReward = cusData.award[1]
    --个人活跃度
    self.active = cusData.active
    --
    self.coin = cusData.coin
    self.exp = cusData.exp
end


return _M