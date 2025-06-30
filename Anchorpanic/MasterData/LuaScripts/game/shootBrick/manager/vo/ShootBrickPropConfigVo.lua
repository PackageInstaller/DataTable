-- @FileName:   ShootBrickPropConfigVo.lua
-- @Description:   文件描述
-- @Author: ZDH
-- @Date:   2023-07-25 11:52:14
-- @Copyright:   (LY) 2023 雷焰网络

module('game.shootBrick.manager.vo.ShootBrickPropConfigVo', Class.impl())

function parseCogfigData(self, key, cusData)
    self.id = key
    self.type = cusData.type
    self.param = cusData.param
    self.life_time = cusData.time
    self.icon = cusData.icon
end

function getIconPath(self)
    return "arts/ui/pack/shootBrick/" .. self.icon
end

return _M
