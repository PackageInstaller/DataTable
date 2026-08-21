module("task.TaskHallPanel", Class.impl(TabView))

UIRes = UrlManager:getUIPrefabPath("taskHall/TaskHallPanel.prefab")
destroyTime = 0 -- 自动销毁时间-1默认
panelType = 1 -- 窗口类型 1 全屏 2 弹窗
isShow3DBg = 1 --是否使用3D背景（0不开启 1开启同时会禁止UI背景图）

--构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(750, 600)
    self:setTxtTitle(_TT(52003))
    self:setBg("common_bg_015.jpg", false)
    self:setUICode(LinkCode.Task)
end

-- 初始化数据
function initData(self)
    super.initData(self)
    self.showTabType = 2
end

function configUI(self)
    super.configUI(self)
end

function active(self, args)
    super.active(self, args)
    GameDispatcher:addEventListener(EventName.UPDATE_TASK_DATA, self.updateTaskBubble, self)
    GameDispatcher:addEventListener(EventName.UPDATE_TASK_LIST, self.updateTaskBubble, self)
    GameDispatcher:addEventListener(EventName.UPDATE_TASK_AWARD, self.updateTaskBubble, self)
    GameDispatcher:addEventListener(EventName.UPDATE_ALL_TASK_AWARD, self.updateTaskBubble, self)
    GameDispatcher:addEventListener(EventName.UPDATE_TASK_SCORE_AWARD, self.updateTaskBubble, self)

    --gs.LayoutRebuilder.ForceRebuildLayoutImmediate(self:getChildTrans("TabBarNode"))
    self:setGuideTrans("guide_TaskHallPanelTabbar", self:getChildTrans("mGuideGroup"))
    self:updateBubble()
    MoneyManager:setMoneyTidList({ MoneyTid.ANTIEPIDEMIC_SERUM_TID, MoneyTid.ITIANIUM_TID, MoneyTid.GOLD_COIN_TID }, 1)

end

function deActive(self)
    super.deActive(self)
    GameDispatcher:removeEventListener(EventName.UPDATE_TASK_DATA, self.updateTaskBubble, self)
    GameDispatcher:removeEventListener(EventName.UPDATE_TASK_LIST, self.updateTaskBubble, self)
    GameDispatcher:removeEventListener(EventName.UPDATE_TASK_AWARD, self.updateTaskBubble, self)
    GameDispatcher:removeEventListener(EventName.UPDATE_ALL_TASK_AWARD, self.updateTaskBubble, self)
    GameDispatcher:removeEventListener(EventName.UPDATE_TASK_SCORE_AWARD, self.updateTaskBubble, self)
    MoneyManager:setMoneyTidList()
end

function isHorizon(self)
    return false
end

-- 页签父节点
function getTabBarParent(self)
    return self:getChildTrans("TabBarNode")
end

function getTabDatas(self)
    self.tabDataList = {}
    local index = 0
    if funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_TASK_DAILY) then
        index = index + 1
        self.tabDataList[index] = { type = task.HallTabType.DAILY_TASK, content = { task.getHallTabName(task.HallTabType.DAILY_TASK) }, nomalIcon = task.getHallTabIcon(task.HallTabType.DAILY_TASK), selectIcon = task.getHallTabIcon(task.HallTabType.DAILY_TASK) }
    end
    if funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_TASK_WEEK) then
        index = index + 1
        self.tabDataList[index] = { type = task.HallTabType.WEEK_TASK, content = { task.getHallTabName(task.HallTabType.WEEK_TASK) }, nomalIcon = task.getHallTabIcon(task.HallTabType.WEEK_TASK), selectIcon = task.getHallTabIcon(task.HallTabType.WEEK_TASK) }
    end
    return self.tabDataList
end

function getTabClass(self)
    self.tabClassDic[task.HallTabType.DAILY_TASK] = task.DailyTaskTabView
    self.tabClassDic[task.HallTabType.WEEK_TASK] = task.WeekTaskTabView
    return self.tabClassDic
end

function updateBubble(self)
    self:updateTaskBubble()
    -- self:__updateAchievementBubble()
end

function updateTaskBubble(self)
    self:updateDailyTaskBubble()
    self:updateWeekTaskBubble()
end

-- 日常任务红点
function updateDailyTaskBubble(self)
    local tabType = task.HallTabType.DAILY_TASK
    local taskType = task.getTypeByTabType(tabType)
    if (task.DailyTaskManager:judgeIsCanRec(taskType)) then
        self:addBubble(tabType)
    else
        self:removeBubble(tabType)
    end
end

-- 周常任务红点
function updateWeekTaskBubble(self)
    local tabType = task.HallTabType.WEEK_TASK
    local taskType = task.getTypeByTabType(tabType)
    if (task.DailyTaskManager:judgeIsCanRec(taskType)) then
        self:addBubble(tabType)
    else
        self:removeBubble(tabType)
    end
end

function close(self)
    super.close(self)
end

function destroyPanel(self)
    super.destroyPanel(self)
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]