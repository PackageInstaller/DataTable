-- @FileName:   FieldExplorationBuffConfigVo.lua
-- @Description:   文件描述
-- @Author: ZDH
-- @Date:   2023-07-25 11:52:14
-- @Copyright:   (LY) 2023 雷焰网络

module('game.fieldExploration.manager.configVo.FieldExplorationBuffConfigVo', Class.impl())

function parseCogfigData(self, key, cusData)
    self.buff_id = key
    self.type = cusData.type
    self.effect = cusData.effect
    self.trigger_effct = cusData.buff_effect[1]
end

return _M
