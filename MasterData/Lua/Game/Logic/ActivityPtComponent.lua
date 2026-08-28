---
--- Created by THL.
---

local ECSComponent = import("Frame.ECS.ECSComponent")

local CDTimerModule = CS.Engine.Modules.CDTimerModule
local CountDownTime = 2592000 --30 * 86400 30天的秒数

---@class ActivityPtComponent
local ActivityPtComponent = Class("ActivityPtComponent", ECSComponent)

function ActivityPtComponent:__init()
    self._activityConf = {}      --活动配置信息
    self._newQuestId = 0         --最新通关剧情关卡id
    self._getActivityGoodsNum = 0         --累积获得活动道具数量

    self._planTask = {}      --周期任务
    self._dailyTask = {}      --日常任务
    self._dailyTaskTimeLeft = 0      --日常剩余时间
    self._planTaskTimeLeft = 0      --周期剩余时间

    self._shopData = {}
end

function ActivityPtComponent:__delete()
    self._activityConf = {}      --活动配置信息
    self._newQuestId = 0         --最新通关剧情关卡id
    self._getActivityGoodsNum = 0         --累积获得活动道具数量

    self._planTask = {}      --周期任务
    self._dailyTask = {}      --日常任务

    self._shopData = {}
end


function ActivityPtComponent:GetActivityConf()
    return self._activityConf
end

function ActivityPtComponent:GetNewQuestId()
    return checkNumber(self._newQuestId)
end

function ActivityPtComponent:GetGetActivityGoodsNum()
    return checkNumber(self._getActivityGoodsNum)
end

function ActivityPtComponent:GetPlanTask()
    return self._planTask
end

function ActivityPtComponent:GetDailyTask()
    return self._dailyTask
end

function ActivityPtComponent:GetDailyTaskTimeLeft()
    return self._dailyTaskTimeLeft
end

function ActivityPtComponent:GetPlanTaskTimeLeft()
    return self._planTaskTimeLeft
end

function ActivityPtComponent:GetShopData()
    return self._shopData
end

---OverseaActivityPtQuestHomeReq 剧情活动首页
function ActivityPtComponent:OverseaActivityPtQuestHomeReq(activityUuid, cb)
    GameUtils.Request(Interfaces.OverseaActivityPtQuestHome, {activityUuid = activityUuid}, function(request, response)
        if checkNumber(response.errCode) == 0 then
            local jsonData = response.data

            self._activityConf = checkTable(jsonData.activityConf)      

            local t = checkTable(jsonData.plotQuest)
            self._newQuestId = checkNumber(t.newQuestId)         
            self._getActivityGoodsNum = checkNumber(t.getActivityGoodsNum)         

            if cb then
                cb()
            end
        end
    end)
end

---OverseaActivityPtQuestPlotReq 剧情活动关卡
function ActivityPtComponent:OverseaActivityPtQuestPlotReq(activityUuid, questId, cb)
    GameUtils.Request(Interfaces.OverseaActivityPtQuestPlot, {activityUuid = activityUuid, questId = questId}, function(request, response)
        if checkNumber(response.errCode) == 0 then
            local jsonData = response.data

            --local playerComponent = GameUtils.GetEntityCompByType(ECSComponentType.Constants.PlayerComponent)
            --playerComponent:UpdatePlayerLvMainExp(jsonData.playerLv, jsonData.mainExp)
            --if not isNull(jsonData.hp) then
            --    GoodsUtils.DrawRewards({
            --        {
            --        num = checkNumber(jsonData.hp) - GoodsUtils.GetThingNo(Constants.Currency.HpId),
            --        goodsId = Constants.Currency.HpId
            --        }
            --    })
            --end

            self._newQuestId = checkNumber(questId)
            if isTable(jsonData.rewards) and checkNumber(self._activityConf.id) > 0 then
                ---@type ActivityPtPlanVo
                local vo = CfUtils.GetCfVo(AutoIds.IdSetting4120, "ActivityPtPlanVo", self._activityConf.id)
                for _, v in pairs(jsonData.rewards) do
                    if checkNumber(v.goodsId) == checkNumber(vo.pointId) then
                        self._getActivityGoodsNum = checkNumber(self._getActivityGoodsNum) + checkNumber(v.num)
                    end
                end
            end
            GoodsUtils.DrawRewards(jsonData.rewards)
            --UIModule.OpenDialog({ id = Constants.UITypeIds.UICommonRewardPop, parameters = { rewards = response.data.rewards } })

            if cb then
                cb(jsonData.rewards)
            end
        end
    end)
end

--OverseaActivityPtQuestTaskReq  剧情活动任务
function ActivityPtComponent:OverseaActivityPtQuestTaskReq(activityUuid, cb)
    GameUtils.Request(Interfaces.OverseaActivityPtQuestTask, {activityUuid = activityUuid}, function(request, response)
        if checkNumber(response.errCode) == 0 then
            local jsonData = response.data

            local t = checkTable(jsonData.task)
            self._planTask = {}
            for k, v in pairs(t) do
                self._planTask[checkString(v.id)] = v
            end

            t = checkTable(jsonData.dailyTask)
            self._dailyTask = {}
            for k, v in pairs(t) do
                self._dailyTask[checkString(v.id)] = v
            end
            
            self._dailyTaskTimeLeft = checkNumber(jsonData.dailyTaskTimeLeft)
            self._planTaskTimeLeft = checkNumber(jsonData.taskTimeLeft)
            self:StartTimeDown()

            if cb then
                cb()
            end
        end
    end)
end

function ActivityPtComponent:StartTimeDown()
    if not isNull(self._timeDown) then
        CDTimerModule.GetInstance():RemoveCD(self._timeDown)
        self._timeDown = nil
    end

    self._timeDown = CDTimerModule.GetInstance():AddCD(1, function(count, id)
        self._dailyTaskTimeLeft = checkNumber(self._dailyTaskTimeLeft) - 1 
        self._planTaskTimeLeft = checkNumber(self._planTaskTimeLeft) - 1 

        if self._shopData then
            self._shopData.remainingTimes = checkNumber(self._shopData.remainingTimes) - 1
        end
    end, CountDownTime, false, true)
end

--OverseaActivityPtQuestDrawTaskReq 领取任务奖励
function ActivityPtComponent:OverseaActivityPtQuestDrawTaskReq(activityUuid, taskId, type, cb)
    GameUtils.Request(Interfaces.OverseaActivityPtQuestDrawTask, {activityUuid = activityUuid, taskId = taskId, type = type}, function(request, response)
        if checkNumber(response.errCode) == 0 then
            local jsonData = response.data

            if checkInt(taskId) == 0 then
                local taskData = type == 1 and  self._dailyTask or self._planTask
                for k, v in pairs(taskData) do
                    if checkInt(v.status) == 1 then
                        taskData[k].status = 2
                    end
                end
            else
                --日常
                if checkNumber(type) == 1 then
                    if self._dailyTask[checkString(taskId)] then
                        self._dailyTask[checkString(taskId)].status = 2
                    end
                else
                    if self._planTask[checkString(taskId)] then
                        self._planTask[checkString(taskId)].status = 2
                    end
                end
            end
            GoodsUtils.DrawRewards(jsonData.rewards,true)
            CS.Engine.UI.UIModule.OpenDialog({ id = Constants.UITypeIds.UICommonRewardPop, parameters = { rewards = jsonData.rewards } })

            if cb then
                cb()
            end
        end
    end)
end

function ActivityPtComponent:ShopReq(activityUuid, activityType, cb)
    GameUtils.Request(Interfaces.StoreActivityHome, {activityUuid = activityUuid, activityType = activityType}, function(request, response)
        if checkNumber(response.errCode) == 0 then
            local jsonData = response.data

            self._shopData = checkTable(jsonData)
            self:StartTimeDown()

            if cb then
                cb()
            end
        end
    end)
end



return ActivityPtComponent
