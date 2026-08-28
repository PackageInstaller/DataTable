---
--- Created by THL.
---

local ECSComponent = import("Frame.ECS.ECSComponent")
---@class SendWordComponent
local SendWordComponent = Class("SendWordComponent", ECSComponent)

function SendWordComponent:__init()
    self._activityUuid = 0

    self._activityConf = {}
    self._unlockLetterIds = {}
    self._rewardReceiveStatus = 0
    self._startTime = 0
    self._endTime = 0
    self._closeTime = 0
end

function SendWordComponent:__delete()
    self._activityUuid = 0

    self._activityConf = {}
    self._unlockLetterIds = {}
    self._rewardReceiveStatus = 0
    self._startTime = 0
    self._endTime = 0
    self._closeTime = 0
end

function SendWordComponent:Initial(jsonData, activityUuid)
    if not jsonData then
        return
    end
    self._activityUuid = activityUuid

    self._activityConf = jsonData.activityConf
    self._unlockLetterIds = jsonData.unlockLetterIds             --解锁的id
    self._rewardReceiveStatus = jsonData.rewardReceiveStatus     --通关奖励是否领取 1 已领取 0 未领取
    self._startTime = jsonData.startTime
    self._endTime = jsonData.endTime
    self._closeTime = jsonData.closeTime
end

function SendWordComponent:IsDrawBox()
    return checkNumber(self._rewardReceiveStatus) == 1
end

function SendWordComponent:IsCanDrawBox()
    local isCanDraw = true
    local t = CfUtils.GetIdGroupData(AutoIds.IdSetting2831, self._activityConf.id)
    if t then
        for k, v in pairs(t) do
            if not self:IsUnlockReward(v) then
                return false
            end
        end
    end
    return true
end

--是否已经解锁了
function SendWordComponent:IsUnlockReward(id)
    for k, v in pairs(self._unlockLetterIds) do
        if checkNumber(v) == checkNumber(id) then
            return true
        end
    end
    return false
end

function SendWordComponent:GetUnlockLetterIds()
    return (self._unlockLetterIds)
end

function SendWordComponent:GetUnlockRewardNum()
    return table.count(self._unlockLetterIds)
end

---ActivitySendUnlockReq 
function SendWordComponent:ActivitySendUnlockReq(letterId, cb)
    GameUtils.Request(Interfaces.ActivitySendUnlock, {activityUuid = self._activityUuid, letterId = letterId}, function(request, response)
        if checkNumber(response.errCode) == 0 then
            local responseData = checkTable(response.data)
            
            table.insert(self._unlockLetterIds, checkString(letterId))

            if cb then
                cb()
            end
        end
    end)
end

---ActivitySendRewardReceiveReq 
function SendWordComponent:ActivitySendRewardReceiveReq(cb)
    GameUtils.Request(Interfaces.ActivitySendRewardReceive, {activityUuid = self._activityUuid}, function(request, response)
        if checkNumber(response.errCode) == 0 then
            local responseData = checkTable(response.data)
            
            self._rewardReceiveStatus = 1

            if #responseData.rewards > 0 then
                GoodsUtils.DrawRewards(responseData.rewards)
            end
            CS.Engine.UI.UIModule.OpenDialog({id = Constants.UITypeIds.UICommonRewardPop, parameters = {rewards = responseData.rewards}})

            if cb then
                cb()
            end
        end
    end)
end

return SendWordComponent
