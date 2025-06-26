-- @FileName:   DanKeRewardConfigVo.lua
-- @Description:   文件描述
-- @Author: ZDH
-- @Date:   2023-07-25 11:52:14
-- @Copyright:   (LY) 2023 雷焰网络

module('game.danke.manager.vo.DanKeRewardConfigVo', Class.impl())

function parseCogfigData(self, key, cusData)
    self.id = key

    self.star_num = cusData.star_num
    self.reward = cusData.reward
    self.des = cusData.des
end

function getMaxLevel(self)
    return table.nums(self.level_data)
end

return _M
