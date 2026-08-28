-------------------------------------------------------------------------------
-- 夜寻迷宫 - 主地图任务
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2024-03-28 21:01:10
-------------------------------------------------------------------------------

local PatrolMazeUtils = import('Game.UI.PatrolMaze.PatrolMazeUtils')
local patrolMazeComp  = PatrolMazeUtils.GetComp()

local TaskCellNodeLuaPath = 'Game.UI.PatrolMaze.PatrolMazePrimaryTaskCell'
local TaskCellNodeLuaName = 'Cell'

--- lifecycle enable: __init -> Awake -> OnInitialize -> OnFocus(true) -> OnShow
--- lifecycle disable: OnFocus(false) -> OnHide -> OnFinalize -> __delete
--- from: Assets/BundleResources/Prefabs/GachaponSkin/GachaponSkinTaskDialog.prefab > name: PatrolPrimaryMapAreaTaskDialog130201
---@class PatrolMazePrimaryTaskDialog
---@field Env                           	PatrolMazePrimaryTaskDialog             
---@field controller                    	Engine.UI.UILuaDialog                   
---@field RootNode                      	UnityEngine.RectTransform               	@ 0    根节点
---@field CloseArea                     	UnityEngine.RectTransform               	@ 1    空白区域
---@field CloseBtn                      	UnityEngine.RectTransform               	@ 2    关闭按钮
---@field TaskListView                  	SuperScrollView.LoopListView2           	@ 3    任务列表节点
---@field DrawAllBtn                    	UnityEngine.RectTransform               	@ 4    领取全部按钮
local PatrolMazePrimaryTaskDialog = Class('PatrolMazePrimaryTaskDialog')


function PatrolMazePrimaryTaskDialog:__init()
    ---@type fun():void
    self.drawRewardsCb_ = nil
end


function PatrolMazePrimaryTaskDialog:__delete()
    self.drawRewardsCb_ = nil
end


function PatrolMazePrimaryTaskDialog:Awake()
    SetButtonAction(self.CloseBtn, Bind(self, self.OnClickCloseButtonHandler_))
    SetListViewAction(self.TaskListView, Bind(self, self.OnUpdateTaskListCellHandler_), TaskCellNodeLuaName)
end


function PatrolMazePrimaryTaskDialog:OnInitialize()
    return CoWaitDo(function()
        local initParams    = self.controller.Argument.parameters or {}
        self.drawRewardsCb_ = initParams.drawRewardsCb

        -- update views
        self:SetTaskDataList(patrolMazeComp:GetHomeDojo().taskDojoList)
    end)
end


function PatrolMazePrimaryTaskDialog:OnFinalize()
    return CoWaitDo(function()
        self.controller = nil --删除lua层引⽤用到的c#对象
        self:Delete()
    end)
end


-------------------------------------------------
-- get / set

---@return PatrolMazeTaskDojo[]
function PatrolMazePrimaryTaskDialog:GetTaskDataList()
    return checkTable(self.taskDataList_)
end
function PatrolMazePrimaryTaskDialog:SetTaskDataList(dataList)
    self.taskDataList_ = checkTable(dataList)
    self:UpdateTaskList_()
end


-------------------------------------------------
-- public

function PatrolMazePrimaryTaskDialog:Close()
    CfUtils.DialogBack()
end


-------------------------------------------------
-- private

function PatrolMazePrimaryTaskDialog:UpdateTaskList_()
    -- sort task
    ---@param aTaskDojo PatrolMazeTaskDojo
    ---@param bTaskDojo PatrolMazeTaskDojo
    table.sort(self.taskDataList_, function(aTaskDojo, bTaskDojo)
        local aPriority = 0
        local bPriority = 0
        local aTaskId   = checkInt(aTaskDojo.taskId)
        local bTaskId   = checkInt(bTaskDojo.taskId)
        --
        aPriority = aPriority + (aTaskDojo:CanDraw() and 100 or 0) -- 可领取
        bPriority = bPriority + (bTaskDojo:CanDraw() and 100 or 0)
        aPriority = aPriority + (aTaskDojo:IsDoing() and 10 or 0)  -- 未完成
        bPriority = bPriority + (bTaskDojo:IsDoing() and 10 or 0)
        aPriority = aPriority + (aTaskId < bTaskId and 1 or 0)  -- 任务id
        bPriority = bPriority + (bTaskId < aTaskId and 1 or 0)
        --
        return aPriority > bPriority
    end)

    -- reload view
    local listDataLength = #self:GetTaskDataList()
    GameUtils.ReloadData(self.TaskListView, listDataLength)
end


-------------------------------------------------
-- handler

function PatrolMazePrimaryTaskDialog:OnClickCloseButtonHandler_()
    self:Close()
end


---@param listView SuperScrollView.LoopListView2
---@param luaIndex integer @ start at 1
---@return SuperScrollView.LoopListViewItem2
function PatrolMazePrimaryTaskDialog:OnUpdateTaskListCellHandler_(listView, luaIndex)
    local cellNode = listView:NewListViewItem(TaskCellNodeLuaName)
    local cellData = checkTable(self:GetTaskDataList()[luaIndex])
    ---@type PatrolMazePrimaryTaskCell
    local cellEnv = CfUtils.GetLuaScr(cellNode.gameObject, TaskCellNodeLuaPath)
    if not isNull(cellEnv) then
        -- init cell
        cellEnv:SetLuaIndex(luaIndex)
        cellEnv:SetCellData(cellData)
        cellEnv:SetClickDrawCB(Bind(self, self.OnClickTaskListDrawButtonCallback_))
        cellEnv:SetOnInitCB(function()
            -- play anim
            if listView.DisplayItemNumber < listView.DisplayItemCount then
                cellEnv:PlayDelayAnimByShow(listView.DisplayItemNumber)
                listView.DisplayItemNumber = listView.DisplayItemNumber + 1
            else
                cellEnv:PlayAnimByIdle()
            end
        end)
    end
    return cellNode
end


---@param luaIndex integer @ start at 1
function PatrolMazePrimaryTaskDialog:OnClickTaskListDrawButtonCallback_(luaIndex)
    local cellData = self:GetTaskDataList()[luaIndex]

    if not cellData:CanDraw() then
        return
    end

    local requestData = {taskId = cellData.taskId}
    GameUtils.Request(Interfaces.OverseaMazeTaskDraw, requestData, function(request, response)
        if checkInt(response.errCode) == 0 then
            local responseData = checkTable(response.data)

            -- update cellData status
            cellData.status = Constants.GetStatus.Has
            if self.drawRewardsCb_ then
                self.drawRewardsCb_()
            end

            -- update taskList cell
            local taskCellNode = self.TaskListView:GetShownItemByItemIndex(luaIndex - 1)
            ---@type PatrolMazePrimaryTaskCell
            local taskCellEnv = CfUtils.GetLuaScr(taskCellNode.gameObject, TaskCellNodeLuaPath)
            if taskCellEnv then
                taskCellEnv:UpdateDrawStatus()
            end

            -- draw rewards
            local rewardList = checkTable(responseData.rewards)
            GoodsUtils.DrawRewards(rewardList, true)
            CfUtils.DialogOpen(Constants.UITypeIds.UICommonRewardPop, {rewards = rewardList})
        end
    end)
end


return PatrolMazePrimaryTaskDialog
