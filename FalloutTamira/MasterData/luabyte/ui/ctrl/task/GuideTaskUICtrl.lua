local GuideTaskUICtrl = BaseClass("GuideTaskUICtrl")

local M = GuideTaskUICtrl

function M:__init(view)
    self._view = view

    self._view.levelScrollView:Init(require("UI.Ctrl.Task.GuideLevelItemCtrl"), 
        require("UI.View.Task.GuideLevelItemView"))
    self._view.listScrollView:Init(require("UI.Ctrl.Task.GuideListItemCtrl"), 
        require("UI.View.Task.GuideListItemView"))

    self._tabLevelChangeEvent = EventMgr:AddListener(UIMessageNames.TASK_TYPE_LEVEL_CHANGE, 
        Bind(self, self.OnTabLevelChangeEvent))
    self._taskRefreshEvent = EventMgr:AddListener(UIMessageNames.TASK_TYPE_REFRESH, 
        Bind(self, self.OnTaskRefreshEvent))
end

function M:Open()
    self:UpdateTasks()
end

function M:UpdateTasks()
    --设置左侧等级列表数据
    TaskDataMgr:UpdateGuideStates()
    TaskDataMgr:SetGuideLevelToUnlock()
    local levelsData = TaskDataMgr:GetGuideLevelsData()
    self._view.levelScrollView:SetDataList(levelsData)

    --设置右侧任务列表数据
    local selectLevelData = TaskDataMgr:GetSelectGuideLevelData()
    local tasksData = TaskDataMgr:GetGuideTasksData(selectLevelData.task)
    self._view.listScrollView:SetDataList(tasksData)
end

function M:OnTabLevelChangeEvent(data)
    local levelsData = TaskDataMgr:GetGuideLevelsData()

    if levelsData then
        for i = 1, #levelsData do
            if levelsData[i].id == data.id then
                levelsData[i].select = true
            else
                levelsData[i].select = false
            end
        end
        TaskDataMgr:SetGuideLevelDatas(levelsData)
    end

    local selectLevelData = TaskDataMgr:GetSelectGuideLevelData()
    local tasksData = TaskDataMgr:GetGuideTasksData(selectLevelData.task)

    self._view.levelScrollView:SetDataList(levelsData)
    self._view.listScrollView:SetDataList(tasksData)
end

function M:OnTaskRefreshEvent(type)
    if type == TaskConst.TaskType.Guide and self._view.rectGuidePanel.gameObject.activeInHierarchy then
        self:UpdateTasks()
    end
end

function M:OnDispose()
    EventMgr:RemoveListener(UIMessageNames.TASK_TYPE_LEVEL_CHANGE, self._tabLevelChangeEvent)
    EventMgr:RemoveListener(UIMessageNames.TASK_TYPE_REFRESH, self._taskRefreshEvent)

    self._view.levelScrollView:Dispose()
    self._view.levelScrollView = nil

    self._view.listScrollView:Dispose()
    self._view.listScrollView = nil
    self._view:OnDispose()
    self._view = nil
end

return GuideTaskUICtrl
