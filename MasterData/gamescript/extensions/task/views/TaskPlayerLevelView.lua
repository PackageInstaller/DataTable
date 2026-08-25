local TaskPlayerLevelView, Super = NewClass("TaskPlayerLevelView", TaskParentChildView)
TaskPlayerLevelView.uiResCls = UI_Task_Popup_ChallengeResource

function TaskPlayerLevelView:ctor()
  BaseView.ctor(self)
  self.disableAsLastSibling = true
end

function TaskPlayerLevelView:RegisterEvents()
  self:_BindTaskView()
  self:BindEvent(EventMgr.Instance.TaskViewUpdate, function(serverIdx)
    if serverIdx == CommonDefine.TaskServerIndex.PlayerLevel then
      self:_RefreshTaskview()
    end
  end)
  self:AddButtonClickListener(self.ui.Btn_OneKey, System.fn(self, self._OnOneKeyReward))
end

function TaskPlayerLevelView:RegisterNotifications()
end

function TaskPlayerLevelView:_BindTaskView()
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

function TaskPlayerLevelView:_TaskCellAtIndex(view, index)
  local cell = view:DequeueCell()
  cell = cell or view:AddChild(self.ui.UI_Task_Popup_Challenge_Item)
  local taskData = self.taskList[index]
  self:AddViewComponentOnce(cell.gameObject, CompTaskPlayerLevelItem, taskData)
  return cell
end

function TaskPlayerLevelView:OnEnterView()
  BaseView.OnEnterView(self)
  local role = DataCenter.playerData.DRole
  self:SetText(self.ui.Text_Name, role.name)
  self:SetText(self.ui.Text_Time, TimeUtils.TimestampToString(role.createTime, TimeUtils.TimeExactType.Day))
  self:SetText(self.ui.Text_Challenge, LT.Text(PlayerDataUtils.GetLevel()))
  local genderCfg = GenderDataUtils.GetGenderCfgByRoleData()
  self:SetImage(self.ui.Image_PLayer, genderCfg and genderCfg.PlayerLevelTaskAvatarRes)
  self:_RefreshTaskview()
end

function TaskPlayerLevelView:RefreshOnRendered()
  self:_RefreshTaskview()
end

function TaskPlayerLevelView:OnExitView()
  BaseView.OnExitView(self)
end

function TaskPlayerLevelView:PlayOpenAnimation()
  if self.taskView.isReady then
    self:JumpToDefaultIdx()
    self:PlayTableViewFadeInAnim(self.ui.ScrollView_Career_List)
  else
    function self.taskView.reloadFinishCallback()
      self.taskView.reloadFinishCallback = nil
      
      self:JumpToDefaultIdx()
      self:PlayTableViewFadeInAnim(self.ui.ScrollView_Career_List)
    end
  end
end

function TaskPlayerLevelView:_RefreshTaskview()
  local curServerIndex = TaskModel.Instance:GetCurServerIndex()
  self.taskList = TaskDataUtils.GetTaskDataListBySvrIdx(curServerIndex)
  table.sort(self.taskList, function(a, b)
    local aCfg = DT.Task[a.tid]
    local bCfg = DT.Task[b.tid]
    return aCfg.BaseSortID < bCfg.BaseSortID
  end)
  self.taskView:ReloadData()
  self:JumpToDefaultIdx()
  self:SetButtonState(self.ui.Btn_OneKey, self:IsHaveReward() and CommonDefine.BtnType.High or CommonDefine.BtnType.Unclickable)
end

function TaskPlayerLevelView:JumpToDefaultIdx()
  if not self.taskView.isReady then
    return
  end
  local firstReceiveIdx = 0
  local firstDoingIdx = 0
  for idx, taskData in pairs(self.taskList) do
    if 0 == firstReceiveIdx and taskData.state == CommonDefine.TaskState.Receive then
      firstReceiveIdx = idx
    end
    if 0 == firstDoingIdx and taskData.state == CommonDefine.TaskState.Doing then
      firstDoingIdx = idx
    end
  end
  local finalJumpIdx = #self.taskList
  if 0 ~= firstReceiveIdx then
    finalJumpIdx = firstReceiveIdx
  elseif 0 ~= firstDoingIdx then
    finalJumpIdx = firstDoingIdx
  end
  local offset = self.taskView:GetOffsetByIndex(finalJumpIdx - 1)
  self.taskView:SetOffset(offset, false)
end

return TaskPlayerLevelView
