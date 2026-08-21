module("dessert.DessertManager", Class.impl(Manager))

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

function parseDessertPanelData(self, msg)
    for i = 1, #msg.dup_list do
        self.mDupDic[msg.dup_list[i].id] = msg.dup_list[i].point
    end
    self.mTaskList = msg.task_list
    self.mGainedList = msg.gained_list
    --self.mStartRewardList = msg.star_reward_list

    GameDispatcher:dispatchEvent(EventName.UPDATE_DESSERT_STAGE_PANEL)
    GameDispatcher:dispatchEvent(EventName.MAINACTIVITY_REDSTATE_UPDATE)
end

function updateDessertTaskData(self,msg)
    for i = 1, #msg.task_id_list, 1 do
        for j = 1, #self.mTaskList, 1 do
            if self.mTaskList[j].id == msg.task_id_list[i] then
                self.mTaskList[j].state = 2
            end
        end
    end

    GameDispatcher:dispatchEvent(EventName.DESSERT_TASK_UPDATE)
end

function updateDessertTaskDataCount(self,msg)
    for i = 1, #self.mTaskList, 1 do
        if self.mTaskList[i].id == msg.task_info.id then
            self.mTaskList[i] = msg.task_info
        end
    end
    GameDispatcher:dispatchEvent(EventName.DESSERT_TASK_UPDATE)
end

function receiveAllTaskAward(self)
    local list = {}
    for i = 1, #self.mTaskList, 1 do
        if self.mTaskList[i].state == 0 then
            table.insert(list, self.mTaskList[i].id)
        end
    end
    if #list > 0 then
        GameDispatcher:dispatchEvent(EventName.REQ_DESSERT_TASK_RECEIVE, {taskId = list})
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

function getDessertTaskMasData(self)
    return self.mTaskList
end



function parseDessertPassDupData(self, msg)
    self.mDupDic[msg.id] = msg.point
    GameDispatcher:dispatchEvent(EventName.UPDATE_DESSERT_PASS_DUP)
    GameDispatcher:dispatchEvent(EventName.UPDATE_DESSERT_STAGE_PANEL)
    GameDispatcher:dispatchEvent(EventName.MAINACTIVITY_REDSTATE_UPDATE)
end

function parseStarData(self)
    self.mStarData = {}
    local baseData = RefMgr:getData("dessert_star_data")
    for key, value in pairs(baseData) do
        local DessertStarVo = LuaPoolMgr:poolGet(dessert.DessertStarDataVo)
        DessertStarVo:parseData(key, value)
        self.mStarData[key] = DessertStarVo
    end
end

function getStarDataById(self,id)
    if self.mStarData == nil then
        self:parseStarData()
    end
    return self.mStarData[id]
end


function parseDessertDupData(self)
    self.mDessertDupData = {}
    local baseData = RefMgr:getData("dessert_area_data")
    for key, value in pairs(baseData) do
        local DessertDupVo = LuaPoolMgr:poolGet(dessert.DessertDupDataVo)
        DessertDupVo:parseCogfigData(key, value)
        self.mDessertDupData[key] = DessertDupVo
    end
end

function getAreaConfigDic(self)
    if self.mDessertDupData == nil then
        self:parseDessertDupData()
    end
    return self.mDessertDupData
end

function getAreaConfig(self,area_id)
    if self.mDessertDupData == nil then
        self:parseDessertDupData()
    end
    return self.mDessertDupData[area_id]
    
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
    if not self.mDessertData then
        self:parseDessertData()
    end
    return self.mDessertData[dup_id]
end

function parseDessertData(self)
    self.mDessertData = {}
    local baseData = RefMgr:getData("dessert_data")
    for key, value in pairs(baseData) do
        local DessertVo = LuaPoolMgr:poolGet(dessert.DessertGameDataVo)
        DessertVo:parseData(key, value)
        self.mDessertData[key] = DessertVo
    end
end

function getDessertDataById(self, id)
    if self.mDessertData == nil then
        self:parseDessertData()
    end
    return self.mDessertData[id]
end

function parseDessertTaskData(self)
    self.mDessertTaskData = {}
    local baseData = RefMgr:getData("dessert_task_data")
    for key, value in pairs(baseData) do
        local DessertTaskVo = LuaPoolMgr:poolGet(dessert.DessertTaskDataVo)
        DessertTaskVo:parseData(key, value)
        self.mDessertTaskData[key] = DessertTaskVo
    end
end

function getTaskConfig(self, id)
    if self.mDessertTaskData == nil then
        self:parseDessertTaskData()
    end
    return self.mDessertTaskData
end

function getTaskConfigVo(self, taskId)
    if self.mDessertTaskData == nil then
        self:parseDessertTaskData()
    end
    return self.mDessertTaskData[taskId]
end

function checkTaskAwardCanReceive(self)
    for i = 1, #self.mTaskList, 1  do
        if self.mTaskList[i].state == 0 then
            return true
        end
    end
    return false
end

function parseDessertItemData(self)
    self.mDessertItemData = {}
    local baseData = RefMgr:getData("dessert_icon_data")
    for key, value in pairs(baseData) do
        local DessertItemVo = LuaPoolMgr:poolGet(dessert.DessertItemDataVo)
        DessertItemVo:parseData(key, value)
        self.mDessertItemData[key] = DessertItemVo
    end
end

function getDessertItemData(self, dessertId)
    if self.mDessertItemData == nil then
        self:parseDessertItemData()
    end
    return self.mDessertItemData[dessertId]
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
        local isNewOpen = not StorageUtil:getBool1(gstor.DESSERT_DUPNEWOPENSTR.. dup_id)

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
    local baseData = RefMgr:getData("dessert_reward_data")
    for key, data in pairs(baseData) do
        local baseVo = dessert.DessertStarRwardConfigVo.new()
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
