local M = BaseClass("PassTaskCtrl", require("UI.Ctrl.Common.BaseSubCtrl"))
local PassMgr = PassDataMgr:GetInstance()

function M:Init()
    local ctrl = require("UI.Ctrl.Pass.PassTaskItemCtrl")
    local view = require("UI.View.Pass.PassTaskItemView")
    self.m_tabIdx = 0
    self.m_isQuick = false -- 是否可以一键领取
    self.m_activityStatusDic = nil -- key:taskType
    self._view.taskloop:Init(ctrl, view)
    self.m_taskTypes = self:_GetTaskTypes()
    local names, icons = self:_GetTabNamesAndIcons()
    local handler = Bind(self, self.OnUpdatePassTaskList)
    self._view.btn_quickGet:onClick(Bind(self, self.OnClickQuickGet))
    self.m_onUpdateEvent = EventMgr:AddListener(UIMessageNames.PASS_TASK_UPDATE, handler)
    self._view.taskTab:InitIconItems(self.m_tabIdx, names, icons, Bind(self, self.OnTabChanged))
end

function M:OnDispose()
    EventMgr:RemoveListener(UIMessageNames.PASS_TASK_UPDATE, self.m_onUpdateEvent)
    self.m_taskTypes = nil
    self.m_onUpdateEvent = nil
    self.m_activityStatusDic = nil
    self._view.taskTab:DisposeAll()
    M.super.OnDispose(self)
end

function M:SetPanelState(value)
    self:SetActive(value)
    if value then
        self._view.taskTab:TabSelect(self.m_tabIdx)
    end
end

function M:OnUpdatePassTaskList()
    local taskType = self.m_taskTypes[self.m_tabIdx + 1]
    local data = PassMgr:GetTaskListByType(taskType)
    self.m_isQuick = PassMgr:HasCompletedTaskByType(taskType)
    self._view.quickGetLock:SetActive(not self.m_isQuick)
    self._view.tipsState:SetState(taskType)
    self._view.taskloop:SetDataList(data)
    self:_CheckTabRedPoint()
end

function M:OnTabChanged(index)
    self.m_tabIdx = index
    self:OnUpdatePassTaskList()
end

function M:OnClickQuickGet()
    if self.m_isQuick then
        local taskType = self.m_taskTypes[self.m_tabIdx + 1]
        PassMgr:QuickGetPassTaskRewards(taskType, Bind(self, self._OnRewardCallBack))
    end
end

--------------------------------------

function M:_GetTaskTypes()
    local list, taskGroups = {}, PassMgr:GetTaskGroups()
    for taskType, _ in pairs(taskGroups or {}) do table.insert(list, taskType) end
    table.sort(list, function(a, b) return a < b end)
    return list
end

function M:_GetTabNamesAndIcons()
    -- 5079:今日任务 5080:本周任务 5081:本期任务
    local names, icons, iconPath = {}, {}, "UI/SpritePics/pass/ui_pass_icon_"
    for i, _ in ipairs(self.m_taskTypes) do
        table.insert(names, ConfigHelper.GetLocalString(5078 + i))
        table.insert(icons, string.format("%s%d.png", iconPath, 8 + i))
    end
    return names, icons
end

function M:_CheckTabRedPoint()
    for i, taskType in ipairs(self.m_taskTypes or {}) do
        local tabItem = self._view.taskTab:GetTabItem(i - 1)
        if tabItem then
            tabItem:SetRedPointParam(0, taskType)
            tabItem:RedPointCheck()
        end
    end
end

function M:_OnRewardCallBack(awardData)
    IRedPointMgr:ForceCheck(RedPointConst.PassCardTaskRedPointChecker)
    GameHelper.ShowGetItems(awardData)
end

return M
