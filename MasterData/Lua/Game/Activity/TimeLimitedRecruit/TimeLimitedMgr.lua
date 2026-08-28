local ResourceModule = CS.Engine.Modules.ResourceModule
local CDTimerModule = CS.Engine.Modules.CDTimerModule
local CountDownTime = 2592000 --30 * 86400 30天的秒数



--- lua:
local CoWait = CS.Engine.Lib.CoWait
local util = require 'XLua.util'
local cs_coroutine = require 'XLua.cs_coroutine' -- 协程
local Yielders = CS.Engine.Lib.Yielders -- 协程
local UIModule = CS.Engine.UI.UIModule

local GameUtils = import('Game.Utils.GameUtils')
local Object = CS.UnityEngine.Object
local GameObject = CS.UnityEngine.GameObject
local Vector2 = CS.UnityEngine.Vector2
local Vector3 = CS.UnityEngine.Vector3
local Mathf = CS.UnityEngine.Mathf
local Random = CS.UnityEngine.Random
local Canvas = CS.UnityEngine.Canvas
local Physics = CS.UnityEngine.Physics
local KTool = CS.Engine.Lib.KTool
local KCookie = CS.Engine.Lib.KCookie
local BehaviourAction = CS.Engine.Lib.BehaviourAction
local ImageAlterable = CS.Engine.UI.ImageAlterable
local Transform = CS.UnityEngine.Transform
local RectTransform = CS.UnityEngine.RectTransform
local Input = CS.UnityEngine.Input
local KeyCode = CS.UnityEngine.KeyCode
local Time = CS.UnityEngine.Time
local CanvasGroup = CS.UnityEngine.CanvasGroup



---@class TimeLimitedMgr : Singleton
local TimeLimitedMgr = Class("TimeLimitedMgr", import("Frame.Singleton"))
-- 外部访问时:
-- ---@type TimeLimitedMgr
-- local Mgr = import("Game.Activity.TimeLimitedRecruit.TimeLimitedMgr"):GetInstance()





function TimeLimitedMgr:__init()
    TimeLimitedMgr.super.__init(self)
    self.totalRewardsMap = {}
    self.activityUuid = nil
    self.activityData = nil
    self.times = 1
    self.isIntoMainDialog = false
    self.roundDatas = {
        currentRoundIdx1Based = 1
    }
    self.walkingCatNum = 0
end



function TimeLimitedMgr:__delete()
    self.totalRewardsMap = {}
    self.activityUuid = nil
    self.activityData = nil
    self.times = 1
    self.isIntoMainDialog = false
    self.roundDatas = {}
    self.walkingCatNum = 0
end



function TimeLimitedMgr:Clear()
    self.totalRewardsMap = {}
    self.walkingCatNum = 0
end



function TimeLimitedMgr:AddReward( goodsId_, num_ )
    goodsId_ = checkInt(goodsId_)
    num_ = checkInt(num_)
    ---
    if self.totalRewardsMap[goodsId_] == nil then 
        self.totalRewardsMap[goodsId_] = 0        
    end 
    self.totalRewardsMap[goodsId_] = self.totalRewardsMap[goodsId_] + num_
end


function TimeLimitedMgr:GetTotalRewards()
    local retList = {}
    for goodsid,num in pairs(self.totalRewardsMap) do 
        table.insert( retList, {
            goodsId = goodsid,
            num = num
        })
    end 
    return retList
end



-- 只有在重新进入一轮抽卡时, 才能调用
function TimeLimitedMgr:InitRoundDatas()
    ---@type TimeLimitedRecruitUtil
    local TimeLimitedRecruitUtil = import("Game.Activity.TimeLimitedRecruit.TimeLimitedRecruitUtil")

    self.roundDatas = {
        conditions = {}, -- int[]
        currentRoundIdx1Based = 1
    }

    -- 收集 conditions: 如: {5,6,7,8}
    local freeConditionStr = TimeLimitedRecruitUtil.GetVoParamValue( TimeLimitedRecruitUtil.VoParamsId.FreeRecruitConditions, Constants.DataType.String )
    local conditionStrLists = string.split( freeConditionStr, ";" )
    for i=1, #conditionStrLists do 
        table.insert( self.roundDatas.conditions, tonumber(conditionStrLists[i]) )
    end     

end


function TimeLimitedMgr:ToNextRound()
    self.roundDatas.currentRoundIdx1Based = self.roundDatas.currentRoundIdx1Based + 1
end



function TimeLimitedMgr:GetCurrentRoundConditionNum()
    assert( self.roundDatas.currentRoundIdx1Based <= #self.roundDatas.conditions )
    return self.roundDatas.conditions[self.roundDatas.currentRoundIdx1Based]
end


function TimeLimitedMgr:IsLastRound()

    return self.roundDatas.currentRoundIdx1Based == #self.roundDatas.conditions + 1

end




function TimeLimitedMgr:GetCardId( activityData_ )
    -- 有时外部会直接提供
    if isNull(activityData_) then 
        activityData_ = self.activityData
    end 
    -- 使用寄存的:
    if isNull(activityData_) then 
        printError("activityData is nil")
        return 0
    end 
    ---@type TimeLimitedRecruitUtil
    local TimeLimitedRecruitUtil = import("Game.Activity.TimeLimitedRecruit.TimeLimitedRecruitUtil")
    local timeLimitedRecruitActivityScheduleVO = TimeLimitedRecruitUtil.GetTimeLimitedRecruitActivityScheduleVO( checkInt(activityData_.activityContentId) )
    local cardId = tonumber(timeLimitedRecruitActivityScheduleVO.cardId)
    return cardId
end






return TimeLimitedMgr
