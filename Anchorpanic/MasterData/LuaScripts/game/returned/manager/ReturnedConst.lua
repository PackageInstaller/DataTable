--[[ 
-----------------------------------------------------
@filename       : ReturnedConst
@Description    : 回归活动常量表
@date           : 2023-10-31 17:34:05
@Author         : Jacob
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
ReturnedTabPage = {
    -- 签到
    RETURNEN_PAGE_SIGN = 1,
    -- 每日任务
    RETURNEN_PAGE_TASK_DAILY = 2,
    -- 挑战任务
    RETURNEN_PAGE_TASK_CHALLENGE = 3,
    -- 礼包
    RETURNEN_PAGE_SHOP = 4
}

-- 任务类型
ReturnedTaskType = {
    -- 每日任务
    TASK_DAILY = 1,
    -- 挑战任务
    TASK_CHALLENGE = 2,
}

-- 任务状态 "任务状态，1:未完成，0:已完成未领奖，2：已领取奖励"
ReturnedTaskState = {
    -- 已完成未领奖
    CAN_REC = 0,
    -- 未完成
    UN_REC = 1,
    -- 已领取奖励
    HAS_REC = 2,
}


return _M