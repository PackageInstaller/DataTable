--region import
---@type FlashSaleDataDojo
local FlashSaleDataDojo = import("Game.Dojo.FlashSaleDataDojo")
---@type ActivityUtils
local ActivityUtils = import("Game.Activity.ActivityUtils")
--endregion

--region defines

--endregion

---@class ActivityLimitFlashSaleDataProvider
---@field _homeData                           	FlashSaleDataDojo  @幸运数字秒杀活动 首页数据
---@field _isRequestComplete                    boolean @是否请求完成  
local ActivityLimitFlashSaleDataProvider = Class('ActivityLimitFlashSaleDataProvider')

function ActivityLimitFlashSaleDataProvider:RequestHome(activityUuid)
    self._isRequestComplete = false
    GameUtils.Request(Interfaces.ActivityLuckyNumHome, {activityUuid = activityUuid}, function(request, response)
        if checkNumber(response.errCode) ~= 0 then
            return
        end
        local jsonData = response.data
        if self._homeData == nil then
            self._homeData = FlashSaleDataDojo.New()
        end
        self._homeData:Fill(jsonData)
        
        self._isRequestComplete = true
    end)
end

function ActivityLimitFlashSaleDataProvider:RequestPopHome()
    self._isRequestComplete = false
    GameUtils.Request(Interfaces.ActivityLuckyNumPrizeHome, {activityUuid = self._activityDojo.id}, function(request, response)
        if checkNumber(response.errCode) ~= 0 then
            return
        end
        local jsonData = response.data
        local prize    = jsonData.prize
        self:SetPopHomeData(prize)

        self._isRequestComplete = true
    end)
end

function ActivityLimitFlashSaleDataProvider:RequestExchange(prizeId)
    local realConsume = self:CheckExchangeConsume(prizeId)
    if realConsume == nil then
        return
    end
    local activityUuid = self._activityDojo.id
    self._isRequestComplete = false
    GameUtils.Request(Interfaces.ActivityLuckyNumPrize, {activityUuid = activityUuid, prizeId = prizeId}, function(request, response)
        local checkNumber = checkNumber
        if checkNumber(response.errCode) ~= 0 then
            return
        end
        local jsonData     = response.data
        local remain       = checkTable(jsonData.remain)
        local prizeId2Data = self:GetPrizeId2Data()
        prizeId            = checkNumber(prizeId)
        local prizeData    = prizeId2Data[prizeId]
        if prizeData then
            prizeData.playerRemain = checkNumber(prizeData.playerRemain) - 1
            GoodsUtils.DrawRewards(realConsume, true)
        end

        for prizeId_, remain in pairs(remain) do
            local data = prizeId2Data[checkNumber(prizeId_)]
            if data then
                data.remain = checkNumber(remain)
            end
        end
        
        local rewards      = checkTable(jsonData.rewards)
        GoodsUtils.DrawRewards(rewards)
        Events.Broadcast(Constants.EventNames.ActivityLimitFlashSaleExchangeComplete, rewards)
        self._isRequestComplete = true
    end)

end

function ActivityLimitFlashSaleDataProvider:CheckIsActivityEnabled()
    if ActivityUtils.IsActivityEnabled(self._activityDojo) then
        return true
    end
    GameUtils.Toast(localize("活动已结束"))
    return false
end

function ActivityLimitFlashSaleDataProvider:CheckIsActivityClosed()
    if not ActivityUtils.IsActivityClosed(self._activityDojo) then
        GameUtils.Toast(localize("活动已关闭"))
        return true
    end
    return false
end

function ActivityLimitFlashSaleDataProvider:CheckExchangeConsume(prizeId)
    local prizeId2Data = self:GetPrizeId2Data()
    prizeId            = checkNumber(prizeId)
    local prizeData    = prizeId2Data[prizeId]
    local consumes     = prizeData.consume
    local realConsume, errorTip = GoodsUtils.CheckGoodConsume(consumes)
    if errorTip then
        GameUtils.Toast(errorTip)
        return
    end
    return realConsume
end


---GetActivityDojo
---@return ActivityDojo
function ActivityLimitFlashSaleDataProvider:GetActivityDojo()
    return self._activityDojo
end
---SetActivityDojo
---@param activityDojo ActivityDojo
function ActivityLimitFlashSaleDataProvider:SetActivityDojo(activityDojo)
    self._activityDojo = activityDojo
end

function ActivityLimitFlashSaleDataProvider:GetIsRequestComplete()
    return self._isRequestComplete
end

function ActivityLimitFlashSaleDataProvider:GetHomeData()
    return self._homeData
end

function ActivityLimitFlashSaleDataProvider:SetPopHomeData(data)
    data = checkTable(data)
    local popHomeData = {}
    local id2Data     = {}
    for index, value in pairs(data) do
        id2Data[checkNumber(value.id)] = value
        table.insert(popHomeData, value)
    end
    SortByMember(popHomeData, "id", true)
    self._prizeId2Data = id2Data
    self._popHomeData = popHomeData
end
function ActivityLimitFlashSaleDataProvider:GetPopHomeData()
    return self._popHomeData
end
function ActivityLimitFlashSaleDataProvider:GetPrizeId2Data()
    return self._prizeId2Data
end

return ActivityLimitFlashSaleDataProvider
