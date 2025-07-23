--[[ 
-----------------------------------------------------
@filename       : MiningTaskVo
@Description    : 挖矿波次配置
@date           : 2023-12-13 14:29:58
@Author         : Jacob
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
module('game.mining.manager.vo.MiningTaskVo', Class.impl())

function parseData(self, key, cusData)
    self.id = key
    self.type = cusData.type
    self.subType = cusData.sub_type
    self.times = cusData.times
    self.des = cusData.des
    self.reward = cusData.reward

    self.count = 0
    self.state = 1
end

function parseMsg(self, cusMsg)
    self.count = cusMsg.count
    -- "任务状态，1:未完成，0:已完成未领奖，2：已领取奖励"
    self.state = cusMsg.state
end


return _M