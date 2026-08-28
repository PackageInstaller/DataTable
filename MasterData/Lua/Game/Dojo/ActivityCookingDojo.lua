---
--- 烹饪玩法服务端数据
--- Author: dawanfan
--- Date: 2024-3-12 16:09:32
---

local CountDownTime = 2592000 --30 * 86400 30天的秒数
local CDTimerModule = CS.Engine.Modules.CDTimerModule

---@class ActivityCooking.Kitchenward
---@field level number

---@class ActivityCooking.Ingredients
---@field level number

---@class ActivityCooking.RankData 
---@field playerId number 
---@field score number
---@field ranking number
---@field name string
---@field level number
---@field avatar number
---@field avatarFrame number


local ActivityCookingConstants = import("Game.UI.ActivityCooking.ActivityCookingConstants")

---@class ActivityCookingDojo
---@field kitchenwareInfos table<number, ActivityCooking.Kitchenward>
---@field ingredientsInfo table<number, ActivityCooking.Ingredients>
---@field playerRank {ranking:number, score:number}
---@field rank ActivityCooking.RankData[]
---@field hpData {buyTimes:number, hp:number, lastCdTime:number}
local ActivityCookingDojo = Class("ActivityCookingDojo")

function ActivityCookingDojo:__init()
    self.kitchenwareInfos = {
        [1] = {level = 3},
        [2] = {level = 3},
        [3] = {level = 3},
        [4] = {level = 3},
    }
    self.ingredientsInfo = {
        [1] = {level = 1},
        [2] = {level = 3},
        [3] = {level = 1},
        [4] = {level = 1},
        [5] = {level = 1},
        [6] = {level = 1},
        [7] = {level = 1},
        [8] = {level = 1}
    }

    self.levelInfo = {
        [1] = {star = 1,},
        [2] = {star = 0,},
        [3] = {star = 0,}
    }

    self.totalStar = 55
    self.config = nil
end

function ActivityCookingDojo:__delete()
    self.kitchenwareInfos = nil
    self.ingredientsInfo = nil
    self.levelInfo = nil
    self.config = nil
    self.rank = nil
    self.playerRank = nil
    self.cookingRankData = nil
end

function ActivityCookingDojo:Init(data)
    self.kitchenwareInfos = {}
    for _, tableward in pairs(checkTable(data.tablewareList)) do
        self.kitchenwareInfos[tonumber(tableward.id)] = tableward
    end

    self.ingredientsInfo = {}
    for _, food in pairs(checkTable(data.foodList)) do
        self.ingredientsInfo[tonumber(food.id)] = food
    end

    self.playerRank  = data.playerRank
    self.rank = data.rank
    self.totalStar = checkNumber(data.starSum)
    for id, levelInfo in pairs(checkTable(data.questList)) do
        self.levelInfo[tonumber(id)] = levelInfo
    end
    
    self.config = data.config
    self.hpData = data.hpData
    self.totalRankNum = data.totalNum

    local ActivityCookingUtils = import("Game.UI.ActivityCooking.ActivityCookingUtils")
    self.cookingRankData = ActivityCookingUtils.GetCookingRankVos()

    self:StartTimeDown()
end

function ActivityCookingDojo:GetKitchenwareFoodShowNum(kitchenwareId, levelId)
    local kitchenwareInfo = self.kitchenwareInfos[kitchenwareId]
    if kitchenwareInfo == nil then
        return 0
    end


    local ActivityCookingUtils = import("Game.UI.ActivityCooking.ActivityCookingUtils")
    local kitchenwareVo = ActivityCookingUtils.GetKitchenwareVo(kitchenwareId)
    if kitchenwareVo == nil then
        return 0
    end

    if levelId ~= nil then
        if levelId < kitchenwareVo.unlockLevel then
            return 0
        end
    end

    return kitchenwareVo.kitchenwareNum[kitchenwareInfo.level]
end

function ActivityCookingDojo:GetIngredientsLevel(ingredientsId)
    local ingredientsInfo = self.ingredientsInfo[ingredientsId]
    if ingredientsInfo == nil then
        printError("[ActivityCookingDojo][GetIngredientsPrice] ingredients data not found, id: %s", ingredientsId)
        return 0
    end

    return ingredientsInfo.level
end

function ActivityCookingDojo:GetItemLevel(id, itemType)
    if itemType == ActivityCookingConstants.UpgradeItemType.Ingredients then
        return self.ingredientsInfo[id].level
    else
        return self.kitchenwareInfos[id].level
    end
end

function ActivityCookingDojo:GetItemIconPath(id, itemType)
    local ActivityCookingUtils = import("Game.UI.ActivityCooking.ActivityCookingUtils")
    if itemType == ActivityCookingConstants.UpgradeItemType.Ingredients then
        local vo = ActivityCookingUtils.GetCookingIngredientsVo(id)
        local level = self.ingredientsInfo[id].level
        local iconDict = parse_strings(vo.icon[level], ":")
        return CS.GameUtils.GetCombineResourceDirPath(tonumber(iconDict[1]), iconDict[2])
    else
        local vo = ActivityCookingUtils.GetKitchenwareVo(id)
        local level = self.kitchenwareInfos[id].level
        local iconDict = parse_strings(vo.icon[level], ":")
        return CS.GameUtils.GetCombineResourceDirPath(tonumber(iconDict[1]), iconDict[2])
    end
end

function ActivityCookingDojo:GetItemDes(id, itemType)
    local ActivityCookingUtils = import("Game.UI.ActivityCooking.ActivityCookingUtils")
    if itemType == ActivityCookingConstants.UpgradeItemType.Ingredients then
        local vo = ActivityCookingUtils.GetCookingIngredientsVo(id)
        local level = self.ingredientsInfo[id].level

        if level == ActivityCookingConstants.ItemMaxLevel then
            return vo.des2
        end

        return string.fmt(vo.des, {["_curPrice_"]=vo.price[level], ["_upgradePrice_"]=vo.price[level+1]})
    else
        local vo = ActivityCookingUtils.GetKitchenwareVo(id)
        local level = self.kitchenwareInfos[id].level

        if level == ActivityCookingConstants.ItemMaxLevel then
            return vo.des2
        end

        return string.fmt(vo.des, {["_curTime_"]=vo.processingTime[level], ["_upgradeTime_"]=vo.processingTime[level+1], ["_kitchenwareNum_"]=vo.kitchenwareNum[level+1]})
    end
end

function ActivityCookingDojo:IsLevelUnlock(levelId)
    local ActivityCookingUtils = import("Game.UI.ActivityCooking.ActivityCookingUtils")

    local levelInfo = self.levelInfo[levelId]
    if levelInfo ~= nil and levelInfo.star > 0 then
        return true
    end
    
    local levelVo = ActivityCookingUtils.GetCookingLevelVo(levelId)
    if levelVo == nil then
        return false
    end

    local preLevelInfo = self.levelInfo[levelVo.preId]
    if levelVo.preId > 0 then
        if not preLevelInfo or preLevelInfo.star == 0 then
            return false
        end
    end

    return self.totalStar >= levelVo.unlockStarNum
end

function ActivityCookingDojo:CanItemUpgrade(id, itemType)
    local ActivityCookingUtils = import("Game.UI.ActivityCooking.ActivityCookingUtils")
    if itemType == ActivityCookingConstants.UpgradeItemType.Ingredients then
        local ingredientsVo = ActivityCookingUtils.GetCookingIngredientsVo(id)
        local level = self.ingredientsInfo[id].level
        if level < ingredientsVo.maxLevel then
            local costItem = ingredientsVo.levelupConsumeItem[level]
                local costNum = ingredientsVo.levelupConsume[level]
    
                if GoodsUtils.CheckGoodConsumeCondition({{id=costItem, num=costNum}}) then
                    return true
                end
        end
    else
        local kitchenwareVo = ActivityCookingUtils.GetKitchenwareVo(id)
        local level = self.kitchenwareInfos[id].level
        if level < kitchenwareVo.maxLevel then
            local costItem = kitchenwareVo.levelupConsumeItem[level]
                local costNum = kitchenwareVo.levelupConsume[level]
    
                if GoodsUtils.CheckGoodConsumeCondition({{id=costItem, num=costNum}}) then
                    return true
                end
        end
    end

    return false

end

function ActivityCookingDojo:ClearTimeDown()
    if not isNull(self._timeDown) then
        CDTimerModule.GetInstance():RemoveCD(self._timeDown)
        self._timeDown = nil
    end
end

function ActivityCookingDojo:StartTimeDown()
    self:ClearTimeDown()
    local maxNum = self:GetMaxTicketNum()
    self._timeDown = CDTimerModule.GetInstance():AddCD(1, function(count, id)
        if self.hpData.hp < maxNum then
            self.hpData.lastCdTime = self.hpData.lastCdTime - 1
            if self.hpData.lastCdTime == 0 then
                self:AddTicketCount(1)
                self.hpData.lastCdTime = self:GetTicketAddTime()
                Events.Broadcast(Constants.EventNames.EveryThingChangeEventName, nil)
            elseif self.hpData.lastCdTime < 0 then
                self.hpData.lastCdTime = self:GetTicketAddTime()
            end
        else
            self.hpData.lastCdTime = 0
        end
    end, CountDownTime, false, true)
end

function ActivityCookingDojo:AddTicketCount(num)
    self.hpData.hp = self.hpData.hp + num
end

function ActivityCookingDojo:GetTicketAddTime()
    return checkNumber(self:GetConfigParamsById(ActivityCookingConstants.ParamsDefine.RESTORE_HP_INTERVAL))
end

function ActivityCookingDojo:GetConfigParamsById(id)
    ---@type BaseArgVo
    local vo = CfUtils.GetCfVo(AutoIds.IdSetting6253, "ActivityCookingParameterVo", id)
    if vo == nil then
        printError("烹饪活动参数表 中未找到 %s", id)
        return 0
    end
    return vo.num
end

function ActivityCookingDojo:GetMaxTicketNum()
    return checkNumber(self:GetConfigParamsById(ActivityCookingConstants.ParamsDefine.HP_UP_LIMIT))
end

return ActivityCookingDojo
