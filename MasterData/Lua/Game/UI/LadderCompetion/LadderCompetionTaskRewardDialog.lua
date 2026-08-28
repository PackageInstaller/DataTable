-------------------------------------------------------------------------------
-- 天梯竞技 - 任务界面
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2022-08-10 14:09:35
-------------------------------------------------------------------------------

local TaskCellNodePath = 'Game.UI.LadderCompetion.LadderCompetionTaskRewardCellNode'
local TaskCellNodeName = 'Cell'

local TaskType = {
    Daily  = 1, -- 日常任务
    Season = 2, -- 赛季任务
}

--- lifecycle enable: __init -> Awake -> OnInitialize -> OnFocus(true) -> OnShow
--- lifecycle disable: OnFocus(false) -> OnHide -> OnFinalize -> __delete
--- from: Assets/BundleResources/Prefabs/LadderSrtruggle/LadderStruggleTaskRewardDialog.prefab > name: LadderStruggleTaskRewardDialog
---@class LadderCompetionTaskRewardDialog
---@field Env                           	LadderCompetionTaskRewardDialog         
---@field controller                    	Engine.UI.UILuaDialog                   
---@field BtnClose                      	UnityEngine.RectTransform               	@ 0    
---@field TaskListView                  	SuperScrollView.LoopListView2           	@ 1    
---@field BtnGetAll                     	UnityEngine.RectTransform               	@ 2    
local LadderCompetionTaskRewardDialog = Class('LadderCompetionTaskRewardDialog')


function LadderCompetionTaskRewardDialog:__init()
    ---@type table[]
    self.taskDataList_ = {}
end


function LadderCompetionTaskRewardDialog:__delete()
    self.taskDataList_ = nil
end


function LadderCompetionTaskRewardDialog:Awake()
    SetButtonAction(self.BtnClose, Bind(self, self.OnClickCloseButtonHandler_))
    SetButtonAction(self.ImgBlack, Bind(self, self.OnClickCloseButtonHandler_))
    SetListViewAction(self.TaskListView, Bind(self, self.OnUpdateTaskListCellHandler_), TaskCellNodeName)
    if isNotNull(self.BtnGetAll) then
        SetButtonAction(self.BtnGetAll, Bind(self, self.OnClickGetAll))
    end
end


function LadderCompetionTaskRewardDialog:OnInitialize()
    return CoWaitDo(function()
        CfUtils.SetAddSortingOrder(self.controller, 5)  -- 为了挡住下面的情绪共鸣特效
        -- 这个界面现在实时PVP和异步PVP都在用，初始化的时候设置一下是哪个系统在调用
        local parameters = self.controller.Argument.parameters
        local systemName = parameters.systemName
        if parameters.isCameraState ~= nil then
            self.controller.IsCameraState = parameters.isCameraState
        end

        self:SwitchSystem(systemName)
        self:InitTaskData_()

        self:RequestTaskData_()
    end)
end


function LadderCompetionTaskRewardDialog:OnFinalize()
    return CoWaitDo(function()
        self.controller = nil --删除lua层引⽤用到的c#对象
        self:Delete()
    end)
end


-------------------------------------------------
-- private

function LadderCompetionTaskRewardDialog:InitTaskData_()
    ---@type LadderTaskVo[]
    local taskVoList = CfUtils.GetWholeVo(self.settingId, 'LadderTaskVo')
    for _, taskVo in ipairs(taskVoList) do
        table.insert(self.taskDataList_, {id = taskVo.taskAchId, taskVo = taskVo})
    end
end


function LadderCompetionTaskRewardDialog:RequestTaskData_()
    -- request taskData
    GameUtils.Request(self.taskInterface, {}, function(request, response)
            if checkNumber(response.errCode) == 0 then
    
                --local taskDataMap  = {}
                --local taskDataList = checkTable(response.data)
                --for _, taskData in ipairs(taskDataList.dailyTasks or {}) do
                --    taskDataMap[tostring(taskData.id)] = taskData
                --end
                --for _, taskData in ipairs(taskDataList.seasonTasks or {}) do
                --    taskDataMap[tostring(taskData.id)] = taskData
                --end
                local dataList = checkTable(response.data.taskInfo)
                for i = 1, #dataList do
                    local taskId = dataList[i].id
                    for k,v in ipairs(self.taskDataList_) do
                        if v.id == taskId then
                            v.taskData = dataList[i]
                            break
                        end
                    end
                end
    
                -- sort listData
                self:SortListData()
    
                -- init views
                self:RefreshView_()
            end
        end
    )
end

function LadderCompetionTaskRewardDialog:SortListData()
    table.sort(self.taskDataList_, function(aData, bData)
        local aTaskData = checkTable(aData.taskData)
        local bTaskData = checkTable(bData.taskData)
        local aStatus   = checkInt(aTaskData.status)
        local bStatus   = checkInt(bTaskData.status)
        if aStatus == bStatus then
            --if aData.taskType == bData.taskType then
                -- 类型相同：日常id从小到大
                return aData.taskVo.taskAchId < bData.taskVo.taskAchId
            --else
            --    -- 类型不同：日常任务 -> 赛季任务
            --    return aData.taskType < bData.taskType
            --end
        else
            if aStatus == Constants.GetStatus.Has or bStatus == Constants.GetStatus.Has then
                -- 已领取的：未完成 -> 可领取 -> 已领取
                return aStatus < bStatus
            else
                -- 未领取的：可领取 -> 未完成
                return aStatus > bStatus
            end
        end
    end)
end

function LadderCompetionTaskRewardDialog:RefreshView_()
    self:RefreshTaskList_()
    self:RefreshRedPointState_()
end


function LadderCompetionTaskRewardDialog:RefreshTaskList_()
    GameUtils.ReloadData(self.TaskListView, #self.taskDataList_)
end


function LadderCompetionTaskRewardDialog:RefreshRedPointState_()
    local isOpenRedPoint = false
    local ladderTaskList = checkTable(self.taskDataList_)
    for _, listData in ipairs(ladderTaskList) do
        local taskData = checkTable(listData.taskData)
        if checkInt(taskData.status) == Constants.GetStatus.Can then
            isOpenRedPoint = true
            break
        end
    end
    if self.redPointEventName then
        Events.Broadcast(self.redPointEventName, 1, isOpenRedPoint and 0 or -1)
    end
    if self.redPointStrNode then
        GameUtils.SetRedPointNum(self.redPointStrNode, isOpenRedPoint and 1 or 0)
    end
end


-------------------------------------------------
-- handler

function LadderCompetionTaskRewardDialog:OnClickCloseButtonHandler_()
    self.controller:Close()
end


---@param listView SuperScrollView.LoopListView2
---@param luaIndex integer
---@return SuperScrollView.LoopListViewItem2
function LadderCompetionTaskRewardDialog:OnUpdateTaskListCellHandler_(listView, luaIndex)
    local cellNode = listView:NewListViewItem(TaskCellNodeName)
    local cellData = checkTable(self.taskDataList_[luaIndex])
    ---@type LadderCompetionTaskRewardCellNode
    local cellEnv = CfUtils.GetLuaScr(cellNode, TaskCellNodePath)
    if cellEnv then
        -- init cell
        cellEnv:SetLuaIndex(luaIndex)
        cellEnv:SetCellData(cellData)
        cellEnv:SetClickCB(Bind(self, self.OnClickTaskListCellCallback_))
        -- init anim
        if listView.DisplayItemNumber < listView.DisplayItemCount then
            cellEnv:PlayDelayAnimByShow(listView.DisplayItemNumber)
            listView.DisplayItemNumber = listView.DisplayItemNumber + 1
        else
            cellEnv:PlayAnimByIdle()
        end
    end
    return cellNode
end


function LadderCompetionTaskRewardDialog:OnClickTaskListCellCallback_(luaIndex)
    local cellData = checkTable(self.taskDataList_[luaIndex])
    local taskData = checkTable(cellData.taskData)
    local statusId = checkInt(taskData.status)

    if statusId == Constants.GetStatus.Not then

    elseif statusId == Constants.GetStatus.Can then
        GameUtils.Request(self.taskDrawInterface, { taskId = taskData.id },
            function(request, response)
                if checkNumber(response.errCode) == 0 then
                    -- draw rewards
                    local rewardList = checkTable(response.data.rewards)
                    GoodsUtils.DrawRewards(rewardList, true)
                    CfUtils.DialogOpen(Constants.UITypeIds.UICommonRewardPop, { rewards = rewardList })

                    -- refresh cell data
                    taskData.status = Constants.GetStatus.Has
                    
                    -- refresh cell node
                    ---@param cellEnv UIActivityAccumulatedRechargeCellNode
                    CfUtils.ListViewEachItem(self.TaskListView, TaskCellNodePath, function(cellEnv)
                        local cellLuaIndex = cellEnv:GetLuaIndex()
                        if cellLuaIndex == luaIndex then
                            cellEnv:SetCellData(cellData)
                            return true
                        end
                    end)

                    -- refresh red point
                    self:RefreshRedPointState_()
                end
            end
        )

    elseif statusId == Constants.GetStatus.Has then
        GameUtils.Toast(localize('已领取'))
    end
end

--- 一键领取
function LadderCompetionTaskRewardDialog:OnClickGetAll()
    local canGet = false
    local ladderTaskList = checkTable(self.taskDataList_)
    for _, listData in ipairs(ladderTaskList) do
        local taskData = checkTable(listData.taskData)
        if checkInt(taskData.status) == Constants.GetStatus.Can then
            canGet = true
            break
        end
    end
    if not canGet then
        GameUtils.Toast(localize("当前没有可领取的奖励"))
        return
    end
    GameUtils.Request(self.taskDrawInterface, { taskId = 0 }, function(request, response)
        if checkNumber(response.errCode) == 0 then
            -- draw rewards
            local rewardList = checkTable(response.data.rewards)
            GoodsUtils.DrawRewards(rewardList, true)
            CfUtils.DialogOpen(Constants.UITypeIds.UICommonRewardPop, { rewards = rewardList })

            self:ListDataGetAll()
            self:SortListData()
            self:RefreshView_()
        end
    end)
end

function LadderCompetionTaskRewardDialog:ListDataGetAll()
    local taskList = checkTable(self.taskDataList_)
    for i, cellData in ipairs(taskList) do
        local taskData = checkTable(cellData.taskData)
        local statusId = checkInt(taskData.status)

        if statusId == Constants.GetStatus.Can then
            taskData.status = Constants.GetStatus.Has
        end
    end
end

function LadderCompetionTaskRewardDialog:SwitchSystem(systemName)
    self.settingId = 0
    self.taskInterface = ""
    self.taskDrawInterface = ""
    self.redPointEventName = ""
    self.redPointStrNode = ""

    if systemName == Constants.SystemToggleIds.Id2008 then
        self.settingId = AutoIds.IdSetting2565
        self.taskInterface = Interfaces.LADDER_TASK
        self.taskDrawInterface = Interfaces.LADDER_TASK_DRAW
        self.redPointEventName = Constants.EventNames.LadderRedPointChange
        self.redPointStrNode = Constants.RedPointConst.LadderCompetionTask
    elseif systemName == Constants.SystemToggleIds.Id2007 then
        self.settingId = AutoIds.IdSetting4023
        self.taskInterface = Interfaces.StruggleTask
        self.taskDrawInterface = Interfaces.StruggleTaskDraw
        self.redPointEventName = Constants.EventNames.LadderStruggleRedPointChange
        self.redPointStrNode = Constants.RedPointConst.LadderStruggleTask
    elseif systemName == Constants.SystemToggleIds.Id2017 then
        self.settingId = AutoIds.IdSetting4028
        self.taskInterface = Interfaces.StruggleSingleTask
        self.taskDrawInterface = Interfaces.StruggleSingleTaskDraw
        self.redPointEventName = Constants.EventNames.LadderStruggleSingleRedPointChange
        self.redPointStrNode = Constants.RedPointConst.LadderStruggleSingleTask
    elseif systemName == Constants.SystemToggleIds.Id4006 then
        self.settingId = AutoIds.IdSetting5106
        self.taskInterface = Interfaces.OverseaClubGVGTask
        self.taskDrawInterface = Interfaces.OverseaClubGVGTaskDraw
        self.redPointEventName = Constants.EventNames.ClubGvgRedPointChange
    end
end

return LadderCompetionTaskRewardDialog
