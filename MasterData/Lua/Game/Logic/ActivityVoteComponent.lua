---
--- Created by THL.
---

local ECSComponent = import("Frame.ECS.ECSComponent")

local CDTimerModule = CS.Engine.Modules.CDTimerModule
local CountDownTime = 2592000 --30 * 86400 30天的秒数

---@class ActivityVoteComponent
local ActivityVoteComponent = Class("ActivityVoteComponent", ECSComponent)
---@type ActivityVoteDojo
local ActivityVoteDojo = import("Game.Dojo.ActivityVoteDojo")
---@field dojo ActivityVoteDojo
function ActivityVoteComponent:__init()
    self.dojo = nil
    self.votes = nil
    self.voteCharcters = {}
    self.activityUuid = nil
end

function ActivityVoteComponent:InitData(activityUuid ,  voteHomeData)
    local jsonData = voteHomeData
    self.activityUuid = activityUuid 
    local dojo = ActivityVoteDojo.New()
    jsonData.votes["0"] = nil
    dojo:Fill(jsonData)
    self.dojo = dojo
end
---@return number  返回活动
function ActivityVoteComponent:GetActivityUuid()
    return self.activityUuid
end

function ActivityVoteComponent:UpdateRank(rank)
    self.dojo:Fill(rank)
end
---@return ActivityVoteDojo
function ActivityVoteComponent:GetDojo()
    return self.dojo
end

function ActivityVoteComponent:GetVoteGoodsId()
    return self:GetDojo().voteGoodsId
end

--- 获取角色投票排名
function ActivityVoteComponent:GetVotesRoleRank()
    self.votes = {}
    local votes = self:GetDojo().votes
    for k, v in pairs(votes) do
        self.votes[#self.votes+1] = {cardId = k  , value = checkInt(v)}
    end
    local voteTimestamps = self:GetDojo().voteTimestamps
    local avoteTime  = 0 
    local bvoteTime  = 0 
    table.sort(self.votes, function (a, b )
        if a.value ~= b.value then
            return a.value > b.value
        else 
            avoteTime  = voteTimestamps[tostring(a.cardId)] 
            bvoteTime  = voteTimestamps[tostring(b.cardId)] 
            if avoteTime == bvoteTime then
                return a.cardId < b.cardId        
            else
                return avoteTime < bvoteTime
            end
        end
    end)
    return self.votes
end

-- 获取玩家投票排名
function ActivityVoteComponent:GetVoteRank()
    return self:GetDojo().rank 
end
-- 获取自己投票排名
function ActivityVoteComponent:GetPlayerRank()
    return self:GetDojo().playerRank
end

function ActivityVoteComponent:GetLevelScore()
    return self:GetDojo().levelScore
end

function ActivityVoteComponent:GetMatchTimeStr()
    ---@type ActivityVoteDojo
    local activityVoteDojo = self:GetDojo()
    local startTime = activityVoteDojo.endTime - activityVoteDojo.currentStageTotalSeconds 
    ---@type ActivityUtils
    local ActivityUtils = import("Game.Activity.ActivityUtils")
    return ActivityUtils.ConventActivityDurationTime(startTime, activityVoteDojo.endTime)
end

function ActivityVoteComponent:GetAllCard()
    local votesDojo = self:GetDojo().votes
    local map = {}
    ---@type CardVo[]
    local cardVos = CfUtils.GetWholeVo(AutoIds.IdSetting28, 'CardVo')
    for voIndex, cardVo in ipairs(cardVos) do
        if votesDojo[tostring(cardVo.roleId)] then
            if not map[tostring(cardVo.characterId)] then
                map[tostring(cardVo.characterId)] = {}
            end
            local data =  map[tostring(cardVo.characterId)]
            data[#data+1] = {cardId = cardVo.roleId , characterId = cardVo.characterId , defaultSkin =cardVo.defaultSkin ,   value = votesDojo[tostring(cardVo.roleId)]}
        end 
    end  
    self.voteCharcters = map 
end
---@param characterId number  获取所有  characterId 角色 并排序
function ActivityVoteComponent:GetSortCharacterId(characterId)
    local oneCharaterIdArray  = self.voteCharcters[tostring(characterId)]
    local voteTimestamps = self:GetDojo().voteTimestamps
    local avoteTime  = 0 
    local bvoteTime  = 0 
    table.sort(oneCharaterIdArray, function(a, b) 
        if a.value ~= b.value then
            -- 票数由高到低
            return a.value > b.value
        else 
            avoteTime  = voteTimestamps[tostring(a.cardId)] 
            bvoteTime  = voteTimestamps[tostring(b.cardId)] 
            if avoteTime == bvoteTime then
                return a.cardId < b.cardId        
            else
                return avoteTime < bvoteTime
            end
        end
    end)
    return oneCharaterIdArray
end

function ActivityVoteComponent:GetAllCharacterArray()
    local data = {}
    if #self.voteCharcters == 0  then
        self:GetAllCard()
    end
    for k, v in pairs(self.voteCharcters) do
        if #v > 1 then
            data[#data+1] = k 
        end
    end
    return data
end
--- func desc 获取所有只有一个卡牌的角色
function ActivityVoteComponent:GetOneCharacterArray()
    local data = {}
    if #self.voteCharcters == 0  then
        self:GetAllCard()
    end
    for k, v in pairs(self.voteCharcters) do
        if #v == 1 then
            data[#data+1] = v[1]
        end
    end
    return data
end

--- 获取所有的参与奖励
function ActivityVoteComponent:GetSortAttendRewards()
    local attendRewards = self:GetDojo().attendRewards
    return attendRewards
end


function ActivityVoteComponent:GetDailyTask()
    local dailyTask =  self:GetDojo().dailyTask
    table.sort(dailyTask , function ( a , b)
        local aStatus = a.status == 2 and -1 or  a.status 
        local bStatus = b.status == 2 and -1 or  b.status 
        if aStatus > bStatus then
            return true 
        elseif aStatus < bStatus then
            return false
        else 
            return checkInt(a.id ) < checkInt(b.id) 
        end
    end)
    return dailyTask
end
---@param taskId number @ 任务id 
function ActivityVoteComponent:DrawDailyTaskReward(taskId)
    local dailyTask = self:GetDojo().dailyTask
    taskId = checkInt(taskId)
    if taskId > 0 then
        for k, v in ipairs(dailyTask) do
            if v.id == taskId then
                v.status = 2
                break
            end
        end
    else
        for k, v in ipairs(dailyTask) do
            if v.status == 1 then
                v.status = 2
            end
        end
    end
    return self:GetDailyTask()
end

--- rewardId  number  领取奖励id ， 如果为零就是一键领取
function ActivityVoteComponent:DrawRewardsRankSorce(rewardId)
    rewardId = checkInt(rewardId)
    local attendRewards = self:GetDojo().attendRewards
    if rewardId > 0 then
        for i, v in ipairs(attendRewards) do
            if checkInt(v.id) == rewardId  then
                v.status = 2 
                break
            end
        end
    else 
        for i, v in ipairs(attendRewards) do
            if checkInt(v.status) == 1  then
                v.status = 2 
            end
        end  
    end
    return attendRewards
end



function ActivityVoteComponent:__delete()
    self.dojo = nil
    self.votes = nil
    self.voteCharcters = nil
    self.activityUuid = nil
end

return ActivityVoteComponent
