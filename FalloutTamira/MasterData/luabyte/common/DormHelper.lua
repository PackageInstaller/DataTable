DormHelper = {}

local CS_HomeHelper = CS.GameX.Home.HomeHelper
local defaultWeight = GameHelper.GetParamters(269)
local fixWeight = GameHelper.GetParamters(270)
local maxLoveValue = GameHelper.GetParamters(271)[0]
local pseudoRandom = GameHelper.GetParamters(319)[0]
local repetitionNum = GameHelper.GetParamter(363)
local randomClickPerformType = { DormConst.RandomClickType.Action, DormConst.RandomClickType.Story,
    DormConst.RandomClickType.Timeline, DormConst.RandomClickType.RewardStory }
local tInsert = table.insert
local activityRoomFlipCgs = ConfigHelper.GetCfgsByLua("activityRoomFlip")

function DormHelper.CommanderMoveToFurniture(areaName, callback)
    CS_HomeHelper.CommanderMoveToFurniture(areaName, callback)
end

function DormHelper.CommanderEnterGift(callback)
    CS_HomeHelper.CommanderEnterGift(callback)
end

function DormHelper.CommanderEnterStory(callback)
    CS_HomeHelper.CommanderEnterStory(callback)
end

function DormHelper.CommanderCall(callback)
    CS_HomeHelper.CommanderCall(callback)
end

function DormHelper.GetCurrentFurnitureId()
    return CS_HomeHelper.GetCurrentFurnitureId()
end

function DormHelper.GetCurrentFurnitureData()
    return CS_HomeHelper.GetCurrentFurnitureData()
end

function DormHelper.GetFurnitureAssetDataByName(name)
    return CS_HomeHelper.GetFurnitureAssetDataByName(name)
end

function DormHelper.GetFurnitureDatasByAreaName(name)
    return CS_HomeHelper.GetFurnitureDatasByAreaName(name)
end

function DormHelper.PlayAction(furnitureData, ActionName, callback, talkId)
    if IsNull(furnitureData) then
        return
    end

    if DormHelper.CheckIsMoving() then
        return
    end

    if callback then
        CS_HomeHelper.PlayAction(furnitureData, ActionName, callback)
    else
        CS_HomeHelper.PlayAction(furnitureData, ActionName)
    end

    if talkId then
        if talkId > 0 then
            DormHelper.PlayTalk(talkId, true)
        end
    end
end

function DormHelper.PlayAnimation(animatonName)
    CS_HomeHelper.PlayAnimation(animatonName)
end

function DormHelper.PlayActionById(furnitureData, ActionId, callback)
    local cfg = ConfigHelper.GetCfgByLua("homeAction", ActionId)

    if cfg then
        if callback then
            CS_HomeHelper.PlayAction(furnitureData, cfg.name, callback)
        else
            CS_HomeHelper.PlayAction(furnitureData, cfg.name)
        end
        if cfg.TalkId > 0 then
            DormHelper.PlayTalk(cfg.TalkId, false)
        end
    end
end

function DormHelper.RoleAfk(isOpen)
    CS_HomeHelper.RoleAfk(isOpen)
end

function DormHelper.LookAtRole()
    CS_HomeHelper.LookAtRole()
end

function DormHelper.AgreeCall(callback)
    CS_HomeHelper.AgreeCall(callback)
end

function DormHelper.InitGril(position)
    CS_HomeHelper.InitGril(position)
end

function DormHelper.EnterFitment(areaName, callback)
    CS_HomeHelper.EnterFitment(areaName, callback)
end

function DormHelper.ExitFitment()
    CS_HomeHelper.ExitFitment()
end

function DormHelper.CameraFadeIn(duration, callback)
    CS_HomeHelper.CameraFadeIn(duration, callback)
end

function DormHelper.CameraFadeOut(duration, callback)
    CS_HomeHelper.CameraFadeOut(duration, callback)
end

function DormHelper.EnableRenderers(enable)
    CS_HomeHelper.EnableRenderers(enable)
end

function DormHelper.CloseFurnitureSolt()
    CS_HomeHelper.CloseFurnitureSolt()
end

function DormHelper.CheckIsMoving()
    return CS_HomeHelper.CheckIsMoving()
end

function DormHelper.GetHomeRoleModel()
    return CS_HomeHelper.GetHomeRoleModel()
end

function DormHelper.GetCurrentWatchPointFurnitureName()
    return CS_HomeHelper.GetCurrentWatchPointFurnitureName()
end

function DormHelper.GetCurrentFurnitureName()
    return CS_HomeHelper.GetCurrentFurnitureName()
end

function DormHelper.GetTargetFurnitureName()
    return CS_HomeHelper.GetTargetFurnitureName()
end

function DormHelper.SetWatchTargetVirtualCamera(isActive)
    CS_HomeHelper.SetWatchTargetVirtualCamera(isActive)
end

--播放timeline（1.隐藏角色，家具 2.播放timeline 6.显示角色，家具）
function DormHelper.PlayTimeline(timelineId, furnitures, callback, showRole)
    -- 2.隐藏角色，家具
    if showRole == nil then
        DormHelper.EnableRenderers(false)
    end

    if furnitures then
        for key, value in pairs(furnitures) do
            value.gameObject:SetActive(false)
        end
    end

    if timelineId == 3010103 or timelineId == 3010203 then
        DormHelper.SetGlassActive(true)
    end
    --4.播放timeline
    GameHelper.PlayTimlineById(timelineId, function()
        --6.显示角色，家具
        if showRole == nil then
            DormHelper.EnableRenderers(true)
        end

        if furnitures then
            for key, value in pairs(furnitures) do
                value.gameObject:SetActive(true)
            end
        end

        if timelineId == 3010103 or timelineId == 3010203 then
            DormHelper.SetGlassActive(false)
        end

        if callback then
            callback()
        end
    end)
end

--获取送礼剧情
function DormHelper.GetGiftStory(heroId, giftId)
    local cfg = ConfigHelper.GetCfgByLua("hero", heroId)
    local giftIndex = 0

    if cfg and cfg.feelingItem and cfg.feelingItemStory then
        for i = 0, cfg.feelingItem.Length - 1 do
            if cfg.feelingItem[i] == giftId then
                giftIndex = i
                break
            end
        end
        return cfg.feelingItemStory[giftIndex]
    end
    return nil
end

--获取动作（交互类型，家具类型，附属家具id）
function DormHelper.GetAction(heroId, actionType, furnitureType, secondFurnitureId)
    local cfgs = ConfigHelper.GetCfgsByLua("homeAction",
        { actionType = actionType, furnitureTypeId = furnitureType, secondFurniture = secondFurnitureId })

    if cfgs then
        local rshd = IRoleStudioHeroDataMgr:GetRoleStudioDataById(heroId)
        local favorLevel = rshd:GetFavorLevel()
        local mood = rshd:GetMood()
        local favorActions = {}
        local moodActions = {}
        --过滤好感度
        for k, v in pairs(cfgs) do
            if v.favorLevel then
                if favorLevel >= v.favorLevel[1] and favorLevel <= v.favorLevel[2] then
                    tInsert(favorActions, v)
                end
            end
        end

        --过滤心情值
        for k, v in pairs(favorActions) do
            if v.mood then
                if mood >= v.mood[1] and mood <= v.mood[2] then
                    tInsert(moodActions, v)
                end
            else
                tInsert(moodActions, v)
            end
        end

        if #moodActions > 0 then
            local random = math.random(1, #moodActions)
            return moodActions[random]
        else
            return nil
        end
    else
        return nil
    end
end

local storys = {}
local timelines = {}
local actions = {}
local rewardStorys = {}
local repetitionActions = {}
local openActions = {}
local triggeredActions = {}
--获取随机点击事件(英雄id，家具类型，特殊家具Id，点击次数)
function DormHelper.GetRandomClickAction(heroId, furnitureType, FurnitureId, actionTimes)
    storys = {}
    timelines = {}
    actions = {}
    rewardStorys = {}
    repetitionActions = {}
    openActions = {}
    local weights = {}
    local rshd = IRoleStudioHeroDataMgr:GetRoleStudioDataById(heroId)
    local loveValue = rshd:GetLoveValue()
    local loveValueTrigger = rshd.IsTrigger
    local isSpecial = false
    if loveValue == maxLoveValue and loveValueTrigger == 0 then
        for i = 0, fixWeight.Length - 1 do
            tInsert(weights, fixWeight[i])
        end
        isSpecial = true
    else
        for i = 0, defaultWeight.Length - 1 do
            tInsert(weights, defaultWeight[i])
        end
    end
    local performType = nil
    if actionTimes == repetitionNum then
        performType = DormConst.RandomClickType.RepetitionAction
    else
        performType = RandomUtil:GetNumByPower(randomClickPerformType, weights)
    end

    local action = nil
    local cfgs = ConfigHelper.GetCfgsByLua("randomClick",
        { hero = heroId, furnitureTypeId = furnitureType, furnitureId = FurnitureId })
    if cfgs then
        local rshd = IRoleStudioHeroDataMgr:GetRoleStudioDataById(heroId)
        local favorLevel = rshd:GetFavorLevel()
        local favorActions = {}

        --过滤好感度
        for k, v in pairs(cfgs) do
            if v.favorLevel then
                if favorLevel >= v.favorLevel[1] and favorLevel <= v.favorLevel[2] then
                    tInsert(favorActions, v)
                end
            end
        end

        --过滤解锁条件
        for k, v in pairs(favorActions) do
            if v.opencondition > 0 then
                if GameHelper.CheckLockByOpenConditionId(v.opencondition) == true then
                    tInsert(openActions, v)
                    if v.Type == DormConst.RandomClickType.Story then
                        tInsert(storys, v)
                    end
                    if v.Type == DormConst.RandomClickType.Action then
                        tInsert(actions, v)
                    end
                    if v.Type == DormConst.RandomClickType.Timeline then
                        tInsert(timelines, v)
                    end
                    if v.Type == DormConst.RandomClickType.RewardStory then
                        tInsert(rewardStorys, v)
                    end
                    if v.Type == DormConst.RandomClickType.RepetitionAction then
                        tInsert(repetitionActions, v)
                    end
                end
            else
                if v.Type == DormConst.RandomClickType.Story then
                    tInsert(storys, v)
                end
                if v.Type == DormConst.RandomClickType.Action then
                    tInsert(actions, v)
                end
                if v.Type == DormConst.RandomClickType.Timeline then
                    tInsert(timelines, v)
                end
                if v.Type == DormConst.RandomClickType.RewardStory then
                    tInsert(rewardStorys, v)
                end
                if v.Type == DormConst.RandomClickType.RepetitionAction then
                    tInsert(repetitionActions, v)
                end
                tInsert(openActions, v)
            end
        end
        action = DormHelper.RandomAction(performType)
    end
    return action, isSpecial
end

function DormHelper.RandomAction(performType)
    local action = nil
    if performType == DormConst.RandomClickType.Story then
        if #storys > 0 then
            local random = math.random(1, #storys)
            action = storys[random]
        else
            local random = math.random(1, #openActions)
            action = openActions[random]
        end
    end

    if performType == DormConst.RandomClickType.Action then
        if #actions > 0 then
            local random = math.random(1, #actions)
            action = actions[random]
        else
            local random = math.random(1, #openActions)
            action = openActions[random]
        end
    end

    if performType == DormConst.RandomClickType.Timeline then
        if #timelines > 0 then
            local random = math.random(1, #timelines)
            action = timelines[random]
        else
            local random = math.random(1, #openActions)
            action = openActions[random]
        end
    end

    if performType == DormConst.RandomClickType.RewardStory then
        if #rewardStorys > 0 then
            local random = math.random(1, #rewardStorys)
            action = rewardStorys[random]
        else
            local random = math.random(1, #openActions)
            action = openActions[random]
        end
    end

    if performType == DormConst.RandomClickType.RepetitionAction then
        if #repetitionActions > 0 then
            local random = math.random(1, #repetitionActions)
            action = repetitionActions[random]
        else
            local random = math.random(1, #openActions)
            action = openActions[random]
        end
    end
    if performType ~= DormConst.RandomClickType.RepetitionAction then
        --判断action是否已经触发
        -- if table.contains(triggeredActions, action) then
        --     DormHelper.RandomAction(performType)
        -- else
            if #triggeredActions == pseudoRandom then
                table.remove(triggeredActions, 1)
            end
            table.insert(triggeredActions, action)
            return action
        -- end
    else
        return action
    end
end

--获取送礼动作
function DormHelper.GetRandomGiftWord(heroId)
    local rshd = IRoleStudioHeroDataMgr:GetRoleStudioDataById(heroId)
    local favorLevel = rshd:GetFavorLevel()
    local cfg = ConfigHelper.GetCfgsByLua("heroFeeling", { hero = heroId, feelingLevel = favorLevel })[1]

    if cfg then
        local random = math.random(1, #cfg.giftWords)
        return cfg.giftWords[random]
    end
    return nil
end

function DormHelper.GetDormTask(heroId)
    local dormTask = 0
    local rshd = IRoleStudioHeroDataMgr:GetRoleStudioDataById(heroId)
    --当前小剧场事件触发id不为0且已经接取任务
    if rshd.EventNode ~= 0 then
        if rshd.EventNodeType == DormConst.EventType.LevelDoing then
            local cfgs = ConfigHelper.GetCfgsByLua("roomStory", { groupId = rshd.EventNode })
            for k, v in pairs(cfgs) do
                if v.task > 0 then
                    dormTask = v.task
                end
            end
        end
    end
    return dormTask
end

--获取角色随机特殊事件
function DormHelper.GetSpecialEvent(HeroId)
    local roleTimeCfg = ConfigHelper.GetCfgsByLua("roleTime",{heroId = HeroId})
    local nowTimer = TimeUtil.GetSecondIndexInDay()
    local curTimeCfg = nil
    for key, value in pairs(roleTimeCfg) do
        if nowTimer >= value.beginTime and nowTimer <= value.endTime then
            curTimeCfg = value
            break
        end
    end
    if curTimeCfg then
        local eventId = RandomUtil:GetNumByPower(curTimeCfg.eventId, curTimeCfg.power)
        return eventId
    else
        return nil
    end
end

--是否送过某个礼物
function DormHelper.CheckGift(heroId, giftId)
    -- return false
     local rshd = IRoleStudioHeroDataMgr:GetRoleStudioDataById(heroId)
     return rshd:CheckGift(giftId)
end

--角色是否在当前家具所在的位置
function DormHelper.IsInCurrentFurniturePos(toFurnitureName)
    return CS_HomeHelper.IsInCurrentFurniturePos(toFurnitureName)
end

--角色是否在演出中
function DormHelper.IsInPerfom()
    return CS_HomeHelper.IsInPerfom()
end

--设置拉近虚拟相机
function DormHelper.SetWatchTargetVirtualCamera(value)
    return CS_HomeHelper.SetWatchTargetVirtualCamera(value)
end

--设置引导镜头
function DormHelper.SetGuideVirtualCamera(value)
    CS_HomeHelper.SetGuideVirtualCamera(value)
end

--角色是否在Idle状态
function DormHelper.IsIdle()
    return CS_HomeHelper.IsIdle()
end

--角色是否在移动中
function DormHelper.IsMoving()
    return CS_HomeHelper.IsMoving()
end

--停止巡游状态
function DormHelper.StopMoving()
    CS_HomeHelper.StopMoving()
end

--模拟点击角色
function DormHelper.ToucheRole()
    CS_HomeHelper.TouchEvent(CS.GameX.Home.HomeCommanderInput.eTouchType.Role)
end

--播放特殊事件
function DormHelper.PlaySpecialEvent(watchPointName, callback)
    CS_HomeHelper.PlaySpecialEvent(watchPointName, callback)
end

--特殊事件解锁
function DormHelper.UnlockSpecialEvent()
    CS_HomeHelper.UnlockSpecialEvent()
end

--判断指挥官是否在角色位置
function DormHelper.CheckCommanderAndRole()
    local WatchPointFurnitureName = DormHelper.GetCurrentWatchPointFurnitureName()
    local roleFurnitureName = DormHelper.GetCurrentFurnitureName()
    --书柜和操作台共用一个观察点
    if WatchPointFurnitureName == DormConst.FurnitureName.Console then
        return roleFurnitureName == DormConst.FurnitureName.Bookcase or
            roleFurnitureName == DormConst.FurnitureName.Console
    end
    if WatchPointFurnitureName == roleFurnitureName then
        return true
    else
        return false
    end
end

--设置镜头拉近拉远
function DormHelper.SetZoomInOut(value)
    CS_HomeHelper.SetZoomInOut(value)
end

--角色播放语音
function DormHelper.PlayTalk(talkId, isShowUI, callback)
    CS_HomeHelper.PlayTalk(talkId, isShowUI, callback)
end

--设置左右滑动摄像机
function DormHelper.SetFreeLookCamera(value)
    CS_HomeHelper.SetFreeLookCamera(value)
end

--设置随机表演
function DormHelper.SetRandomShow(value)
    CS_HomeHelper.SetRandomShow(value)
end

function DormHelper.GetBoneRootTransform()
    return CS_HomeHelper.GetBoneRootTransform()
end

function DormHelper.SetRoleAndCamera(furnitureName, watchPointName, callBack)
    CS_HomeHelper.SetRoleAndCamera(furnitureName, watchPointName, callBack)
end

function DormHelper.GetCurrentActionName()
    return CS_HomeHelper.GetCurrentActionName()
end

function DormHelper.MoveCamera(watchPointName)
    CS_HomeHelper.MoveCamera(watchPointName)
end

--判断相机移动
function DormHelper.CheckCameraMove()
    return CS_HomeHelper.CheckCameraMove()
end

function DormHelper.AreaSlotWaitSelect(waitSelect, slotType)
    CS_HomeHelper.AreaSlotWaitSelect(waitSelect, slotType)
end

function DormHelper.AreaSlotEnable(value)
    CS_HomeHelper.AreaSlotEnable(value)
end

function DormHelper.AreaMainSlotEnable(value)
    CS_HomeHelper.AreaMainSlotEnable(value)
end

function DormHelper.ChangeStyle(res)
    CS_HomeHelper.ChangeStyle(res)
end

function DormHelper.SetGlassActive(value)
    CS_HomeHelper.SetGlassActive(value)
end

function DormHelper.GetRolePointType()
    return CS_HomeHelper.GetRolePointType()
end

function DormHelper.GetUnarrangedHomeFurnitureSlots()
    return CS_HomeHelper.GetUnarrangedHomeFurnitureSlots()
end

function DormHelper.GetAreaFurnitureDatas()
    return CS_HomeHelper.GetAreaFurnitureDatas()
end

function DormHelper.GetSlotNum(areaName)
    return CS_HomeHelper.GetSlotNum(areaName)
end

function DormHelper.GetPuzzleActivityId(heroId)
    for key, value in pairs(activityRoomFlipCgs) do
        if value.hero == heroId then
            return value.activityId
        end
    end
    return 0
end

function DormHelper.CheckFurnitureAsset(furnitureName)
    return CS_HomeHelper.CheckFurnitureAsset(furnitureName)
end

function DormHelper.CheckPlaySpecialEvent(specialEventcfg)
    local open = GameHelper.CheckLockByOpenConditionId(specialEventcfg.openCondition)
    local furniture = DormHelper.CheckFurnitureAsset(specialEventcfg.position)
    if open and furniture then
        return true
    else
        return false
    end
end

function DormHelper.RemoveTouchEvent()
    CS_HomeHelper.RemoveTouchEvent()
end

function DormHelper.GetRoomSkin(heroId, fashionId)
    local cfgs = ConfigHelper.GetCfgsByLua("roomSkin",{heroId = heroId})
    for key, value in pairs(cfgs) do
        if value.roomSignId == fashionId then
            return value
        end
    end
    return nil
end

function DormHelper.ChangeCameraType(type)
    CS_HomeHelper.ChangeCameraType(type)
end

function DormHelper.GetTimelineId(heroId, groupId)
    local rshd = IRoleStudioHeroDataMgr:GetRoleStudioDataById(heroId)
    local roomSkinCfg = DormHelper.GetRoomSkin(heroId, rshd.Fashion)
    local cfgs = ConfigHelper.GetCfgsByLua("timelineAction",{groupId = groupId, roomSkinId = roomSkinCfg.id})
    return cfgs[1].timeline
end 