-- @FileName:   SandPlayOtherNPCThing.lua
-- @Description:   文件描述
-- @Author: ZDH
-- @Date:   2023-07-25 12:00:06
-- @Copyright:   (LY) 2023 雷焰网络
module('game.sandPlay.thing.SandPlayOtherNPCThing', Class.impl(sandPlay.SandPlayNPCThing))

function getModel(self)
    return sandPlay.SandPlayNPCModel.new()
end

return _M
