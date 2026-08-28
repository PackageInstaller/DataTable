---
--- 烹饪活动排行榜数据获取
--- Author: dawanfan
--- Date: 2024-12-26 14:24:54
--- 

local util = require 'XLua.util'
local UIModule = CS.Engine.UI.UIModule
local Yielders = CS.Engine.Lib.Yielders
local CoWait = CS.Engine.Lib.CoWait
local cs_coroutine = require('XLua.cs_coroutine')

---@type ActivityCookingComponent
local ActivityCookingComponent = GameUtils.GetOrAddEntityCompByType(ECSComponentType.Constants.ActivityCookingComponent)
local ActivityCookingConstants = import("Game.UI.ActivityCooking.ActivityCookingConstants")
local ActivityCookingUtils = import("Game.UI.ActivityCooking.ActivityCookingUtils")


---@class ActivityCookingRankingsDialogImp
local ActivityCookingRankingsDialogImp = Class("ActivityCookingRankingsDialogImp")

function ActivityCookingRankingsDialogImp:__init()
    
end

function ActivityCookingRankingsDialogImp:GetPlayerRankData()

    local playerComponent = GameUtils.GetEntityCompByType(ECSComponentType.Constants.PlayerComponent)
    ---@type PlayerDojo
    local playerDojo = playerComponent:GetPlayerDojo()

    local data = {}
    local rankData = {
        playerId=playerDojo.playerId,
        score=checkInt(ActivityCookingComponent.dojo.playerRank.score),
        name=playerDojo.playerName,
        avatar=playerDojo.playerAvatar,
        avatarFrame=playerDojo.playerAvatarFrame,
        level=checkInt(playerDojo.level),
        ranking=checkInt(ActivityCookingComponent.dojo.playerRank.ranking),
    }

    local totalRankNum = math.max(100, checkInt(ActivityCookingComponent.dojo.totalRankNum))
    data["input"] = self:GetReward(rankData, ActivityCookingUtils.GetCookingRankVos(ActivityCookingComponent.dojo.config.id), totalRankNum)

    return data
end

function ActivityCookingRankingsDialogImp:GetRankTitleTexts()
    return {localize("排名"), localize("调查官"), localize("经营收益"), localize("奖励")}
end

function ActivityCookingRankingsDialogImp:GetRankData()
    local rankData =  {}

    local totalRankNum = math.max(100, checkInt(ActivityCookingComponent.dojo.totalRankNum))
    local vos = ActivityCookingUtils.GetCookingRankVos(ActivityCookingComponent.dojo.config.id)
    for index, data in ipairs(ActivityCookingComponent.dojo.rank) do
        -- local currentRankPercent = math.ceil(data.ranking / totalRankNum * 100)
        -- if data.ranking == 0 then
        --     currentRankPercent = math.maxinteger
        -- end

        -- for _, vo in pairs(ActivityCookingUtils.GetCookingRankVos(ActivityCookingComponent.dojo.config.id)) do
        --     if (vo.type == 1 and data.ranking <= vo.lowerLimit) or (vo.type == 2 and currentRankPercent <= vo.lowerLimit) then
        --         local reward = {}
    
        --         for i, id in ipairs(vo.reward) do
        --             table.insert(reward, {goodsId = id,num = vo.rewardNum[i]})
        --         end 

        --         data.reward = reward
    
        --         if data.ranking <= 100 then
        --             data.rankingText = data.ranking
        --         else
        --             data.rankingText = tostring(currentRankPercent) .. "%"
        --         end
        --         break
        --     end
        -- end
        table.insert(rankData, self:GetReward(data, vos, totalRankNum))
    end

    return rankData
end

function ActivityCookingRankingsDialogImp:GetReward(data, vos, totalRankNum)

    local currentRankPercent = math.ceil(data.ranking / totalRankNum * 100)
    if data.ranking == 0 then
        currentRankPercent = math.maxinteger
    end

    for _, vo in pairs(vos) do
        if (vo.type == 1 and data.ranking <= vo.lowerLimit) or (vo.type == 2 and currentRankPercent <= vo.lowerLimit) then
            local reward = {}

            for i, id in ipairs(vo.reward) do
                table.insert(reward, {goodsId = id,num = vo.rewardNum[i]})
            end 

            data.reward = reward

            if data.ranking <= 100 then
                data.rankingText = data.ranking
            else
                data.rankingText = tostring(currentRankPercent) .. "%"
            end
            break
        end
    end

    return data
end

function ActivityCookingRankingsDialogImp:GetRankRewardType()
    return 1
end

function ActivityCookingRankingsDialogImp:GetBossRankRewardVos()
    ---@type ActivityCookingRankVo[]
    local data = CfUtils.GetCf(AutoIds.IdSetting6252, "ActivityCookingRankVo", true)
    local result = {}
    for index, value in ipairs(data) do
        if value.activityId == ActivityCookingComponent.dojo.config.id then
            table.insert(result, value)
        end
    end

    return result
end

function ActivityCookingRankingsDialogImp:GetBgPath()
    return "Arts/Textures/ActivityMountain/11300302/activity_mountain_operate_bg_2.png"
end

return ActivityCookingRankingsDialogImp