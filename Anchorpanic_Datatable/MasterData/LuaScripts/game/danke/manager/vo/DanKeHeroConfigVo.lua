-- @FileName:   DanKeHeroConfigVo.lua
-- @Description:   文件描述
-- @Author: ZDH
-- @Date:   2023-07-25 11:52:14
-- @Copyright:   (LY) 2023 雷焰网络

module('game.danke.manager.vo.DanKeHeroConfigVo', Class.impl())

function parseCogfigData(self, key, cusData)
    self.id = key

    self.agent_radius = cusData.agent_radius * 0.01
    self.normal_speed = cusData.normal_speed * 0.01
    self.hp = cusData.hp
    self.affected_time = cusData.affected_time * 0.001
    self.level_data = table.copy(cusData.level_data)
end

function getMaxLevel(self)
    return table.nums(self.level_data)
end

return _M
