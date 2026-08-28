
--region global define
local os                   = os
local import               = import
local isNull               = isNull
local isNotNull            = isNotNull
local checkNumber          = checkNumber
local PriorityQueue        = import("Game.Utils.PriorityQueue")
local Pool                 = import("Game.Utils.Pool")
local ClubGVGDriverData = import("Game.UI.Club.GVG.ClubGVGDriverData")


--endregion

--region import
---@type ClubGVGConstants
local GVGConstants     = import('Game.UI.Club.GVG.ClubGVGConstants')
--endregion

--region define
local TriggerType = GVGConstants.TriggerType
local Stage = GVGConstants.Stage
--endregion

---@class ClubGVGTimerDriver
local ClubGVGTimerDriver = Class('ClubGVGTimerDriver')

function ClubGVGTimerDriver:__init()
    ---@type PriorityQueue
    self._triggerSeconds        = PriorityQueue.New(function (a, b)
        return a > b
    end)
    self._seconds2DriverData = {}

    ---@type Pool
    self._pool = Pool.New(function ()
        return ClubGVGDriverData.New()
    end)

    -- self._battleCoolDown   = ClubGVGUtils.GetParamValue(GVGConstants.ParamsId.BattleCoolDown)
    -- self._buildingCoolDown = ClubGVGUtils.GetParamValue(GVGConstants.ParamsId.BuildingCoolDown)
end


function ClubGVGTimerDriver:__delete()
    self._pool = nil
    self._triggerSeconds        = nil
    self._seconds2DriverData = nil
end


--region init 

---@param mgr ClubGVGMgr
---@param component ClubGVGComponent
function ClubGVGTimerDriver:Init(mgr, component)
    self._mgr         = mgr
    self._component   = component

end


---@param dojo ClubGVGHomeDojo
function ClubGVGTimerDriver:InitData(dojo, protectionPeriodEndTime)
    self:Reset()
    local clubIsDie = dojo.clubIsDie == 1
    self:InitStageChangeData(dojo.stageEndSeconds)
    self:InitAllMarchComplete(dojo.marchInfo)
    self:InitAllAttackComplete(dojo.buildingInfo)
    self:InitProtectionPeriod(protectionPeriodEndTime)
    if not clubIsDie then
        self:InitRebirthLimitRemoveData(dojo.rebirthTime)
    end

end

--endregion 


--region logic 


---@param seconds number
function ClubGVGTimerDriver:InitStageChangeData(seconds)
    local stageEndSeconds = seconds
    ---@type ClubGVGDriverData
    local driverData      = self:GetDriverData(stageEndSeconds)
    driverData:Add({triggerType = TriggerType.Stage_Change})

end

---初始化所有行军数据
---@param marchInfo table
function ClubGVGTimerDriver:InitAllMarchComplete(marchInfo)
    for key, marchData in pairs(marchInfo) do
        self:AddMarchData(marchData)
    end
end

---添加行军数据
---@param marchData {playerId:number, endTime:number, startBuilding:number, endBuilding:number}
function ClubGVGTimerDriver:AddMarchData(marchData)
    ---@type ClubGVGDriverData
    local driverData      = self:GetDriverData(marchData.endTime)
    driverData:Add({triggerType = TriggerType.March_Complete, id = marchData.playerId, data = marchData})
end

---移除行军数据
---@param marchData {playerId:number, endTime:number, startBuilding:number, endBuilding:number}
function ClubGVGTimerDriver:RemoveMarching(marchData)
    if marchData == nil then
        return
    end
    self:RemoveDriverTriggerData(marchData.endTime, TriggerType.March_Complete, checkNumber(marchData.playerId))
end

---@param buildingInfo table
function ClubGVGTimerDriver:InitAllAttackComplete(buildingInfo)
    ---@param value {buildingId:number, type:number, clubId:number, shield:number, leftHp:number, playerIds:table, defensePlayerIds:table, attackPlayerIds:table, fightingInfo:table}
    for key, value in pairs(buildingInfo) do
        local fightingInfo = checkTable(value.fightingInfo)
        ---@param fightingData {questEndTime:number, attackPlayerId:number, defencePlayerId:number}
        for key, fightingData in pairs(fightingInfo) do
            self:InitAtkData(fightingData, value.buildingId)
        end
    end
end


---初始化复活限制移除数据
function ClubGVGTimerDriver:InitRebirthLimitRemoveData(rebirthTime)
    ---@type ClubGVGDriverData
    local driverData      = self:GetDriverData(rebirthTime)
    local dojo = self._component:GetDojo()
    local clubPlace = dojo.clubPlace
    local data = {buildingId = clubPlace}
    driverData:Add({triggerType = TriggerType.Rebirth_Limit_Remove, data = data})

    ---@type ClubGVGDriverData
    driverData      = self:GetDriverData(rebirthTime + 1)
    driverData:Add({triggerType = TriggerType.Rebirth_Effect_Remove, data = data})

end

---添加行军加速数据
---@param oldMarchEndTime number 旧的行军到达时间
---@param marchData {playerId:number, endTime:number, startBuilding:number, endBuilding:number}
---@param accelerateCdEndTime number 加速完成时间
function ClubGVGTimerDriver:AddAccelerateData(oldMarchEndTime, marchData, accelerateCdEndTime)
    if accelerateCdEndTime then
        ---@type ClubGVGDriverData
        local driverData      = self:GetDriverData(accelerateCdEndTime)
        driverData:Add({triggerType = TriggerType.Accelerate_Complete, id = marchData.playerId})
    end

    self:UpdateMarchComplete(TriggerType.March_Complete, oldMarchEndTime, marchData.playerId, marchData.endTime, function() 
        return marchData
    end)

end

---@param attackCDEndTime number
function ClubGVGTimerDriver:AddAttackBuildingData(attackCDEndTime, data)
    ---@type ClubGVGDriverData
    local driverData             = self:GetDriverData(attackCDEndTime)
    driverData:Add({triggerType = TriggerType.Atk_Building_Limit_Remove, id = checkNumber(data.pid), data = data})

end

---@param attackCDEndTime number
function ClubGVGTimerDriver:AddPlayerAttackData(attackCDEndTime, data)
    ---@type ClubGVGDriverData
    local driverData             = self:GetDriverData(attackCDEndTime)
    driverData:Add({triggerType = TriggerType.Atk_Player_Limit_Remove, id = checkNumber(data.pid), data = data})

end

---@param fightingData {questEndTime:number, attackPlayerId:number, defencePlayerId:number}
function ClubGVGTimerDriver:InitAtkData(fightingData, buildingId)
    local playerId               = checkNumber(fightingData.attackPlayerId)
    ---@type ClubGVGDriverData
    local driverData             = self:GetDriverData(checkNumber(fightingData.questEndTime))
    local newData = {buildingId = buildingId, attackPlayerId = playerId, defencePlayerId = checkNumber(fightingData.defencePlayerId)}
    
    driverData:Add({triggerType = TriggerType.Atk_Limit_Remove, id = playerId, data = newData})

end

---初始化保护罩移除限制时间
function ClubGVGTimerDriver:InitProtectionPeriod(seconds)
    if seconds <= 0 then
        return
    end
    ---@type ClubGVGDriverData
    local driverData = self._seconds2DriverData[seconds]
    if driverData ~= nil then
        local isFind = driverData:Find(TriggerType.Protection_Period_Limit_Remove, seconds)
        if isFind then return end

    end
    
    ---@type ClubGVGDriverData
    local driverData      = self:GetDriverData(seconds)
    driverData:Add({triggerType = TriggerType.Protection_Period_Limit_Remove, id = seconds})


end

-- ---@param data         {id:number, t:number, pid:number, tid:number, bid:number, et:number}
-- function ClubGVGTimerDriver:AddPlayerAtkData(data)
--     local playerId               = checkNumber(data.pid)
--     local accelerateCompleteTime = GameUtils.GetServerTime() + self._battleCoolDown
--     ---@type ClubGVGDriverData
--     local driverData             = self:GetDriverData(accelerateCompleteTime)
--     driverData:Add({triggerType = TriggerType.Atk_Limit_Remove, id = playerId, data = data})

-- end

function ClubGVGTimerDriver:Update(currentSeconds)
    local triggerSeconds = self._triggerSeconds
    
    local size = triggerSeconds:Size()
    if size <= 0 then
        return
    end
    
    local seconds
    while size > 0 do
        seconds = triggerSeconds:Peek()
        if seconds > currentSeconds then
            break
        end
        size = size - 1
        triggerSeconds:Dequeue()
        self:FreeDriverData(seconds, currentSeconds)
    end

end


--endregion 


--region handler driver data

function ClubGVGTimerDriver:OnFreeDriverData(dataList)
    -- local TriggerType = self._constants.TriggerType
    ---@param value {triggerType: number, id:number, data:table}
    for key, value in ipairs(dataList) do
        local triggerType = value.triggerType
        local data = value.data
        local extraData
        if triggerType == TriggerType.Stage_Change then
            self:HandleStageChange(data)
        elseif triggerType == TriggerType.Accelerate_Complete then
            self:HandleAccelerateComplete(data)
        elseif triggerType == TriggerType.March_Complete then
            self:HandleMarchComplete(data)
        elseif triggerType == TriggerType.Atk_Building_Limit_Remove then
            extraData = self:HandleBuildingAtkLimitRemove(data)
        elseif triggerType == TriggerType.Atk_Player_Limit_Remove then
            extraData = self:HandlePlayerAtkLimitRemove(data)
        elseif triggerType == TriggerType.Atk_Limit_Remove then
            self:HandleAtkLimitRemove(data)
        elseif triggerType == TriggerType.Rebirth_Limit_Remove then
            self:HandleRebirthLimitRemove(data)
        elseif triggerType == TriggerType.Protection_Period_Limit_Remove then
            self:HandleProtectionPeriodLimitRemove()
        end

        Events.Broadcast(GVGConstants.EventNames.DataUpdate, triggerType, data, extraData)
    end
end

---处理阶段改变
function ClubGVGTimerDriver:HandleStageChange()
    ---@type ClubGVGHomeDojo 
    local dojo            = self._component:GetDojo()
    local stageEndSeconds = dojo.stageEndSeconds
    local stage           = dojo.stage
    if stage == Stage.Preview then
        stage            = Stage.Batting
        stageEndSeconds  = dojo.gvgEndTime
    elseif stage == Stage.Batting then
        stage            = Stage.Result
    end

    -- local comp = self:GetComp()
    self._component:UpdateStage(stage, stageEndSeconds)
    self._mgr:InitStageStatus() 

    -- Events.Broadcast(GVGConstants.EventNames.ChangeStage)

end

---处理行军完成
---@param data {playerId:number, endTime:number, startBuilding:number, endBuilding:number}
function ClubGVGTimerDriver:HandleMarchComplete(data)
    return self._component:UpdateMarchComplete(data)
    
end

---处理加速时间结束完成
function ClubGVGTimerDriver:HandleAccelerateComplete()
    self._component:UpdateAccelerateCompleteData()

end

---@param data {id:number, t:number, pid:number, bid:number, hp:number, et:number}
function ClubGVGTimerDriver:HandleBuildingAtkLimitRemove(data)
    return self._component:UpdateBuildingAtkCompleteData(data)

end

---@param data {id:number, t:number, pid:number, tid:number, bid:number, et:number}
function ClubGVGTimerDriver:HandlePlayerAtkLimitRemove(data)
    local isSelfDie, bannerData, buildingIds = self._component:UpdatePlayerAtkCompleteData(data)
    if isSelfDie then
        self._mgr:InitStageStatus()
    end

    local playerBanners = self._mgr:CheckAndGetPlayerBanner(bannerData)
    if playerBanners ~= nil and next(playerBanners) ~= nil then
        for k, v in ipairs(playerBanners) do
            Events.Broadcast(GVGConstants.EventNames.ShowBannerUI, v.data, v.bannerType)
        end
    elseif bannerData then
        Events.Broadcast(GVGConstants.EventNames.ShowBannerUI, bannerData, GVGConstants.BannerType.DefeatPlayer)
    end
  
    return {isSelfDie = isSelfDie, buildingIds = buildingIds}
end

---@param data {buildingId:number, attackPlayerId:number, defencePlayerId:number}
function ClubGVGTimerDriver:HandleAtkLimitRemove(data)
    self._component:UpdateAtkCompleteData(data)
end

function ClubGVGTimerDriver:HandleRebirthLimitRemove(data)
    -- self._component:UpdateRebirthCompleteData(data)
    self._mgr:SetResurrecting(false) 
end

function ClubGVGTimerDriver:HandleProtectionPeriodLimitRemove()
    self._mgr:SetIsProtectionPeriod(false)
end

--endregion


--region get/set 

---@return ClubGVGDriverData
function ClubGVGTimerDriver:GetDriverData(seconds)
    ---@type ClubGVGDriverData
    local driverData = self._seconds2DriverData[seconds]
    if driverData == nil then
        driverData = self._pool:Obtain()
        self._triggerSeconds:Enqueue(seconds, seconds)
        self._seconds2DriverData[seconds] = driverData
    end
    return driverData
end

function ClubGVGTimerDriver:FreeDriverData(seconds, currentSeconds)
    ---@type ClubGVGDriverData
    local driverData = self._seconds2DriverData[seconds]
    
    if driverData ~= nil then
        self:OnFreeDriverData(driverData:GetTriggerList())

        self._pool:Free(driverData)
        self._seconds2DriverData[seconds] = nil
    end
end

---@return {triggerType: number, id:number, data:table} | nil
function ClubGVGTimerDriver:RemoveDriverTriggerData(seconds, triggerType, id)
    ---@type ClubGVGDriverData
    local driverData = self._seconds2DriverData[seconds]
    if driverData ~= nil then
        local triggerData, isFree = driverData:Remove(triggerType, id)
        if isFree then
            self:FreeDriverData(seconds)
        end
        return triggerData
    end
end

function ClubGVGTimerDriver:UpdateDriverTriggerData(triggerType, oldSecond, ...)
    if triggerType == TriggerType.March_Complete then
        self:UpdateMarchComplete(oldSecond, ...)
        -- local data = self:RemoveDriverTriggerData(oldSecond, triggerType, newData.playerId)
        -- self:AddMarchData(newData)
    end
end

---@param triggerType number
---@param oldSecond number
---@param playerId number
---@param newSeconds number
---@param createFunc fun():{playerId:number, endTime:number, startBuilding:number, endBuilding:number}
function ClubGVGTimerDriver:UpdateMarchComplete(triggerType, oldSecond, playerId, newSeconds, createFunc)
    local data = self:RemoveDriverTriggerData(oldSecond, triggerType, playerId)
    if data then
        data.data.endTime = newSeconds

        ---@type ClubGVGDriverData
        local driverData      = self:GetDriverData(newSeconds)
        driverData:Add(data)

    elseif createFunc then
        self:AddMarchData(createFunc())
    end
end


---endregion 


--region handler 



---endregion 


function ClubGVGTimerDriver:Reset()
    self._triggerSeconds.Values = {}
    self._triggerSeconds.Priorities = {}

    for key in pairs(self._seconds2DriverData) do
        self._seconds2DriverData[key] = nil
    end

end

return ClubGVGTimerDriver
