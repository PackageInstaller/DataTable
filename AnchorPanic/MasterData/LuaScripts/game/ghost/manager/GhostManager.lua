module("ghost.GhostManager", Class.impl(Manager))

-- 构造函数
function ctor(self)
    super.ctor(self)
    self:__initData()
end

-- Override 重置数据
function resetData(self)
    super.resetData(self)
    self:__initData()
end

function __initData(self)
    self.mDupDic = {}
    --self.mStartRewardList = {}
end

function parseGhostPanelData(self, msg)
    for i = 1, #msg.dup_list do
        self.mDupDic[msg.dup_list[i].id] = msg.dup_list[i].point
    end
    self.mTaskList = msg.task_list
    self.mGainedList = msg.gained_list
    --self.mStartRewardList = msg.star_reward_list

    GameDispatcher:dispatchEvent(EventName.UPDATE_GHOST_STAGE_PANEL)
    GameDispatcher:dispatchEvent(EventName.MAINACTIVITY_REDSTATE_UPDATE)
end

function updateGhostTaskData(self,msg)
    for i = 1, #msg.task_id_list, 1 do
        for j = 1, #self.mTaskList, 1 do
            if self.mTaskList[j].id == msg.task_id_list[i] then
                self.mTaskList[j].state = 2
            end
        end
    end

    GameDispatcher:dispatchEvent(EventName.GHOST_TASK_UPDATE)
end

function updateGhostTaskDataCount(self,msg)
    for i = 1, #self.mTaskList, 1 do
        if self.mTaskList[i].id == msg.task_info.id then
            self.mTaskList[i] = msg.task_info
        end
    end
    GameDispatcher:dispatchEvent(EventName.GHOST_TASK_UPDATE)
end

function receiveAllTaskAward(self)
    local list = {}
    for i = 1, #self.mTaskList, 1 do
        if self.mTaskList[i].state == 0 then
            table.insert(list, self.mTaskList[i].id)
        end
    end
    if #list > 0 then
        GameDispatcher:dispatchEvent(EventName.REQ_GHOST_TASK_RECEIVE, {taskId = list})
    end
end

function checkTaskAwardReceived(self,taskId)
    if self.mTaskList == nil then
        return false
    end
    for i = 1, #self.mTaskList, 1 do
        if self.mTaskList[i].id == taskId then
            return self.mTaskList[i].state == 2
        end
    end
    return false
end

function getTaskMsgVo(self, taskId)
    for i = 1, #self.mTaskList, 1 do
        if self.mTaskList[i].id == taskId then
            return self.mTaskList[i]
        end
    end
    return nil
end

function getGhostTaskMasData(self)
    return self.mTaskList
end



function parseGhostPassDupData(self, msg)
    self.mDupDic[msg.id] = msg.point
    GameDispatcher:dispatchEvent(EventName.UPDATE_GHOST_PASS_DUP)
    GameDispatcher:dispatchEvent(EventName.UPDATE_GHOST_STAGE_PANEL)
    GameDispatcher:dispatchEvent(EventName.MAINACTIVITY_REDSTATE_UPDATE)
end

function parseStarData(self)
    self.mStarData = {}
    local baseData = RefMgr:getData("ghost_star_data")
    for key, value in pairs(baseData) do
        local ghostStarVo = LuaPoolMgr:poolGet(ghost.GhostStarDataVo)
        ghostStarVo:parseData(key, value)
        self.mStarData[key] = ghostStarVo
    end
end

function getStarDataById(self,id)
    if self.mStarData == nil then
        self:parseStarData()
    end
    return self.mStarData[id]
end


function parseGhostDupData(self)
    self.mGhostDupData = {}
    local baseData = RefMgr:getData("ghost_area_data")
    for key, value in pairs(baseData) do
        local ghostDupVo = LuaPoolMgr:poolGet(ghost.GhostDupDataVo)
        ghostDupVo:parseCogfigData(key, value)
        self.mGhostDupData[key] = ghostDupVo
    end
end

function getAreaConfigDic(self)
    if self.mGhostDupData == nil then
        self:parseGhostDupData()
    end
    return self.mGhostDupData
end

function getAreaConfig(self,area_id)
    if self.mGhostDupData == nil then
        self:parseGhostDupData()
    end
    return self.mGhostDupData[area_id]
    
end

function getAreaPassState(self,area_id)
    local areaConfig = self:getAreaConfig(area_id)
    if areaConfig then
        for _, dupId in pairs(areaConfig.stage_list) do
            if not self:getDupPassState(dupId) then
                return false
            end
        end
    end
    return true
end

function getDupPassState(self,dupId)
    return self:getDupPassStar(dupId) ~= 0
end

function getDupPassStar(self,dupId)
    if not self.mDupDic or self.mDupDic[dupId] == nil then
        return 0
    end
    return self.mDupDic[dupId] or 0
end

function getNextDupId(self,dupId)
    local isBreak = false
    local allAreaCofig = self:getAreaConfigDic()
    for areaId, areaConfigVo in pairs(allAreaCofig) do
        if isBreak then
            return areaConfigVo.stage_list[1]
        end

        local length = #areaConfigVo.stage_list
        for i = 1, length do
            if areaConfigVo.stage_list[i] == dupId then
                local next_index = i + 1
                if next_index <= length then
                    return areaConfigVo.stage_list[next_index]
                else
                    isBreak = true
                    break
                end
            end
        end
    end
end

function getDupConfig(self,dup_id)
    if not self.mGhostData then
        self:parseGhostData()
    end
    return self.mGhostData[dup_id]
end

function parseGhostData(self)
    self.mGhostData = {}
    local baseData = RefMgr:getData("ghost_data")
    for key, value in pairs(baseData) do
        local ghostVo = LuaPoolMgr:poolGet(ghost.GhostGameDataVo)
        ghostVo:parseData(key, value)
        self.mGhostData[key] = ghostVo
    end
end

function getGhostDataById(self, id)
    if self.mGhostData == nil then
        self:parseGhostData()
    end
    return self.mGhostData[id]
end

function parseGhostTaskData(self)
    self.mGhostTaskData = {}
    local baseData = RefMgr:getData("ghost_task_data")
    for key, value in pairs(baseData) do
        local ghostTaskVo = LuaPoolMgr:poolGet(ghost.GhostTaskDataVo)
        ghostTaskVo:parseData(key, value)
        self.mGhostTaskData[key] = ghostTaskVo
    end
end

function getTaskConfig(self, id)
    if self.mGhostTaskData == nil then
        self:parseGhostTaskData()
    end
    return self.mGhostTaskData
end

function getTaskConfigVo(self, taskId)
    if self.mGhostTaskData == nil then
        self:parseGhostTaskData()
    end
    return self.mGhostTaskData[taskId]
end

function checkTaskAwardCanReceive(self)
    for i = 1, #self.mTaskList, 1  do
        if self.mTaskList[i].state == 0 then
            return true
        end
    end
    return false
end

function parseGhostItemData(self)
    self.mGhostItemData = {}
    local baseData = RefMgr:getData("ghost_icon_data")
    for key, value in pairs(baseData) do
        local ghostItemVo = LuaPoolMgr:poolGet(ghost.GhostItemDataVo)
        ghostItemVo:parseData(key, value)
        self.mGhostItemData[key] = ghostItemVo
    end
end

function getGhostItemData(self, ghostId)
    if self.mGhostItemData == nil then
        self:parseGhostItemData()
    end
    return self.mGhostItemData[ghostId]
end


function getAreaShowRed(self, areaConfigVo)
    local timeOpen = areaConfigVo:isOpen()
    if not timeOpen then
        return false
    end

    for i = 1, #areaConfigVo.stage_list do
        local dup_id = areaConfigVo.stage_list[i]
        if self:getDupShowRed(dup_id) then
            return true
        end
    end

    return false
end

function getDupShowRed(self, dup_id)
    local dupConfig = self:getDupConfig(dup_id)
    if dupConfig then
        local lastDup_id = dupConfig.pre_id

        local pass = self:getDupPassState(lastDup_id) or lastDup_id == 0
        local curPass = not self:getDupPassState(dup_id)
        local isOpen = dupConfig:isOpen()
        local isNewOpen = not StorageUtil:getBool1(gstor.GHOST_DUPNEWOPENSTR.. dup_id)

        if pass and curPass and isOpen and isNewOpen then
            return true
        end
    end

    return false
end

function getPassAllStarCount(self)
    return 0
end



function getAwardState(self,award_id)
    if not self.mStartRewardList then
        return false
    end
    return table.indexof01(self.mStartRewardList,award_id)>0
end

function getStarRewardConfig(self)
    -- if not self.m_StarRewardConfigVoDic then
    --     self:parseStarRewardConfigData()
    -- end
    -- return self.m_StarRewardConfigVoDic
    return {}
end

function parseStarRewardConfigData(self)
    self.m_StarRewardConfigVoDic = {}
    local baseData = RefMgr:getData("ghost_reward_data")
    for key, data in pairs(baseData) do
        local baseVo = ghost.GhostStarRwardConfigVo.new()
        baseVo:parseCogfigData(key, data)
        self.m_StarRewardConfigVoDic[key] = baseVo
    end
end


function getIsShowRed(self)
    local areaConfig = self:getAreaConfigDic()
    for areaId, areaConfigVo in pairs(areaConfig) do
        if self:getAreaShowRed(areaConfigVo) then
            return true
        end
    end

    if self:getTaskRed() then
        return true
    end

    return false
end

function getTaskRed(self)
    if self.mTaskList == nil then
        return false
    end
    for i = 1, #self.mTaskList, 1 do
        if self.mTaskList[i].state == 0 then
            return true
        end
    end
    return false
end

return _M
