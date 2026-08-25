local AchievementTrophyType = CommonDefine.AchievementTrophyType
local AchievementHistoryDataType = CommonDefine.AchievementHistoryDataType
local TaskState = CommonDefine.TaskState
local MAX_REWARD_NUM = 3
local CompHomeAchievementTaskItem, Super = NewViewComponent("CompHomeAchievementTaskItem")

function CompHomeAchievementTaskItem:ctor(uiNode, view, data)
  Super.ctor(self, uiNode, view)
  self.ui = UI_Research_Panel_Challenge_ItemResource(uiNode)
  self.taskTid = data.tid
  self.taskUid = data.uid
  self.taskState = data.state
  self.isReplaceText = data.isReplaceText
  self.taskCfg = DT.Task[self.taskTid]
  self.achieveHistoryDataFuncMap = {
    [AchievementHistoryDataType.AchieveCommemorativeData_Time] = self.ConvertTimeStamp,
    [AchievementHistoryDataType.AchieveCommemorativeData_Dmg] = self.ShowDirectly
  }
end

function CompHomeAchievementTaskItem:OnEnterComponent()
  self:_RefreshTaskInfo()
  self:_RefreshAwards()
  self:_RefreshStatus()
end

function CompHomeAchievementTaskItem:_RefreshTaskInfo()
  local trophyMap = {
    [AchievementTrophyType.Gold] = self.ui.Image_IconGold,
    [AchievementTrophyType.Silver] = self.ui.Image_IconSilver,
    [AchievementTrophyType.Bronze] = self.ui.Image_IconCopper
  }
  for type, obj in pairs(trophyMap) do
    obj:SetActive(type == self.taskCfg.AchieveQuality)
  end
  local nameTxt = self.taskCfg.Name
  local descTxt = self.taskCfg.Desc
  if self.taskCfg.ReplaceCondition and #self.taskCfg.ReplaceCondition > 0 then
    local isStagesFinished = true
    for i = 1, #self.taskCfg.ReplaceCondition do
      local stageId = self.taskCfg.ReplaceCondition[i] or 0
      local stageCfg = DT.Stage[stageId]
      if stageCfg then
        local stageData = self:_GetStageData(stageCfg.BelongGroup, stageId)
        if not stageData or not stageData.firstRewardDraw then
          isStagesFinished = false
          break
        end
      end
    end
    if not isStagesFinished then
      nameTxt = self.taskCfg.Name
      descTxt = self.taskCfg.Desc
    else
      nameTxt = self.taskCfg.Name2
      descTxt = self.taskCfg.Desc2
    end
  end
  self:SetText(self.ui.Text_Desc1, nameTxt)
  self:SetText(self.ui.Text_Desc2, descTxt)
  local colorType = CommonDefine.ColorType.Dark
  if self.taskState == TaskState.Done then
    colorType = CommonDefine.ColorType.Light
  end
  self:SetTextColorType(self.ui.Text_Desc2, colorType)
  local taskData = TaskDataUtils.GetTaskData(self.taskUid)
  local totalProgress = TaskDataUtils.GetTaskProgressLimit(taskData.tid)
  local progressTxt = LT.Text(string.format("%s/%s", math.min(taskData.count, totalProgress), totalProgress))
  self:SetText(self.ui.Text_Count, progressTxt)
end

function CompHomeAchievementTaskItem:_GetStageData(stageGroupId, stageId)
  local groupData = DataCenter.MainCopyData.allPlots[stageGroupId]
  if not groupData or not groupData.stageList then
    return
  end
  for _, stageData in ipairs(groupData.stageList) do
    if stageData and stageData.stageID == stageId then
      return stageData
    end
  end
end

function CompHomeAchievementTaskItem:_RefreshAwards()
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
      itemRes.Group_Get:SetActive(self.taskState == TaskState.Done)
    end
  end
end

function CompHomeAchievementTaskItem:_RefreshStatus()
  self.ui.Group_Nor:SetActive(self.taskState == TaskState.Receive or self.taskState == TaskState.Doing)
  self.ui.Group_Over:SetActive(self.taskState == TaskState.Done)
  self.ui.Group_Undone:SetActive(self.taskState == TaskState.Doing)
  self.ui.Btn_Get:SetActive(self.taskState == TaskState.Receive)
  self:AddButtonClickListener(self.ui.Btn_Get, System.fn(self, self.OnTaskReceive))
  self:SetButtonText(self.ui.Btn_Get, LT.Text("TaskModule_btn_reward"))
  self:SetButtonRedPoint(self.ui.Btn_Get, function()
    return RedPointDataUtils.RedAttrType.Red
  end)
  local showVal = ""
  if self.taskCfg.AchieveCommemorativeData then
    showVal = DT.CommonID[self.taskCfg.AchieveCommemorativeData].Desc
  end
  self:SetText(self.ui.Text_Accomplish, LT.Text(showVal))
  local taskData = TaskDataUtils.GetTaskData(self.taskUid)
  local historyData = taskData.historyData
  local handleFunc = self.achieveHistoryDataFuncMap[self.taskCfg.AchieveCommemorativeData]
  local showNumVal = ""
  if handleFunc then
    showNumVal = handleFunc(historyData)
  end
  self:SetText(self.ui.Text_Num, LT.Text(showNumVal))
end

function CompHomeAchievementTaskItem:OnTaskReceive()
  TaskDataUtils.TaskComplete(self.taskUid)
end

function CompHomeAchievementTaskItem.ConvertTimeStamp(historyData)
  local y, m, d = TimeUtils.GetTimestampYmdHMS(tonumber(historyData))
  do return string.format, "%s-%s-%s", y, m end
  return string.format, "%s-%s-%s", y, m, d
end

function CompHomeAchievementTaskItem.ShowDirectly(historyData)
  return historyData
end

return CompHomeAchievementTaskItem
