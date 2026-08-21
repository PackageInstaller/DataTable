module("bird.BirdManager", Class.impl(Manager))

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

function parseBirdPanelData(self, msg)
    for i = 1, #msg.dup_list do
        self.mDupDic[msg.dup_list[i].id] = msg.dup_list[i].point
    end
    self.mTaskList = msg.task_list
    self.mGainedList = msg.gained_list
    --self.mStartRewardList = msg.star_reward_list

    GameDispatcher:dispatchEvent(EventName.UPDATE_BIRD_STAGE_PANEL)
    GameDispatcher:dispatchEvent(EventName.MAINACTIVITY_REDSTATE_UPDATE)
end

function updateBirdTaskData(self,msg)
    for i = 1, #msg.task_id_list, 1 do
        for j = 1, #self.mTaskList, 1 do
            if self.mTaskList[j].id == msg.task_id_list[i] then
                self.mTaskList[j].state = 2
            end
        end
    end

    GameDispatcher:dispatchEvent(EventName.BIRD_TASK_UPDATE)
end

function updateBirdTaskDataCount(self,msg)
    for i = 1, #self.mTaskList, 1 do
        if self.mTaskList[i].id == msg.task_info.id then
            self.mTaskList[i] = msg.task_info
        end
    end
    GameDispatcher:dispatchEvent(EventName.BIRD_TASK_UPDATE)
end

function receiveAllTaskAward(self)
    local list = {}
    for i = 1, #self.mTaskList, 1 do
        if self.mTaskList[i].state == 0 then
            table.insert(list, self.mTaskList[i].id)
        end
    end
    if #list > 0 then
        GameDispatcher:dispatchEvent(EventName.REQ_BIRD_TASK_RECEIVE, {taskId = list})
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

function getBirdTaskMasData(self)
    return self.mTaskList
end



function parseBirdPassDupData(self, msg)
    self.mDupDic[msg.id] = msg.point
    GameDispatcher:dispatchEvent(EventName.UPDATE_BIRD_PASS_DUP)
    GameDispatcher:dispatchEvent(EventName.UPDATE_BIRD_STAGE_PANEL)
    GameDispatcher:dispatchEvent(EventName.MAINACTIVITY_REDSTATE_UPDATE)
end

function parseStarData(self)
    self.mStarData = {}
    local baseData = RefMgr:getData("bird_star_data")
    for key, value in pairs(baseData) do
        local birdStarVo = LuaPoolMgr:poolGet(bird.BirdStarDataVo)
        birdStarVo:parseData(key, value)
        self.mStarData[key] = birdStarVo
    end
end

function getStarDataById(self,id)
    if self.mStarData == nil then
        self:parseStarData()
    end
    return self.mStarData[id]
end


function parseBirdDupData(self)
    self.mBirdDupData = {}
    local baseData = RefMgr:getData("bird_area_data")
    for key, value in pairs(baseData) do
        local birdDupVo = LuaPoolMgr:poolGet(bird.BirdDupDataVo)
        birdDupVo:parseCogfigData(key, value)
        self.mBirdDupData[key] = birdDupVo
    end
end

function getAreaConfigDic(self)
    if self.mBirdDupData == nil then
        self:parseBirdDupData()
    end
    return self.mBirdDupData
end

function getAreaConfig(self,area_id)
    if self.mBirdDupData == nil then
        self:parseBirdDupData()
    end
    return self.mBirdDupData[area_id]
    
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
    if not self.mBirdData then
        self:parseBirdData()
    end
    return self.mBirdData[dup_id]
end

function parseBirdData(self)
    self.mBirdData = {}
    local baseData = RefMgr:getData("bird_data")
    for key, value in pairs(baseData) do
        local birdVo = LuaPoolMgr:poolGet(bird.BirdGameDataVo)
        birdVo:parseData(key, value)
        self.mBirdData[key] = birdVo
    end
end

function getBirdDataById(self, id)
    if self.mBirdData == nil then
        self:parseBirdData()
    end
    return self.mBirdData[id]
end

function parseBirdTaskData(self)
    self.mBirdTaskData = {}
    local baseData = RefMgr:getData("bird_task_data")
    for key, value in pairs(baseData) do
        local birdTaskVo = LuaPoolMgr:poolGet(bird.BirdTaskDataVo)
        birdTaskVo:parseData(key, value)
        self.mBirdTaskData[key] = birdTaskVo
    end
end

function getTaskConfig(self, id)
    if self.mBirdTaskData == nil then
        self:parseBirdTaskData()
    end
    return self.mBirdTaskData
end

function getTaskConfigVo(self, taskId)
    if self.mBirdTaskData == nil then
        self:parseBirdTaskData()
    end
    return self.mBirdTaskData[taskId]
end

function checkTaskAwardCanReceive(self)
    for i = 1, #self.mTaskList, 1  do
        if self.mTaskList[i].state == 0 then
            return true
        end
    end
    return false
end

function parseBirdItemData(self)
    self.mBirdItemData = {}
    local baseData = RefMgr:getData("bird_icon_data")
    for key, value in pairs(baseData) do
        local birdItemVo = LuaPoolMgr:poolGet(bird.BirdItemDataVo)
        birdItemVo:parseData(key, value)
        self.mBirdItemData[key] = birdItemVo
    end
end

function getBirdItemData(self, birdId)
    if self.mBirdItemData == nil then
        self:parseBirdItemData()
    end
    return self.mBirdItemData[birdId]
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
        local isNewOpen = not StorageUtil:getBool1(gstor.BIRD_DUPNEWOPENSTR.. dup_id)

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
    local baseData = RefMgr:getData("bird_reward_data")
    for key, data in pairs(baseData) do
        local baseVo = bird.BirdStarRwardConfigVo.new()
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
