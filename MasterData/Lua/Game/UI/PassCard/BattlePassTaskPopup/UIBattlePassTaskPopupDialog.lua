-------------------------------------------------------------------------------
-- Pass卡 - 任务界面
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2023-11-30 16:59:47
-------------------------------------------------------------------------------

local PassCardUtils = import('Game.UI.PassCard.PassCardUtils')
local passCardComp  = PassCardUtils.GetComp()

local TaskListCellPath = 'Game.UI.PassCard.BattlePassTaskPopup.UIBattlePassTaskPopupNode'
local TaskListCellName = 'Cell'

local ROOT_ANIM_NAME = {
    SHOW = 'BattlePassTaskPopup_Entry'
}

--- from: Assets/BundleResources/Prefabs/BattlePass/BattlePassTaskPopup.prefab > name: BattlePassTaskPopup
---@class UIBattlePassTaskPopupDialog
---@field Env                           	UIBattlePassTaskPopupDialog             
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field LeftTimeTxt                   	UnityEngine.RectTransform               	@ 0    剩余时间文本
---@field RefreshFreeTxt                	UnityEngine.RectTransform               	@ 1    免费刷新文本
---@field RefreshFreeNode               	UnityEngine.RectTransform               	@ 2    免费刷新节点
---@field QuickDrawBtn                  	UnityEngine.RectTransform               	@ 3    一键领取按钮
---@field TaskListView                  	SuperScrollView.LoopListView2           	@ 4    任务列表
---@field ExtraExpTxt                   	UnityEngine.RectTransform               	@ 5    额外经验文本
---@field ExtraExpNode                  	UnityEngine.RectTransform               	@ 6    额外经验节点
---@field TypeTabToggle                 	UnityEngine.RectTransform               	@ 7    类型页签节点
---@field AnimRoot                      	UnityEngine.RectTransform               	@ 8    动画根节点
---@field Root                          	UnityEngine.RectTransform               	@ 9    根节点
local UIBattlePassTaskPopupDialog = Class('UIBattlePassTaskPopupDialog')


function UIBattlePassTaskPopupDialog:__init() 
    ---@type Engine.Modules.CDTimerModule @ 刷新倒计时的计时器
    self.taskRefreshTimer_ = nil

    ---@type CommonTabToggleUp @ 顶部任务页签控制器
    self.taskTabEnv_ = nil

    ---@type table[] @ 任务切换页签数据
    self.taskTabData_ = nil

    ---@type table<integer, boolean> @ 动画切换页签字典
    self.animTabAnim_ = {}

    ---@type table[] @ 当前的任务数据
    self.taskDataList_ = {}
end


function UIBattlePassTaskPopupDialog:__delete()
    self.taskRefreshTimer_ = nil
    self.taskTabEnv_       = nil
    self.taskTabData_      = nil
    self.animTabAnim_      = nil
    self.taskDataList_     = nil
end


function UIBattlePassTaskPopupDialog:Awake()
    self.taskTabEnv_ = CfUtils.GetLuaScr(self.TypeTabToggle, Constants.UILuaTablePath.ComUpToggle)
    CfUtils.SetAnimationAutomaticallyPlay(self.AnimRoot, false)
end


function UIBattlePassTaskPopupDialog:OnInit()
    self.OnPassTypeChangeEvent_ = Events.AddListener(PassCardUtils.EventName.PASS_CARD_TYPE_CHANGE, Bind(self, self.OnPassTypeChangeEventHandler_))
    SetListViewAction(self.TaskListView, Bind(self, self.OnUpdateTaskListCellHandler_), TaskListCellName)
    SetButtonAction(self.QuickDrawBtn, Bind(self, self.OnQuickDrawButtonClickHandler_))
end


function UIBattlePassTaskPopupDialog:OnDestroy()
    Events.RemoveListener(PassCardUtils.EventName.PASS_CARD_TYPE_CHANGE, self.OnPassTypeChangeEvent_)
    self:TaskRefreshCountdownClear_()
    self.OnStartCallback = nil
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


-------------------------------------------------
-- get / set

---@return integer
function UIBattlePassTaskPopupDialog:GetSelectTabIndex()
    return checkInt(self.selectTabIndex_)
end
function UIBattlePassTaskPopupDialog:SetSelectTabIndex(index)
    self.selectTabIndex_ = checkInt(index)
    self:UpdateSelectTabIndex_()
end


---@return PassCardUtils.TaskType
function UIBattlePassTaskPopupDialog:GetCurrentTaskType()
    local taskTabData = checkTable(self.taskTabData_[self:GetSelectTabIndex()])
    return checkInt(taskTabData.type)
end


---@return table[]
function UIBattlePassTaskPopupDialog:GetTaskDataList()
    return checkTable(self.taskDataList_)
end


-------------------------------------------------
-- public

---@param initParams table
function UIBattlePassTaskPopupDialog:OnOpen(initParams)
    self:OnInit()

    local isRecover   = initParams.taskTabIndex ~= nil
    local initIndex   = initParams.taskTabIndex or 1
    local animTabAnim = initParams.animTabAnim or {}
    self.animTabAnim_ = animTabAnim

    -- init data
    self.taskTabData_ = {
        {
            text            = localize('每日任务'),
            type            = PassCardUtils.TaskType.Daily,
            redPointStrNode = Constants.RedPointConst.BattlePassTaskCommon,
            func            = Bind(self, self.OnClickTaskToggleHandler_)
        },
        {
            text            = localize('精英任务'),
            type            = PassCardUtils.TaskType.Elite,
            redPointStrNode = Constants.RedPointConst.BattlePassTaskElite,
            func            = Bind(self, self.OnClickTaskToggleHandler_)
        },
    }
    
    -- play show anim
    if isRecover then
        self.TaskListView.DisplayItemNumber = self.TaskListView.DisplayItemCount
    else
        CfUtils.PlayAnimation(self.AnimRoot, ROOT_ANIM_NAME.SHOW)
    end

    -- update task tabToggle
    self.taskTabEnv_:FillToggles(self.taskTabData_, initIndex)
    self:SetSelectTabIndex(initIndex)
    
    -- init daily expExtra
    self:UpdatePassExpExtraInfo_()

    self:UpdateRedPoint_()
end


---@param initParams table
function UIBattlePassTaskPopupDialog:OnClose(initParams)
    initParams.taskTabIndex = self:GetSelectTabIndex()
    initParams.animTabAnim  = self.animTabAnim_
end


function UIBattlePassTaskPopupDialog:OnDataRefresh()
    self:UpdateSelectTabIndex_()
    self:UpdateRedPoint_()
end


-------------------------------------------------
-- private

function UIBattlePassTaskPopupDialog:UpdatePassExpExtraInfo_()
    local dailyExpExtraConf  = PassCardUtils.GetParamValue(PassCardUtils.ParamsId.DTASK_PARSS_EXP_EXTRA)
    local dailyExpExtraValue = passCardComp:IsUnlockNormalPass() and dailyExpExtraConf or 0
    CfUtils.FillText(self.ExtraExpTxt, string.fmt('_num_%', {_num_ = math.ceil(dailyExpExtraValue * 100)}))
end


function UIBattlePassTaskPopupDialog:TaskRefreshCountdownClear_()
    if isNotNull(self.taskRefreshTimer_) then
        CfUtils.CDTimerRemove(self.taskRefreshTimer_)
        self.taskRefreshTimer_ = nil
    end
end


function UIBattlePassTaskPopupDialog:TaskRefreshCountdownStart_()
    self:TaskRefreshCountdownClear_()

    local passCardTaskDojo  = passCardComp:GetTaskDojo()
    local dailyTaskTimeLeft = passCardTaskDojo.dailyTaskTimeLeft
    local eliteTaskTimeLeft = passCardTaskDojo.eliteTaskTimeLeft
    local countdownTimeNum  = math.max(math.min(dailyTaskTimeLeft, eliteTaskTimeLeft), 1)
    self.taskRefreshTimer_  = CfUtils.CDTimerAppend(1, countdownTimeNum, true, true, function(count, id, elapsed)

        -- update leftTime
        passCardTaskDojo.dailyTaskTimeLeft = passCardTaskDojo.dailyTaskTimeLeft - elapsed
        passCardTaskDojo.eliteTaskTimeLeft = passCardTaskDojo.eliteTaskTimeLeft - elapsed
        self:UpdateTaskRefreshTime_()

        -- check timeover
        if count == 0 then
            passCardComp:SyncPassTaskData(function()
                self:OnDataRefresh()
            end)
        end
    end)
end


function UIBattlePassTaskPopupDialog:UpdateTaskRefreshTime_()
    local currentTaskTime  = 0
    local currentTaskType  = self:GetCurrentTaskType()
    local passCardTaskDojo = passCardComp:GetTaskDojo()

    if currentTaskType == PassCardUtils.TaskType.Daily then
        currentTaskTime = passCardTaskDojo.dailyTaskTimeLeft

    elseif currentTaskType == PassCardUtils.TaskType.Elite then
        currentTaskTime = passCardTaskDojo.eliteTaskTimeLeft
    end

    local leftTimeTxt = CfUtils.GetTimeHMS3(math.max(currentTaskTime, 0), 30)
    CfUtils.FillText(self.LeftTimeTxt, string.fmt(localize('剩余时间：_time_'), {_time_ = leftTimeTxt}))
end


function UIBattlePassTaskPopupDialog:UpdateTaskRefreshCount_()
    local refreshCountNow  = 0
    local refreshCountMax  = 0
    local currentTaskType  = self:GetCurrentTaskType()
    local passCardTaskDojo = passCardComp:GetTaskDojo()

    if currentTaskType == PassCardUtils.TaskType.Daily then
        refreshCountNow = passCardTaskDojo.dailyTaskRefreshTimes
        refreshCountMax = PassCardUtils.GetParamValue(PassCardUtils.ParamsId.DTASK_REFRESH_FREE)

    elseif currentTaskType == PassCardUtils.TaskType.Elite then
        refreshCountNow = passCardTaskDojo.eliteTaskRefreshTimes
        refreshCountMax = PassCardUtils.GetParamValue(PassCardUtils.ParamsId.ETASK_REFRESH_FREE)
    end

    CfUtils.FillText(self.RefreshFreeTxt, string.fmt('%1/%2', refreshCountNow, refreshCountMax))
end


function UIBattlePassTaskPopupDialog:UpdateTaskDataList_()
    self.taskDataList_ = {}

    local currentTaskType  = self:GetCurrentTaskType()
    local passCardTaskDojo = passCardComp:GetTaskDojo()

    if currentTaskType == PassCardUtils.TaskType.Daily then
        for taskIndex, taskDojo in ipairs(passCardTaskDojo.dailyTaskList) do
            local taskVo = PassCardUtils.GetPassCardDailyTaskVo(taskDojo.taskId)
            self.taskDataList_[taskIndex] = {
                taskVo   = taskVo,
                taskDojo = taskDojo,
                taskType = PassCardUtils.TaskType.Daily,
                isUnlock = GameUtils.IsUnlocked(taskVo.unlockId, taskVo.unlockNum),
            }
        end

    elseif currentTaskType == PassCardUtils.TaskType.Elite then
        for taskIndex, taskDojo in ipairs(passCardTaskDojo.eliteTaskList) do
            local taskVo = PassCardUtils.GetPassCardEliteTaskVo(taskDojo.taskId)
            self.taskDataList_[taskIndex] = {
                taskVo   = taskVo,
                taskDojo = taskDojo,
                taskType = PassCardUtils.TaskType.Elite,
                isUnlock = GameUtils.IsUnlocked(taskVo.unlockId, taskVo.unlockNum),
            }
        end
    end

    -- 显示排序：可领取 > 已解锁 > 进行中 > 已领取 > taskId
    ---@param aTaskData table
    ---@param bTaskData table
    table.sort(self.taskDataList_, function(aTaskData, bTaskData)
        local aTaskPriority = 0
        local bTaskPriority = 0

        ---@type PassCardTaskInfoDojo
        local aTaskDojo = aTaskData.taskDojo
        ---@type PassCardTaskInfoDojo
        local bTaskDojo = bTaskData.taskDojo

        aTaskPriority = aTaskPriority + (aTaskDojo:CanDraw() and 1000 or 0)
        bTaskPriority = bTaskPriority + (bTaskDojo:CanDraw() and 1000 or 0)
        aTaskPriority = aTaskPriority + (aTaskData.isUnlock and 100 or 0)
        bTaskPriority = bTaskPriority + (bTaskData.isUnlock and 100 or 0)
        aTaskPriority = aTaskPriority + (aTaskDojo:IsDoing() and 10 or 0)
        bTaskPriority = bTaskPriority + (bTaskDojo:IsDoing() and 10 or 0)
        aTaskPriority = aTaskPriority + (aTaskDojo:IsDrawn() and 1 or 0)
        bTaskPriority = bTaskPriority + (bTaskDojo:IsDrawn() and 1 or 0)

        if aTaskPriority == bTaskPriority then
            return aTaskDojo.taskId < bTaskDojo.taskId
        else
            return aTaskPriority > bTaskPriority
        end
    end)

    local listDataLength = #self.taskDataList_
    GameUtils.ReloadData(self.TaskListView, listDataLength)
end


function UIBattlePassTaskPopupDialog:UpdateSelectTabIndex_()
    local currentTaskType  = self:GetCurrentTaskType()
    CfUtils.SetActive(self.ExtraExpNode, currentTaskType == PassCardUtils.TaskType.Daily)

    -- 切换页签时，重置动画次数，要求切每个页签都要播一次入场动画
    if not self.animTabAnim_[self:GetSelectTabIndex()] then
        self.animTabAnim_[self:GetSelectTabIndex()] = true
        self.TaskListView.DisplayItemNumber = 0
    else
        -- 避免第二个页签只有3条数据时：DisplayItemNumber 播放记录只会自增到3
        -- 这时再切回拥有5条记录的第一个页签，会因为没达到 DisplayItemCount(5)，从而有2条重复再播动画
        -- 所以无论这里强制对齐 DisplayItemCount，避免反复切换数据不等的页签时，触发再次播放动画
        self.TaskListView.DisplayItemNumber = self.TaskListView.DisplayItemCount
    end

    self:UpdateTaskRefreshCount_()
    self:UpdateTaskRefreshTime_()
    self:UpdateTaskDataList_()
end


function UIBattlePassTaskPopupDialog:UpdateRedPoint_()
    passCardComp:CheckPassTaskRedPoint()
end


-------------------------------------------------
-- handler

--- Pass卡类型发生变化
function UIBattlePassTaskPopupDialog:OnPassTypeChangeEventHandler_()
    self:UpdatePassExpExtraInfo_()
    self:UpdateTaskDataList_()
end


---@param toggleIndex integer
function UIBattlePassTaskPopupDialog:OnClickTaskToggleHandler_(toggleIndex)
    if self:GetSelectTabIndex() ~= toggleIndex then
        self:SetSelectTabIndex(toggleIndex)
    end
end


---@param listView SuperScrollView.LoopListView2
---@param luaIndex integer
---@return SuperScrollView.LoopListViewItem2
function UIBattlePassTaskPopupDialog:OnUpdateTaskListCellHandler_(listView, luaIndex)
    local cellNode = listView:NewListViewItem(TaskListCellName)
    local cellData = self:GetTaskDataList()[luaIndex]
    ---@type UIBattlePassTaskPopupNode
    local cellEnv = CfUtils.GetLuaScr(cellNode, TaskListCellPath)
    if isNotNull(cellEnv) then
        -- init cell
        cellEnv:SetLuaIndex(luaIndex)
        cellEnv:SetCellData(cellData)
        cellEnv:SetClickDrawCB(Bind(self, self.OnClickTaskCellDrawButtonCallback_))
        cellEnv:SetClickRefreshCB(Bind(self, self.OnClickTaskCellRefreshButtonCallback_))

        if listView.DisplayItemNumber < listView.DisplayItemCount then
            cellEnv:PlayDelayAnimByShow(listView.DisplayItemNumber)
            listView.DisplayItemNumber = listView.DisplayItemNumber + 1
        else
            cellEnv:PlayAnimByIdle()
        end
    end
    return cellNode
end


---@param luaIndex integer @ start at 1
function UIBattlePassTaskPopupDialog:OnClickTaskCellDrawButtonCallback_(luaIndex)
    local cellData = self:GetTaskDataList()[luaIndex]

    ---@type PassCardTaskInfoDojo
    local taskDojo = checkTable(cellData.taskDojo)
    ---@type PassCardDailyTaskVo | PassCardEliteTaskVo
    local taskVo   = checkTable(cellData.taskVo)
    ---@type boolean
    local isUnlock = checkBool(cellData.isUnlock)

    if taskDojo:IsDrawn() then
        GameUtils.Toast(localize('该奖励已领取'))
        return
    end

    local drawTaskType = checkInt(cellData.taskType)
    if taskDojo:CanDraw() then
        local requestData = {type = drawTaskType, taskId = taskDojo.taskId}
        GameUtils.Request(Interfaces.OverseaPassCardDrawTask, requestData, function(request, response)
            if checkInt(response.errCode) == 0 then
                local responseData = checkTable(response.data)
                
                -- update passCardExp
                local oldTotalExp = passCardComp:GetHomeDojo().passCardTotalExp
                local newTotalExp = checkInt(responseData.exp)
                passCardComp:UpdatePassCardExp(newTotalExp)

                -- show rewards
                CfUtils.DialogOpen(Constants.UITypeIds.UICommonRewardPop, {rewards = {
                    {goodsId = passCardComp:GetPassExpGoodsId(), num = newTotalExp - oldTotalExp},
                }})

                -- refresh taskDojo
                taskDojo.status = Constants.GetStatus.Has

                -- refresh listCell
                self.TaskListView:RefreshItemByItemIndex(luaIndex - 1)
                
                -- update redPoint
                self:UpdateRedPoint_()
            end
        end)
    else
        -- 前往
        if checkInt(taskVo.openType) > 0 then
            ---@type GoodsConfMgr
            local goodsConfMgr  = GoodsConfMgr:GetInstance()
            local jumpModuleRow = goodsConfMgr:GetJumpModuleRow(taskVo.openType)
            goodsConfMgr:ExecuteJump(jumpModuleRow, taskVo.openParameter)
        end
    end
end


---@param luaIndex integer @ start at 1
function UIBattlePassTaskPopupDialog:OnClickTaskCellRefreshButtonCallback_(luaIndex)
    local cellData = self:GetTaskDataList()[luaIndex]

    ---@type PassCardTaskInfoDojo
    local taskDojo = checkTable(cellData.taskDojo)
    if taskDojo:IsDrawn() then
        return
    end

    if taskDojo:CanDraw() then
        GameUtils.Toast(localize('当前任务已完成'))
        return
    end

    local refreshCountNow   = 0
    local refreshCountMax   = 0
    local refreshTaskType   = checkInt(cellData.taskType)
    local passCardTaskDojo  = passCardComp:GetTaskDojo()
    local refreshConsumeId  = 0
    local refreshConsumeNum = 0

    if refreshTaskType == PassCardUtils.TaskType.Daily then
        refreshCountNow   = passCardTaskDojo.dailyTaskRefreshTimes
        refreshCountMax   = PassCardUtils.GetParamValue(PassCardUtils.ParamsId.DTASK_REFRESH_FREE)
        refreshConsumeId  = PassCardUtils.GetParamValue(PassCardUtils.ParamsId.DTASK_REFRESH_CONSUME_ID)
        refreshConsumeNum = PassCardUtils.GetParamValue(PassCardUtils.ParamsId.DTASK_REFRESH_CONSUME_NUM)

    elseif refreshTaskType == PassCardUtils.TaskType.Elite then
        refreshCountNow   = passCardTaskDojo.eliteTaskRefreshTimes
        refreshCountMax   = PassCardUtils.GetParamValue(PassCardUtils.ParamsId.ETASK_REFRESH_FREE)
        refreshConsumeId  = PassCardUtils.GetParamValue(PassCardUtils.ParamsId.ETASK_REFRESH_CONSUME_ID)
        refreshConsumeNum = PassCardUtils.GetParamValue(PassCardUtils.ParamsId.ETASK_REFRESH_CONSUME_NUM)
    end

    local isFreeRefresh  = refreshCountNow > 0
    local reqRefreshFunc = function()
        local requestData = {type = refreshTaskType, taskId = taskDojo.taskId}
        GameUtils.Request(Interfaces.OverseaPassCardRefreshTask, requestData, function(request, response)
            if checkInt(response.errCode) == 0 then
                local refreshTasId = checkInt(requestData.taskId)
                local responseData = checkTable(response.data)
                local newTaskData  = checkTable(responseData.task)
                local dailyTimes   = passCardTaskDojo.dailyTaskRefreshTimes
                local eliteTimes   = passCardTaskDojo.eliteTaskRefreshTimes
                local newTaskVo    = nil
                local taskDojoList = nil

                if refreshTaskType == PassCardUtils.TaskType.Daily then
                    dailyTimes   = dailyTimes - 1
                    taskDojoList = passCardTaskDojo.dailyTaskList
                    newTaskVo    = PassCardUtils.GetPassCardDailyTaskVo(newTaskData.id)

                elseif refreshTaskType == PassCardUtils.TaskType.Elite then
                    eliteTimes   = eliteTimes - 1
                    taskDojoList = passCardTaskDojo.eliteTaskList
                    newTaskVo    = PassCardUtils.GetPassCardEliteTaskVo(newTaskData.id)
                end

                -- check free
                if isFreeRefresh then
                    -- update freeTimes
                    passCardTaskDojo.dailyTaskRefreshTimes = dailyTimes
                    passCardTaskDojo.eliteTaskRefreshTimes = eliteTimes

                    -- update times view
                    self:UpdateTaskRefreshCount_()

                else
                    -- update consume
                    GoodsUtils.ConsumeGoods({{goodsId = refreshConsumeId, num = refreshConsumeNum}}, true)
                end

                -- refresh taskDojo
                ---@param taskDojo PassCardTaskInfoDojo
                for taskIndex, taskDojo in ipairs(taskDojoList or {}) do
                    if taskDojo.taskId == refreshTasId then
                        taskDojo:Fill(newTaskData)
                        break
                    end
                end
                GameUtils.Toast(localize('已刷新出一条新任务'))

                -- refresh cellData
                if newTaskVo then
                    cellData.taskVo   = newTaskVo
                    cellData.isUnlock = GameUtils.IsUnlocked(newTaskVo.unlockId, newTaskVo.unlockNum)
                end

                -- refresh listCell
                self.TaskListView:RefreshItemByItemIndex(luaIndex - 1)

                -- update redPoint
                self:UpdateRedPoint_()
            end
        end)
    end

    if isFreeRefresh then
        reqRefreshFunc()
    else
        local goodsVo = GoodsConfMgr:GetInstance():GetGoodsVoById(refreshConsumeId)
        local tipsTxt = localize('是否消耗_num_个_name_立刻获得1次刷新次数', {_num_ = refreshConsumeNum, _name_ = tostring(goodsVo.name)})
        GameUtils.SecondConfirm(tipsTxt, function()
            reqRefreshFunc()
        end)
    end
end


--- 点击一键领取按钮
function UIBattlePassTaskPopupDialog:OnQuickDrawButtonClickHandler_()
    local hasCanDrawTask = false
    for dataIndex, cellData in ipairs(self:GetTaskDataList()) do
        ---@type PassCardTaskInfoDojo
        local taskDojo = checkTable(cellData.taskDojo)
        if taskDojo:CanDraw() then
            hasCanDrawTask = true
            break
        end
    end

    if not hasCanDrawTask then
        GameUtils.Toast(localize('当前没有可领取的任务'))
        return
    end

    local drawTaskType = self:GetCurrentTaskType()
    local requestData  = {type = drawTaskType}
    GameUtils.Request(Interfaces.OverseaPassCardDrawTask, requestData, function(request, response)
        if checkInt(response.errCode) == 0 then
            local responseData = checkTable(response.data)
            
            -- update passCardExp
            local oldTotalExp = passCardComp:GetHomeDojo().passCardTotalExp
            local newTotalExp = checkInt(responseData.exp)
            passCardComp:UpdatePassCardExp(newTotalExp)

            -- show rewards
            CfUtils.DialogOpen(Constants.UITypeIds.UICommonRewardPop, {rewards = {
                {goodsId = passCardComp:GetPassExpGoodsId(), num = newTotalExp - oldTotalExp},
            }})

            -- refresh taskDojo
            for dataIndex, cellData in ipairs(self:GetTaskDataList()) do
                ---@type PassCardTaskInfoDojo
                local taskDojo = checkTable(cellData.taskDojo)
                if taskDojo:CanDraw() then
                    taskDojo.status = Constants.GetStatus.Has
                end
            end

            -- refresh list
            local listDataLength = #self:GetTaskDataList()
            GameUtils.ReloadData(self.TaskListView, listDataLength)
            
            -- update redPoint
            self:UpdateRedPoint_()
        end
    end)
end


return UIBattlePassTaskPopupDialog
