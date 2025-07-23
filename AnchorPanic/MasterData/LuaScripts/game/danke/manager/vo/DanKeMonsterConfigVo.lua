-- @FileName:   DanKeMonsterConfigVo.lua
-- @Description:   文件描述
-- @Author: ZDH
-- @Date:   2023-07-25 11:52:14
-- @Copyright:   (LY) 2023 雷焰网络

module('game.danke.manager.vo.DanKeMonsterConfigVo', Class.impl())

function parseCogfigData(self, key, cusData)
    self.id = key

    self.type = cusData.type
    self.find_type = cusData.find_type
    self.damage = cusData.damage
    self.hp = cusData.hp
    self.move_speed = cusData.move_speed * 0.01
    self.monster_skill = cusData.monster_skill
    self.mon_model = cusData.mon_model
    self.drop = cusData.drop
    self.agent_radius = cusData.agent_radius * 0.01
    self.scale = cusData.multiple * 0.01
end

function getDrop(self)
    if table.empty(self.drop) then 
        return
    end
    
    local totalWeight = 0
    for _, v in pairs(self.drop) do
        totalWeight = totalWeight + v[2]
    end

    local random = math.random(1, totalWeight)
    for i = 1, #self.drop do
        if random <= self.drop[i][2] then
            return self.drop[i][1]
        else
            random = random - self.drop[i][2]
        end
    end
end

function getScale(self)
    return self.scale
end

return _M
