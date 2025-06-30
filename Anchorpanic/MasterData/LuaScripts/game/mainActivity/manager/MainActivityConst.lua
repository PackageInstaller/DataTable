MainActivityConst = {}

-------------------------------------------其他位置的按钮，注意不要跟下方的小游戏按钮重叠了---------------------
-- progress 为nil不显示
MainActivityConst.getBtnList = function()
    local tabList = {}

    local recruit_id = sysParam.SysParamManager:getValue(SysParamType.MAINACTIVITY_TRIAL_RECRUITID)
    if (recruit_id ~= 0) then
        -- 试玩关卡
        table.insert(tabList, {
            btnName = "mBtnTrialPlay",
            activity_id = activity.ActivityId.TrialPlayLevel,
            progress = nil
        })
    end

    local isMain = sysParam.SysParamManager:getValue(SysParamType.MainActivityType) == 1
    -- 普通关卡
    table.insert(tabList, {
        btnName = "mBtnNomalLevel",
        activity_id = activity.ActivityId.NomalLevel,
        progress = isMain and battleMap.MainMapManager:getMainMapProgress(battleMap.MainMapStyleType.Easy) .. "%" or
        mainActivity.ActiveDupManager:getCurStageProgress(mainActivity.ActiveDupStyleType.Easy) .. "%"
    })
    -- 困难关卡
    table.insert(tabList, {
        btnName = "mBtnDifLevel",
        activity_id = activity.ActivityId.DifficultyLevel,
        progress = isMain and battleMap.MainMapManager:getMainMapProgress(battleMap.MainMapStyleType.Difficulty) .. "%" or
        mainActivity.ActiveDupManager:getCurStageProgress(mainActivity.ActiveDupStyleType.Difficulty) .. "%"
    })
    -- 超难关卡
    table.insert(tabList, {
        btnName = "mBtnHellLevel",
        activity_id = activity.ActivityId.HellLevel,
        progress = isMain and battleMap.MainMapManager:getMainMapProgress(battleMap.MainMapStyleType.SuperDifficulty) ..
        "%" or mainActivity.ActiveDupManager:getCurStageProgress(mainActivity.ActiveDupStyleType.Hard) .. "%"
    })

    -- 签到
    table.insert(tabList, {
        btnName = "mBtnSign",
        activity_id = activity.ActivityId.Sign,
        progress = nil
    })
    -- 商店
    table.insert(tabList, {
        btnName = "mBtnShop",
        activity_id = activity.ActivityId.Shop,
        progress = nil
    })
    -- 任务
    table.insert(tabList, {
        btnName = "mBtnTask",
        activity_id = activity.ActivityId.Task,
        progress = nil
    })
    return tabList
end

-- 下方小游戏按钮
MainActivityConst.bottomBtns =
{
    activity.ActivityId.OrganizeBackpacks,
    activity.ActivityId.Gameplay,
    activity.ActivityId.Gameplay2,
    activity.ActivityId.DanKe,
    activity.ActivityId.Gold,
    activity.ActivityId.Eliminate,
    activity.ActivityId.Ciruit,
    activity.ActivityId.HappyFarm,
    activity.ActivityId.Mining,
    activity.ActivityId.ThreeSheep,
    activity.ActivityId.ShootBrick,
    activity.ActivityId.PutImage,
    activity.ActivityId.Linklink,
}

---所有主题活动这边的红点获取定义
MainActivityConst.getActivityRedState = function(activity_id)

    local activityRedState = {
        [activity.ActivityId.NomalLevel] = mainActivity.ActiveDupManager:getCanRecAllByStyle(
        mainActivity.ActiveDupStyleType.Easy),
        [activity.ActivityId.DifficultyLevel] = mainActivity.ActiveDupManager:getCanRecAllByStyle(
        mainActivity.ActiveDupStyleType.Difficulty),
        [activity.ActivityId.HellLevel] = mainActivity.ActiveDupManager:getCanRecAllByStyle(
        mainActivity.ActiveDupStyleType.Hard),
        [activity.ActivityId.Sign] = mainActivity.MainActivityManager:getSignBubble(),
        [activity.ActivityId.Shop] = false,
        [activity.ActivityId.Task] = mainActivity.MainActivityManager:checkTaskAwardCanReceive(),
        [activity.ActivityId.Gameplay] = fieldExploration.FieldExplorationManager:getIsShowRed(activity.ActivityId
        .Gameplay),
        [activity.ActivityId.Gameplay2] = fieldExploration.FieldExplorationManager:getIsShowRed(activity.ActivityId
        .Gameplay2),
        [activity.ActivityId.Gold] = fieldExploration.FieldExplorationManager:getIsShowRed(activity.ActivityId.Gold),
        [activity.ActivityId.Mining] = mining.MiningManager:getAllRed(),
        [activity.ActivityId.Eliminate] = eliminate.EliminateManager:getAllRed(),
        [activity.ActivityId.Fishing] = sandPlay.SandPlayManager:getFishingGuideRedState(),
        [activity.ActivityId.DanKe] = danke.DanKeManager:getDanKeGuideRedState(),
        [activity.ActivityId.Ciruit] = ciruit.CiruitManager:getIsShowRed(),
        [activity.ActivityId.HappyFarm] = sandPlay.SandPlayManager:getHappyFarmRedState(),
        [activity.ActivityId.OrganizeBackpacks] = organizeBackpacks.OrganizeBackpacksManager:getRedState(),
        [activity.ActivityId.ThreeSheep] = threeSheep.ThreeSheepManager:getIsShowRed(),
        [activity.ActivityId.ShootBrick] = shootBrick.ShootBrickManager:getIsShowRed(),
        [activity.ActivityId.PutImage] = putImage.PutImageManager:getIsShowRed(),
        [activity.ActivityId.Linklink] = linklink.LinklinkManager:getIsShowRed(),
    }

    local activityVo = mainActivity.MainActivityManager:getMainActivityVoById(activity_id)
    if not activityVo:getIsCanOpen() then
        return false
    end

    if activity_id == activity.ActivityId.TrialPlayLevel then
        local recruit_id = sysParam.SysParamManager:getValue(SysParamType.MAINACTIVITY_TRIAL_RECRUITID)
        if (recruit_id == 0) then
            return false
        else
            local configVo = recruit.RecruitManager:getRecruitConfigVo(recruit_id)
            if not configVo then
                return false
            end
            return recruit.RecruitManager:getIsShowTrial(configVo:getTry_hero())
        end
    end
    return activityRedState[activity_id]
end
