module("build.BuildManager", Class.impl(Manager))

-- 建造小游戏数据管理器，负责服务端进度、任务状态、配置缓存、红点与关卡解锁判断
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

-- 初始化服务端关卡进度缓存
function __initData(self)
    self.mDupDic = {}
    --self.mStartRewardList = {}
end

-- 解析活动主面板下发数据，缓存关卡最高分、任务列表和已领奖列表
function parseBuildPanelData(self, msg)
    for i = 1, #msg.dup_list do
        self.mDupDic[msg.dup_list[i].id] = msg.dup_list[i].point
    end
    self.mTaskList = msg.task_list
    self.mGainedList = msg.gained_list
    --self.mStartRewardList = msg.star_reward_list

    GameDispatcher:dispatchEvent(EventName.UPDATE_BUILD_STAGE_PANEL)
    GameDispatcher:dispatchEvent(EventName.MAINACTIVITY_REDSTATE_UPDATE)
end

function updateBuildTaskData(self,msg)
    for i = 1, #msg.task_id_list, 1 do
        for j = 1, #self.mTaskList, 1 do
            if self.mTaskList[j].id == msg.task_id_list[i] then
                self.mTaskList[j].state = 2
            end
        end
    end

    GameDispatcher:dispatchEvent(EventName.BUILD_TASK_UPDATE)
end

function updateBuildTaskDataCount(self,msg)
    for i = 1, #self.mTaskList, 1 do
        if self.mTaskList[i].id == msg.task_info.id then
            self.mTaskList[i] = msg.task_info
        end
    end
    GameDispatcher:dispatchEvent(EventName.BUILD_TASK_UPDATE)
end

function receiveAllTaskAward(self)
    local list = {}
    for i = 1, #self.mTaskList, 1 do
        if self.mTaskList[i].state == 0 then
            table.insert(list, self.mTaskList[i].id)
        end
    end
    if #list > 0 then
        GameDispatcher:dispatchEvent(EventName.REQ_BUILD_TASK_RECEIVE, {taskId = list})
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

function getBuildTaskMasData(self)
    return self.mTaskList
end



-- 解析通关返回数据，更新指定关卡最高分，并刷新关卡界面和主活动红点
function parseBuildPassDupData(self, msg)
    self.mDupDic[msg.id] = msg.point
    GameDispatcher:dispatchEvent(EventName.UPDATE_BUILD_PASS_DUP)
    GameDispatcher:dispatchEvent(EventName.UPDATE_BUILD_STAGE_PANEL)
    GameDispatcher:dispatchEvent(EventName.MAINACTIVITY_REDSTATE_UPDATE)
end

-- 解析星级条件配置表，按配置 id 缓存为 VO，供奖励或结算相关逻辑读取
function parseStarData(self)
    self.mStarData = {}
    local baseData = RefMgr:getData("build_star_data")
    for key, value in pairs(baseData) do
        local buildStarVo = LuaPoolMgr:poolGet(build.BuildStarDataVo)
        buildStarVo:parseData(key, value)
        self.mStarData[key] = buildStarVo
    end
end

-- 懒加载并返回指定星级条件配置
function getStarDataById(self,id)
    if self.mStarData == nil then
        self:parseStarData()
    end
    return self.mStarData[id]
end


-- 解析区域配置表，区域中包含一组关卡、开放时间和首通奖励信息
function parseBuildDupData(self)
    self.mBuildDupData = {}
    local baseData = RefMgr:getData("build_area_data")
    for key, value in pairs(baseData) do
        local buildDupVo = LuaPoolMgr:poolGet(build.BuildDupDataVo)
        buildDupVo:parseCogfigData(key, value)
        self.mBuildDupData[key] = buildDupVo
    end
end

function getAreaConfigDic(self)
    if self.mBuildDupData == nil then
        self:parseBuildDupData()
    end
    return self.mBuildDupData
end

function getAreaConfig(self,area_id)
    if self.mBuildDupData == nil then
        self:parseBuildDupData()
    end
    return self.mBuildDupData[area_id]
    
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

-- 懒加载并返回指定关卡玩法配置
function getDupConfig(self,dup_id)
    if self.mBuildData == nil then
        self:parseBuildData()
    end
    return self.mBuildData[dup_id]
end

-- 解析关卡玩法配置表，缓存目标分数、前置关卡、计分速度等数据
function parseBuildData(self)
    self.mBuildData = {}
    local baseData = RefMgr:getData("build_data")
    for key, value in pairs(baseData) do
        local buildVo = LuaPoolMgr:poolGet(build.BuildGameDataVo)
        buildVo:parseData(key, value)
        self.mBuildData[key] = buildVo
    end
end

-- 懒加载并返回指定关卡玩法配置
function getBuildDataById(self, id)
    if self.mBuildData == nil then
        self:parseBuildData()
    end
    return self.mBuildData[id]
end

-- 解析任务配置表，缓存任务类型、目标值、奖励和描述信息
function parseBuildTaskData(self)
    self.mBuildTaskData = {}
    local baseData = RefMgr:getData("build_task_data")
    for key, value in pairs(baseData) do
        local buildTaskVo = LuaPoolMgr:poolGet(build.BuildTaskDataVo)
        buildTaskVo:parseData(key, value)
        self.mBuildTaskData[key] = buildTaskVo
    end
end

-- 懒加载并返回全部任务配置，任务界面用它组装列表
function getTaskConfig(self, id)
    if self.mBuildTaskData == nil then
        self:parseBuildTaskData()
    end
    return self.mBuildTaskData
end

-- 懒加载并返回指定任务配置
function getTaskConfigVo(self, taskId)
    if self.mBuildTaskData == nil then
        self:parseBuildTaskData()
    end
    return self.mBuildTaskData[taskId]
end

-- 判断当前是否存在可领取任务，任务界面一键领取按钮和红点会使用该结果
function checkTaskAwardCanReceive(self)
    for i = 1, #self.mTaskList, 1  do
        if self.mTaskList[i].state == 0 then
            return true
        end
    end
    return false
end

-- 解析可生成方块图标配置，缓存图标路径、尺寸和分数信息
function parseBuildItemData(self)
    self.mBuildItemData = {}
    local baseData = RefMgr:getData("build_icon_data")
    for key, value in pairs(baseData) do
        local buildItemVo = LuaPoolMgr:poolGet(build.BuildItemDataVo)
        buildItemVo:parseData(key, value)
        self.mBuildItemData[key] = buildItemVo
    end
end

function getBuildItemData(self, buildId)
    if self.mBuildItemData == nil then
        self:parseBuildItemData()
    end
    return self.mBuildItemData[buildId]
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
        local isNewOpen = not StorageUtil:getBool1(gstor.BUILD_DUPNEWOPENSTR.. dup_id)

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
    local baseData = RefMgr:getData("build_reward_data")
    for key, data in pairs(baseData) do
        local baseVo = build.BuildStarRwardConfigVo.new()
        baseVo:parseCogfigData(key, data)
        self.m_StarRewardConfigVoDic[key] = baseVo
    end
end


-- 模块总红点入口，任意区域新开放关卡或任务可领取时返回 true
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

-- 判断任务列表中是否存在可领取任务红点
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
