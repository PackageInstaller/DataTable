---@class LotteryData.Probability
---@field rewardId number @奖励ID
---@field rewards Reward[] @奖励列表
---@field probability string @概率

---@class LotteryCallResponse  TODO delete
---@field consume LotteryDetail.ConsumeItem[] @消耗列表
---@field rewards Reward[] @奖励列表
---@field rewardIds number[] @奖励IDs
---@field extraRewards LotteryExtraReward[] @额外奖励信息

---@class LotteryExtraReward
---@field rewardId number @奖励ID
---@field num number @召唤次数
---@field rewardGroup LotteryExtraRewards.RewardGroup[] @奖励分组
---@field status number @奖励状态: 0初始 1可领取 2已领取
---@field rewardGroupIndex number @已领取奖励分组下标, 默认null

---@class LotteryExtraProbability
---@field rewardId number @奖励ID
---@field num number @召唤次数
---@field rewardGroup LotteryExtraRewards.RewardGroup[] @奖励分组

---@class LotteryExtraRewards.RewardGroup
---@field rewards Reward[] @奖励列表
---@field probability number @概率

---@class LotteryDetail
---@field calledTimes number @已召唤次数
---@field extraRewards LotteryExtraReward[] @额外奖励信息  5个
---@field consume LotteryDetail.Consume @召唤道具消耗信息
---@field taskRedDotHint number @任务红点提示

---@class Reward
---@field goodsId number @奖励ID
---@field num number @奖励数量
---@field from number @奖励来源

---@class LotteryDetail.Consume
---@field oneConsume LotteryDetail.ConsumeItem @单抽道具消耗
---@field tenConsume LotteryDetail.ConsumeItem @十连道具消耗

---@class LotteryDetail.ConsumeItem
---@field goodsId number @道具ID
---@field num number @道具数量

---@class LotteryDetail.Task
---@field id number @任务ID
---@field progress number @任务进度
---@field status number @任务状态: 0初始 1可领取 2已领取

---@class LotteryData
---@field lotteryDetail LotteryDetail @抽奖详情
---@field probabilityList LotteryData.Probability[] @抽奖概率
---@field extraProbabilityList LotteryExtraProbability[] @额外抽奖概率
---@field tasks LotteryDetail.Task[] @任务列表

local ActivityDojo  = import("Game.Dojo.ActivityDojo")

---@class ActivityGachaponSkinServer
---@field activities ActivityCardSkinDojo[]
local ActivityGachaponSkinServer = Class("ActivityGachaponSkinServer")

function ActivityGachaponSkinServer:__init()
    self.activities = {}
    ---@type LotteryData
    self.lotteryData = {}
end

function ActivityGachaponSkinServer:__delete()
    self.activities = nil
    self.lotteryData = nil
end

--{{{ interface
function ActivityGachaponSkinServer:RequestHome(callBack,callBackOnErrCode)
    GameUtils.Request(Interfaces.ActivitySkinCallHome, {}, function(request, response)
        if checkNumber(response.errCode) ~= 0 then
            if callBackOnErrCode then
                callBackOnErrCode(response.errCode)
            end
            return
        end
        ---@type ActivityCardSkinComponent
        local ActivityCardSkinComponent = GameUtils.GetOrAddEntityCompByType(ECSComponentType.Constants.ActivityCardSkinComponent)
        ActivityCardSkinComponent:Initial(response.data.activities)
        self.activities = ActivityCardSkinComponent:GetActivityData()

        ---@type ActivityMgr
        local ActivityMgr = import('Game.Activity.ActivityMgr'):GetInstance()
        local ActivityComponent = ActivityMgr:GetActivityComponent()
        for i, v in ipairs(response.data.activities) do
            local dojo = ActivityDojo.New()
            dojo:Fill(v)
            ActivityComponent:AddActivityData(dojo)
        end

        if callBack then
            callBack(response)
        end
    end)
end

function ActivityGachaponSkinServer:RequestSkinLotteryDetail(id, callBack)
    GameUtils.Request(Interfaces.ActivitySkinLotteryDetail, { activityUuid = id }, function(request, response)
        if checkNumber(response.errCode) ~= 0 then
            return
        end
        
        self.lotteryData.lotteryDetail = response.data
        if callBack then
            callBack(response)
        end
    end)
end

function ActivityGachaponSkinServer:RequestSkinLotteryCall(id, type, callBack)
    GameUtils.Request(Interfaces.ActivitySkinLotteryCall, { activityUuid = id, callType = type }, function(request, response)
        if checkNumber(response.errCode) ~= 0 then
            return
        end
        
        self.lotteryData.lotteryDetail.calledTimes = checkNumber(response.data.calledTimes)
        self.lotteryData.lotteryDetail.extraRewards = checkTable(response.data.extraRewards)
        
        local consumes = checkTable(response.data.consume)
        if #consumes > 0 then
            for i = #consumes, 1, -1 do
                local item = consumes[i]
                if checkNumber(item.num) == 0 then
                    table.remove(consumes, i)
                end
            end
            for i, v in ipairs(consumes) do
                v.num = -v.num
            end
        end
        local rewards = checkTable(response.data.rewards)
        table.insertto(consumes,rewards)
        GoodsUtils.DrawRewards(consumes,true)
        if callBack then
            callBack(rewards)
        end
    end)
end

function ActivityGachaponSkinServer:RequestActivitySkinLotteryReceiveExtraRewards(id,rewardId, callBack)
    GameUtils.Request(Interfaces.ActivitySkinLotteryReceiveExtraRewards, { activityUuid = id,rewardId = rewardId }, function(request, response)
        if checkNumber(response.errCode) ~= 0 then
            return
        end
        
        --TODO response.data.rewards 入库
        local rewards = checkTable(response.data.rewards)
        GoodsUtils.DrawRewards(rewards,true)
        ---@type LotteryExtraReward
        self.lotteryData.lotteryDetail.extraRewards = checkTable(response.data.extraRewards)
        self.lotteryData.lotteryDetail.calledTimes = checkNumber(response.data.calledTimes)
        
        if callBack then
            callBack(rewards)
        end
    end)
end

--activitySkinLottery/probability (时装兑换抽奖概率)
function ActivityGachaponSkinServer:RequestActivitySkinLotteryProbability(id, callBack,onError)
    GameUtils.Request(Interfaces.ActivitySkinLotteryProbability, { activityUuid = id }, function(request, response)
        if checkNumber(response.errCode) ~= 0 then
            if onError then
                onError(response.errCode)
            end
            return
        end
        
        ---@type LotteryExtraReward
        self.lotteryData.extraProbabilityList = checkTable(response.data.extraProbability)
        ---@type LotteryData.Probability[]
        self.lotteryData.probabilityList = checkTable(response.data.probability)
        if callBack then
            callBack(response)
        end
    end)
end
--}}}

--- 根据活动id 获取活动数据
---@return ActivityCardSkinDojo
function ActivityGachaponSkinServer:GetActivityByUuid(id)
    id = checkInt(id)
    ---@type ActivityCardSkinDojo[]
    local activityData = self.activities
    for k, v in pairs(activityData) do
        if checkInt(v.id) == id then
            return v
        end
    end
    return nil
end

return ActivityGachaponSkinServer