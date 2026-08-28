--------------------------------
--- 地图解密活动(春节活动)Dojo数据管理类
--- 提供Dojo数据更新获取之类的方法

local CDTimerModule                          = CS.Engine.Modules.CDTimerModule
local MapDecryptionExploreTaskEntity        = import("Game.Activity.MapDecryption.Entity.MapDecryptionExploreTaskEntity")
local MapDecryptionExploreDataEntity        = import("Game.Activity.MapDecryption.Entity.MapDecryptionExploreDataEntity")
local MapDecryptionTrackingDataEntity       = import("Game.Activity.MapDecryption.Entity.MapDecryptionTrackingDataEntity")
local MapDecryptionAntiqueRestorationEntity = import("Game.Activity.MapDecryption.Entity.MapDecryptionAntiqueRestorationEntity")
local MapDecryptionTalkDataEntity           = import("Game.Activity.MapDecryption.Entity.MapDecryptionTalkDataEntity")
local MapDecryptionDojo                     = import("Game.Dojo.MapDecryptionDojo")

local ECSComponent                           = import("Frame.ECS.ECSComponent")
---@class MapDecryptionComponent
local MapDecryptionComponent = Class("MapDecryptionComponent", ECSComponent)

function MapDecryptionComponent:__init()
    ECSComponent.__init(self)
    ---@type string
    self.name = "MapDecryptionComponent"

    self._activityData = nil

    ---@type MapDecryptionDojo
    self._springFestivalDojo = MapDecryptionDojo.New()
    
end

function MapDecryptionComponent:__delete()
    self:__RemoveCountdown()
end

function MapDecryptionComponent:Initial(jsonData)
    self:FillMapDecryptionDojo(checkTable(jsonData))
end

--- GetMapDecryptionDojo
--- 获取春节活动数据
---@return MapDecryptionDojo
function MapDecryptionComponent:GetMapDecryptionDojo()
    return self._springFestivalDojo

end
function MapDecryptionComponent:FillMapDecryptionDojo(jsonData)
    self._springFestivalDojo:Fill(jsonData)
    self._npcId2Entity       = self:GenerateNPCId2Entity()
    self._antiqueEntityList  = self:GenerateAntiqueRestorationEntityList()
end

function MapDecryptionComponent:GetActivityData()
    return self._activityData

end
function MapDecryptionComponent:SetActivityData(activityData)
    self._activityData     = activityData
    activityData.endTime   = checkNumber(activityData.endTime)
    activityData.closeTime = checkNumber(activityData.closeTime)

    local curTime = os.time()
    ---@type MapDecryptionDojo
    local springFestivalDojo = self:GetMapDecryptionDojo()
    springFestivalDojo.isActivityEnd   = activityData.endTime <= curTime
    springFestivalDojo.isActivityClose = activityData.closeTime <= curTime

    if not springFestivalDojo.isActivityClose then
        local leftTime = activityData.closeTime - os.time()
        self:__StartCountdown(leftTime)
    end
end

function MapDecryptionComponent:__RemoveCountdown()
    if self._countdown == nil then return end

    CDTimerModule.GetInstance():RemoveCD(self._countdown)
    self._countdown = nil
end
function MapDecryptionComponent:__StartCountdown(leftTime)
    self:__RemoveCountdown()

    local EventNames    = MapDecryptionConstants.EventNames
    local ActivityEnd   = EventNames.ActivityEnd
    local ActivityClose = EventNames.ActivityClose
    local TimeChanged   = EventNames.TimeChanged
    self._countdown = CDTimerModule.GetInstance():AddCD(1, function(count, id, elapsed)
        ---@type MapDecryptionDojo
        local springFestivalDojo = self:GetMapDecryptionDojo()
        if not springFestivalDojo.isActivityEnd then
            local activityData   = self:GetActivityData()
            local oldEndTime     = activityData.endTime
            activityData.endTime = oldEndTime > 0 and (oldEndTime - elapsed)   or 0
            
            if activityData.endTime <= 0 then
                springFestivalDojo.isActivityEnd = true
                Events.Broadcast(ActivityEnd)
            end

            if Events.HasListener(TimeChanged) then
                Events.Broadcast(TimeChanged)
            end
        end

        if not springFestivalDojo.isActivityClose then
            local activityData     = self:GetActivityData()
            local oldCloseTime     = activityData.closeTime
            activityData.closeTime = oldCloseTime > 0 and (oldCloseTime - elapsed) or 0

            if activityData.closeTime <= 0 then
                springFestivalDojo.isActivityClose = true
                Events.Broadcast(ActivityClose)
            end

        end
        

    end, leftTime, false, true)

end

--- CheckActivityIsEnd
--- 检查活动是否结束
---@return boolean 是否活动结束
function MapDecryptionComponent:CheckActivityIsEnd()
    ---@type MapDecryptionDojo
    local springFestivalDojo = self:GetMapDecryptionDojo()
    return springFestivalDojo.isActivityEnd

end

--- CheckActivityIsClose
--- 检查活动是否关闭
---@return boolean 是否活动关闭
function MapDecryptionComponent:CheckActivityIsClose()
    ---@type MapDecryptionDojo
    local springFestivalDojo = self:GetMapDecryptionDojo()
    return springFestivalDojo.isActivityClose

end

--- GenerateExploreDataEntityList
--- 生成探索数据实体列表
---@return MapDecryptionExploreDataEntity[]
function MapDecryptionComponent:GenerateExploreDataEntityList()
    local entityList = {}
    local activityData   = self:GetActivityData()
    local activityContentId   = checkNumber(activityData.activityContentId)
    
    local exploreMapData = self:GetMapDecryptionDojo().maps
    ---@type MapDecryptionDecryptedMapsVo[]
    local decryptedMapsVos = MapDecryptionConfMgr:GetAllDecryptedMaps()
    ---@param decryptedMapsVo MapDecryptionDecryptedMapsVo
    for i, decryptedMapsVo in ipairs(decryptedMapsVos) do
        if activityContentId == decryptedMapsVo.activityId then
            -- decryptedMapsVo.id
            ---@type MapDecryptionExploreDataEntity
            local exploreDataEntity = MapDecryptionExploreDataEntity.New()
            exploreDataEntity:Fill(decryptedMapsVo, exploreMapData[decryptedMapsVo.id])

            table.insert(entityList, exploreDataEntity)
        end
    end
    return entityList

end

--- GetExploreMapData
--- 获取探索地图数据
---@param mapId number 探索地图id
function MapDecryptionComponent:GetExploreMapData(mapId)
    ---@type MapDecryptionDojo
    local springFestivalDojo = self:GetMapDecryptionDojo()
    local maps    = springFestivalDojo.maps
    local mapData = maps[mapId]
    return mapData
end

--- GetExploreTasksByMapId
--- 通关地图id 获取探索任务数据
---@param mapId number 探索地图id
function MapDecryptionComponent:GetExploreTasksByMapId(mapId)
    local mapData = self:GetExploreMapData(mapId)
    return mapData.tasks
end

--- UpdateExploreMapStatus
--- 更新探索地图状态
---@param mapId number  探索地图id
---@---@param status number 地图总奖励领取状态 [0,1,2] 0:代表进行中 1:可领取 2:已领取
function MapDecryptionComponent:UpdateExploreMapStatus(mapId, status)
    local mapData = self:GetExploreMapData(mapId)
    mapData.status = status
end

--- UpdateExploreTaskProgress
--- 更新探索任务进度
---@param mapId number    探索地图id
---@param id number       探索任务id
---@param progress number 探索进度
function MapDecryptionComponent:UpdateExploreTaskProgress(mapId, id, progress)
    id = checkNumber(id)
    local mapExploreTasks = self:GetExploreTasksByMapId(mapId)
    for i, v in ipairs(mapExploreTasks) do
        if checkNumber(v.id) == id then
            v.progress = progress
            break
        end
    end
end

--- UpdateExploreTaskStatus
--- 更新探索任务状态
---@param mapId number  探索地图id
---@param id number     探索任务id
---@param status number 任务状态 [0,1,2] 0:代表进行中 1:可领取 2:已领取
function MapDecryptionComponent:UpdateExploreTaskStatus(mapId, id, status)
    id = checkNumber(id)
    local mapExploreTasks = self:GetExploreTasksByMapId(mapId)
    for i, v in ipairs(mapExploreTasks) do
        if checkNumber(v.id) == id then
            v.status = status
            break
        end
    end
end

--- GenerateAntiqueRestorationEntityList
--- 生成追踪实体数据列表
---@return MapDecryptionTrackingDataEntity[]
function MapDecryptionComponent:GenerateTrackingDataEntityList()
    local entityList = {}
    ---@type MapDecryptionDojo
   local springFestivalDojo     = self:GetMapDecryptionDojo() 
   local serverData = springFestivalDojo.trackingQuests
   local starInfo = springFestivalDojo.starInfo
    ---@type MapDecryptionQuestVo[]    
   local questVos = MapDecryptionConfMgr:GetAllQuestVos()
   for i, v in ipairs(questVos) do
        ---@type MapDecryptionTrackingDataEntity
        local entity = MapDecryptionTrackingDataEntity.New()
        entity:Fill(v, serverData[v.id], starInfo)
        table.insert(entityList, entity)
   end
   return entityList
end

--- GetTrackingQuestData
--- 获取追踪数据
---@param questId number 追踪关卡id
function MapDecryptionComponent:GetTrackingQuestData(questId)
    ---@type MapDecryptionDojo
    local springFestivalDojo = self:GetMapDecryptionDojo()
    local trackingQuests     = springFestivalDojo.trackingQuests
    return trackingQuests[checkNumber(questId)]
end

--- UpdateTrackingQuestStar
---@param questId number 追踪关卡id
---@param star table    追踪关卡星级
function MapDecryptionComponent:UpdateTrackingQuestStar(questId, newStarInfo)
    -- local trackingQuestData = self:GetTrackingQuestData(questId)
    
    -- star = checkTable(star)
    -- local t = {}
    -- local count = 0
    -- for k, v in pairs(star) do
    --     if checkInt(v) > 0 then
    --         count = count + 1
    --         table.insert(t, count)
    --     end
    -- end
    -- local oldStar = checkTable(trackingQuestData.star)
    -- if count > #oldStar then
    --     trackingQuestData.star = t
    -- end

    if not newStarInfo or not questId then
        return
    end
    ---@type MapDecryptionDojo
    local dojo = self:GetMapDecryptionDojo()
    local starInfo = dojo.starInfo
    --达成三星的不刷新
    if not QuestConfMgr:GetInstance():IsCompleteAllCondition(questId) then
        --直接覆盖
        starInfo[tostring(questId)] = checkTable(newStarInfo)
    end

    local nextQuestId = self:UpdateTrackQuestId(checkNumber(questId))
    if nextQuestId then
        local questData = self:GetTrackingQuestData(nextQuestId)
        if questData then
            questData.isUnlock = 1
            questData.isNew = true
        end
    end
end

--- GenerateAntiqueRestorationEntityList
--- 生成古物修复实体数据列表
function MapDecryptionComponent:GenerateAntiqueRestorationEntityList()
    local entityList         = {}
    ---@type MapDecryptionDojo
    local springFestivalDojo = self:GetMapDecryptionDojo() 
    local serverData         = springFestivalDojo.antiques
    local finalAntiqueId     = self:GetFinalAntiqueId()
    
    local MapDecryptionConfMgr = MapDecryptionConfMgr
    --- antiques 中没有最终古物的是否修复的状态
    
    local finalAntiqueVo
    local isStuffAll = true
    ---@type MapDecryptionAntiqueRestorationVo[]    
    local vos = MapDecryptionConfMgr:GetAllAntiqueRestorations()
    for i, v in ipairs(vos) do
        if v.antiqueId == finalAntiqueId then
            finalAntiqueVo = v
        else
            ---@type MapDecryptionAntiqueRestorationEntity
            local entity = MapDecryptionAntiqueRestorationEntity.New()
            entity:Fill(v, serverData[v.antiqueId], entityList)
            table.insert(entityList, entity)

            isStuffAll = isStuffAll and entity.status == 2
        end
    end

    if finalAntiqueVo then
        ---@type MapDecryptionAntiqueRestorationEntity
        local entity = MapDecryptionAntiqueRestorationEntity.New()
        entity:FillFinalAntique(finalAntiqueVo, isStuffAll)
        table.insert(entityList, entity)
        
    end
    

    return entityList
end

--- GetRotaryTableData
--- 获取转盘数据
function MapDecryptionComponent:GetRotaryTableData()
    ---@type MapDecryptionDojo
    local springFestivalDojo = self:GetMapDecryptionDojo()
    local data = springFestivalDojo.allRotaryTableNumInfo
    return data
end

function MapDecryptionComponent:SetRotaryTableData(data)
    local springFestivalDojo = self:GetMapDecryptionDojo()
    springFestivalDojo.allRotaryTableNumInfo = data
end

function MapDecryptionComponent:GetFinalAntiqueId()
    if self._finalAntiqueId then
        return self._finalAntiqueId
    end
    local MapDecryptionConfMgr = MapDecryptionConfMgr
    local activityData      = self:GetActivityData()
    local activityContentId = activityData.activityContentId
    ---@type MapDecryptionPlanVo
    local planVo            = MapDecryptionConfMgr:GetPlanVoById(activityContentId)
    local finalAntiqueId    = checkNumber(planVo.antiqueId)
    self._finalAntiqueId = finalAntiqueId
    return finalAntiqueId
end

--- GetAntiqueEntityList
---@return MapDecryptionAntiqueRestorationEntity[]
function MapDecryptionComponent:GetAntiqueEntityList()
    return self._antiqueEntityList
end

--- UpdateAntiqueStatus
---@param antiqueId number 古物id
---@param status number    古物状态 0:未获得 1:未修复|未合成 2:已修复|已合成
function MapDecryptionComponent:UpdateAntiqueStatus(antiqueId, status)
    local finalAntiqueId     = self:GetFinalAntiqueId()
    local antiqueEntity, finalAntiqueEntity
    ---@type MapDecryptionAntiqueRestorationEntity[]
    local antiqueEntityList = self:GetAntiqueEntityList()
    local count = #antiqueEntityList
    local isStuffAll = true
    for i = count, 1, -1 do
        
        local entity = antiqueEntityList[i]
        local entityAntiqueId = entity.antiqueId
        if entityAntiqueId == antiqueId then
            entity.status = status
            antiqueEntity = entity
            -- break
        end

        if entityAntiqueId == finalAntiqueId then
            finalAntiqueEntity = entity
        else
            isStuffAll = isStuffAll and entity.status == 2
        end

    end
    
    local isCreateFinalAntique = antiqueId ~= finalAntiqueId and isStuffAll
    --- 如果修复的古物不是最终古物 则需要检查最后一个是否解锁
    if isCreateFinalAntique then
        finalAntiqueEntity.status = 1
    end

    return antiqueEntity, isCreateFinalAntique and finalAntiqueEntity or nil
end

function MapDecryptionComponent:GenerateNPCId2Entity()
    local npcId2Entity = {
        -- npcId      = 对话数据
        -- [peopleId] = MapDecryptionTalkDataEntity
    }
    ---@type MapDecryptionDojo
    local springFestivalDojo = self:GetMapDecryptionDojo()
    local talk               = springFestivalDojo.talk
    for k, v in pairs(talk) do
        local people = checkNumber(v.people)
        ---@type MapDecryptionTalkDataEntity
        local entity = npcId2Entity[people]
        if entity == nil then
            entity = MapDecryptionTalkDataEntity.New()
            npcId2Entity[people] = entity:Fill(v)
        else
            entity:AddTalk(v)
        end

    end
    return npcId2Entity
end

function MapDecryptionComponent:GetNPCId2Entity()
    return self._npcId2Entity
end

--- GetTalkEntityByNPCId
--- 获取闲聊数据数据
---@param npcId number 
function MapDecryptionComponent:GetTalkEntityByNPCId(npcId)
    local npcId2Entity = self:GetNPCId2Entity()
    ---@type MapDecryptionTalkDataEntity
    local entity = npcId2Entity[npcId]
    return entity

end

--- UpdateTrackQuestId
---@param questId number 通关的追踪关卡id
function MapDecryptionComponent:UpdateTrackQuestId(questId)
    ---@type MapDecryptionDojo
    local dojo                = self:GetMapDecryptionDojo()
    local playerMapDecryption = dojo.playerMapDecryption
    local challengeQuestId    = checkNumber(playerMapDecryption.challengeQuestId)
    if questId > challengeQuestId then
        playerMapDecryption.challengeQuestId = questId
        return questId + 1
    end

    return nil
end

function MapDecryptionComponent:IsCompleteCondition(questId, conditionId)
    ---@type MapDecryptionDojo
    local dojo      = self:GetMapDecryptionDojo()
    local starInfo  = dojo.starInfo[tostring(questId)]
    if starInfo then
        if checkNumber(starInfo[conditionId]) == 1 then
            return true
        end
    end
    return false
end

--- GetTrackQuestId
--- 获取通关的追踪关卡id
function MapDecryptionComponent:GetTrackQuestId()
    ---@type MapDecryptionDojo
    local dojo                = self:GetMapDecryptionDojo()
    local playerMapDecryption = dojo.playerMapDecryption
    return checkNumber(playerMapDecryption.challengeQuestId)
end

--- IsPassTrackLevelById
--- 根据id 判断是否通关
---@param questId number
function MapDecryptionComponent:IsPassTrackLevelById(questId)
    local passQuestId = self:GetTrackQuestId()
    return passQuestId > 0 and passQuestId >= checkNumber(questId)
end

--- GetMapQuestId
--- 获取通关的探索地图关卡id
function MapDecryptionComponent:GetMapQuestId()
    ---@type MapDecryptionDojo
    local dojo                = self:GetMapDecryptionDojo()
    local playerMapDecryption = dojo.playerMapDecryption
    return checkNumber(playerMapDecryption.newQuestId)
end

--- IsPassMapLevelById
--- 根据id 判断是否通关
---@param questId number
function MapDecryptionComponent:IsPassMapLevelById(questId)
    local passQuestId = self:GetMapQuestId()
    return passQuestId > 0 and passQuestId >= checkNumber(questId)
end

function MapDecryptionComponent:GetBubbleRedPointStateByNpcId(npcId)
    if self:CheckActivityIsEnd() then
        return false
    end
    if npcId == 1 then
        -- 1,云灿,考古学家
        -- 有解密地图的奖励未领取
        -- 有解密地图未全部通关的
        return self:CheckMapsRedPoint()

    elseif npcId == 2 then
        -- 2,云沛,修复专家
        -- 有古物可修复
        return self:CheckAntiquesRedPoint()
        
    elseif npcId == 3 then
        -- 3,小玲,新年大使
        -- 有免费红包可领取
        return self:CheckStoreRedPoint()
    end
    return false
end

function MapDecryptionComponent:CheckMapsRedPoint()
    local entityList = self:GenerateExploreDataEntityList()
    for index, exploreDataEntity in ipairs(entityList) do
        if self:CheckMapRedPoint(exploreDataEntity) then
            return true
        end
    end
    return false
end
---CheckMapRedPoint
---@param exploreDataEntity MapDecryptionExploreDataEntity
function MapDecryptionComponent:CheckMapRedPoint(exploreDataEntity)
    local curTime   = os.time()
    local unlockDay = exploreDataEntity.unlockDay
    if curTime < unlockDay then
        return false
    end
    if exploreDataEntity.status == 1 then
        return true
    end
    
    local ReceiveStatus = MapDecryptionConstants.ReceiveStatus
    ---@type MapDecryptionExploreTaskEntity[]
    local entityList = exploreDataEntity.taskEntityList
    for index, taskEntity in ipairs(entityList) do
        local status        = taskEntity.status
        local isCanReceive  = status == ReceiveStatus.CanReceive
        if isCanReceive or status == ReceiveStatus.NotComplete then
            return true
        end

    end
    return false
end

---CheckAntiquesRedPoint
---检查是否有能修复的古物
---@return boolean 是否能修复
function MapDecryptionComponent:CheckAntiquesRedPoint()
    ---@type MapDecryptionAntiqueRestorationEntity
    local entityList = self:GetAntiqueEntityList()
    for index, antiqueEntity in ipairs(entityList) do
        if self:CheckAntiqueIsCanRestore(antiqueEntity) then
            return true
        end
    end
    return false
end
---CheckAntiqueIsCanRestore
---检查古物是否能修复
---@param antiqueEntity MapDecryptionAntiqueRestorationEntity
---@return boolean 是否能修复
function MapDecryptionComponent:CheckAntiqueIsCanRestore(antiqueEntity)
    ---@type MapDecryptionAntiqueRestorationVo
    local antiqueRestorationVo = antiqueEntity.antiqueRestorationVo
    local rewards = antiqueEntity.isFinal and antiqueRestorationVo.composeGoods or antiqueRestorationVo.stuffGoods
    local isShowTips = antiqueEntity.status == 1 and GoodsUtils.CheckGoodConsumeCondition(rewards)
    return isShowTips
end

function MapDecryptionComponent:GetOptionRedPointStateByFunctionId(id)
    if self:CheckActivityIsEnd() then
        return false
    end
    local FunctionEnterType = MapDecryptionConstants.FunctionEnterType
    if id == FunctionEnterType.Explore then
        -- 有解密地图的奖励未领取
        -- 有解密地图未全部通关的
        return self:CheckMapsRedPoint()

    elseif id == FunctionEnterType.Tracking then
        return self:CheckTrackQuestRedPoint()
        
    elseif id == FunctionEnterType.AntiqueRestoration then
        -- 有古物可修复
        return self:CheckAntiquesRedPoint()

    elseif id == FunctionEnterType.Store then
        return self:CheckStoreRedPoint()

    end

    return false
end

function MapDecryptionComponent:CheckTrackQuestRedPoint()
    ---@type MapDecryptionDojo
   local dojo           = self:GetMapDecryptionDojo() 
   local trackingQuests = dojo.trackingQuests
   for index, value in pairs(trackingQuests) do
        if value.isNew then
            return true
        end
    end
    return false

end

function MapDecryptionComponent:ClearTrackQuestRedPoint(test)
    ---@type MapDecryptionDojo
   local dojo           = self:GetMapDecryptionDojo() 
   local trackingQuests = dojo.trackingQuests
   for index, value in pairs(trackingQuests) do
        -- value.isNew = false
        value.isNew = checkBool(test)
    end
end

---CheckStoreRedPoint
---检查商店红点
function MapDecryptionComponent:CheckStoreRedPoint()
    ---@type MapDecryptionDojo
   local dojo          = self:GetMapDecryptionDojo() 
   local redPacketTips = dojo.redPacketTips == nil and -1 or checkNumber(dojo.redPacketTips)
   return redPacketTips == 0
end

function MapDecryptionComponent:ClearStoreRedPoint()
    ---@type MapDecryptionDojo
   local dojo         = self:GetMapDecryptionDojo() 
   dojo.redPacketTips = -1

end

return MapDecryptionComponent