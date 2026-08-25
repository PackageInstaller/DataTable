local typeof = _ENV.typeof
local MainCopyAchieveItem, Super = System.NewComponent("MainCopyAchieveItem")

function MainCopyAchieveItem:ctor(uiNode, data)
  Super.ctor(self)
  self.ui = UI_Chapter_Item_Achievement_ListResource(uiNode)
  self.index = data.index
  self.taskId = data.taskId
  self.achieveState = Vue.ref(data.achieveState or CommonDefine.MainCopyAchieveState.NotAchieved)
  self.stageId = data.stageId
  self.getBtnType = Vue.ref(CommonDefine.BtnType.High)
  self.fromStage = data.fromStage
end

function MainCopyAchieveItem:OnBind(binder)
  local cfg = DT.Task[self.taskId]
  binder:BindToText(self.ui.Text_Normal_Tips, function()
    return cfg and LT.Text(cfg.Desc) or ""
  end)
  binder:BindToText(self.ui.Text_Finish_Title, function()
    return cfg and LT.Text(cfg.Name) or ""
  end)
  binder:BindToText(self.ui.Text_Finish_Tips, function()
    return cfg and LT.Text(cfg.Desc) or ""
  end)
  binder:BindToText(self.ui.Text_Normal_Title, function()
    return cfg and LT.Text(cfg.Name) or ""
  end)
  binder:BindToText(self.ui.Text_Progress, function()
    do return LT.Text, self:GetTaskProgressText() end
    return LT.Text, self:GetTaskProgressText()
  end)
  binder:BindToVisible(self.ui.Group_Finish, function()
    return self.achieveState.value >= CommonDefine.MainCopyAchieveState.IsFinish
  end)
  binder:BindToVisible(self.ui.Group_Normal, function()
    do return self.IsNotAchieved end
    return self.IsNotAchieved, self
  end)
  binder:BindToVisible(self.ui.Text_Lost, function()
    if self:IsShowTaskProgress() then
      return false
    end
    return not self.achieveState.value or self:IsNotAchieved()
  end)
  binder:BindToVisible(self.ui.Image_Got, function()
    return self.achieveState.value == CommonDefine.MainCopyAchieveState.IsGot
  end)
  binder:BindToVisible(self.ui.Btn_Get, function()
    return self.achieveState.value == CommonDefine.MainCopyAchieveState.IsFinish
  end)
  binder:BindToVisible(self.ui.Text_Progress, function()
    do return self.IsShowTaskProgress end
    return self.IsShowTaskProgress, self
  end)
  binder:BindZ1Button(self.ui.Btn_Get, function()
    ProtoManager.Instance:ReqServer("GameRequest", "GainStageAchievementRw", function(_)
      local stageData = MainCopyDataUtils.GetStageData(self.stageId)
      if stageData.achivement then
        stageData.achivement[self.taskId] = CommonDefine.MainCopyAchieveState.IsGot
      end
      self.achieveState.value = CommonDefine.MainCopyAchieveState.IsGot
      EventMgr.Instance.AchieveRewarded:Dispatch()
    end, nil, self.stageId, self.taskId)
  end, function()
    return CommonDefine.BtnType.High
  end, function()
    do return LT.Text end
    return LT.Text, "StoryLineTask_String_Available"
  end)
  local rewards = {}
  for itemTid, itemCount in table.iteraDouble(cfg.CompleteAward or {}) do
    table.insert(rewards, {
      tid = itemTid,
      type = CommonDefine.ItemAwardType.Normal,
      num = itemCount,
      isGot = self.achieveState.value == CommonDefine.MainCopyAchieveState.IsGot
    })
  end
  local layout = self.ui.Content:GetComponent(typeof(CS.UnityEngine.UI.HorizontalLayoutGroup))
  binder:BindToCircularListView(self.ui.ScrollView_Award, function()
    return rewards
  end, function(itemBinder, item, index)
    local itemData = {
      itemTid = rewards[index].tid,
      itemCount = rewards[index].num
    }
    itemBinder:BindComponent(CommonIconItemType2(item, itemData))
    if layout then
      if 1 == index then
        layout.enabled = false
      end
      if index == #rewards then
        layout.enabled = true
      end
    end
  end)
end

function MainCopyAchieveItem:IsShowTaskProgress()
  if not self.fromStage then
    return false
  end
  return self:IsStatsTask() and self:IsNotAchieved()
end

function MainCopyAchieveItem:IsStatsTask()
  local statsType = TaskDataUtils.GetStageTaskShowType(self.taskId)
  return nil ~= statsType
end

function MainCopyAchieveItem:IsNotAchieved()
  return self.achieveState.value == CommonDefine.MainCopyAchieveState.NotAchieved
end

function MainCopyAchieveItem:GetTaskStatsCount()
  if not self:IsStatsTask() then
    return 0
  end
  local stageData = WorldStageManager.Instance:GetCurStageData()
  if stageData.achivement[self.taskId] and (stageData.achivement[self.taskId].count or 0) > 0 then
    return stageData.achivement[self.taskId].count
  end
  return 0
end

function MainCopyAchieveItem:GetTaskProgressText()
  if not self:IsStatsTask() then
    return
  end
  local cfg = DT.Task[self.taskId]
  local count = self:GetTaskStatsCount() or 0
  local completeCount = self.GetCompleteCond(cfg)
  local isOk
  local compareType = TaskDataUtils.GetStageTaskCompareType(self.taskId)
  if not compareType then
    return ""
  end
  if compareType == CommonDefine.CompareType.Greater then
    isOk = count >= completeCount
  elseif compareType == CommonDefine.CompareType.Less then
    isOk = count <= completeCount
  end
  local langKey = isOk and "MainLines_CurrentProgressGreen" or "MainLines_CurrentProgressRed"
  if count then
    do return LT.Textf, langKey end
    return LT.Textf, langKey, count
  end
end

function MainCopyAchieveItem.GetCompleteCond(cfg)
  local rst = 0
  if not cfg.CompleteCondPara or not cfg.CompleteCondPara[1] then
    return rst
  end
  if type(cfg.CompleteCondPara[1]) == "string" then
    rst = cfg.CompleteCondPara[2] or 0
  elseif type(cfg.CompleteCondPara[1]) == "number" then
    rst = cfg.CompleteCondPara[1]
  end
  return rst
end

return MainCopyAchieveItem
