module("cycle.CycleMonthRewardVo", Class.impl())

function parseData(self,id,data)
    self.id = id 
    self.reward = data.reward
    self.icon = data.icon
end

return _M