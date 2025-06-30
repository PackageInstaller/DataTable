--[[ 
-----------------------------------------------------
@filename       : MiningRewardVo
@Description    : 挖矿奖励配置
@date           : 2023-12-13 17:23:48
@Author         : Jacob
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
module('game.mining.manager.vo.MiningRewardVo', Class.impl())

function parseData(self, key, cusData)
    self.id = key
    self.activity_id = cusData.activity_id
    self.map_id = cusData.map_id
    self.star_num = cusData.star_num
    self.reward = cusData.reward
    self.des = cusData.des
end

return _M