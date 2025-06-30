-- @FileName:   DanKeDropConfigVo.lua
-- @Description:   文件描述
-- @Author: ZDH
-- @Date:   2023-07-25 11:52:14
-- @Copyright:   (LY) 2023 雷焰网络

module('game.danke.manager.vo.DanKeDropConfigVo', Class.impl())

function parseCogfigData(self, key, cusData)
    self.tid = key
    self.type = cusData.type
    self.param = cusData.param
    self.icon = cusData.icon
    self.scale = cusData.multiple * 0.01
    self.die_time = cusData.die_time
end

function getIcon(self)
    return "arts/ui/icon/danke/" .. self.icon
end

function getScale(self)
    return self.scale
end

return _M
