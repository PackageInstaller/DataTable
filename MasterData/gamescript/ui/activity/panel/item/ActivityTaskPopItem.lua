local ActivityTaskPopItem, Super = System.NewComponent("ActivityTaskPopItem")
local TaskState = CommonDefine.TaskState

function ActivityTaskPopItem:ctor(gameObject, activityTid, taskTid, rewardCb)
  Super.ctor(self)
  self.ui = UI_Pvp_Item_Popup_Award3Resource(gameObject)
  self.activityTid = activityTid
  self.taskTid = taskTid
  self.taskData = TaskDataUtils.GetTaskData(taskTid)
  self.rewardCb = rewardCb
  self.rewardList = self:GetRewardList()
end

function ActivityTaskPopItem:OnBind(binder)
  self.binder = binder
  local taskCfg = DT.Task[self.taskTid] or {}
  binder:SetText(self.ui.Text_Title, LT.Text(taskCfg.Desc))
  local score = table.unpack(taskCfg.CompleteCondPara or {})
  binder:SetText(self.ui.Text_StarNumber, score)
  self:BindRewardButton(binder)
  self:BindAlertButton(binder)
  self.ui.Button_Get:SetActive(self.taskData.state == TaskState.Receive)
  self.ui.Text_C_Lost:SetActive(self.taskData.state == TaskState.UnDone)
  self.ui.Image_Finish:SetActive(self.taskData.state == TaskState.Done)
  self.ui.Text_C_Lost:SetActive(self.taskData.state < TaskState.Receive)
  self:CreataRewardTable()
  self:RefreshTableView()
end

function ActivityTaskPopItem:BindRewardButton(binder)
  binder:BindZ1Button(self.ui.Button_Get, function()
    self:ReqTaskReward()
  end, function()
    local btnType = CommonDefine.BtnType.Normal
    if self.taskData.state == TaskState.Receive then
      btnType = CommonDefine.BtnType.High
    elseif self.taskData.state == TaskState.UnDone then
      btnType = CommonDefine.BtnType.Unclickable
    end
    return btnType
  end, function()
    do return LT.Text end
    return LT.Text, "CommonReceive"
  end, function()
    do return self.GetRedState end
    return self.GetRedState, self
  end)
end

function ActivityTaskPopItem:BindAlertButton(binder)
  binder:BindZ1Button(self.ui.Button_Alert, function()
    local taskCfg = DT.Task[self.taskTid] or {}
    if not taskCfg.UnlockCondDesc then
      return
    end
    Alert.Show(10919, nil, function()
      local cfgPara4 = ActivityCfgUtils.GetCfgField("ActivityPara4", self.activityTid)
      local subPlotGroupId = cfgPara4 and table.unpack(cfgPara4)
      CopyDataUtils.OnClickSubPlotEntry(subPlotGroupId, self.activityTid, true)
    end, nil, taskCfg.UnlockCondDesc)
  end, function()
    return CommonDefine.BtnType.Normal
  end, function()
    do return LT.Text end
    return LT.Text, "TaskAvgUnlockStr"
  end)
  binder:BindToVisible(self.ui.Button_Alert, function()
    if self.taskData.state ~= TaskState.Receive then
      return false
    end
    local taskCfg = DT.Task[self.taskTid] or {}
    if taskCfg.UnlockCondType == CommonDefine.TaskUnlockCondType.StageFirstClear then
      local stageId = taskCfg.UnlockCondPara[1]
      if not MainCopyDataUtils.IsStageDataFirstFinish(stageId) then
        return true
      end
    end
  end)
end

function ActivityTaskPopItem:GetRewardList()
  local taskCfg = DT.Task[self.taskTid] or {}
  local rewards = {}
  for tid, count in table.iteraDouble(taskCfg.CompleteAward or {}) do
    table.insert(rewards, {itemTid = tid, itemCount = count})
  end
  return rewards
end

function ActivityTaskPopItem:ReqTaskReward()
  ActivityDataUtils.ReqGainAward(self.activityTid, self.taskTid, {}, function(svrData)
    if self.rewardCb then
      self.rewardCb(self.taskTid)
    end
  end)
end

function ActivityTaskPopItem:GetRedState()
end

function ActivityTaskPopItem:CreataRewardTable()
  local baseGameObj = self.ui.UI_Dungeous_Item_Award_1
  local sizeDelta = baseGameObj.transform.sizeDelta
  local itemW, itemH = sizeDelta.x, sizeDelta.y
  local itemComps = {}
  self.tableView = UIBasePanel.CreateTableview(self, self.ui.RewardScrollView, function()
    return #self.rewardList
  end, function(view, idx)
    local cell = view:DequeueCell()
    cell = cell or view:AddChild(baseGameObj)
    local gameObj = cell.gameObject
    if itemComps[gameObj] then
      itemComps[gameObj].binder:teardown()
    end
    local itemData = self.rewardList[idx]
    itemComps[gameObj] = self.binder:BindComponent(CommonIconItemType2(gameObj, itemData))
    return cell
  end, function()
    return itemW, itemH
  end, function()
    itemComps = nil
  end)
end

function ActivityTaskPopItem:RefreshTableView()
  self.tableView:ReloadData()
end

return ActivityTaskPopItem
