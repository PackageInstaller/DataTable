local PVPFightRecordItem, Super = System.NewComponent("PVPFightRecordItem")

function PVPFightRecordItem:ctor(gameObject, taskTid, rewardCb)
  Super.ctor(self)
  self.ui = UI_Pvp_Item_Popup_Award3Resource(gameObject)
  self.taskTid = taskTid
  self.taskData = TaskDataUtils.GetTaskData(taskTid)
  self.rewardCb = rewardCb
  self.rewardList = self:GetRewardList()
end

function PVPFightRecordItem:OnBind(binder)
  self.binder = binder
  local taskCfg = DT.Task[self.taskTid] or {}
  binder:SetText(self.ui.Text_Title, LT.Text(taskCfg.Desc))
  local score = table.unpack(taskCfg.CompleteCondPara or {})
  binder:SetText(self.ui.Text_StarNumber, score)
  binder:BindZ1Button(self.ui.Button_Get, function()
    self:ReqTaskReward()
  end, function()
    local btnType = CommonDefine.BtnType.Normal
    if self.taskData.state == CommonDefine.TaskState.Receive then
      btnType = CommonDefine.BtnType.High
    elseif self.taskData.state == CommonDefine.TaskState.UnDone then
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
  self.ui.Button_Get:SetActive(self.taskData.state == CommonDefine.TaskState.Receive)
  self.ui.Text_C_Lost:SetActive(self.taskData.state == CommonDefine.TaskState.UnDone)
  self.ui.Image_Finish:SetActive(self.taskData.state == CommonDefine.TaskState.Done)
  self.ui.Text_C_Lost:SetActive(self.taskData.state < CommonDefine.TaskState.Receive)
  self:CreataRewardTable()
  self:RefreshTableView()
end

function PVPFightRecordItem:GetRewardList()
  local taskCfg = DT.Task[self.taskTid] or {}
  local rewards = {}
  for tid, count in table.iteraDouble(taskCfg.CompleteAward) do
    table.insert(rewards, {itemTid = tid, itemCount = count})
  end
  return rewards
end

function PVPFightRecordItem:ReqTaskReward()
  TaskDataUtils.TaskComplete(self.taskTid, function(svrData)
    if self.rewardCb then
      self.rewardCb(self.taskTid)
    end
  end)
end

function PVPFightRecordItem:GetRedState()
end

function PVPFightRecordItem:CreataRewardTable()
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

function PVPFightRecordItem:RefreshTableView()
  self.tableView:ReloadData()
end

return PVPFightRecordItem
