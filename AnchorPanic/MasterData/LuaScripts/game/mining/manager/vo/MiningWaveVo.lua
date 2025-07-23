--[[ 
-----------------------------------------------------
@filename       : MiningWaveVo
@Description    : 挖矿波次配置
@date           : 2023-11-30 10:34:36
@Author         : Jacob
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
module('game.mining.manager.vo.MiningWaveVo', Class.impl())

function parseData(self, key, cusData)
    self.id = key
    self.requirePoint = cusData.require_point
    self.timeLimit = cusData.time_limit
    self.eventList =  cusData.event_list
end


return _M
