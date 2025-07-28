MainActivityConst = {}

--progress 为nil不显示
MainActivityConst.getBtnList = function()
    local tabList = {}
    -- 试玩关卡
    table.insert(tabList, {btnName = "mBtnTrialPlay", activity_id = activity.ActivityId.TrialPlayLevel, progress = nil})
    -- --普通关卡
    -- table.insert(tabList, {btnName = "mBtnNomalLevel", activity_id = activity.ActivityId.NomalLevel, progress = mainActivity.ActiveDupManager:getCurStageProgress(mainActivity.ActiveDupStyleType.Easy) .. "%"})
    -- --困难关卡
    -- table.insert(tabList, {btnName = "mBtnDifLevel", activity_id = activity.ActivityId.DifficultyLevel, progress = mainActivity.ActiveDupManager:getCurStageProgress(mainActivity.ActiveDupStyleType.Difficulty) .. "%"})
    -- --超难关卡
    -- table.insert(tabList, {btnName = "mBtnHellLevel", activity_id = activity.ActivityId.HellLevel, progress = mainActivity.ActiveDupManager:getCurStageProgress(mainActivity.ActiveDupStyleType.Hard) .. "%"})
    --普通关卡
    table.insert(tabList, {btnName = "mBtnNomalLevel", activity_id = activity.ActivityId.NomalLevel, progress = battleMap.MainMapManager:getMainMapProgress(battleMap.MainMapStyleType.Easy) .. "%"})
    --困难关卡
    table.insert(tabList, {btnName = "mBtnDifLevel", activity_id = activity.ActivityId.DifficultyLevel, progress = battleMap.MainMapManager:getMainMapProgress(battleMap.MainMapStyleType.Difficulty) .. "%"})
    --超难关卡
    table.insert(tabList, {btnName = "mBtnHellLevel", activity_id = activity.ActivityId.HellLevel, progress = battleMap.MainMapManager:getMainMapProgress(battleMap.MainMapStyleType.SuperDifficulty) .. "%"})

    --签到
    table.insert(tabList, {btnName = "mBtnSign", activity_id = activity.ActivityId.Sign, progress = nil})
    --商店
    table.insert(tabList, {btnName = "mBtnShop", activity_id = activity.ActivityId.Shop, progress = nil})
    --任务
    table.insert(tabList, {btnName = "mBtnTask", activity_id = activity.ActivityId.Task, progress = nil})
    --消消乐
    table.insert(tabList, {btnName = "mBtnGamePlay", activity_id = activity.ActivityId.Eliminate, progress = nil})
    return tabList
end

--下方小游戏按钮
MainActivityConst.bottomBtns =
{
    activity.ActivityId.Gameplay,
    activity.ActivityId.Gameplay2,
    activity.ActivityId.DanKe,
    activity.ActivityId.Gold,
    activity.ActivityId.Eliminate,
    activity.ActivityId.Ciruit,
}

MainActivityConst.getActivityRedState = function (activity_id)
    
    local activityRedState =
    {
        --试玩的红点不放在主题活动这边了
        [activity.ActivityId.TrialPlayLevel] = mainActivity.MainActivityManager:getIsShowTrial(),
        --[activity.ActivityId.TrialPlayLevel] = false,
        [activity.ActivityId.NomalLevel] = mainActivity.ActiveDupManager:getCanRecAllByStyle(mainActivity.ActiveDupStyleType.Easy),
        [activity.ActivityId.DifficultyLevel] = mainActivity.ActiveDupManager:getCanRecAllByStyle(mainActivity.ActiveDupStyleType.Difficulty),
        [activity.ActivityId.HellLevel] = mainActivity.ActiveDupManager:getCanRecAllByStyle(mainActivity.ActiveDupStyleType.Hard),
        [activity.ActivityId.Sign] = mainActivity.MainActivityManager:getSignBubble(),
        [activity.ActivityId.Shop] = false,
        [activity.ActivityId.Task] = mainActivity.MainActivityManager:checkTaskAwardCanReceive(),
        [activity.ActivityId.Gameplay] = fieldExploration.FieldExplorationManager:getIsShowRed(activity.ActivityId.Gameplay),
        [activity.ActivityId.Gameplay2] = fieldExploration.FieldExplorationManager:getIsShowRed(activity.ActivityId.Gameplay2),
        [activity.ActivityId.Gold] = fieldExploration.FieldExplorationManager:getIsShowRed(activity.ActivityId.Gold),
        [activity.ActivityId.Mining] = mining.MiningManager:getAllRed(),
        [activity.ActivityId.Eliminate] = eliminate.EliminateManager:getAllRed(),
        [activity.ActivityId.Fishing] = sandPlay.SandPlayManager:getFishingGuideRedState(),
        [activity.ActivityId.DanKe] = danke.DanKeManager:getDanKeGuideRedState(),
    }

    local type = sysParam.SysParamManager:getValue(SysParamType.MAINACITIVITY_TYPE)
    if(type ~= 1) then
        activityRedState[activity.ActivityId.TrialPlayLevel] = false
    end
    return activityRedState[activity_id]
end
