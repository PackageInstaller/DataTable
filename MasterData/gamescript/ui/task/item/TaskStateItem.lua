local TMP_Text = typeof(CS.TMPro.TMP_Text)
local TaskStateItem, Super = System.NewComponent("TaskStateItem")
local MAX_AWORDNUM = 4

function TaskStateItem:ctor(uiNode, data, clickCb)
  Super.ctor(self)
  self.ui = UI_Task_Item_Detail_List_NewResource(uiNode)
  self.data = data
  self.clickCb = clickCb
  self.taskCfg = DT.Task[self.data.tid]
end

function TaskStateItem:OnBind(binder)
  self.binder = binder
  if self.taskCfg.CompleteAward and #self.taskCfg.CompleteAward > MAX_AWORDNUM then
    Logger.Debug("任务奖励配置有误！奖励数量超过三个！")
    return
  end
  local articleIndex = 1
  local awardList = {}
  if self.taskCfg.CompleteAward then
    local itemCountMap = {}
    for key, count in table.iteraDouble(self.taskCfg.CompleteAward) do
      table.insert(awardList, key)
      itemCountMap[key] = count
    end
    for _, itemId in pairs(awardList) do
      local itemObj = self.ui["Article_" .. articleIndex]
      itemObj:SetActive(true)
      local itemNum = itemCountMap[itemId]
      local itemCount
      local itemCfg = DT.Item[itemId]
      if itemCfg.Type == "DropItem" then
        itemCount = ""
      else
        itemCount = itemNum
      end
      local itemData = {itemTid = itemId, itemCount = itemCount}
      binder:BindComponent(CommonIconItemType2(itemObj, itemData))
      articleIndex = articleIndex + 1
    end
  end
  for i = articleIndex, MAX_AWORDNUM do
    self.ui["Article_" .. i]:SetActive(false)
  end
  self.binder:SetText(self.ui.Text_Desc, self.taskCfg.Desc)
  self.binder:BindToRaw(function(_, new)
    self:UpdateShowByState(new)
  end, function()
    return self.data.state
  end)
  self.binder:BindToRaw(function(itemBinder, nVal)
    local count = nVal
    local progressLimit = TaskDataUtils.GetTaskProgressLimit(self.data.tid)
    itemBinder:SetText(self.ui.Text_Count, count .. "/" .. progressLimit)
  end, function()
    return self.data.count
  end)
  self.binder:BindButtonClick(self.ui.Image_Location, function()
    if self.taskCfg and self.taskCfg.JumpTo then
      FuncJumpManager.Instance:JumpFunc(self.taskCfg.JumpTo[1])
    end
  end)
end

function TaskStateItem:UpdateShowByState(curState)
  if curState == CommonDefine.TaskState.Done then
    self:SetDoneShow()
  elseif curState == CommonDefine.TaskState.Receive then
    self:SetReceiveShow()
  elseif curState == CommonDefine.TaskState.Doing then
    self:SetDoingShow()
  end
end

function TaskStateItem:SetDoneShow()
  self.ui.Group_Nor:SetActive(false)
  self.ui.Image_State:SetActive(true)
  self:EnableLocationBtn(false)
  self.ui.Btn_Get:SetActive(false)
end

function TaskStateItem:SetReceiveShow()
  self.ui.Group_Nor:SetActive(true)
  self.ui.Image_State:SetActive(false)
  self:EnableLocationBtn(false)
  self.ui.Btn_Get:SetActive(true)
  self.binder:SetText(self.ui.Btn_Get:GetComponentInChildren(TMP_Text), (LT.Text("TaskAward_Btn_Completed")))
  self.binder:BindButtonClick(self.ui.Btn_Get, System.fn(self, self.BtnReceiveClick))
end

function TaskStateItem:SetDoingShow()
  self.ui.Group_Nor:SetActive(true)
  self.ui.Image_State:SetActive(false)
  self:EnableLocationBtn(true)
  self.ui.Btn_Get:SetActive(false)
end

function TaskStateItem:BtnReceiveClick()
  if self.clickCb then
    Logger.Error("clickCb")
    self.clickCb(self.data.tid, self.data.uid)
  end
  TaskDataUtils.TaskComplete(self.data.uid)
end

function TaskStateItem:EnableLocationBtn(enable)
  local finalEnable = false
  if self.taskCfg.JumpTo and #self.taskCfg.JumpTo > 0 then
    finalEnable = enable
  end
  self.ui.Image_Location:SetActive(finalEnable)
end

return TaskStateItem
