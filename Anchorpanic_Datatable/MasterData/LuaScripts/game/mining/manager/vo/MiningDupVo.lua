--[[ 
-----------------------------------------------------
@filename       : MiningDupVo
@Description    : 挖矿小游戏副本数据
@date           : 2023-11-29 20:28:19
@Author         : Jacob
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
module('game.mining.manager.vo.MiningDupVo', Class.impl())

function parseData(self, key, cusData)
    self.id = key
    self.name = cusData.name
    self.dupName = cusData.copy_name
    self.waveList = cusData.wave_list
    self.starList = cusData.star_list
    self.beginTime = cusData.begin_time --TimeUtil.transTime(cusData.begin_time)
    self.preId = cusData.pre_id
    self.firstAward = AwardPackManager:getAwardListById(cusData.first_award)
end


return _M