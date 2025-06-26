-- @FileName:   ShootBrickStarConfigVo.lua
-- @Description:   文件描述
-- @Author: ZDH
-- @Date:   2023-07-25 11:52:14
-- @Copyright:   (LY) 2023 雷焰网络

module('game.shootBrick.manager.vo.ShootBrickStarConfigVo', Class.impl())

function parseCogfigData(self, key, cusData)
    self.id = key
    self.star = cusData.star
    self.point = cusData.point
    self.des = cusData.des
end

function getDesc(self)
    return _TT(self.des)
end

return _M
