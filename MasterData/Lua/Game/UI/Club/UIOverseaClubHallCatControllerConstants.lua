---
--- 社团大厅，猫控制器 Constants
--- Author: dawanfan
--- Date: 2024-5-6 16:45:42
---


local Animator = CS.UnityEngine.Animator


---@class UIOverseaClubHallCatControllerConstants
local UIOverseaClubHallCatControllerConstants = {}

-- 旧动画系统 clips:
UIOverseaClubHallCatControllerConstants.clipName_old_sit_01 = Animator.StringToHash("sit01_01")
UIOverseaClubHallCatControllerConstants.clipName_old_sit_02 = Animator.StringToHash("sit01_02")

-- 新动画系统(npc猫控制器专用):
-- clips:
UIOverseaClubHallCatControllerConstants.clipName_walk = Animator.StringToHash("walk_club")
UIOverseaClubHallCatControllerConstants.clipName_idle = Animator.StringToHash("idle_club")
-- 变量名:
UIOverseaClubHallCatControllerConstants.param_club = Animator.StringToHash("club")
-- 写入 param_club 的值:
UIOverseaClubHallCatControllerConstants.int_idle_club = 0      -- 
UIOverseaClubHallCatControllerConstants.int_walk_club = 1      -- 去走路
UIOverseaClubHallCatControllerConstants.int_sit_club = 2  -- 去坐下
UIOverseaClubHallCatControllerConstants.int_sleep_club = 3 
UIOverseaClubHallCatControllerConstants.int_touch_01_club = 11
UIOverseaClubHallCatControllerConstants.int_touch_02_club = 12
UIOverseaClubHallCatControllerConstants.int_touch_03_clb = 13 

UIOverseaClubHallCatControllerConstants.catMoveMaxSpeed = 0.8

UIOverseaClubHallCatControllerConstants.CatMode = 
{
    Manual = 11, -- 手操模式
    Auto   = 12, -- 自动随机游走模式
    Server = 13, -- 服务器同步
}

-- Auto Mode 下的各种状态:
UIOverseaClubHallCatControllerConstants.CatAutoState = 
{
    Idle = 0,
    Walk = 1,
    Sit = 2,
    Sleep = 3,
    Touch_01 = 11,  -- 低头等待被摸
    Touch_02 = 12,
    Touch_03 = 13,
}


-- 随机时间:
UIOverseaClubHallCatControllerConstants.randomDuration_Idle = { min = 1, max = 3, }
UIOverseaClubHallCatControllerConstants.randomDuration_Walk = { min = 2, max = 4, }
UIOverseaClubHallCatControllerConstants.randomDuration_Sit = { min = 2, max = 5, }
UIOverseaClubHallCatControllerConstants.randomDuration_Sleep = { min = 4, max = 9, }
UIOverseaClubHallCatControllerConstants.randomDuration_Touch_01 = { min = 2, max = 4, }
UIOverseaClubHallCatControllerConstants.randomDuration_Touch_02 = { min = 2, max = 4, }
UIOverseaClubHallCatControllerConstants.randomDuration_Touch_03 = { min = 2, max = 4, }



-- npc猫可自由活动的区域:
UIOverseaClubHallCatControllerConstants.CatActiveRegion = 
{
    ---- 用户请手动配置下面两组值: world-space pos:
    xRange = Vector2(-2.6, 7.6),
    zRange = Vector2(-4, 0.8),
    --- 
    npcCatRadius = 3, 
    mainCatRadius = 1.5,
}




return UIOverseaClubHallCatControllerConstants
