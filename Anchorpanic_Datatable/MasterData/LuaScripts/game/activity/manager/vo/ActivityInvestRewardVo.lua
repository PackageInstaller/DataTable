module('game.activity.manager.vo.ActivityInvestRewardVo', Class.impl())

function parseData(self, id, cusData)

    self.id = id
    self.cost = cusData.cost
    self.allReturn = cusData.all_return
    self.dayReturn = cusData.day_return
    self.title = cusData.title
    self.dayReward = cusData.day_reward
    --self.allReward = cusData.all_reward
end

return _M