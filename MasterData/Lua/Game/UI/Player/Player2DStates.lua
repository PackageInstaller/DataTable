---@class Player2DStates
local Player2DStates = {}

-- 全局变量 及其配套函数

-- 外部调用时使用:
-- ---@type Player2DStates
-- local Player2DStates = import('Game.UI.Player.Player2DStates')


-- ======================  =========================


-- =======
Player2DStates.BadgeState = 
{ 
    Locked = 1, -- 锁定 (未解锁)
    UnShow = 2, -- 未被展示 (已解锁)
    Showed = 3, -- 正在展示 (已解锁)
}



Player2DStates.FrameState = 
{ 
    Locked = 1, -- 锁定 (未解锁)
    UnLocked = 2, -- 已解锁
}





return Player2DStates
