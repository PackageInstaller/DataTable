local TaskState = CommonDefine.TaskState
local MAX_REWARD_NUM = 3
local CompTaskSchoolItem, Super = NewViewComponent("CompTaskSchoolItem")

function CompTaskSchoolItem:ctor(uiNode, view, data)
  Super.ctor(self, uiNode, view)
  self.ui = UI_Task_Popup_Career_ItemResource(uiNode)
  self.taskTid = data.tid
  self.taskUid = data.uid
  self.taskState = data.state
  self.taskCfg = DT.Task[self.taskTid]
  self.banClick = false
end

function CompTaskSchoolItem:OnEnterComponent()
  if self.taskCfg.CompleteCond == CommonDefine.TaskCond.AwakerAppointSchoolBreakLevelNum then
    local schoolId = self.taskCfg.CompleteCondPara[2]
    local imgPath = DT.SchoolConfig[schoolId].Icon
    self:SetImage(self.ui.Image_IconGold, imgPath)
  end
  self:SetText(self.ui.Text_Desc1, LT.Text(self.taskCfg.Name))
  self:SetText(self.ui.Text_Desc2, LT.Text(self.taskCfg.Desc))
  local txtCount = ""
  if self.taskUid then
    local taskData = TaskDataUtils.GetTaskData(self.taskUid)
    if taskData then
      local totalProgress = TaskDataUtils.GetTaskProgressLimit(taskData.tid)
      txtCount = LT.Text(string.format("%s/%s", math.min(taskData.count, totalProgress), totalProgress))
    else
      txtCount = "0/0"
    end
  end
  self:SetText(self.ui.Text_Count, txtCount)
  self:_RefreshItems()
  self:_RefreshStatus()
end

function CompTaskSchoolItem:_RefreshItems()
  local rewardGroup = TaskDataUtils.GetTaskCompleteAward(self.taskTid)
  for i = 1, MAX_REWARD_NUM do
    local obj = self.ui["Article_" .. i]
    obj:SetActive(i <= #rewardGroup)
    if i <= #rewardGroup then
      local itemId = rewardGroup[i].tid
      local itemNum = rewardGroup[i].num
      local itemRes = UI_Common_Item_WuPin_Type2Resource(obj)
      local itemCfg = DT.Item[itemId]
      local itemCount = itemCfg.Type == "DropItem" and "" or itemNum
      self:SetText(itemRes.Text_Article_Number, itemCount)
      self:SetImage(itemRes.Icon_Common, ItemDataUtils.GetItemIcon(itemId))
      self:SetImage(itemRes.Image_Quality, ItemDataUtils.GetCommonItemBottomQualityFrame(itemCfg, itemRes.Image_Bg_Black))
      self:SetLongPressButtonIntervalTime(itemRes.Btn_Click, tonumber(DT.GetConstant("Role_Press_Time")))
      self:AddShortPressButtonListener(itemRes.Btn_Click, function()
        ItemDataUtils.ShowItemDetailTips(self.binder, obj, nil, itemId, true)
      end)
    end
  end
end

function CompTaskSchoolItem:_RefreshStatus()
  self.ui.Group_Nor:SetActive(self.taskState ~= TaskState.Done)
  self.ui.Group_Lock:SetActive(self.taskState == TaskState.Doing)
  self.ui.Group_Over:SetActive(self.taskState == TaskState.Done)
  self.ui.Btn_Get:SetActive(self.taskState == TaskState.Receive)
  self:AddButtonClickListener(self.ui.Btn_Get, System.fn(self, self.OnTaskReceive))
  self:SetButtonText(self.ui.Btn_Get, LT.Text("TaskModule_btn_reward"))
  self:SetButtonRedPoint(self.ui.Btn_Get, function()
    return RedPointDataUtils.RedAttrType.Red
  end)
end

function CompTaskSchoolItem:OnTaskReceive()
  if not self.banClick then
    TaskDataUtils.TaskComplete(self.taskUid)
    self.banClick = true
    self:BindTimer(0.5, 0, nil, function()
      self.banClick = false
    end)
  end
end

return CompTaskSchoolItem
