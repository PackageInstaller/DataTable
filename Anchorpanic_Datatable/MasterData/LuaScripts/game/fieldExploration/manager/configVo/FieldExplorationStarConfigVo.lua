-- @FileName:   FieldExplorationStarConfigVo.lua
-- @Description:   文件描述
-- @Author: ZDH
-- @Date:   2023-07-25 11:52:14
-- @Copyright:   (LY) 2023 雷焰网络

module('game.fieldExploration.manager.configVo.FieldExplorationStarConfigVo', Class.impl())

function parseCogfigData(self, key, cusData)
    self.star_id = key
    self.type = cusData.type --星级类别
    self.star = cusData.star --星级
    self.point = cusData.point
    self.des = cusData.des
end

return _M
