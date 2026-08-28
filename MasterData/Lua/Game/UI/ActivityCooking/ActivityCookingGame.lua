---
--- 烹饪玩法类
--- Author: dawanfan
--- Date: 2024-3-12 13:52:25
---


---@class ActivityCooking.ViewFood
---@field index number UI 中对应位置Id，运行时创建
---@field foodId number 食物 Id


---@class ActivityCooking.ViewKitchenware
---@field index number UI 中对应位置Id，运行时创建
---@field id number 厨具Id
---@field state number 当前状态
---@field canBurnt boolean 是否会糊
---@field nextStateTime number 进入下一状态时间
---@field burntTime number 烤糊所需时间
---@field workTime number 制作所需时间
---@field autoCompelete boolean 是否自动拾取食物
---@field autoCooking boolean 是否自动制作
---@field level number 等级


---@class ActivityCooking.ViewGuest
---@field id number 顾客id
---@field needFoods table<number, {id:number, hasGet:boolean}> 所需食物
---@field enterTime number 进入时间
---@field survivalTime number 存在时间
---@field addTime number
---@field location number


local cs_coroutine = require "XLua.cs_coroutine"
local Yielders = CS.Engine.Lib.Yielders
local UIModule = CS.Engine.UI.UIModule


local Singleton = import("Frame.Singleton")
local ActivityCookingConstants = import("Game.UI.ActivityCooking.ActivityCookingConstants")
local ActivityCookingUtils = import("Game.UI.ActivityCooking.ActivityCookingUtils")
---@type ActivityCookingComponent
local ActivityCookingComponent = GameUtils.GetOrAddEntityCompByType(ECSComponentType.Constants.ActivityCookingComponent)


---@class ActivityCookingGameData
---@field selledFood table<number, number>
---@field selledPrice number 营业额
---@field finishGuestNum number 完成顾客数量
---@field successGuestNum number
---@field totalTime number
---@field currentTime number
---@field gameMode number
---@field guestQueue PriorityQueue
---@field ratingCondition number 星级条件
---@field ratingParam number[] 星级条件参数
---@field totalGuestNum number
---@field failingCondition table<number, boolean>
---@field failingData table
---@field isTrash boolean 是否丢垃圾的状态
---@field trashEnable boolean 是否能使用垃圾桶


---@class ActivityCookingGame: Singleton
local ActivityCookingGame = Class("ActivityCookingGame", Singleton)

function ActivityCookingGame:__init()
    rawset(self.class, "Instance", self)
    self.currentLevel = nil
    self.inGame = false

    self._foodIndex = 0
    self._kitchenIndex = 0

    self.coUpdate = nil

    self.foodProcessDict = nil
    self.data = nil
    self.stopped = false
end

function ActivityCookingGame:__delete()
    self.foodProcessDict = nil
    self.data = nil
    self.stopped = false
end

--- 烹饪玩法入口
function ActivityCookingGame:StartGame(level)
    -- if self.inGame then
    --     return
    -- end

    self.currentLevel = level
    self.inGame = true
    self.stopped = false

    self.data = ActivityCookingUtils.CreateCookingGameData(level)

    local config = ActivityCookingConstants.CookingUIConfigs[ActivityCookingComponent.dojo.config.id]
    UIModule.OpenDialog({id=config.OperateMainDialog}, {{ id = config.EntryDialog}}, false)
    self:GenerateFoodProcessDict()
end

function ActivityCookingGame:GameRestart()
    -- if not self.inGame then
    --     return
    -- end

    self.inGame = false
    self.stopped = false

    GameUtils.ShowBlack()

    local config = ActivityCookingConstants.CookingUIConfigs[ActivityCookingComponent.dojo.config.id]
    UIModule.CloseDialogById(config.OperateMainDialog)
    self:StartGame(self.currentLevel)
end

function ActivityCookingGame:CookingEnd(cb)
    if not self:CheckIsGameEnd() then
        return
    end

    ---@type ActivityCookingComponent
    local ActivityCookingComponent = GameUtils.GetOrAddEntityCompByType(ECSComponentType.Constants.ActivityCookingComponent)
    ActivityCookingComponent:CookingEnd(self.currentLevel, self.data.selledFood, self.data.selledPrice, cb)
end

function ActivityCookingGame:Update(deltaTime)
    self.data.currentTime = self.data.currentTime + deltaTime
end

function ActivityCookingGame:CheckIsGameEnd()

    --- 额外失败条件判断
    for condition, _ in pairs(self.data.failingCondition) do
        if self.data.failingData[condition] ~= nil then
            return true
        end
    end

    if self.data.gameMode == ActivityCookingConstants.GameMode.Normal then
        return self:CheckNormalGameEnd()
    else
        return self:CheckEndlessGameEnd()
    end
end

function ActivityCookingGame:CheckNormalGameEnd()
    if self.data.finishGuestNum == self.data.totalGuestNum then
        return true
    end

    if self.data.totalTime <= self.data.currentTime then
        return true
    end

    return false
end

function ActivityCookingGame:CheckEndlessGameEnd()
    if self.data.totalTime <= self.data.currentTime then
        return true
    end

    return false
end


function ActivityCookingGame:GenKitchenIndex()
    self._kitchenIndex = self._kitchenIndex + 1
    return self._kitchenIndex
end

function ActivityCookingGame:GenFoodIndex()
    self._foodIndex = self._foodIndex + 1
    return self._foodIndex
end

function ActivityCookingGame:SellFood(foodId)
    
    if self.data.selledFood[foodId] == nil then
        self.data.selledFood[foodId] = 0
    end

    self.data.selledFood[foodId] = self.data.selledFood[foodId] + 1
    local price = ActivityCookingUtils.GetFoodPrice(foodId)
    self.data.selledPrice = self.data.selledPrice + price
end

--- 构造食物加工数据
function ActivityCookingGame:GenerateFoodProcessDict()
    if self.foodProcessDict ~= nil then
        return
    end

    self.foodProcessDict = {}
    ---@type ActivityCookingFoodProcessVo[]
    local foodProcessTable = CfUtils.GetCf(AutoIds.IdSetting6236, "ActivityCookingFoodProcessVo", true)

    for _, vo in pairs(foodProcessTable) do
        if self.foodProcessDict[vo.foodId] == nil then
            self.foodProcessDict[vo.foodId] = {}
        end
        self.foodProcessDict[vo.foodId][vo.ingredientsId] = vo.targetFoodId
    end
end


function ActivityCookingGame:GetCookingProcessTargetFoodId(foodId, ingredientsId)
    if self.inGame == false or self.foodProcessDict == nil then
        return nil
    end

    local processDict = checkTable(self.foodProcessDict[foodId])
    return processDict[ingredientsId]
end

function ActivityCookingGame:AddTime(time)
    self.data.totalTime = self.data.totalTime + time
end

function ActivityCookingGame:GameStop(value)
    self.stopped = value
end

function ActivityCookingGame:ExitGame()
    self.inGame = false
    self.data = nil
    local config = ActivityCookingConstants.CookingUIConfigs[ActivityCookingComponent.dojo.config.id]
    UIModule.OpenDialog({id=config.EntryDialog, parameters = {level=self.currentLevel}}, {{id=config.OperateMainDialog}}, false)
    -- UIModule.CloseDialogById(Constants.UITypeIds.ActivityOperateMainDialog, true)
end

---@return boolean
function ActivityCookingGame:DropFood()
    if not self.data.trashEnable then
        return false
    end

    if not self.data.isTrash then
        return false
    end

    self.data.isTrash = false
    self:SetConditionData(ActivityCookingConstants.CookingFailType.DropFood)

    return true
end

function ActivityCookingGame:SetConditionData(condition)
    self.data.failingData[condition] = true

    if self.data.failingCondition[condition] then
        GameUtils.Toast(ActivityCookingConstants.CookingFailMessage[condition])
    end
end

return ActivityCookingGame
