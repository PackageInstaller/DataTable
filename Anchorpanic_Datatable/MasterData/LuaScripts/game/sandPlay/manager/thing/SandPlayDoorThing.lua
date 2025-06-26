-- @FileName:   SandPlayDoorThing.lua
-- @Description:   文件描述
-- @Author: ZDH
-- @Date:   2023-07-25 12:00:06
-- @Copyright:   (LY) 2023 雷焰网络
module('game.sandPlay.thing.SandPlayDoorThing', Class.impl(sandPlay.SandPlayOtherNPCThing))

function onModelLoadFinish(self)
    super.onModelLoadFinish(self)

    for _, eventConfigVo in pairs(self.mData.config.base_config.event_ConfigVoList) do
        if sandPlay.SandPlayManager:getMapEventIsPass(nil, self.mData.config.base_config.npc_id, eventConfigVo.event_id) then
            self:playAction("After")
            return
        end
    end

    self:playAction("shut")
end

return _M
