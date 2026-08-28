-------------------------------------------------------------------------------
-- 任务界面 - 日常面板
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2023-02-20 01:57:11
-------------------------------------------------------------------------------

---@type TaskComponent
local taskComponent = GameUtils.GetOrAddEntityCompByType(ECSComponentType.Constants.TaskComponent)

local TaskCellNodeLuaPath = "Game.UI.Tasks.UITaskDailyTaskCell"
local TaskCellNodeLuaName = "DailyTaskCellNode"

local BxoCellNodeLuaPath  = "Game.UI.Tasks.UITaskDailyTaskBoxCell"
local BoxCellNodeLuaName  = "DailyTaskBoxCellNode"

local FilterTypes = {
    ALL  = 0,  -- 全部的
    DRAW = 1,  -- 可领取
    WORK = 2,  -- 执行中
    LOCK = 3,  -- 锁定中
    DONE = 4,  -- 已完成
}

--- from: Assets/BundleResources/Prefabs/OverseaTasks/OverseaTasksDailyTasksPanel.prefab > name: OverseaTasksDailyTasksPanel
---@class UITaskDailyPanel
---@field Env                           	UITaskDailyPanel                        
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field BoxUpgradeUIFX                	UnityEngine.RectTransform               	@ 0    宝箱升级特效节点
---@field MoveBoomDoneUIFX              	UnityEngine.RectTransform               	@ 1    活跃点停止特效节点
---@field BoxRewardNode                 	UnityEngine.RectTransform               	@ 2    宝箱奖励节点
---@field BoxRewardContainer            	UnityEngine.RectTransform               	@ 3    宝箱奖励容器
---@field BoxPointSlider                	UnityEngine.UI.Slider                   	@ 4    活跃点进度条
---@field BoxPointTxt                   	UnityEngine.RectTransform               	@ 5    当前活跃点文本
---@field TaskEmptyNode                 	UnityEngine.RectTransform               	@ 6    空列表状态节点
---@field FontStyleButton               	UnityEngine.RectTransform               	@ 7    一键领取按钮
---@field CommonFilterNode              	UnityEngine.RectTransform               	@ 8    类型过滤按钮
---@field TaskListView                  	SuperScrollView.LoopListView2           	@ 9    日常任务列表
---@field TaskRefreshTxt                	UnityEngine.RectTransform               	@ 10   刷新时间文本
local UITaskDailyPanel = Class('UITaskDailyPanel')


function UITaskDailyPanel:__init()
    ---@type Engine.Modules.CDTimerModule @ 刷新倒计时的计时器
    self.taskRefreshTimer_ = nil

    ---@type table<string, DailyTaskVo> @ 全部任务配表缓存（key：任务id，value：任务vo）
    self.allDailyTaskVoMap_ = {}

    ---@type table<string, table> @ 任务分组数据（key：分组id，value：分组数据）
    self.taskGroupDataMap_ = {}

    ---@type table[] @ 当前过滤后的任务数据
    self.filterTaskDataList_ = {}

    ---@type table[] @ 奖励宝箱数据列表
    self.rewardsBoxDataList_ = {}

    ---@type UICommonFilterMB @ 任务类型筛选控制器
    self.taskTypeFilterEnv_ = nil

    ---@type table<string, boolean> @ 单元可领取的动画map（key：任务id，是否已经播过动画）
    self.cellCanDrawAnimMap_ = {}

    ---@type integer @ 之前的宝箱积分
    self.oldDailyTaskPoint_ = nil

    ---@type number 0 之前的积分进度
    self.oldPointProgress_ = nil
end


function UITaskDailyPanel:__delete()
    self.taskRefreshTimer_   = nil
    self.allDailyTaskVoMap_  = nil
    self.taskGroupDataMap_   = nil
    self.filterTaskDataList_ = nil
    self.rewardsBoxDataList_ = nil
    self.taskTypeFilterEnv_  = nil
    self.cellCanDrawAnimMap_ = nil
    self.oldDailyTaskPoint_  = nil
    self.oldPointProgress_   = nil
end


function UITaskDailyPanel:OnInit()
    -- parse dailyTask struct
    ---@type DailyTaskVo[]
    local allDailyTaskVo = CfUtils.GetWholeVo(AutoIds.IdSetting254, "DailyTaskVo")
    for _, dailyTaskVo in ipairs(allDailyTaskVo) do
        local taskId  = checkInt(dailyTaskVo.taskId)
        local groupId = checkInt(dailyTaskVo.taskGroup)
        if not self.taskGroupDataMap_[tostring(groupId)] then
            self.taskGroupDataMap_[tostring(groupId)] = {
                idList   = {},     -- 该系列任务 id列表
                chains   = {},     -- 任务链表结构
                minId    = 0,      -- 起始任务id
                maxId    = 0,      -- 结束任务id
                isDrawn  = false,  -- 该系列任务 是否领取
                showData = nil,    -- 该系列任务 显示的任务
                lockData = nil,    -- 该系列任务 待解锁的任务
            }
        end
        table.insert(self.taskGroupDataMap_[tostring(groupId)].idList, taskId)
        self.allDailyTaskVoMap_[tostring(taskId)] = dailyTaskVo
    end

    -- Init dailyTask chains
    for _, groupData in pairs(self.taskGroupDataMap_) do
        local chains = groupData.chains
        for _, taskId in ipairs(groupData.idList) do
            local taskVo = self.allDailyTaskVoMap_[tostring(taskId)]
            local prevId = checkInt(taskVo.before)
            chains[tostring(taskId)] = chains[tostring(taskId)] or {taskId = taskId, nextId = 0}
            chains[tostring(taskId)].prevId = checkInt(taskVo.before)
            if prevId == 0 then
                groupData.minId = taskId
            else
                chains[tostring(prevId)] = chains[tostring(prevId)] or {taskId = prevId}
                chains[tostring(prevId)].nextId = taskId
            end
        end
        for _, chain in pairs(chains) do
            if chain.nextId == 0 then
                groupData.maxId = chain.taskId
                break
            end
        end
    end
end


function UITaskDailyPanel:Start()
    -- init data
    self:OnInit()

    -- init views
    if GameUtils.isZmFunction() then
        CfUtils.FillText(self.TaskRefreshTxt, localize("每日5：00_zone_刷新", {_zone_ = GameUtils.GetUTCTimeZoneText()}))
    else
        CfUtils.FillText(self.TaskRefreshTxt, localize("每日5：00刷新"))
    end

    -- init type filter
    if self.CommonFilterNode then
        self.taskTypeFilterEnv_ = CfUtils.GetLuaScr(self.CommonFilterNode, "Game.Behaviours.UICommonFilterMB")
        self.taskTypeFilterEnv_:SetPageType(Constants.UIFilterPageType.PullUP)
        self.taskTypeFilterEnv_:InitSortTypeData({
            {conditionType = FilterTypes.ALL,  typeDesc = localize('全部')},
            {conditionType = FilterTypes.DRAW, typeDesc = localize('可领取')},
            {conditionType = FilterTypes.WORK, typeDesc = localize('未完成')},
            {conditionType = FilterTypes.LOCK, typeDesc = localize('可解锁')},
            {conditionType = FilterTypes.DONE, typeDesc = localize('已完成')},
        })
        self.taskTypeFilterEnv_:SetCallback({}, function()
            local selectIndex  = self.taskTypeFilterEnv_.selectIndex
            local sortTypeData = self.taskTypeFilterEnv_.sortTypeList[selectIndex]
            self:SetFilterType(sortTypeData.conditionType)
        end)
        self.taskTypeFilterEnv_:SetStyleType(2) -- 1：黑色，2：白色
        -- self.taskTypeFilterEnv_.selectIndex = 0  -- 设置后，首次点第一项也能响应了
    end

    if self.FontStyleButton then
        SetButtonAction(self.FontStyleButton, Bind(self, self.OnClickBatchDrawHandler_))
    end

    SetListViewAction(self.TaskListView, Bind(self, self.OnUpdateTaskListCellHandler_), TaskCellNodeLuaName)

    self.eventEveryThingChangeCb_ = Events.AddListener(Constants.EventNames.EveryThingChangeEventName, Bind(self, self.OnEveryThingChangeHandler_))
end


function UITaskDailyPanel:OnDestroy()
    Events.RemoveListener(Constants.EventNames.EveryThingChangeEventName, self.eventEveryThingChangeCb_)
    self:StopRefreshCountdown_()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


-------------------------------------------------
-- get / set

---@return integer @see FilterTypes
function UITaskDailyPanel:GetFilterType()
    return checkInt(self.filterType_)
end
function UITaskDailyPanel:SetFilterType(type)
    self.filterType_ = checkInt(type)
    self:UpdateFilterType_()
end


---@return fun():void
function UITaskDailyPanel:GetRedPointChangeCB()
    return self.redPointChangeCB_
end
function UITaskDailyPanel:SetRedPointChangeCB(callback)
    self.redPointChangeCB_ = callback
end


-------------------------------------------------
-- public

function UITaskDailyPanel:RefreshAll()
    CfUtils.SetActive(self.BoxUpgradeUIFX, false)
    CfUtils.SetActive(self.MoveBoomDoneUIFX, false)

    self:StartRefreshCountdown_()

    self:UpdateTaskGroupData_()  -- task data / task list

    self:UpdateTaskBoxData_()  -- box data / box list

    self:UpdateTaskBoxPoint_()  -- box progress

    self:SetFilterType(self:GetFilterType())

    self:UpdateRedPoint()  -- mast last call
end


function UITaskDailyPanel:UpdateRedPoint()
    local isOpenRedPoint1 = self:CheckTaskHasReward_()
    local isOpenRedPoint2 = self:CheckRewardBoxHasReward_()

    -- 更新成就红点值
    GameUtils.SetRedPointNum(Constants.RedPointConst.DailyTask, isOpenRedPoint1 and 1 or 0)
    GameUtils.SetRedPointNum(Constants.RedPointConst.DailyTaskBox, isOpenRedPoint2 and 1 or 0)

    -- do callback
    if self:GetRedPointChangeCB() then
        self:GetRedPointChangeCB()()
    end
end


-------------------------------------------------
-- private

function UITaskDailyPanel:StopRefreshCountdown_()
    if not isNull(self.taskRefreshTimer_) then
        CfUtils.CDTimerRemove(self.taskRefreshTimer_)
        self.taskRefreshTimer_ = nil
    end
end


function UITaskDailyPanel:StartRefreshCountdown_()
    self:StopRefreshCountdown_()

    local countdownTimeNum = math.max(checkInt(taskComponent.dailyTaskTimeLeft), 1)
    self.taskRefreshTimer_ = CfUtils.CDTimerAppend(1, countdownTimeNum, true, true, function(count)
        if count == 0 then
            taskComponent:SyncDailyTaskData(function()
                self:RefreshAll()
            end)
        end
    end)
end


function UITaskDailyPanel:UpdateTaskGroupData_()
    -- check drawn group
    for taskId, taskData in pairs(taskComponent.dailyTaskDataMap) do
        if taskComponent:IsDrawnDailyTask(taskId) then
            local taskVo      = checkTable(self.allDailyTaskVoMap_[tostring(taskId)])
            local groupId     = checkInt(taskVo.taskGroup)
            local groupData   = checkTable(self.taskGroupDataMap_[tostring(groupId)])
            groupData.isDrawn = true
        end
    end

    -------------------------------------------------
    -- each group : latest taskId
    local latestGroupMap = {}
    for groupId, groupData in pairs(self.taskGroupDataMap_) do
        local eachIdMap  = {}
        local eachTaskId = checkInt(groupData.maxId)
        while eachTaskId > 0 and eachIdMap[tostring(eachTaskId)] == nil do
            local taskId   = eachTaskId
            local taskVo   = checkTable(self.allDailyTaskVoMap_[tostring(taskId)])
            local taskData = taskComponent:GetDailyTaskData(taskId)
            local isUnlock = GameUtils.IsUnlocked(taskVo.unlockId, taskVo.unlockValue)
            -- cache each taskId
            eachIdMap[tostring(taskId)] = true
            -- is first && unlock / tasking
            if (checkInt(taskVo.before) == 0 and isUnlock) or next(taskData) ~= nil then
                break
            else
                -- to each prev
                local chain = checkTable(groupData.chains[tostring(taskId)])
                eachTaskId  = checkInt(chain.prevId)
            end
        end
        if eachTaskId > 0 then
            latestGroupMap[tostring(groupId)] = eachTaskId
        end
    end

    -------------------------------------------------
    -- fill data : showTask / lockTask
    for groupId, groupData in pairs(self.taskGroupDataMap_) do

        -- init show data
        local showTaskId = checkInt(latestGroupMap[tostring(groupId)])
        if showTaskId > 0 then
            local taskId     = showTaskId
            local taskVo     = self.allDailyTaskVoMap_[tostring(taskId)]
            local taskData   = taskComponent:GetDailyTaskData(taskId) or {}
            local isDrawn    = groupData.isDrawn == true
            local targetNum  = checkInt(taskVo.taskContent)
            local currentNum = isDrawn and targetNum or checkInt(taskData.progress)
            local isCanDraw  = not isDrawn and currentNum >= targetNum
            groupData.showData = {
                groupId   = groupId,
                taskId    = taskId,
                taskVo    = taskVo,
                taskData  = taskData,
                progress  = checkInt(taskData.progress) / targetNum,
                isDrawn   = isDrawn,
                isWorking = not isDrawn and not isCanDraw,
                isCanDraw = isCanDraw,
                isLocked  = false,
            }
        else
            groupData.showData = nil
        end

        -- init lockData
        local taskChain  = showTaskId > 0 and checkTable(groupData.chains[tostring(showTaskId)]) or nil
        local lockTaskId = taskChain and checkInt(taskChain.nextId) or checkInt(groupData.minId)
        if lockTaskId > 0 then
            local taskId = lockTaskId
            local taskVo = self.allDailyTaskVoMap_[tostring(taskId)]
            groupData.lockData = {
                groupId   = groupId,
                taskId    = taskId,
                taskVo    = taskVo,
                taskData  = {},
                progress  = 0,
                isWorking = false,
                isDrawn   = false,
                isCanDraw = false,
                isLocked  = true,
            }
        else
            groupData.lockData = nil
        end
    end
end


function UITaskDailyPanel:UpdateFilterType_()
    self.filterTaskDataList_ = {}

    local filterType = self:GetFilterType()
    for groupId, groupData in pairs(self.taskGroupDataMap_) do
        if filterType == FilterTypes.ALL then
            table.insert(self.filterTaskDataList_, groupData.showData)
            table.insert(self.filterTaskDataList_, groupData.lockData)
        elseif filterType == FilterTypes.WORK then
            if groupData.showData and groupData.showData.isWorking then
                table.insert(self.filterTaskDataList_, groupData.showData)
            end
        elseif filterType == FilterTypes.DRAW then
            if groupData.showData and groupData.showData.isCanDraw then
                table.insert(self.filterTaskDataList_, groupData.showData)
            end
        elseif filterType == FilterTypes.LOCK then
            table.insert(self.filterTaskDataList_, groupData.lockData)
        elseif filterType == FilterTypes.DONE then
            if groupData.isDrawn then
                table.insert(self.filterTaskDataList_, groupData.showData)
            end
        end
    end

    -- 显示排序：可领取 > 进行中 > 待解锁 > 已领取 > taskId
    table.sort(self.filterTaskDataList_, function(aTaskData, bTaskData)
        local aTaskPriority = 0
        local bTaskPriority = 0
        aTaskPriority = aTaskPriority + (aTaskData.isCanDraw and 1000 or 0)
        bTaskPriority = bTaskPriority + (bTaskData.isCanDraw and 1000 or 0)
        aTaskPriority = aTaskPriority + (aTaskData.isWorking and 100 or 0)
        bTaskPriority = bTaskPriority + (bTaskData.isWorking and 100 or 0)

        if aTaskData.progress ~= bTaskData.progress then
            if aTaskData.progress > bTaskData.progress then
                aTaskPriority = aTaskPriority + 50
            else
                bTaskPriority = bTaskPriority + 50
            end
        end

        aTaskPriority = aTaskPriority + (aTaskData.isLocked and 10 or 0)
        bTaskPriority = bTaskPriority + (bTaskData.isLocked and 10 or 0)
        aTaskPriority = aTaskPriority + (aTaskData.isDrawn and 1 or 0)
        bTaskPriority = bTaskPriority + (bTaskData.isDrawn and 1 or 0)
        if aTaskPriority == bTaskPriority then
            return aTaskData.taskId < bTaskData.taskId
        else
            return aTaskPriority > bTaskPriority
        end
    end)

    -- update taskList
    self:UpdateTaskList_()
end


function UITaskDailyPanel:UpdateTaskList_()
    local listDataLength = #self.filterTaskDataList_
    CfUtils.SetActive(self.TaskEmptyNode, listDataLength == 0)
    GameUtils.ReloadData(self.TaskListView, listDataLength)

    -- 一键领取按钮：有可领取的奖励时才显示
    -- if self.FontStyleButton then  -- 又要关掉了 by 陈菲
    --     CfUtils.SetActive(self.FontStyleButton, self:CheckTaskHasReward_())
    -- end
end


function UITaskDailyPanel:UpdateTaskBoxData_()
    self.rewardsBoxDataList_ = {}

    for boxId, boxData in pairs(taskComponent.dailyTaskBoxDataMap or {}) do
        table.insert(self.rewardsBoxDataList_, {
            taskBoxId   = checkInt(boxId),
            taskBoxData = boxData,
        })
    end
    table.sort(self.rewardsBoxDataList_, function(aBoxData, bBoxData)
        return aBoxData.taskBoxId < bBoxData.taskBoxId
    end)

    self:UpdateTaskBoxList_()
end


function UITaskDailyPanel:UpdateTaskBoxList_()
    local boxCount = #self.rewardsBoxDataList_
    local boxSpace = self.BoxRewardContainer.rect.size.x / boxCount
    local boxPosY  = -(self.BoxRewardContainer.sizeDelta.y / 2)

    ---@param luaIndex integer
    ---@param childNode UnityEngine.RectTransform
    GameUtils.ResizeContent(self.BoxRewardContainer, self.BoxRewardNode, boxCount, function(luaIndex, childNode)
        childNode.name = BoxCellNodeLuaName .. luaIndex
        childNode.anchoredPosition = Vector2.New(boxSpace * luaIndex, boxPosY)
        
        local cellData = checkTable(self.rewardsBoxDataList_[luaIndex])
        ---@type UITaskDailyTaskBoxCell
        local nodeEnv = CfUtils.GetLuaScr(childNode, BxoCellNodeLuaPath)
        if not isNull(nodeEnv) then
            -- init cell
            nodeEnv:SetLuaIndex(luaIndex)
            nodeEnv:SetCellData(cellData)
            nodeEnv:SetClickCellCB(Bind(self, self.OnClickTaskBoxListCellCallback))
        end
    end)
end


function UITaskDailyPanel:UpdateTaskBoxPoint_()
    local pointTweenTime = 0.5

    -- update pointTxt
    local boxPointNow  = checkInt(taskComponent.dailyTaskPointNow)
    local boxPointMax  = checkInt(taskComponent.dailyTaskPointMax)
    local setPointFunc = function(pointNum)
        CfUtils.FillText(self.BoxPointTxt, string.fmt('<size=58><color=#FFFFFF>%1</color></size>/%2', pointNum, boxPointMax))
    end
    if self.oldDailyTaskPoint_ == nil then
        setPointFunc(boxPointNow)
        self.oldDailyTaskPoint_ = boxPointNow
    else
        local pointTweenValue = boxPointNow - self.oldDailyTaskPoint_
        CfUtils.DoTween(pointTweenTime, 
            function(updatePercent)
                local targetPoint = self.oldDailyTaskPoint_ + math.ceil(pointTweenValue * updatePercent)
                setPointFunc(targetPoint)
            end, 
            function()
                setPointFunc(boxPointNow)
                self.oldDailyTaskPoint_ = boxPointNow
            end
        )
    end
    
    -- update pointSlider
    local pointProgress = 1
    local pointPercent  = 1 / #self.rewardsBoxDataList_
    for boxIndex, boxData in ipairs(self.rewardsBoxDataList_) do
        local targetPoint = boxData.taskBoxData.boxVo.unlockPoint
        if boxPointNow < targetPoint then
            local prevBoxData  = boxIndex > 1 and self.rewardsBoxDataList_[boxIndex - 1] or nil
            local prevBoxPoint = prevBoxData and prevBoxData.taskBoxData.boxVo.unlockPoint or 0
            pointProgress = ((boxIndex - 1) + (boxPointNow - prevBoxPoint) / (targetPoint - prevBoxPoint)) * pointPercent
            break
        end
    end
    if self.oldPointProgress_ == nil then
        CfUtils.SetSliderPercent(self.BoxPointSlider, pointProgress)
        self.oldPointProgress_ = pointProgress
    else
        local progressTweenValue = pointProgress - self.oldPointProgress_
        CfUtils.DoTween(pointTweenTime, 
            function(updatePercent)
                local targeProgress = self.oldPointProgress_ + (progressTweenValue * updatePercent)
                CfUtils.SetSliderPercent(self.BoxPointSlider, targeProgress)
            end, 
            function()
                CfUtils.SetSliderPercent(self.BoxPointSlider, pointProgress)
                self.oldPointProgress_ = pointProgress
            end
        )
    end
end


--- 是否 拥有未领取的任务奖励
---@return boolean
function UITaskDailyPanel:CheckTaskHasReward_()
    local hasReward = false
    for _, groupData in pairs(self.taskGroupDataMap_) do
        if groupData.showData and groupData.showData.isCanDraw then
            hasReward = true
            break
        end
    end
    return hasReward
end


--- 是否 拥有未领取的宝箱奖励
---@return boolean
function UITaskDailyPanel:CheckRewardBoxHasReward_()
    local hasReward = false
    for _, rewardsBoxData in ipairs(self.rewardsBoxDataList_) do
        if rewardsBoxData.taskBoxData.status == Constants.GetStatus.Can then
            hasReward = true
            break
        end
    end
    return hasReward
end


---@param responseData table
---@param drawGroupId integer | nil
function UITaskDailyPanel:DoDrawTaskRewards_(responseData, drawGroupId)
    local drawnGroupIdList = {}

    if drawGroupId then
        drawnGroupIdList = { checkInt(drawGroupId) }
    else
        for groupId, groupData in pairs(self.taskGroupDataMap_) do
            if groupData.showData and groupData.showData.isCanDraw then
                table.insert(drawnGroupIdList, checkInt(groupId))
            end
        end
    end
    
    -- draw rewards
    -- local rewardList = checkTable(responseData.rewards)
    -- GoodsUtils.DrawRewards(rewardList)
    -- CfUtils.DialogOpen(Constants.UITypeIds.UICommonRewardPop, {rewards = rewardList})
    
    local oldCanRewardNum = 0
    local newCanRewardNum = 0
    for _, rewardsBoxData in ipairs(self.rewardsBoxDataList_) do
        if rewardsBoxData.taskBoxData.status == Constants.GetStatus.Can then
            oldCanRewardNum = oldCanRewardNum + 1
        end
    end
    -- update cache point
    taskComponent:UpdateDailyTaskBoxProgress(responseData.point)
    for _, rewardsBoxData in ipairs(self.rewardsBoxDataList_) do
        if rewardsBoxData.taskBoxData.status == Constants.GetStatus.Can then
            newCanRewardNum = newCanRewardNum + 1
        end
    end
    local isNewCanRewardNum = newCanRewardNum > oldCanRewardNum

    -- refresh cache data
    local drawnTaskIdMap = {}
    for _, groupId in pairs(drawnGroupIdList) do
        -- update groupData
        local groupData = checkTable(self.taskGroupDataMap_[tostring(groupId)])
        groupData.isDrawn = true  -- 系列标记为完成
        -- update showData
        local showData = checkTable(groupData.showData)
        showData.isDrawn   = true  -- 该任务标记为完成
        showData.isCanDraw = false -- 更新为不可再领取
        showData.isWorking = false -- 更新为非未完成
        -- update taskComponent cache
        taskComponent:SetDrawnDailyTask(showData.taskId)
        drawnTaskIdMap[tostring(showData.taskId)] = true
    end

    -- refresh cell node
    local isRefreshView = false
    CfUtils.SetActive(self.BoxUpgradeUIFX, false)
    CfUtils.SetActive(self.MoveBoomDoneUIFX, false)

    ---@type UITaskDailyTaskCell
    CfUtils.ListViewEachItem(self.TaskListView, TaskCellNodeLuaPath, function(nodeEnv)
        local cellData = nodeEnv:GetCellData()
        local taskId   = checkInt(cellData.taskId)
        if drawnTaskIdMap[tostring(taskId)] then
            nodeEnv:SetCellData(cellData)
            nodeEnv:PlayRewardsAnim(self.MoveBoomDoneUIFX, function()
                if not isRefreshView then
                    self:UpdateTaskBoxList_()
                    self:UpdateTaskBoxPoint_()
                    CfUtils.SetActive(self.BoxUpgradeUIFX, true)
                    CfUtils.SetActive(self.MoveBoomDoneUIFX, isNewCanRewardNum)
                    isRefreshView = true
                end
            end)
        end
    end)
    -- 要领取完立刻沉下去
    -- self:UpdateFilterType_()

    -- update red point
    self:UpdateRedPoint()
end


-------------------------------------------------
-- handler

function UITaskDailyPanel:OnClickBatchDrawHandler_()
    if not self:CheckTaskHasReward_() then
        GameUtils.Toast(localize('没有可领取的奖励'))
        return
    end

    GameUtils.Request(Interfaces.OverseaDailyDraw, {}, function(request, response)
        if checkInt(response.errCode) == 0 then
            self:DoDrawTaskRewards_(response.data)
        end
    end)
end


---@param listView SuperScrollView.LoopListView2
---@param luaIndex integer @ start at 1
---@return SuperScrollView.LoopListViewItem2
function UITaskDailyPanel:OnUpdateTaskListCellHandler_(listView, luaIndex)
    local cellNode = listView:NewListViewItem(TaskCellNodeLuaName)
    local cellData = checkTable(self.filterTaskDataList_[luaIndex])
    ---@type UITaskDailyTaskCell
    local nodeEnv = CfUtils.GetLuaScr(cellNode.gameObject, TaskCellNodeLuaPath)
    if not isNull(nodeEnv) then
        -- init cell
        nodeEnv:SetLuaIndex(luaIndex)
        nodeEnv:SetCellData(cellData, function()
            -- enter anime
            ---@type DailyTaskVo
            local taskVo    = checkTable(cellData.taskVo)
            local isCanDraw = cellData.isCanDraw == true
            if isCanDraw then
                if not self.cellCanDrawAnimMap_[tostring(taskVo.taskId)] then
                    nodeEnv:PlayCompleteAnim()
                    self.cellCanDrawAnimMap_[tostring(taskVo.taskId)] = true
                else
                    nodeEnv:ResetCompleteAnim()
                end
            end
        end)
        nodeEnv:SetClickReceiveCB(Bind(self, self.OnClickTaskListReceiveButtonCallback_))
        nodeEnv:SetClickJumpToCB(Bind(self, self.OnClickTaskListJumpToButtonCallback_))
    end
    return cellNode
end


---@param luaIndex integer @ start at 1
function UITaskDailyPanel:OnClickTaskListReceiveButtonCallback_(luaIndex)
    local filterData = checkTable(self.filterTaskDataList_[luaIndex])

    ---@type DailyTaskVo
    local taskVo = checkTable(filterData.taskVo)
    if filterData.isCanDraw then
        GameUtils.Request(Interfaces.OverseaDailyDraw, {id = taskVo.taskId}, function(request, response)
            if checkInt(response.errCode) == 0 then
                self:DoDrawTaskRewards_(response.data, filterData.groupId)
            end
        end)
    end
end


---@param luaIndex integer @ start at 1
function UITaskDailyPanel:OnClickTaskListJumpToButtonCallback_(luaIndex)
    local filterData = checkTable(self.filterTaskDataList_[luaIndex])

    ---@type DailyTaskVo
    local taskVo = checkTable(filterData.taskVo)
    if checkInt(taskVo.openType) > 0 then
        ---@type GoodsConfMgr
        local goodsConfMgr  = GoodsConfMgr:GetInstance()
        local jumpModuleRow = goodsConfMgr:GetJumpModuleRow(taskVo.openType)
        goodsConfMgr:ExecuteJump(jumpModuleRow, {})
    end
end


---@param luaIndex integer @ start at 1
---@param tipsNode UnityEngine.RectTransform
function UITaskDailyPanel:OnClickTaskBoxListCellCallback(luaIndex, tipsNode)
    local cellData = checkTable(self.rewardsBoxDataList_[luaIndex])
    local status   = checkInt(cellData.taskBoxData.status)

    if status == Constants.GetStatus.Has then
        GameUtils.Toast(localize('奖励已领取'))
        return

    elseif status == Constants.GetStatus.Can then
        -- 逻辑为领取全部可领取的
        GameUtils.Request(Interfaces.OverseaDailyBoxDraw, {}, function(request, response)
            if checkInt(response.errCode) == 0 then
                local responseData = checkTable(response.data)

                -- update cache data
                for boxIndex, boxData in ipairs(self.rewardsBoxDataList_) do
                    if checkInt(boxData.taskBoxData.status) == Constants.GetStatus.Can then
                        local boxId = boxData.taskBoxData.boxId
                        taskComponent:SetDrawnDailyTaskBox(boxId)
                    end
                end
                self:UpdateTaskBoxList_()

                --- update rewards
                local rewardList = checkTable(responseData.rewards)
                GoodsUtils.DrawRewards(rewardList)
                CfUtils.DialogOpen(Constants.UITypeIds.UICommonRewardPop, {rewards = rewardList})
                
                -- update red point
                self:UpdateRedPoint()
            end
        end)

    elseif status == Constants.GetStatus.Not then
        -- 显示预览
        ---@type TaskRewardBoxVo
        local boxVo = cellData.taskBoxData.boxVo
        GameUtils.ShowCommonTipsBoardRewardPreview(tipsNode, boxVo.rewards, localize('奖励预览:'), false)
    end
end


---@param goodsId integer
function UITaskDailyPanel:OnEveryThingChangeHandler_(goodsId)
    if checkInt(goodsId) == Constants.Currency.HpId then
        taskComponent:SyncDailyTaskData(function()
            self:RefreshAll()
        end)
    end
end


return UITaskDailyPanel
