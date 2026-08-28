
local util = require 'XLua.util'
local CoWait = CS.Engine.Lib.CoWait
local CDTimerModule = CS.Engine.Modules.CDTimerModule
local CountDownTime = 2592000 --30 * 86400 30天的秒数

--- from: Assets/BundleResources/Prefabs/OverseaParkour12001801/OverseaParkourTaskDialog12001801.prefab > name: OverseaParkourTaskDialog12001801
---@class ParkourGameTaskDialog
---@field Env                           	ParkourGameTaskDialog                   
---@field controller                    	Engine.UI.UILuaDialog                   
---@field TabView                       	SuperScrollView.LoopListView2           	@ 0    
---@field TextTime                      	UnityEngine.UI.Text                     	@ 1    
---@field ListView                      	SuperScrollView.LoopListView2           	@ 2    
---@field FontStyleButton               	UnityEngine.RectTransform               	@ 3    
local ParkourGameTaskDialog = Class("ParkourGameTaskDialog")

function ParkourGameTaskDialog:__init()
    self.controller = nil
    self.data = nil
    self.activityData = nil
    self.tabIndex = 1
    self.topGoods = nil
end

function ParkourGameTaskDialog:__delete()
    self.data = nil
    self.controller = nil
    self.activityData = nil
    self.tabIndex = 0
    self.topGoods = nil
end
function ParkourGameTaskDialog:OnFocus(focus)
    if focus then
        if self.topGoods then
            CfUtils.RefreshTopGoods(self.topGoods)
        end
    end
end

function ParkourGameTaskDialog:Awake()
    self.activityData = self.controller.Argument.parameters.data
    self.topGoods = checkTable(self.controller.Argument.parameters.topGoods)
    SetButtonAction(self.FontStyleButton, function()
        ---一键
        if self.data and self.data.tasks then
            local canOneKey = false
            for i, v in pairs(self.data.tasks) do
                if checkNumber(v.status) == 1 then
                    ---可领取
                    canOneKey = true
                    break
                end
            end
            if not canOneKey then
                GameUtils.Toast(localize('没有可以领取的奖励'))
                return
            end
            GameUtils.Request("activityTinyWorld/receiveTaskRewards", { activityUuid = self.activityData.id, taskId = 0 }, function(request, response)
                if checkNumber(response.errCode) == 0 then
                    local rData = response.data
                    local rewardList = checkTable(rData.rewards)
                    GoodsUtils.DrawRewards(rewardList, true)
                    CfUtils.DialogOpen(Constants.UITypeIds.UICommonRewardPop, {rewards = rewardList})
                    local t = self:FilterProgress()
                    Events.Broadcast("PARK_PROGRESS", t)
                   self:RequestHome()
                end
            end)
        end
    end)
end

function ParkourGameTaskDialog:RequestHome(cb)
    GameUtils.Request("activityTinyWorld/task", { activityUuid = self.activityData.id, type = 1 }, function(request, response)
        if cb then cb() end
        if checkNumber(response.errCode) == 0 then
            self.data = checkTable(response.data)
            self:RefreshUI()
        end
    end)
end

function ParkourGameTaskDialog:OnInitialize()
    local isSuccess = false
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        self:RequestHome(function()
            isSuccess = true
        end)
        --GameUtils.Request("activityTinyWorld/task", { activityUuid = self.activityData.id }, function(request, response)
        --    isSuccess = true
        --    if checkNumber(response.errCode) == 0 then
        --        self.data = checkTable(response.data)
        --        self:RefreshUI()
        --    end
        --end)
        while not isSuccess do
            coroutine.yield()
        end
    end))
    return coWait
end

function ParkourGameTaskDialog:OnFinalize()
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        if not isNull(self._timeDown) then
            CDTimerModule.GetInstance():RemoveCD(self._timeDown)
        end
        self._timeDown = nil
        self.controller = nil --删除lua层引用到的c#对象 否则不会产生c# gc回收到对象
        self:Delete()
        self = nil --lua层的gc需要
    end))
    return coWait
end

function ParkourGameTaskDialog:FreshTabView()
    ---刷新页签
    if not self.TabView.IsListViewInit then
        self.TabView:InitListView(1, Bind(self, self.OnGetItemByIndex))
    else
        GameUtils.ReloadData(self.TabView, 1)
    end
end

function ParkourGameTaskDialog:RefreshUI()
    self:FreshTabView()
    self:FillTaskList()
    self:FillTime()
    self:StartTimeDown()
end

function ParkourGameTaskDialog:StartTimeDown()
    if not isNull(self._timeDown) then
        CDTimerModule.GetInstance():RemoveCD(self._timeDown)
        self._timeDown = nil
    end

    self._timeDown = CDTimerModule.GetInstance():AddCD(1, function(count, id, countElapsed)
        self:FillTime()
        self.data.taskCountdown = checkNumber( self.data.taskCountdown) - countElapsed
        local time = checkNumber(self.data.taskCountdown)
        if time < 0 then
            GameUtils.Request("activityTinyWorld/task", { activityUuid = self.activityData.id }, function(request, response)
                if checkNumber(response.errCode) == 0 then
                    self.data = checkTable(response.data)
                    self:RefreshUI()
                end
            end)
        end
    end, CountDownTime, false, true)
end

function ParkourGameTaskDialog:FillTime()
    local time = checkNumber(self.data.taskCountdown)
    CfUtils.FillText(self.TextTime, CfUtils.GetTimeHMS(time))
end

function ParkourGameTaskDialog:FillTaskList()
    local t = {}
    for k, v in pairs(self.data.tasks) do
        if checkNumber(v.status) == 2 then
            v.sortKey = 3
        elseif checkNumber(v.status) == 1 then
            v.sortKey = 1
        elseif checkNumber(v.status) == 0 then
            v.sortKey = 2
        end
        table.insert(t, v)
    end
    table.sort(t, function(a, b)
        if a.sortKey == b.sortKey then
            return checkNumber(a.id) < checkNumber(b.id)
        else
            return checkNumber(a.sortKey) < checkNumber(b.sortKey)
        end
    end)
    self.data.tasks = t
    if not self.ListView.IsListViewInit then
        self.ListView:InitListView(#self.data.tasks, Bind(self, self.OnGetItemTaskByIndex))
    else
        GameUtils.ReloadData(self.ListView, #self.data.tasks)
    end
end

function ParkourGameTaskDialog:OnGetItemTaskByIndex(listView, index)
    if index < 0 then
        return nil
    end
    local cell = listView:NewListViewItem("CellNode")
    local go = cell.gameObject
    local data = self.data.tasks[index + 1]
    CfUtils.PlayAnimation(go, "ActivityPtTaskDialog_CellNode_change")

    ---@type ParkTaskCellNode
    local scr = CfUtils.GetLuaScr(go, "Game.Activity.ParkourGame.Dialog.ParkTaskCellNode")
    if scr then
        scr:Refresh(data, function()
            GameUtils.Request("activityTinyWorld/receiveTaskRewards", { activityUuid = self.activityData.id, taskId = data.id, type = 1 }, function(request, response)
                if checkNumber(response.errCode) == 0 then
                    local rData = response.data
                    data.status = 2
                    local rewardList = checkTable(rData.rewards)
                    GoodsUtils.DrawRewards(rewardList, true)
                    CfUtils.DialogOpen(Constants.UITypeIds.UICommonRewardPop, {rewards = rewardList})
                    self:FillTaskList()
                    self:FreshTabView()
                    local t = self:FilterProgress()
                    Events.Broadcast("PARK_PROGRESS", t)
                end
            end)
        end)
    end

    return cell
end

function ParkourGameTaskDialog:FilterProgress()
    local pro, count = 0,0
    local redPoint = -1
    for i, v in pairs(self.data.tasks) do
        if checkNumber(v.status) == 2 then
            pro = pro + 1
        end
        if checkNumber(v.status) == 1 then
            redPoint = 1
        end
        count = count + 1
    end
    GameUtils.SetRedPointNum(Constants.RedPointConst.MainActivityMinWorldTask, redPoint)
    GameUtils.InvokeRedPointCallBack(Constants.RedPointConst.MainActivityMinWorldTask)
    return {pro = pro, max = count}
end

function ParkourGameTaskDialog:OnGetItemByIndex(listView, index)
    if index < 0 then
        return nil
    end
    local cellNode = listView:NewListViewItem("Cell")
    ---@type TaskTabCellNode
    local nodeEnv  = CfUtils.GetLuaScr(cellNode, "Game.Activity.ParkourGame.Dialog.TaskTabCellNode")
    if nodeEnv then
        local t = self:FilterProgress()
        nodeEnv:FreshUI(t, index + 1, self.tabIndex)
    end
    return cellNode
end

return ParkourGameTaskDialog