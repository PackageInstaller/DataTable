---
--- 烹饪玩法，工具类
--- Author: dawanfan
--- Date: 2024-3-12 11:36:02
---

---@type LuaParametersReader
local LuaParametersReader = import('Game.Utils.LuaParametersReader')
local LuaParametersType = LuaParametersReader.Type
local LuaParameters = CS.Engine.Modules.LuaParameters
local PriorityQueue = import("Game.Utils.PriorityQueue")


---@type ActivityCookingComponent
local ActivityCookingComponent = GameUtils.GetOrAddEntityCompByType(ECSComponentType.Constants.ActivityCookingComponent)
---@type ActivityCookingConstants
local ActivityCookingConstants = import("Game.UI.ActivityCooking.ActivityCookingConstants")


---@class ActivityCookingUtils
local ActivityCookingUtils = {}


--- 解析节点数据
function ActivityCookingUtils.ParserNodeData()

end

--- 解析厨具参数
---@return ActivityCookingKitchenwareParam
function ActivityCookingUtils.ParserKitchenwareParameters(params)
    if params == nil then
        return nil
    end

    local data = {}
    data.EntryAnimationName = LuaParametersReader.Read(params, "EntryAnimationName", LuaParametersType.String)
    data.CookingAnimationName = LuaParametersReader.Read(params, "CookingAnimationName", LuaParametersType.String)
    data.FinishAnimationName = LuaParametersReader.Read(params, "FinishAnimationName", LuaParametersType.String)
    data.BurntAnimationName = LuaParametersReader.Read(params, "BurntAnimationName", LuaParametersType.String)
    data.ResetAnimationName = LuaParametersReader.Read(params, "ResetAnimationName", LuaParametersType.String)
    data.WorkingAudioSheetName = LuaParametersReader.Read(params, "WorkingAudioSheetName", LuaParametersType.String)
    data.WorkingAudioName = LuaParametersReader.Read(params, "WorkingAudioName", LuaParametersType.String)

    return data
end

--- 解析食物参数
---@return ActivityCookingFoodParam
function ActivityCookingUtils.ParserFoodParameters(params)
    if params == nil then
        return nil
    end

    local data = {}
    data.FoodEntryAnimationName = LuaParametersReader.Read(params, "FoodEntryAnimationName", LuaParametersType.String)
    data.AddIngredientsAnimName1 = LuaParametersReader.Read(params, "AddIngredientsAnimName1", LuaParametersType.String)
    data.AddIngredientsAnimName2 = LuaParametersReader.Read(params, "AddIngredientsAnimName2", LuaParametersType.String)


    return data
end


--- 创建厨具数据
---@return ActivityCooking.ViewKitchenware
function ActivityCookingUtils.CreateKitchenwareData(index, nodeId)
    ---@type ActivityCookingNodeVo
    local cookingNodeVo = CfUtils.GetCfVo(AutoIds.IdSetting6232, "ActivityCookingNodeVo", nodeId)
    local kitchenwareVo = ActivityCookingUtils.GetKitchenwareVo(cookingNodeVo.kitchenwareId)
    -- local kitchenwareVo = CfUtils.GetCfVo(AutoIds.IdSetting6231, "ActivityCookingKitchenwareVo", kitchenwareId)
    local kitchenwareInfo = ActivityCookingComponent.dojo.kitchenwareInfos[kitchenwareVo.id]

    local workTime = kitchenwareVo.processingTime[kitchenwareInfo.level]
    local burntTime = checkNumber(kitchenwareVo.burntTime)

    ---@type ActivityCooking.ViewKitchenware
    local data = {
        index = index, id = kitchenwareVo.id, state=ActivityCookingConstants.KitchenwareState.Idle, level=kitchenwareInfo.level,
        canBurnt=burntTime > 0, nextStateTime=0, burntTime=burntTime, workTime=workTime, autoCompelete=cookingNodeVo.autoIdleIfFinish, autoCooking=cookingNodeVo.autoCooking
    }

    return data
end

---@return ActivityCookingGameData
function ActivityCookingUtils.CreateCookingGameData(levelId)
    
    local activityCookingLevelVo = ActivityCookingUtils.GetCookingLevelVo(levelId)
    
    ---@type ActivityCookingGuestComingVo[]
    local guestComingTable = CfUtils.GetCf(AutoIds.IdSetting6250, "ActivityCookingGuestComingVo", true)

    --- 创建顾客队列
    local guestQueue = PriorityQueue.New(function(x, y) return x > y end)
    for _, guestComingVo in pairs(guestComingTable) do
        if guestComingVo.groupId == activityCookingLevelVo.groupId then
            local guestData = ActivityCookingUtils.CreateCookingGuestData(guestComingVo)
            guestQueue:Enqueue(guestData, checkInt(guestData.enterTime))
        end
    end
    
    local conditions = {}
    for _, condition in pairs(activityCookingLevelVo.failingCondition) do
        conditions[condition] = true
    end

    ---@type ActivityCookingGameData
    local data = {
        selledFood = {},
        selledPrice = 0,
        finishGuestNum = 0,
        successGuestNum = 0,
        failingData = {},
        totalTime = activityCookingLevelVo.levelDuration,
        currentTime = 0,
        gameMode = activityCookingLevelVo.type,
        guestQueue = guestQueue,
        ratingCondition = activityCookingLevelVo.ratingCondition,
        ratingParam = activityCookingLevelVo.ratingParam,
        totalGuestNum = guestQueue:Size(),
        failingCondition = conditions,
        isTrash=false,
        trashEnable=activityCookingLevelVo.useTrash
    }

    return data
end

---@param guestComingVo ActivityCookingGuestComingVo
---@return ActivityCooking.ViewGuest
function ActivityCookingUtils.CreateCookingGuestData(guestComingVo)

    local needFoods = {}
    for i, foodId in ipairs(guestComingVo.needFoods) do
        needFoods[i] = {id=foodId, hasGet=false}
    end

    ---@type ActivityCooking.ViewGuest
    local data = {
        id = guestComingVo.guestId,
        enterTime = guestComingVo.appearTime,
        needFoods = needFoods,
        survivalTime = guestComingVo.survivalTime,
        addTime = guestComingVo.addTime,
        location = guestComingVo.location,
    }

    return data
end

---@return ActivityCookingKitchenwareVo
function ActivityCookingUtils.GetKitchenwareVoByNodeId(nodeId)
    ---@type ActivityCookingNodeVo
    local cookingNodeVo = CfUtils.GetCfVo(AutoIds.IdSetting6232, "ActivityCookingNodeVo", nodeId)
    return ActivityCookingUtils.GetKitchenwareVo(cookingNodeVo.kitchenwareId)
end

--- 获取食物价格
---@return number
function ActivityCookingUtils.GetFoodPrice(foodId)
    local foodVo = ActivityCookingUtils.GetCookingFoodVo(foodId)
    
    local price = 0
    for _, ingredientsId in pairs(foodVo.ingredientsId) do
        local ingredientsVo = ActivityCookingUtils.GetCookingIngredientsVo(ingredientsId)
        local level = ActivityCookingComponent.dojo:GetIngredientsLevel(ingredientsId)
        if level ~= 0 then
            local ingredientsPrice = ingredientsVo.price[level]
            if ingredientsPrice == nil then
                printError("[ActivityCookingUtils][GetFoodPrice] ingredients price data not found, ingredientsId: %s, level: %s", ingredientsId, level)
            else
                price = price + ingredientsPrice
            end
        end
    end

    return price
end

--- 厨具数据
---@return ActivityCookingKitchenwareVo
function ActivityCookingUtils.GetKitchenwareVo(kitchenwareId)
    return CfUtils.GetCfVo(AutoIds.IdSetting6231, "ActivityCookingKitchenwareVo", kitchenwareId)
end

--- 烹饪玩法配置数据
---@return ActivityCookingConfigVo
function ActivityCookingUtils.GetCookingConfigVo()
    if ActivityCookingComponent.dojo.config == nil then
        return nil
    end
    return CfUtils.GetCfVo(AutoIds.IdSetting6234, "ActivityCookingConfigVo", ActivityCookingComponent.dojo.config.id)
end

--- 烹饪节点数据
---@return ActivityCookingNodeVo
function ActivityCookingUtils.GetCookingNodeVo(nodeId)
    return CfUtils.GetCfVo(AutoIds.IdSetting6232, "ActivityCookingNodeVo", nodeId)
end

--- 食物组数据
---@return ActivityCookingFoodGroupVo
function ActivityCookingUtils.GetCookingFoodGroupVo(groupId)
    return CfUtils.GetCfVo(AutoIds.IdSetting6235, "ActivityCookingFoodGroupVo", groupId)
end

--- 食物数据
---@return ActivityCookingFoodVo
function ActivityCookingUtils.GetCookingFoodVo(foodId)
    return CfUtils.GetCfVo(AutoIds.IdSetting6233, "ActivityCookingFoodVo", foodId)
end

--- 食物加工数据
---@return ActivityCookingFoodProcessVo
function ActivityCookingUtils.GetCookingFoodProcessVo(foodGoupId)
    return CfUtils.GetCfVo(AutoIds.IdSetting6236, "ActivityCookingFoodProcessVo", foodGoupId)
end

--- 食材数据
---@return ActivityCookingIngredientsVo
function ActivityCookingUtils.GetCookingIngredientsVo(ingredientsId)
    return CfUtils.GetCfVo(AutoIds.IdSetting6230, "ActivityCookingIngredientsVo", ingredientsId)
end

--- 顾客形象数据
---@return ActivityCookingGuestVo
function ActivityCookingUtils.GetCookingGuestVo(guestId)
    return CfUtils.GetCfVo(AutoIds.IdSetting6237, "ActivityCookingGuestVo", guestId)
end

--- 烹饪关卡数据
---@return ActivityCookingLevelVo
function ActivityCookingUtils.GetCookingLevelVo(levelId)
    return CfUtils.GetCfVo(AutoIds.IdSetting6238, "ActivityCookingLevelVo", levelId)
end

--- 活动排期数据
---@return ActivityCookingRankVo[]
function ActivityCookingUtils.GetCookingRankVos(activityScheduleId)
    local result = {}

    local data = CfUtils.GetCf(AutoIds.IdSetting6252, "ActivityCookingRankVo", true)
    for _, vo in pairs(data) do
        if vo.activityId == activityScheduleId then
            table.insert(result, vo)
        end
    end

    return result
end

function ActivityCookingUtils.GetCookingLevelVosByActivityId(activityScheduleId)
    local result = {}
    local data = CfUtils.GetCf(AutoIds.IdSetting6238, "ActivityCookingLevelVo", true)
    for _, vo in pairs(data) do
        if vo.cookingActivityId == activityScheduleId then
            table.insert(result, vo)
        end
    end

    return result
end

---@return boolean
function ActivityCookingUtils.HasAnyFoodOrKitchenwareCanUpgrade()
    for id, ingredientsInfo in pairs(ActivityCookingComponent.dojo.ingredientsInfo ) do
        local ingredientsVo = ActivityCookingUtils.GetCookingIngredientsVo(id)
        if ActivityCookingComponent.dojo:IsLevelUnlock(ingredientsVo.unlockLevel) then
            if ingredientsInfo.level < ingredientsVo.maxLevel then
                local costItem = ingredientsVo.levelupConsumeItem[ingredientsInfo.level]
                local costNum = ingredientsVo.levelupConsume[ingredientsInfo.level]
    
                if GoodsUtils.CheckGoodConsumeCondition({{id=costItem, num=costNum}}) then
                    return true
                end
            end
        end
    end

    for id, kitchenwareInfo in pairs(ActivityCookingComponent.dojo.kitchenwareInfos ) do
        local kitchenwareVo = ActivityCookingUtils.GetKitchenwareVo(id)
        if ActivityCookingComponent.dojo:IsLevelUnlock(kitchenwareVo.unlockLevel) then
            if kitchenwareInfo.level < kitchenwareVo.maxLevel then
                local costItem = kitchenwareVo.levelupConsumeItem[kitchenwareInfo.level]
                local costNum = kitchenwareVo.levelupConsume[kitchenwareInfo.level]
    
                if GoodsUtils.CheckGoodConsumeCondition({{id=costItem, num=costNum}}) then
                    return true
                end
            end
        end
    end

    return false
end

return ActivityCookingUtils
