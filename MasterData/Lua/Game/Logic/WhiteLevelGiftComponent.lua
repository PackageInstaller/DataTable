------------ import ------------
local ECSComponent = import("Frame.ECS.ECSComponent")
local UIModule = CS.Engine.UI.UIModule

---@type WhiteLevelGiftDojo
local WhiteLevelGiftDojo = import('Game.Dojo.WhiteLevelGiftDojo')
------------ import ------------

------------ define ------------
local CountDownTime = 2592000 --30 * 86400 30天的秒数
local CDTimerModule = CS.Engine.Modules.CDTimerModule
------------ define ------------


---@class WhiteLevelGiftComponent
local WhiteLevelGiftComponent = Class("WhiteLevelGiftComponent", ECSComponent)
function WhiteLevelGiftComponent:__init()
    self.name = "WhiteLevelGiftComponent"
    ---@type WhiteLevelGiftDojo[]
    self.whiteLevelGift = {}
    self._timeDown = nil
    self.playerLevel = 0
    self.whiteLevelGiftTodayReceived = false
end

function WhiteLevelGiftComponent:__delete()
    if self._timeDown then
        CDTimerModule:GetInstance():RemoveCD(self._timeDown)
    end
    self._timeDown = nil
    self.name = nil
    self.whiteLevelGift = nil
    self.playerLevel = nil
    self.whiteLevelGiftTodayReceived = 0
end


function WhiteLevelGiftComponent:InitLevelGift(data, playerLevel, whiteLevelGiftTodayReceived)
    self:SetWhiteLevelGiftTodayReward(whiteLevelGiftTodayReceived)
    self.whiteLevelGift = {}
    local preIndex = 0
    local t = checkTable(data)
    for index, v in pairs(t) do
        ---@type WhiteLevelGiftDojo
        local dojo = WhiteLevelGiftDojo.New()
        dojo:Fill(v)
        if preIndex > 0 then
            dojo.preGift = t[preIndex]
        end
        preIndex = index
        --dojo.id = checkNumber(id)
        table.insert(self.whiteLevelGift, dojo)
    end
    self.playerLevel = checkNumber(playerLevel)
    --SortByMember(self.whiteLevelGift, "")
    --print('===>>', whiteLevelGiftTodayReceived)
    --print("===>>", table.dump(self.whiteLevelGift, false, 2), playerLevel)
    ---开始倒计时的逻辑
    self._timeDown = CDTimerModule.GetInstance():AddCD(1, function(count, id, Elapsed)
        local smallestTime = 0
        for i, v in pairs(self.whiteLevelGift) do
            ----解锁未被购买的礼包
            if checkNumber(self.playerLevel) >= checkNumber(v.level) and checkNumber(v.hasBuy) == 0 then
                ---已解锁的礼包
                v.saleRemainTime = checkNumber(v.saleRemainTime) - Elapsed
                if v.saleRemainTime > 0 then
                    ----倒计时未结束的情况下
                    if smallestTime == 0 then
                        smallestTime = v.saleRemainTime
                    elseif v.saleRemainTime < smallestTime then
                        smallestTime = v.saleRemainTime ---取最小的倒计时
                    end
                end
            end
        end
        if Events.HasListener(Constants.EventNames.WHITE_GIFT_TIME_EVENT) then
            Events.Broadcast(Constants.EventNames.WHITE_GIFT_TIME_EVENT, smallestTime)
        end
    end, CountDownTime, false, true)
end

function WhiteLevelGiftComponent:SetWhiteLevelGiftTodayReward(whiteLevelGiftTodayReceived)
    self.whiteLevelGiftTodayReceived = checkNumber(whiteLevelGiftTodayReceived)
    if GameUtils.IsUnlockedBySystemTogId(Constants.SystemToggleIds.Id1111) then
        if self.whiteLevelGiftTodayReceived == 1 then
            GameUtils.SetRedPointNum(Constants.RedPointConst.WhiteLevelGiftButtonReward, 0)
            GameUtils.InvokeRedPointCallBack(Constants.RedPointConst.WhiteLevelGiftButtonReward)
        else
            GameUtils.SetRedPointNum(Constants.RedPointConst.WhiteLevelGiftButtonReward, 1)
            GameUtils.InvokeRedPointCallBack(Constants.RedPointConst.WhiteLevelGiftButtonReward)
        end
    else
        GameUtils.SetRedPointNum(Constants.RedPointConst.WhiteLevelGiftButtonReward, 0)
        GameUtils.InvokeRedPointCallBack(Constants.RedPointConst.WhiteLevelGiftButtonReward)
    end
end


---SetPlayerLevel
---设置玩家最新的等级
---@param level number
function WhiteLevelGiftComponent:SetPlayerLevel(level)
    self.playerLevel = checkNumber(level)
    local whiteLevelGiftTodayReceived = checkNumber(self.whiteLevelGiftTodayReceived)
    self:SetWhiteLevelGiftTodayReward(whiteLevelGiftTodayReceived)
end

return WhiteLevelGiftComponent