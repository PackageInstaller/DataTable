local ParentChildTaskStateItem, Super = NewViewComponent("ParentChildTaskStateItem")
local MAX_AWORDNUM = 4

function ParentChildTaskStateItem:ctor(uiNode, view, data, clickCb)
  Super.ctor(self, uiNode, view)
  self.ui = UI_Task_Item_Detail_List_NewResource(uiNode)
  self.data = data
  self.clickCb = clickCb
  self.taskCfg = DT.Task[self.data.tid]
end

function ParentChildTaskStateItem:OnEnterComponent()
  self:SetText(self.ui.Text_Desc, self.taskCfg.Desc)
  self:UpdateShowByState(self.data.state)
  local count = self.data.count
  local progressLimit = TaskDataUtils.GetTaskProgressLimit(self.data.tid)
  self:SetText(self.ui.Text_Count, count .. "/" .. progressLimit)
  self:AddButtonClickListener(self.ui.Image_Location, function()
    if self.taskCfg and self.taskCfg.JumpTo then
      FuncJumpManager.Instance:JumpFunc(self.taskCfg.JumpTo[1])
    end
  end)
  self:_RefreshItems()
end

function ParentChildTaskStateItem:_RefreshItems()
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
      local itemRes = UI_Common_Item_WuPin_Type2Resource(itemObj)
      local itemNum = itemCountMap[itemId]
      local itemCount
      local itemCfg = DT.Item[itemId]
      if itemCfg.Type == "DropItem" then
        itemCount = ""
      else
        itemCount = itemNum
      end
      self:SetText(itemRes.Text_Article_Number, itemCount)
      self:SetImage(itemRes.Icon_Common, ItemDataUtils.GetItemIcon(itemId))
      self:SetImage(itemRes.Image_Quality, ItemDataUtils.GetCommonItemBottomQualityFrame(itemCfg, itemRes.Image_Bg_Black))
      self:SetLongPressButtonIntervalTime(itemRes.Btn_Click, tonumber(DT.GetConstant("Role_Press_Time")))
      self:AddShortPressButtonListener(itemRes.Btn_Click, function()
        ItemDataUtils.ShowItemDetailTips(self.view.binder, itemObj, nil, itemId, true)
      end)
      articleIndex = articleIndex + 1
    end
  end
  for i = articleIndex, MAX_AWORDNUM do
    self.ui["Article_" .. i]:SetActive(false)
  end
end

function ParentChildTaskStateItem:UpdateShowByState(curState)
  if curState == CommonDefine.TaskState.Done then
    self:SetDoneShow()
  elseif curState == CommonDefine.TaskState.Receive then
    self:SetReceiveShow()
  elseif curState == CommonDefine.TaskState.Doing then
    self:SetDoingShow()
  end
end

function ParentChildTaskStateItem:SetDoneShow()
  self.ui.Group_Nor:SetActive(false)
  self.ui.Image_State:SetActive(true)
  self:EnableLocationBtn(false)
  self.ui.Btn_Get:SetActive(false)
end

function ParentChildTaskStateItem:SetReceiveShow()
  self.ui.Group_Nor:SetActive(true)
  self.ui.Image_State:SetActive(false)
  self:EnableLocationBtn(false)
  self.ui.Btn_Get:SetActive(true)
  self:SetText(self.ui.Btn_Get, LT.Text("TaskAward_Btn_Completed"))
  self:AddButtonClickListener(self.ui.Btn_Get, System.fn(self, self.BtnReceiveClick))
end

function ParentChildTaskStateItem:SetDoingShow()
  self.ui.Group_Nor:SetActive(true)
  self.ui.Image_State:SetActive(false)
  self:EnableLocationBtn(true)
  self.ui.Btn_Get:SetActive(false)
end

function ParentChildTaskStateItem:BtnReceiveClick()
  if self.clickCb then
    Logger.Error("clickCb")
    self.clickCb(self.data.tid, self.data.uid)
  end
  TaskDataUtils.TaskComplete(self.data.uid)
end

function ParentChildTaskStateItem:EnableLocationBtn(enable)
  local finalEnable = false
  if self.taskCfg.JumpTo and #self.taskCfg.JumpTo > 0 then
    finalEnable = enable
  end
  self.ui.Image_Location:SetActive(finalEnable)
end

return ParentChildTaskStateItem
