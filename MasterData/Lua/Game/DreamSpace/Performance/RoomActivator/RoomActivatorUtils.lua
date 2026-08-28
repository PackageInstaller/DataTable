---@class RoomActivatorUtils
local RoomActivatorUtils = {}

-- 外部访问时使用:
-- ---@type RoomActivatorUtils
-- local RoomActivatorUtils = import('Game.DreamSpace.Performance.RoomActivator.RoomActivatorUtils')


RoomActivatorUtils.RoomState = 
{
    Off = 0,
    On = 1
}


RoomActivatorUtils.RoomSide = 
{
    Left  = 1,
    Right = 2
}



RoomActivatorUtils.DoorState = 
{
    DoNothing = 0, -- 啥都不用干     
    NeedOpen  = 1, -- 需要发送 open 指令
    NeedClose = 2, -- 需要发送 close 指令
}




-- RoomActivatorUtils.RoomActivatorState = 
-- {
--     Off = 0,
--     Left = 1,
--     Right = 2
-- }



return RoomActivatorUtils
