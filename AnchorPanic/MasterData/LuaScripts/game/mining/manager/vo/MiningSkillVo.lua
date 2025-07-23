--[[ 
-----------------------------------------------------
@filename       : MiningSkillVo
@Description    : 挖矿技能配置
@date           : 2023-12-12 15:24:43
@Author         : Jacob
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
module('game.mining.manager.vo.MiningSkillVo', Class.impl())

function parseData(self, key, cusData)
    self.id = key
    self.type = cusData.type
    self.param = cusData.param
end

return _M
