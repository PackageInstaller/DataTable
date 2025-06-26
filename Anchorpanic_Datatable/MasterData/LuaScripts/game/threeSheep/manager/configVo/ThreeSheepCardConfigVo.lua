-- @FileName:   ThreeSheepCardConfigVo.lua
-- @Description:   文件描述
-- @Author: ZDH
-- @Date:   2023-07-25 11:52:14
-- @Copyright:   (LY) 2023 雷焰网络

module('game.threeSheep.manager.configVo.ThreeSheepCardConfigVo', Class.impl())

function parseCogfigData(self, key, cusData)
    self.tid = key
    self.icon = cusData.icon

end

function getIconPath(self)
    return "arts/ui/icon/threeSheep/" ..self.icon
end

return _M
