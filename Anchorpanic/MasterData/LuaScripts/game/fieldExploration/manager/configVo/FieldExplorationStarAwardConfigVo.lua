-- @FileName:   FieldExplorationStarAwardConfigVo.lua
-- @Description:   文件描述
-- @Author: ZDH
-- @Date:   2023-07-25 11:52:14
-- @Copyright:   (LY) 2023 雷焰网络

module('game.fieldExploration.manager.configVo.FieldExplorationStarAwardConfigVo', Class.impl())

function parseCogfigData(self, key, cusData)
    self.id = key
    self.map_id = cusData.map_id
    self.star_num = cusData.star_num
    self.reward = cusData.reward
    self.des = cusData.des
end

return _M
