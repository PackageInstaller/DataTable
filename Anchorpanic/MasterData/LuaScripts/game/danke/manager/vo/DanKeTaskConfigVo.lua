-- @FileName:   DanKeTaskConfigVo.lua
-- @Description:   文件描述
-- @Author: ZDH
-- @Date:   2023-07-25 11:52:14
-- @Copyright:   (LY) 2023 雷焰网络

module('game.danke.manager.vo.DanKeTaskConfigVo', Class.impl())

function parseCogfigData(self, key, cusData)
    self.id = key

    self.reward = cusData.reward
    self.des = cusData.des
    self.name = cusData.name
    self.type = cusData.type
    self.times = cusData.times

end

function getMaxLevel(self)
    return table.nums(self.level_data)
end

return _M
