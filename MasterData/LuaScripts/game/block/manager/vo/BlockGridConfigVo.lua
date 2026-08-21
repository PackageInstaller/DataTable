-- @FileName:   BlockGridConfigVo.lua
-- @Description:   文件描述
-- @Author: ZDH
-- @Date:   2023-07-25 11:52:14
-- @Copyright:   (LY) 2023 雷焰网络

module('game.block.manager.vo.BlockGridConfigVo', Class.impl())

function parseCogfigData(self, key, cusData, weight)
    self.id = key
    self.shape_list = cusData.shape_list
    self.score = cusData.score
    self.weight = weight
end

return _M
