-- @FileName:   SandPlayHappyFarmTaskConfigVo.lua
-- @Description:   文件描述
-- @Author: ZDH
-- @Date:   2023-07-25 11:52:14
-- @Copyright:   (LY) 2023 雷焰网络

module('game.sandPlay.manager.configVo.SandPlayHappyFarmTaskConfigVo', Class.impl())

function parseCogfigData(self, key, cusData)
    self.id = key
    self.cost = cusData.cost
    self.award = cusData.award
    self.icon = cusData.icon
    self.name = cusData.name
end

function getName(self)
    return _TT(self.name)
end

function getIcon(self)
    return UrlManager:getIconPath(self.icon)
end

return _M
