-- @FileName:   CiruitGridConfigVo.lua
-- @Description:   文件描述
-- @Author: ZDH
-- @Date:   2023-07-25 11:52:14
-- @Copyright:   (LY) 2023 雷焰网络

module('game.ciruit.manager.configVo.CiruitGridConfigVo', Class.impl())

function parseCogfigData(self, key, cusData)
    self.tid = key
    self.grid_type = cusData.grid_type
    self.init_angle = cusData.init_angle * -1

    self.canRotate = cusData.is_move == 1
end

return _M
