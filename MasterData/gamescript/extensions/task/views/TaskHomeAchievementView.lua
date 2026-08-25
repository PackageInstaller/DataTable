local TaskHomeAchievementView, Super = NewClass("TaskHomeAchievementView", TaskParentChildView)
TaskHomeAchievementView.uiResCls = UI_Task_Popup_Challenge2Resource
local AchievementTrophyType = CommonDefine.AchievementTrophyType

function TaskHomeAchievementView:RegisterEvents()
  self:_BindTaskView()
  self:_BindToggleGroups()
  self:BindEvent(EventMgr.Instance.TaskViewUpdate, function(viewIndex)
    if viewIndex == CommonDefine.TaskServerIndex.Achivement then
      self:PushCommand(self._RefreshCommand, self)
    end
  end)
  self:AddButtonClickListener(self.ui.Btn_OneKey, System.fn(self, self._OnOneKeyReward))
end

function TaskHomeAchievementView:RegisterNotifications()
end

function TaskHomeAchievementView:_RefreshCommand()
  self:_RefreshToggleGroup()
  self:_RefreshTaskview()
  self:_RefreshTrophyGroup()
end

function TaskHomeAchievementView:_BindTaskView()
  self.taskView = self:CreateTableview(self.ui.ScrollView_Career_List, function()
    if not self.taskList then
      return 0
    end
    return #self.taskList
  end, function(view, index)
    do return self._TaskCellAtIndex, self, view end
    return self._TaskCellAtIndex, self, view, index
  end, function()
    return 926, 150
  end)
end

function TaskHomeAchievementView:_BindToggleGroups()
  local toggleTypeGroup = TaskHomeAchievementModel.Instance:GetToggleTypeGroup()
  for i, val in ipairs(toggleTypeGroup) do
    local uiNode = self.ui["UI_Common_Item_Toggle" .. i]
    self:AddZ1ToggleValueChangedListener(uiNode, function(isOn)
      if isOn then
        self:_OnSelectTaskType(val)
      end
    end)
  end
end

function TaskHomeAchievementView:_TaskCellAtIndex(view, index)
  local cell = view:DequeueCell()
  cell = cell or view:AddChild(self.ui.UI_Research_Panel_Challenge_Item)
  local taskData = self.taskList[index]
  self:AddViewComponentOnce(cell.gameObject, CompHomeAchievementTaskItem, taskData)
  return cell
end

function TaskHomeAchievementView:OnEnterView()
  TaskHomeAchievementModel.Instance:RebuildAchievementTaskMap()
  BaseView.OnEnterView(self)
  self:_RefreshToggleGroup()
  self:_RefreshTaskview()
  self:_RefreshTrophyGroup()
  local groupContent = self:FindChildComponent(self.root, "Group_Content", typeof(CS.UnityEngine.CanvasGroup))
  if groupContent then
    groupContent.alpha = 1
  end
end

function TaskHomeAchievementView:OnExitView()
  BaseView.OnExitView(self)
end

function TaskHomeAchievementView:RefreshOnRendered()
  self:_RefreshToggleGroup()
  self:_RefreshTaskview()
  self:_RefreshTrophyGroup()
end

function TaskHomeAchievementView:PlayOpenAnimation()
  if self.taskView.isReady then
    self:PlayTableViewFadeInAnim(self.ui.ScrollView_Career_List)
  else
    function self.taskView.reloadFinishCallback()
      self.taskView.reloadFinishCallback = nil
      
      self:PlayTableViewFadeInAnim(self.ui.ScrollView_Career_List)
    end
  end
end

function TaskHomeAchievementView:_RefreshTaskview()
  self.taskList = TaskHomeAchievementModel.Instance:GetCurTaskList()
  self.taskView:SetOffsetWithoutRefresh(0)
  self.taskView:ReloadData()
  print("------------self:_RefreshTaskview()", self:IsHaveReward())
  self:SetButtonState(self.ui.Btn_OneKey, self:IsHaveReward() and CommonDefine.BtnType.High or CommonDefine.BtnType.Unclickable)
end

function TaskHomeAchievementView:_RefreshToggleGroup()
  local toggleTypeGroup = TaskHomeAchievementModel.Instance:GetToggleTypeGroup()
  for i, val in ipairs(toggleTypeGroup) do
    local uiRes = UI_Common_Item_ToggleResource(self.ui["UI_Common_Item_Toggle" .. i])
    local name = LT.Text(DT.CommonID[val].Desc)
    
    local function redDotFunc()
      do return TaskHomeAchievementModel.Instance.GetTaskRedDotStatusByType, TaskHomeAchievementModel.Instance end
      return TaskHomeAchievementModel.Instance.GetTaskRedDotStatusByType, TaskHomeAchievementModel.Instance, val
    end
    
    self:SetText(uiRes.Text_Toggle_Normal, name)
    self:SetText(uiRes.Text_Toggle_Select, name)
    self:AddViewComponentOnce(uiRes.Com_RedDot_Normal, UICompRedDot, CommonDefine.RedDotType.Dot, redDotFunc)
    self:AddViewComponentOnce(uiRes.Com_RedDot_Select, UICompRedDot, CommonDefine.RedDotType.Dot, redDotFunc)
    self:SetZ1Toggle(uiRes.uiNode, TaskHomeAchievementModel.Instance:GetCurTaskType() == val, true)
  end
end

function TaskHomeAchievementView:_OnSelectTaskType(taskType)
  TaskHomeAchievementModel.Instance:SetCurTaskType(taskType)
  self:_RefreshToggleGroup()
  self:_RefreshTaskview()
  self:_RefreshTrophyGroup()
  self:PlayTableViewFadeInAnim(self.ui.ScrollView_Career_List)
end

function TaskHomeAchievementView:_RefreshTrophyGroup()
  local textObjGroup = {
    [AchievementTrophyType.Gold] = self.ui.Text_GoldNum,
    [AchievementTrophyType.Silver] = self.ui.Text_SilverNum,
    [AchievementTrophyType.Bronze] = self.ui.Text_CopperNum
  }
  local trophyNums = TaskHomeAchievementModel:GetTrophyNums()
  for type, obj in pairs(textObjGroup) do
    self:SetText(obj, LT.Text(trophyNums[type]))
  end
end

return TaskHomeAchievementView
