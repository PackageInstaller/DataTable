-- 任务类型，后端、前端、配置保持一致
-- 日常任务
task.TYPE_DAILY_TASK = 1
-- 周常任务
task.TYPE_WEEK_TASK = 2

-- 任务大厅的切卡类型
task.HallTabType = {
    -- 日常任务
    DAILY_TASK = 1,
    -- 周常任务
    WEEK_TASK = 2,
    -- 成就
    ACHIEVEMENT = 3,
}

task.getTypeByTabType = function(cusTabType)
    local type = nil
    if (cusTabType == task.HallTabType.DAILY_TASK) then
        type = task.TYPE_DAILY_TASK
    elseif (cusTabType == task.HallTabType.WEEK_TASK) then
        type = task.TYPE_WEEK_TASK
    end
    return type
end

task.getHallTabName = function(cusTabType)
    local name = ""
    if (cusTabType == task.HallTabType.DAILY_TASK) then
        name = _TT(652)--"日事务"
    elseif (cusTabType == task.HallTabType.WEEK_TASK) then
        name = _TT(661)--"周事务"
    elseif (cusTabType == task.HallTabType.ACHIEVEMENT) then
        name = "成就"
    end
    return name
end

task.getHallTabIcon = function(cusTabType)
    local icon = ""
    if (cusTabType == task.HallTabType.DAILY_TASK) then
        icon = UrlManager:getIconPath("tabIcon/tabIcon_10.png") --"日事务"
    elseif (cusTabType == task.HallTabType.WEEK_TASK) then
        icon = UrlManager:getIconPath("tabIcon/tabIcon_5.png")--"周事务"
    elseif (cusTabType == task.HallTabType.ACHIEVEMENT) then
        icon = UrlManager:getIconPath("tabIcon/tabIcon_10.png")--成就
    end
    return icon
end

-- 奖励领取状态类型
task.AwardRecState = {
    -- 可领取
    CAN_REC = 1,
    -- 未领取
    UN_REC = 2,
    -- 已领取
    HAS_REC = 3,
}

--[[ 替换语言包自动生成，请勿修改！
]]