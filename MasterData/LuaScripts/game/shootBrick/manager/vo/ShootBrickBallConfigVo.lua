-- @FileName:   ShootBrickBallConfigVo.lua
-- @Description:   文件描述
-- @Author: ZDH
-- @Date:   2023-07-25 11:52:14
-- @Copyright:   (LY) 2023 雷焰网络

module('game.shootBrick.manager.vo.ShootBrickBallConfigVo', Class.impl())

function parseCogfigData(self, key, cusData)
    self.id = key
    self.speed = cusData.speed
    -- self.speed = 10
    self.damage = cusData.damage
    -- self.damage = 10
    self.scale = cusData.scale
end

function getIconPath(self)
    return "arts/ui/pack/shootBrick/" .. self.icon
end

return _M
