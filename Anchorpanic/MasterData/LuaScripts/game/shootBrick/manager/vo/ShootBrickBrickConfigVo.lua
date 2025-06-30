-- @FileName:   ShootBrickBrickConfigVo.lua
-- @Description:   文件描述
-- @Author: ZDH
-- @Date:   2023-07-25 11:52:14
-- @Copyright:   (LY) 2023 雷焰网络

module('game.shootBrick.manager.vo.ShootBrickBrickConfigVo', Class.impl())

function parseCogfigData(self, key, cusData)
    self.id = key
    self.hp = cusData.brick_hp
    self.score = cusData.score
    self.icon = cusData.icon
    self.sound = cusData.sound
end

function getIconPath(self, hp)
    for k, v in pairs(self.icon) do
        if v[2] == hp then
            return "arts/ui/pack/shootBrick/" .. v[1]
        end
    end
end

function getSoundPath(self)
    return string.format("arts/audio/UI/minigames/%s.prefab", self.sound)
end

return _M
