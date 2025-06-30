--[[ 
-----------------------------------------------------
@filename       : MiningStarVo
@Description    : 挖矿星级配置
@date           : 2023-11-30 10:34:36
@Author         : Jacob
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
module('game.mining.manager.vo.MiningStarVo', Class.impl())

function parseData(self, key, cusData)
    self.id = key
    self.star = cusData.star
    self.point = cusData.point
    self.des =  cusData.des
end

return _M
