local MAX_SHOW_ITEM_NUM = 10
local TaskState = CommonDefine.TaskState
local CompTaskPlayerLevelItem, Super = NewViewComponent("CompTaskPlayerLevelItem")

function CompTaskPlayerLevelItem:ctor(uiNode, view, data)
  Super.ctor(self, uiNode, view)
  self.ui = UI_Task_Popup_Challenge_Item1Resource(uiNode)
  self.taskTid = data.tid
  self.taskUid = data.uid
  self.taskState = data.state
  self.taskCfg = DT.Task[self.taskTid]
end

function CompTaskPlayerLevelItem:OnEnterComponent()
  local showLevel
  if self.taskCfg.CompleteCond ~= CommonDefine.TaskCond.PlayerLevel then
    showLevel = ""
  else
    showLevel = LT.Text(self.taskCfg.CompleteCondPara[1])
  end
  self:SetText(self.ui.Text_LvevlNum, showLevel)
  self:_CreateRewardTableView()
  self:_RefreshAwards()
  self:_RefreshStatus()
  self:AddButtonClickListener(self.ui.Btn_Get, System.fn(self, self.OnTaskReceive))
  self:SetButtonText(self.ui.Btn_Get, LT.Text("TaskModule_btn_reward"))
  self:SetButtonRedPoint(self.ui.Btn_Get, function()
    return RedPointDataUtils.RedAttrType.Red
  end)
end

function CompTaskPlayerLevelItem:_CreateRewardTableView()
  local cellGameObj = self.ui.UI_Common_Item_WuPin_Type2
  local sizeDelta = cellGameObj.transform.sizeDelta
  local w, h = sizeDelta.x, sizeDelta.y
  self._rewardTableView = self:CreateTableview(self.ui.RewardView, function()
    return #(self._rewards or {})
  end, function(view, index)
    local cell = view:DequeueCell()
    cell = cell or view:AddChild(cellGameObj)
    local viewData = self._rewards[index]
    local itemTid = viewData.itemTid
    
    function viewData.clickFunc()
      ItemDataUtils.ShowItemDetailTips(self.binder, cell.gameObject, nil, itemTid, true)
    end
    
    self:AddViewComponentOnce(cell.gameObject, CompPublicIconItemType2, viewData)
    return cell
  end, function()
    return w, h
  end)
end

function CompTaskPlayerLevelItem:_RefreshAwards()
  local rewardGroup = TaskDataUtils.GetTaskCompleteAward(self.taskTid)
  self._rewards = {}
  for _, reward in ipairs(rewardGroup) do
    table.insert(self._rewards, {
      itemTid = reward.tid,
      itemCount = reward.num
    })
  end
  self._rewardTableView:ReloadData()
end

function CompTaskPlayerLevelItem:_RefreshStatus()
  local lockPlayer = self:LockByPlayerLevel()
  self.ui.Group_Content:SetActive(not lockPlayer)
  self.ui.Group_Nor:SetActive(self.taskState ~= TaskState.Done)
  self.ui.Group_Get:SetActive(self.taskState == TaskState.Receive)
  self.ui.Group_Over:SetActive(self.taskState == TaskState.Done)
  self.ui.Group_Undone:SetActive(self.taskState == TaskState.Doing and not lockPlayer)
  self.ui.Group_Lock:SetActive(lockPlayer)
end

function CompTaskPlayerLevelItem:OnTaskReceive()
  TaskDataUtils.TaskComplete(self.taskUid)
end

function CompTaskPlayerLevelItem:LockByPlayerLevel()
  local playerLevel = PlayerDataUtils.GetLevel()
  local showLevel = self.taskCfg and self.taskCfg.CompleteCondPara and self.taskCfg.CompleteCondPara[1] or 0
  return showLevel > playerLevel + MAX_SHOW_ITEM_NUM
end

return CompTaskPlayerLevelItem
