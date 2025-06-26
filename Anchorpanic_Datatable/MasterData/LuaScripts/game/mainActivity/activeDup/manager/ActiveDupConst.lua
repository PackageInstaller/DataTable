-- 1.1副本活动主线关卡风格难度类型
mainActivity.ActiveDupStyleType = {
    -- 轻松/常显关卡
    Easy = 0,
    -- 困难/隐藏关卡
    Difficulty = 1,
    --困难
    Hard = 2,
}

-- 获取主线关卡风格难度类型名称
mainActivity.getMainMapStyleName = function(cusStyleType)
    local name = ""
    if (cusStyleType == mainActivity.ActiveDupStyleType.Easy) then
        name = _TT(71306)
    elseif (cusStyleType == mainActivity.ActiveDupStyleType.Difficulty) then
        name = _TT(71307)
    elseif (cusStyleType == mainActivity.ActiveDupStyleType.Hard) then
        name = _TT(71307)
    end
    return name
end

-- 主线关卡类型
mainActivity.MainMapStageType = {
    -- 普通战斗关卡
    Normal = 0,
    -- 剧情战斗关卡
    StoryFight = 1,
    -- 剧情关卡
    Story = 2,
    --精英怪战斗关卡
    Elite = 3,
    -- 地图探索
    Boss = 4,
    -- -- 精英关
    -- Cream = 5,
}

function getBtnList(self)
    local tabList = {}
    -- 试玩关卡
    table.insert(tabList, {btnName = "mBtnTrialPlay", type = activity.ActivityId.TrialPlayLevel, progress = nil, isBubble = false})
    --普通关卡
    table.insert(tabList, {btnName = "mBtnNomalLevel", type = activity.ActivityId.NomalLevel, progress = 0, isBubble = false})
    --困难关卡
    table.insert(tabList, {btnName = "mBtnDifLevel", type = activity.ActivityId.DifficultyLevel, progress = 0, isBubble = false})

    table.insert(tabList, {btnName = "mBtnHellLevel", type = activity.ActivityId.HellLevel, progress = 0, isBubble = false})
    --签到
    table.insert(tabList, {btnName = "mBtnSign", type = activity.ActivityId.Sign, progress = nil, isBubble = mainActivity.MainActivityManager:getSignBubble()})
    --商店
    table.insert(tabList, {btnName = "mBtnShop", type = activity.ActivityId.Shop, progress = nil, isBubble = false})
    --任务
    table.insert(tabList, {btnName = "mBtnTask", type = activity.ActivityId.Task, progress = nil, isBubble = false})
    return tabList
end

--[[ 替换语言包自动生成，请勿修改！
语言包: _TT(71307):"隐藏剧情"
语言包: _TT(71306):"普通剧情"
]]
