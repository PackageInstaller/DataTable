module('guild.GuildExpDataVo', Class.impl())

function parseData(self,id,cusData)
    self.lv = id 
    self.nextExp = cusData.need_exp
    self.supplyAward = cusData.supply_reward
    self.supplyCost = cusData.supply_cost
    self.peopleNum = cusData.member_limit
end


return _M