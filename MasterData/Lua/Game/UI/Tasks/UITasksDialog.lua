-------------------------------------------------------------------------------
-- UITasksDialog Brief
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2023-02-16 16:50:05
-------------------------------------------------------------------------------

---@type TaskComponent
local taskComponent = GameUtils.GetOrAddEntityCompByType(ECSComponentType.Constants.TaskComponent)
---@type RedPointMgrComponent
local redPointCom = GameUtils.GetEntityCompByType(ECSComponentType.Constants.RedPointMgrComponent)

local UITaskUtils = import('Game.UI.Tasks.UITaskUtils')
local KCookie = CS.Engine.Lib.KCookie


--- lifecycle enable: __init -> Awake -> OnInitialize -> OnFocus(true) -> OnShow
--- lifecycle disable: OnFocus(false) -> OnHide -> OnFinalize -> __delete
--- from: Assets/BundleResources/Prefabs/OverseaTasks/OverseaTasksDialog.prefab
---@class UITasksDialog
---@field Env                           	UITasksDialog                           
---@field controller                    	Engine.UI.UILuaDialog                   
---@field Container                     	UnityEngine.RectTransform               @ 面板的容器节点
---@field LeftTabToggle                 	Engine.Modules.LuaBehaviour             @ 左侧页签控制节点
local UITasksDialog = Class('UITasksDialog')


function UITasksDialog:__init()
    ---@type UnityEngine.Coroutine
    self.tabHandlerCo_ = nil
    ---@type UnityEngine.Coroutine
    self.createNodeCo_ = nil
    ---@type table[]
    self.taskTabDatas_ = nil
    ---@type table<Constants.TaskType, UnityEngine.GameObject>
    self.taskPanelMap_ = {}
    ---@type table<Constants.TaskType, boolean> @ 数据初始状态记录
    self.initStatusMap_ = {}
    ---@type CommonTabToggleLeftExpand
    self.taskTypeTabEnv_ = nil
end


function UITasksDialog:__delete()
    self.tabHandlerCo_   = nil
    self.createNodeCo_   = nil
    self.taskTabDatas_   = nil
    self.taskPanelMap_   = nil
    self.taskTypeTabEnv_ = nil
    self.initStatusMap_  = nil
end


function UITasksDialog:OnInit()
    self.taskTypeTabEnv_ = CfUtils.GetLuaScr(self.LeftTabToggle, Constants.UILuaTablePath.ComTabExpand)
end


function UITasksDialog:OnInitialize()
    return CoWaitDo(function()
        self:OnInit()
        self:IniViewStatus_()
    end)
end


function UITasksDialog:OnFinalize()
    return CoWaitDo(function()
        if self.tabHandlerCo_ then
            CoStop(self.tabHandlerCo_)
            self.tabHandlerCo_ = nil
        end
        if self.createNodeCo_ then
            CoStop(self.createNodeCo_)
            self.createNodeCo_ = nil
        end
        self.controller = nil --删除lua层引⽤用到的c#对象
        self:Delete()
    end)
end


-------------------------------------------------
-- get / set

---@return table[]
function UITasksDialog:GetTaskTabDatas()
    return checkTable(self.taskTabDatas_)
end


---@return Constants.TaskType
function UITasksDialog:GetSelectTaskType()
    return checkInt(self.selectType_)
end
function UITasksDialog:SetSelectTaskType(taskType)
    self.selectType_ = taskType
    self:UpdateSelectTaskType_()
end


---@return boolean
function UITasksDialog:IsInitedTaskData(taskType)
    return self.initStatusMap_[taskType] == true
end
function UITasksDialog:SetInitedTaskData(taskType)
    self.initStatusMap_[taskType] = true
end


-------------------------------------------------
-- private

function UITasksDialog:IniViewStatus_()
    self.taskTabDatas_ = {
        {
            name        = localize('每日任务'),
            bgPath      = 'Arts/Icons/HomeLabel/tab_ico_daily.png',
            prefabe     = 'Prefabs/OverseaTasks/OverseaTasksDailyTasksPanel.prefab',
            srcPath     = 'Game.UI.Tasks.UITaskDailyPanel',
            lock        = not taskComponent:IsUnlockedDailyTask(),
            lockToast   = taskComponent:GetUnlockDailyTaskDescr(),
            taskType    = Constants.TaskType.DailyTask,
            func        = Bind(self, self.OnClickTaskTabHandler_),
            redPointFun = function(data)
                local redPoint1 = redPointCom:GetNodeNum(Constants.RedPointConst.DailyTask)
                local redPoint2 = redPointCom:GetNodeNum(Constants.RedPointConst.DailyTaskBox)
                return checkInt(redPoint1) > 0 or checkInt(redPoint2) > 0
            end,
        },
        --{
        --    name        = localize('成长任务'),
        --    bgPath      = 'Arts/Icons/HomeLabel/tab_ico_overview.png', -- 左侧面板条目 头部的 圆形小图标
        --    prefabe     = 'Prefabs/OverseaTasks/OverseaGrowUpTasksDialog.prefab',
        --    srcPath     = 'Game.UI.Tasks.UITaskGrowUpPanel',
        --    lock        = not taskComponent:IsUnlockedGrowUpTask(),
        --    lockToast   = taskComponent:GetUnlockGrowUpTaskDescr(),
        --    taskType    = Constants.TaskType.GrowUpTask,
        --    func        = Bind(self, self.OnClickTaskTabHandler_),
        --    redPointFun = function(data)
        --        local redPoint1 = redPointCom:GetNodeNum(Constants.RedPointConst.GrowUpTask)
        --        local redPoint2 = redPointCom:GetNodeNum(Constants.RedPointConst.GrowUpTaskBox)
        --        return checkInt(redPoint1) > 0 or checkInt(redPoint2) > 0
        --    end,
        --},
        {
            name        = localize('调查任务'),
            bgPath      = 'Arts/Icons/HomeLabel/tab_ico_honor.png',
            prefabe     = 'Prefabs/OverseaTasks/OverseaInvestigationTasksDialog.prefab',
            srcPath     = 'Game.UI.Tasks.UITaskInvestigationPanel',
            lock        = not taskComponent:IsUnlockedInvestigationTask(),
            lockToast   = taskComponent:GetUnlockInvestigationTaskDescr(),
            taskType    = Constants.TaskType.InvestigationTask,
            func        = Bind(self, self.OnClickTaskTabHandler_),
            redPointFun = function(data)
                local redPoint1 = redPointCom:GetNodeNum(Constants.RedPointConst.InvestigationTask)
                return checkInt(redPoint1) > 0
            end,
        },
        {
            name        = localize('荣誉任务'),
            bgPath      = 'Arts/Icons/HomeLabel/tab_ico_honor.png',
            prefabe     = 'Prefabs/OverseaTasks/OverseaTasksAchievementTasksPanel.prefab',
            srcPath     = 'Game.UI.Tasks.UITaskAchievementPanel',
            lock        = not taskComponent:IsUnlockedAchievementTask(),
            lockToast   = taskComponent:GetUnlockAchievementTaskDescr(),
            taskType    = Constants.TaskType.AchievementsTask,
            func        = Bind(self, self.OnClickTaskTabHandler_),
            redPointFun = function(data)
                local redPoint1 = redPointCom:GetNodeNum(Constants.RedPointConst.AchievementTask)
                local redPoint2 = redPointCom:GetNodeNum(Constants.RedPointConst.AchievementTaskBox)
                return checkInt(redPoint1) > 0 or checkInt(redPoint2) > 0
            end,
        },
    }

    ---@type AchievementTagVo[]
    local achievementTagVoList = CfUtils.GetWholeVo(AutoIds.IdSetting253, "AchievementTagVo")
    local achievementTagsData  = {}
    for voIndex, achievementTagVo in ipairs(achievementTagVoList) do
        achievementTagsData[voIndex] = {
            name    = achievementTagVo.name,
            sort    = achievementTagVo.sort,
            tagType = achievementTagVo.reputationType,
            tagVo   = achievementTagVo,
            func    = Bind(self, self.OnClickTaskSubTabHandler_, Constants.TaskType.AchievementsTask),
        }
    end
    table.sort(achievementTagsData, function(aData, bData)
        return aData.sort < bData.sort
    end)

    local defaultIndex = 0
    -- 如果外部指定了 返回任务界面 时指向的 页签, 沿用它
    local typeIndexFromOutside = checkInt(KCookie.Get( "Task.TypeIndexFromOutside" ))
    if typeIndexFromOutside > 0 then 
        defaultIndex = typeIndexFromOutside
        KCookie.Set("Task.TypeIndexFromOutside", UITaskUtils.TaskTypeIndexFromOutside.None)
    end 

    ---
    local childrenData = {}
    for toggleIndex, toggleData in ipairs(self.taskTabDatas_) do

        -- children data
        if toggleData.taskType == Constants.TaskType.AchievementsTask then
            childrenData[toggleIndex] = achievementTagsData
        else
            childrenData[toggleIndex] = {}
        end

        -- default index
        if defaultIndex == 0 and not toggleData.lock then
            defaultIndex = toggleIndex
        end
    end
    
    if defaultIndex > 0 then
        self.taskTypeTabEnv_:Refresh(self.taskTabDatas_, childrenData, defaultIndex, 1)
    else
        self:SetSelectTaskType(defaultIndex)
    end
end


function UITasksDialog:UpdateTaskTypePanel_(taskTabData)
    local oldSelectTaskType = self:GetSelectTaskType() -- 数字: 1,2,3
    local newSelectTaskType = checkInt(taskTabData.taskType)
    if oldSelectTaskType == newSelectTaskType then
        return
    end
    
    local oldPanelData = self.taskPanelMap_[oldSelectTaskType]
    local newPanelData = self.taskPanelMap_[newSelectTaskType]

    -- hide old panel
    if isNotNull(oldPanelData) then
        CfUtils.SetCanvasEnabled(oldPanelData.go, false)
    end
    
    if isNull(newPanelData) then
        -- create new panel
        self:CreateTaskTypePanel_(taskTabData)
    else
        -- update new panel
        self:SetSelectTaskType(newSelectTaskType)

        -- show new panel
        CfUtils.SetCanvasEnabled(newPanelData.go, true)
    end
end


function UITasksDialog:CreateTaskTypePanel_(taskTabData)
    self.createNodeCo_ = CoStart(function()
        local createType  = checkInt(taskTabData.taskType)
        local prefabePath = taskTabData.prefabe
        local luaEnvPath  = taskTabData.srcPath
        if not prefabePath then return end

        local panelNodeGo  = GameUtils.LoadBundleAsync(prefabePath, self.Container.gameObject, false)
        local panelNodeEnv = CfUtils.GetLuaScr(panelNodeGo, luaEnvPath)
        self.taskPanelMap_[createType] = {go = panelNodeGo, src = panelNodeEnv}

        panelNodeEnv:SetRedPointChangeCB(function()
            self.taskTypeTabEnv_:RedPointRefresh()
        end)

        self:SetSelectTaskType(createType)
        self.createNodeCo_ = nil
    end)
end


function UITasksDialog:UpdateSelectTaskType_()
    local currentTaskType  = self:GetSelectTaskType()
    local currentPanelData = self.taskPanelMap_[currentTaskType]
    local currentPanelLua  = currentPanelData.src

    -------------------------------------------------
    -- 刷新 日常任务
    if currentTaskType == Constants.TaskType.DailyTask then
        if taskComponent:IsUnlockedDailyTask() then
            if self:IsInitedTaskData(Constants.TaskType.DailyTask) then
                currentPanelLua:RefreshAll()
            else
                taskComponent:SyncDailyTaskData(function()
                    self:SetInitedTaskData(Constants.TaskType.DailyTask)
                    self:UpdateSelectTaskType_()
                end)
            end
        else
            GameUtils.Toast(taskComponent:GetUnlockDailyTaskDescr())
        end

    -------------------------------------------------
    -- 刷新 成就任务
    elseif currentTaskType == Constants.TaskType.AchievementsTask then
        if taskComponent:IsUnlockedAchievementTask() then
            if self:IsInitedTaskData(Constants.TaskType.AchievementsTask) then
                currentPanelLua:RefreshAll()
            else
                taskComponent:SyncAchievementTaskData(function()
                    self:SetInitedTaskData(Constants.TaskType.AchievementsTask)
                    self:UpdateSelectTaskType_()
                end)
            end
        else
            GameUtils.Toast(taskComponent:GetUnlockAchievementTaskDescr())
        end

    -------------------------------------------------
    -- 刷新 成长任务
    elseif currentTaskType == Constants.TaskType.GrowUpTask then

        if taskComponent:IsUnlockedGrowUpTask() then
            if self:IsInitedTaskData(Constants.TaskType.GrowUpTask) then
                -- 已经初始化过了:
                currentPanelLua:RefreshAll()
            else
                -- 第一次初始化:
                currentPanelLua:RefreshAll()
                self:SetInitedTaskData(Constants.TaskType.GrowUpTask)
                --self:UpdateSelectTaskType_()
            end
        else
            GameUtils.Toast(taskComponent:GetUnlockGrowUpTaskDescr()) -- 显示 小黑框文本
        end

    -------------------------------------------------
    -- 刷新 调查任务
    elseif currentTaskType == Constants.TaskType.InvestigationTask then

        if taskComponent:IsUnlockedInvestigationTask() then
            if self:IsInitedTaskData(Constants.TaskType.InvestigationTask) then
                -- 已经初始化过了:
                currentPanelLua:RefreshAll( false )
            else
                -- 第一次初始化:
                currentPanelLua:RefreshAll( true )
                self:SetInitedTaskData(Constants.TaskType.InvestigationTask)
                --self:UpdateSelectTaskType_()
            end
        else
            GameUtils.Toast(taskComponent:GetUnlockInvestigationTaskDescr()) -- 显示 小黑框文本
        end
    end
end


-------------------------------------------------
-- handler

function UITasksDialog:OnClickTaskTabHandler_(taskTabData)
    if self.tabHandlerCo_ then return end  -- 等待协程如果存在，则无视切换操作
    if self.createNodeCo_ then  -- 创建协程如果存在，则创建等待协程
        self.tabHandlerCo_ = CoStart(function()
            while self.createNodeCo_ do
                CoYield()
            end
            self.tabHandlerCo_ = nil
            self:UpdateTaskTypePanel_(taskTabData)
        end)
    else
        self:UpdateTaskTypePanel_(taskTabData)
    end
end


---@param taskType Constants.TaskType
function UITasksDialog:OnClickTaskSubTabHandler_(taskType, taskSubTabData)
    local currentPanelData = self.taskPanelMap_[taskType]
    if currentPanelData then
        local currentPanelLua  = currentPanelData.src
        currentPanelLua:SetSelectType(taskSubTabData.tagType)
    end
end


return UITasksDialog
