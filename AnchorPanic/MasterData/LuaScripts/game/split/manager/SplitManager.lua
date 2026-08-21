module("split.SplitManager", Class.impl(Manager))

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

function parseSplitPanelData(self, msg)
    for i = 1, #msg.dup_list do
        self.mDupDic[msg.dup_list[i].id] = msg.dup_list[i].point
    end
    self.mTaskList = msg.task_list
    self.mGainedList = msg.gained_list
    --self.mStartRewardList = msg.star_reward_list

    GameDispatcher:dispatchEvent(EventName.UPDATE_SPLIT_STAGE_PANEL)
    GameDispatcher:dispatchEvent(EventName.MAINACTIVITY_REDSTATE_UPDATE)
end

function updateSplitTaskData(self,msg)
    for i = 1, #msg.task_id_list, 1 do
        for j = 1, #self.mTaskList, 1 do
            if self.mTaskList[j].id == msg.task_id_list[i] then
                self.mTaskList[j].state = 2
            end
        end
    end

    GameDispatcher:dispatchEvent(EventName.SPLIT_TASK_UPDATE)
end

function updateSplitTaskDataCount(self,msg)
    for i = 1, #self.mTaskList, 1 do
        if self.mTaskList[i].id == msg.task_info.id then
            self.mTaskList[i] = msg.task_info
        end
    end
    GameDispatcher:dispatchEvent(EventName.SPLIT_TASK_UPDATE)
end

function receiveAllTaskAward(self)
    local list = {}
    for i = 1, #self.mTaskList, 1 do
        if self.mTaskList[i].state == 0 then
            table.insert(list, self.mTaskList[i].id)
        end
    end
    if #list > 0 then
        GameDispatcher:dispatchEvent(EventName.REQ_SPLIT_TASK_RECEIVE, {taskId = list})
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

function getSplitTaskMasData(self)
    return self.mTaskList
end



function parseSplitPassDupData(self, msg)
    self.mDupDic[msg.id] = msg.point
    GameDispatcher:dispatchEvent(EventName.UPDATE_SPLIT_PASS_DUP)
    GameDispatcher:dispatchEvent(EventName.UPDATE_SPLIT_STAGE_PANEL)
    GameDispatcher:dispatchEvent(EventName.MAINACTIVITY_REDSTATE_UPDATE)
end

function parseStarData(self)
    self.mStarData = {}
    local baseData = RefMgr:getData("drink_star_data")
    for key, value in pairs(baseData) do
        local splitStarVo = LuaPoolMgr:poolGet(split.SplitStarDataVo)
        splitStarVo:parseData(key, value)
        self.mStarData[key] = splitStarVo
    end
end

function getStarDataById(self,id)
    if self.mStarData == nil then
        self:parseStarData()
    end
    return self.mStarData[id]
end


function parseSplitDupData(self)
    self.mSplitDupData = {}
    local baseData = RefMgr:getData("drink_area_data")
    for key, value in pairs(baseData) do
        local splitDupVo = LuaPoolMgr:poolGet(split.SplitDupDataVo)
        splitDupVo:parseCogfigData(key, value)
        self.mSplitDupData[key] = splitDupVo
    end
end

function getAreaConfigDic(self)
    if self.mSplitDupData == nil then
        self:parseSplitDupData()
    end
    return self.mSplitDupData
end

function getAreaConfig(self,area_id)
    if self.mSplitDupData == nil then
        self:parseSplitDupData()
    end
    return self.mSplitDupData[area_id]
    
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
    if not self.mSplitData then
        self:parseSplitData()
    end
    return self.mSplitData[dup_id]
end

function parseSplitData(self)
    self.mSplitData = {}
    local baseData = RefMgr:getData("drink_data")
    for key, value in pairs(baseData) do
        local splitVo = LuaPoolMgr:poolGet(split.SplitGameDataVo)
        splitVo:parseData(key, value)
        self.mSplitData[key] = splitVo
    end
end

function getSplitDataById(self, id)
    if self.mSplitData == nil then
        self:parseSplitData()
    end
    return self.mSplitData[id]
end

function parseSplitTaskData(self)
    self.mSplitTaskData = {}
    local baseData = RefMgr:getData("drink_task_data")
    for key, value in pairs(baseData) do
        local splitTaskVo = LuaPoolMgr:poolGet(split.SplitTaskDataVo)
        splitTaskVo:parseData(key, value)
        self.mSplitTaskData[key] = splitTaskVo
    end
end

function getTaskConfig(self, id)
    if self.mSplitTaskData == nil then
        self:parseSplitTaskData()
    end
    return self.mSplitTaskData
end

function getTaskConfigVo(self, taskId)
    if self.mSplitTaskData == nil then
        self:parseSplitTaskData()
    end
    return self.mSplitTaskData[taskId]
end

function checkTaskAwardCanReceive(self)
    for i = 1, #self.mTaskList, 1  do
        if self.mTaskList[i].state == 0 then
            return true
        end
    end
    return false
end

function parseSplitItemData(self)
    self.mSplitItemData = {}
    local baseData = RefMgr:getData("split_icon_data")
    for key, value in pairs(baseData) do
        local splitItemVo = LuaPoolMgr:poolGet(split.SplitItemDataVo)
        splitItemVo:parseData(key, value)
        self.mSplitItemData[key] = splitItemVo
    end
end

function getSplitItemData(self, splitId)
    if self.mSplitItemData == nil then
        self:parseSplitItemData()
    end
    return self.mSplitItemData[splitId]
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
        local isNewOpen = not StorageUtil:getBool1(gstor.SPLIT_DUPNEWOPENSTR.. dup_id)

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
    local baseData = RefMgr:getData("split_reward_data")
    for key, data in pairs(baseData) do
        local baseVo = split.SplitStarRwardConfigVo.new()
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
