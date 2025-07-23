-- @FileName:   SandPlayChickenThing.lua
-- @Description:    家禽 鸡
-- @Author: ZDH
-- @Date:   2023-07-25 12:00:06
-- @Copyright:   (LY) 2023 雷焰网络
module('game.sandPlay.thing.SandPlayChickenThing', Class.impl(sandPlay.SandPlayPoultryThing))

function setAIRadius(self)
    local radiusList = {0.15, 0.2}
    self.mAIRadius = radiusList[self.mData:getStage()]
end

function getPrefabPath(self)
    if self.mData:getStage() == 1 then
        return "arts/character/scene_module/nongchang/nc_ji_02/modelnc_ji_02.prefab"
    elseif self.mData:getStage() == 2 then
        return "arts/character/scene_module/nongchang/nc_ji_03/modelnc_ji_03.prefab"
    end
end

return _M
