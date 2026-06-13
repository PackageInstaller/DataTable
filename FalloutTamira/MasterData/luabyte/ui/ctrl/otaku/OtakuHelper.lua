local OtakuHelper = {}
local OtakuRoomType = OtakuType.OtakuRoomType
local tInsert = table.insert

--获得房间的数量、等级限制以及拆解返还比例
function OtakuHelper.GetHouseInfo(roomType, bridgeLevel)
    local houseCfg = ConfigHelper.GetCfg("house", bridgeLevel)
    if houseCfg then
        local arr = nil

        if roomType == OtakuRoomType.EST_Bridge then
            --船桥等级
            local allHouseCfg = ConfigHelper.GetCfgs("house")
            local curLevel = -1

            for i, v in ipairs(allHouseCfg) do
                if v.level > curLevel then
                    curLevel = v.level
                end
            end
            return 1, curLevel, 0
        elseif roomType == OtakuRoomType.EST_Produce then
            --制造室
            arr = houseCfg.make
        elseif roomType == OtakuRoomType.EST_Communication then
            --通讯室
            arr = houseCfg.communication
        elseif roomType == OtakuRoomType.EST_Dormitory then
            --宿舍
            arr = houseCfg.room
        elseif roomType == OtakuRoomType.EST_Canteen then
            --餐厅
            arr = houseCfg.restaurant
        end

        if arr then
            return arr[1], arr[2], houseCfg.returnPer
        end
        return nil
    end
end

-- ↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓ 制造相关 start ↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓

-- 获取制造持续时间 【秒】
function OtakuHelper.GetMakeDuration(roomData)
    local makeId = roomData:MakeItemId()

    if (not OtakuHelper.m_makeItem) or (OtakuHelper.m_makeItem.id ~= makeId) then
        OtakuHelper.m_makeItem = ConfigHelper.GetCfgByLua("makeItem", makeId)
    end

    if not OtakuHelper.m_makeItem then
        Logger.LogError("makeItem is nil, id = " .. makeId)
    end

    local buffs = roomData:Buffs()
    local progress = roomData:Progress()
    local makeNum = roomData:MakeItemNum()
    local stopTime = roomData:TerminalTick()
    local startTime = roomData:CalculateTick()
    local costTime = OtakuHelper.m_makeItem.costTime
    local normalMakeTime = makeNum * costTime
    Logger.Log(string.format("Progress:%d  CalculateTick:%d  MakeTime:%d  MakeNum:%d StopTime:%d",
        progress, startTime, normalMakeTime, makeNum, stopTime))
    normalMakeTime = normalMakeTime - progress

    local buffDic, endList = {}, {}

    for i, buff in ipairs(buffs) do
        local isWork = (stopTime == 0) or (buff.Final <= stopTime)
        local final = isWork and buff.Final or stopTime

        for j = i, #buffs, 1 do
            local ratio = buffs[j].Ratio
            local ratioSum = buffDic[final]

            if not ratioSum then
                tInsert(endList, final)
            end

            -- 有序列表，先结束在前
            buffDic[final] = (ratioSum or 0) + ratio
        end

        if final == stopTime then
            break
        end
    end

    for _, buff in ipairs(buffs) do
        Logger.Log(string.format("[Buff] Ratio:%d  Final:%d", buff.Ratio, buff.Final))
    end

    local lastSec, accBuffTime = 0, 0

    for _, endTime in ipairs(endList) do
        local ratioSum = buffDic[endTime]
        local curSec = math.max(0, endTime - startTime)
        local buffTime = math.max(0, curSec - lastSec)
        lastSec = curSec
        local accRatio = 1 + ratioSum / 10000
        local accTime = buffTime * accRatio

        if normalMakeTime >= accTime then
            -- 剩余时间大于加速时间
            normalMakeTime = normalMakeTime - accTime
            accBuffTime = accBuffTime + buffTime
        else
            accTime = normalMakeTime / accRatio
            accBuffTime = accBuffTime + accTime
            normalMakeTime = 0
            break
        end
    end

    -- 取最大时间
    return math.ceil(accBuffTime + normalMakeTime)
end

-- 下一个领取制造道具的时间 【时间戳】
function OtakuHelper.NextGetMakeItemTime(roomData)
    local makeId = roomData:MakeItemId()

    if makeId == 0 then
        return 0
    end

    if (not OtakuHelper.m_makeItem) or (OtakuHelper.m_makeItem.id ~= makeId) then
        OtakuHelper.m_makeItem = ConfigHelper.GetCfgByLua("makeItem", makeId)
    end

    local buffs = roomData:Buffs()
    local getNum = roomData:AwardNum()
    local progress = roomData:Progress()
    local stopTime = roomData:TerminalTick()
    local startTime = roomData:CalculateTick()
    local costTime = OtakuHelper.m_makeItem.costTime
    local reminTime = progress - costTime * getNum
    -- 已经有可领道具
    if reminTime >= costTime then
        return startTime - reminTime + costTime
    end

    costTime = costTime - reminTime

    local buffDic, endList = {}, {}

    for i, buff in ipairs(buffs) do
        local isWork = (stopTime == 0) or (buff.Final <= stopTime)
        local final = isWork and buff.Final or stopTime

        for j = i, #buffs, 1 do
            local ratio = buffs[j].Ratio
            local ratioSum = buffDic[final]

            if not ratioSum then
                tInsert(endList, final)
            end

            -- 有序列表，先结束在前
            buffDic[final] = (ratioSum or 0) + ratio
        end

        if final == stopTime then
            break
        end
    end

    local lastSec, accBuffTime = 0, 0

    for _, endTime in ipairs(endList) do
        local ratioSum = buffDic[endTime]
        local curSec = math.max(0, endTime - startTime)
        local buffTime = math.max(0, curSec - lastSec)
        lastSec = curSec
        local accRatio = 1 + ratioSum / 10000
        local accTime = buffTime * accRatio

        if costTime >= accTime then
            -- 剩余时间大于加速时间
            costTime = costTime - accTime
            accBuffTime = accBuffTime + buffTime
        else
            accTime = costTime / accRatio
            accBuffTime = accBuffTime + accTime
            costTime = 0
            break
        end
    end

    return math.ceil(accBuffTime + costTime) + startTime
end

-- 获取最大可制造道具数量 itemNum字段为一批，可配置大于1的数
function OtakuHelper.GetMaxMakeNum(makeCfg, makedNum)
    if not makedNum then
        makedNum = 0
    end

    local costItem, remainNum = makeCfg.costItem, makeCfg.makeMax - makedNum

    if not costItem or (#costItem == 0) then
        return remainNum
    end

    local maxMakeNum, costNum = remainNum, makeCfg.costNum

    for i, itemId in ipairs(costItem) do
        local itemNum = ItemDataMgr:GetInstance():GetItemNumById(itemId)

        if itemNum <= 0 then
            return 0
        end

        local canMakeNum = math.floor(itemNum / costNum[i])

        if canMakeNum <= 0 then
            return 0
        end

        if canMakeNum < maxMakeNum then
            maxMakeNum = canMakeNum
        end
    end
    return maxMakeNum
end

-- 获取制造加成
function OtakuHelper.GetMakeScale(houseLevel)
    if houseLevel then
        local powerCfg = ConfigHelper.GetCfg("power", houseLevel.makeResult)
        if powerCfg then
            return powerCfg.powerValue[#powerCfg.powerValue]
        else
            Logger.LogError("houseLevel is 空 , id = " .. tostring(houseLevel.makeResult))
        end
    else
        Logger.LogError("houseLevel is 空 !!!")
    end

    return 0
end

-- ↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑ 制造相关  end  ↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑

--舱室入住探员可行走巡逻
function OtakuHelper.AddWalkFSM(role, type)
    local cfg = ConfigHelper.GetCfg("houseRes", type)

    if cfg.slot and #cfg.slot > 0 then
        local aaa = math.random(1, #cfg.slot)
        local strPath = cfg.slot[aaa]
        local strPoints = string.split(strPath, ",")
        local burnPoint = Vector3.New(tonumber(strPoints[1]) / 1000, tonumber(strPoints[2]) / 1000,
            tonumber(strPoints[3]) / 1000)
        role.transform.localPosition = burnPoint
    end

    local fsm = role.gameObject:AddComponent(typeof(CS.GameX.FSM_WalkSceneCtrl))
    fsm.m_HouseType = type
end

--通过英雄ID，和当前好感度，获得好感度等级:当前好感度:下个好感度:以及当前升级进度，好感度阶段,是否有升级剧情
function OtakuHelper.GetHeroFeeling(heroId, favor)
    if heroId == 0 then
        return 0, 0, 0, 0, 0, 0, 0
    end

    local heroData = IHeroDataMgr:GetMyHeroDataById(heroId)
    local cfgs = ConfigHelper.GetCfgsByLua("heroFeeling", { hero = heroId })
    local nearSmallCfg = nil
    local nearBigCfg = nil
    local maxCfg = nil

    for i, cfg in ipairs(cfgs) do
        if cfg.feelingValue <= favor then
            if nearSmallCfg == nil or (nearSmallCfg and nearSmallCfg.feelingValue < cfg.feelingValue) then
                if cfg.feelingLevel <= heroData:GetRoleStudioHeroData().maxLevel then
                    nearSmallCfg = cfg
                end
            end
        end

        if maxCfg == nil or cfg.feelingValue >= maxCfg.feelingValue then
            maxCfg = cfg
        end
    end

    local level = 0
    local leftFavour = 0
    local stage = 1
    local stageStory = 0
    local roomStory = 0
    local roomStoryLevel = 0

    if nearSmallCfg then
        level = nearSmallCfg.feelingLevel
        leftFavour = nearSmallCfg.feelingValue
        stage = nearSmallCfg.stage

        if level + 1 <= maxCfg.feelingLevel then
            nearBigCfg = ConfigHelper.GetCfgsByLua("heroFeeling", { hero = heroId, feelingLevel = level + 1 })[1]
        else
            nearBigCfg = maxCfg
        end
    else
        nearBigCfg = ConfigHelper.GetCfgsByLua("heroFeeling", { hero = heroId, feelingLevel = 0 })[1]
    end

    local curFavor = favor
    local rightFavour = nearBigCfg ~= nil and nearBigCfg.feelingValue or maxCfg.feelingValue
    local progress = 0

    if rightFavour - leftFavour == 0 then
        progress = 1
    else
        progress = (favor - leftFavour) / (rightFavour - leftFavour)
    end

    --判断是否有升级剧情
    for i, cfg in ipairs(cfgs) do
        if cfg.feelingLevel <= level and cfg.roomStory ~= 0 then
            if cfg.feelingLevel > heroData:GetRoleStudioHeroData().RoomStory then
                roomStory = cfg.roomStory
                roomStoryLevel = cfg.feelingLevel
                break
            end
        end
    end
    return level, favor, rightFavour, progress, stage, roomStory, roomStoryLevel
end

-- 该道具是不是指定英雄喜欢的
function OtakuHelper.IsUpGiftItem(heroCfg, itemId)
    if heroCfg == nil then
        return false
    end

    local feelingItem = heroCfg.feelingItem
    local feelingItemStory = heroCfg.feelingItemStory
    local feelingItemLen = feelingItem.Length
    local isUp = false

    for i = 0, feelingItemLen - 1 do
        local id = feelingItem[i]

        if id == itemId then
            isUp = true
            break
        end
    end
    return isUp
end

-- 该道具是不是指定英雄的解锁动作道具  是否为英雄可用道具:是否为专属:对应解锁interactEventId:
function OtakuHelper.HasUnlockAct(heroCfg, itemCfg)
    if heroCfg == nil then
        return false, false, 0
    end

    local itemType = itemCfg.type

    if itemType ~= CS.GameBase.EItemType.EIT_Gift:GetHashCode() then
        return false, false
    end

    local isAvilable = false
    local isForHero = false
    local itemSubtype = itemCfg.subType
    local heroId = heroCfg.id

    if itemSubtype == 100 and itemCfg.effectType == 5 then
        if itemCfg.effectArgs.Length >= 2 then
            if itemCfg.effectArgs[0] == heroId then
                isForHero = true
                isAvilable = true
            end
        end
    elseif itemSubtype ~= 100 and itemCfg.effectType == 5 then
        isForHero = false
        isAvilable = true
    end
    return isAvilable, isForHero
end

--获取当前阶段所有好感度等级
function OtakuHelper.GetFeelingLevelByStage(heroId, stage, level, curLevel)
    local cfgs = ConfigHelper.GetCfgsByLua("heroFeeling", { hero = heroId })
    local levels = {}

    for i, cfg in ipairs(cfgs) do
        local data = {}

        --好感度0级不显示
        if cfg.stage == stage and cfg.feelingLevel ~= 0 then
            data.feelingLevel = cfg.feelingLevel
            data.curLevel = curLevel

            if cfg.feelingLevel == level then
                data.isSelect = true
            else
                data.isSelect = false
            end

            if cfg.feelingLevel > curLevel then
                data.isLock = true
            else
                data.isLock = false
            end

            data.title = cfg.title

            tInsert(levels, data)
        end
    end
    return levels
end

--获取当前等级解锁数据
function OtakuHelper.GetFellingLevelUnlock(heroId, level, favorLevel)
    favorLevel = favorLevel or 0
    local cfgs = ConfigHelper.GetCfgsByLua("heroFeeling", { hero = heroId, feelingLevel = level })
    local datas = {}

    if cfgs and #cfgs > 0 then
        if cfgs[1].unlockWords == nil then
            return nil
        else
            for i = 1, #cfgs[1].unlockWords do
                local data = {}
                data.unlockWords = cfgs[1].unlockWords[i]
                data.linkTo = cfgs[1].linkTo[i]
                data.unlock = favorLevel >= cfgs[1].feelingLevel
                data.heroId = heroId
                data.roomStory = cfgs[1].roomStory
                tInsert(datas, data)
            end
        end
    end
    return datas
end

--获取所有好感度阶级数据
function OtakuHelper.GetFeelingStages(heroId, favorLevel, stage)
    local cfgs = ConfigHelper.GetCfgsByLua("heroFeeling", { hero = heroId })
    local maxStage = 0

    for i, cfg in ipairs(cfgs) do
        if cfg.stage >= maxStage then
            maxStage = cfg.stage
        end
    end

    local datas = {}

    for i = 1, maxStage do
        local data = {}
        data.stage = i

        if i == stage then
            data.isSelect = true
        else
            data.isSelect = false
        end

        data.curStage = favorLevel
        tInsert(datas, data)
    end
    return datas
end

function OtakuHelper.CheckFavorUp(heroId, favorLevel)
    local data = IRoleStudioHeroDataMgr:GetRoleStudioDataById(heroId)

    local level = data.showFavorLevel

    if data.favorLevelChange and favorLevel > level then
        level = favorLevel
        return true, level
    end
    return false
end

--获取宿舍剧情的所有步骤
function OtakuHelper.GetFavorStoryByGroupId(groupId)
    local cfgs = ConfigHelper.GetCfgsByLua("roomStory", { groupId = groupId })
    local datas = {}

    for i, cfg in ipairs(cfgs) do
        datas[cfg.stepId] = cfg
    end
    return datas
end

function OtakuHelper.GetMinLevelByStage(heroId, stage)
    local cfgs = ConfigHelper.GetCfgsByLua("heroFeeling", { hero = heroId, stage = stage })
    return cfgs[1].feelingLevel > 0 and cfgs[1].feelingLevel or cfgs[2].feelingLevel
end

function OtakuHelper.CheckOpenConDition(type, withTips)
    local cfg = ConfigHelper.GetCfg("houseRes", type)

    if withTips == nil then
        withTips = true
    end

    if cfg then
        local lockList = GameHelper.GetLockConditions(cfg.openCondition)

        if lockList and #lockList > 0 then
            local openCfg = ConfigHelper.GetCfgByLua("openCondition", lockList[1])

            if withTips then
                GameHelper.TipsById(openCfg.tips)
            end
            return false
        else
            return true
        end
    end

    return false
end

function OtakuHelper.GetRoomLockByString(openCondition)
    local text = ""
    local condition = ConfigHelper.GetCfgByLua("openCondition", openCondition)
    if text == "" then
        text = ConfigHelper.GetLocalString(condition.tips)
    else
        text = text .. " " .. ConfigHelper.GetLocalString(condition.tips)
    end
    return text
end

--当前英雄饱食度
function OtakuHelper.Satiety(heroId)
    local data = IRoleStudioHeroDataMgr:GetRoleStudioDataById(heroId)
    local satiety = data:GetEater()
    return satiety
end

--当前英雄最大饱食度
function OtakuHelper.MaxSatiety(heroId)
    local data = IHeroDataMgr:GetMyHeroDataById(heroId)
    local maxSatiety = data:GetHeroCfg().eater
    return maxSatiety
end

-- 房间升级状态
function OtakuHelper.CheckRoomUpState(roomData)
    local itemIds, itemNums = roomData:GetUpgradeCost()

    for i, itemId in ipairs(itemIds) do
        if not GameHelper.CheckItem(itemId, itemNums[i]) then
            return OtakuType.UpgradeState.LessConsume
        end
    end

    local roomType = roomData:Type()

    if roomType ~= OtakuType.OtakuRoomType.EST_Bridge then
        local roomLevel = roomData:Level()
        local limitLevel = OtakuRoomDataMgr:GetInstance():GetRoomCurUpLimitByType(roomType)

        if roomLevel >= limitLevel then
            return OtakuType.UpgradeState.LessBridgeLv
        end
    end

    return OtakuType.UpgradeState.Available
end

-- 是否存在指定远征任务
function OtakuHelper.IsExistExpMission(expMissionId)
    local roomType = OtakuType.OtakuRoomType.EST_Survey
    local roomDatas = OtakuRoomDataMgr:GetInstance():RoomDatasByRoomType(roomType)
    local roomData = (#roomDatas > 0) and roomDatas[1] or nil
    local taskdatas = roomData and roomData:GetExtraData() or nil
    for _, taskData in pairs(taskdatas or {}) do
        if expMissionId == taskData.ConfigId then return true end
    end
    return false
end

function OtakuHelper.IsOtakuAnimatorOnPlay()
    if OtakuRoomDataMgr:GetInstance().onAnimator == nil then
        return true
    end
    return OtakuRoomDataMgr:GetInstance().onAnimator
end

return OtakuHelper
