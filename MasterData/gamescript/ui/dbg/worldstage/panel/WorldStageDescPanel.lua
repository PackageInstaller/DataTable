local TaskCond = CommonDefine.TaskCond
local ShowingAchieveState = {
  Normal = 1,
  Red = 2,
  Green = 3,
  Hide = 4
}
local showingState2ColorType = {
  [ShowingAchieveState.Normal] = CommonDefine.ColorType.Normal,
  [ShowingAchieveState.Red] = CommonDefine.ColorType.Dark,
  [ShowingAchieveState.Green] = CommonDefine.ColorType.Light
}
local WorldStageDescPanel, Super = System.NewClass("WorldStageDescPanel", UIBasePanel)
WorldStageDescPanel.uiResCls = UI_Dbgcopy_Item_Target_TitleResource

function WorldStageDescPanel:ctor(data)
  Super.ctor(self)
  self.stageId = data.stageId
  self.stageCfg = DT.Stage[self.stageId]
  self.stageNumber = CopyDataUtils.GetStageNameNumber(self.stageId)
  self.stageName = self.stageCfg.Name
  self.achieveList = self.stageCfg.LevelAchieve
  self.stageGroupId = data.stageGroupId
  self.taskList = Vue.reactive(data.taskList)
end

function WorldStageDescPanel:OnBind(binder)
  self.binder = binder
  self:OnBindText(binder)
  self:OnBindEvent(binder)
  self:InitUIBothSidesUI(binder)
  self:OnBindStarDetailGroup(binder)
  self:OnBindAchieveGroup(binder)
  self:_NeedScroll()
  self.renderTimer = binder:BindTimer(0.1, -1, function()
    self:SetRendered(true)
  end)
end

function WorldStageDescPanel:OnBindText(binder)
  binder:BindToText(self.ui.Text_Introduce, function()
    local stageGroupCfg = DT.StageGroup[self.stageGroupId]
    local showBossTargeStageType = DT.GetOriginalConstant("BossObject", {})
    if stageGroupCfg and table.contains(showBossTargeStageType, stageGroupCfg.Type) then
      do return self.GetBossTargetDesc end
      return self.GetBossTargetDesc, self, stageGroupCfg.Type
    end
    local ok, intro = pcall(function()
      do return LT.Text, self:GetCurTaskDesc() end
      return LT.Text, self:GetCurTaskDesc()
    end)
    if ok and intro then
      return intro
    end
    return ""
  end)
  binder:BindToText(self.ui.Text_Iayer, function()
    do return string.format, "%s<space=0.4em>%s", LT.Text(self.stageNumber), LT.Text(self.stageName) end
    return string.format, "%s<space=0.4em>%s", LT.Text(self.stageNumber), LT.Text(self.stageName)
  end)
end

function WorldStageDescPanel:OnBindEvent(binder)
  binder:BindEvent(EventMgr.Instance.OnStoryStart, System.fn(self, self.OnStoryStart))
  binder:BindEvent(EventMgr.Instance.OnStoryEnd, System.fn(self, self.OnStoryEnd))
end

function WorldStageDescPanel:OnBindStarDetailGroup(binder)
  local star = self:GetStageStar()
  if not ((not self.stageCfg.DisplayAchieveUI or 0 ~= self.stageCfg.DisplayAchieveUI) and self.stageCfg.PerfectCondition) or 0 == #self.stageCfg.PerfectCondition then
    self.ui.Group_Star:SetActive(false)
    return
  end
  self.ui.Group_Star:SetActive(true)
  local totalHeight = 0
  local space = 9
  for index, taskId in ipairs(self.stageCfg.PerfectCondition or {}) do
    local taskCfg = DT.Task[taskId]
    local uiNode = self.ui["UI_Dbgcopy_Panel_Main_New_Star" .. index]
    uiNode:SetActive(nil ~= taskCfg)
    if taskCfg then
      local isGot = index <= star
      local uiRes = UI_Dbgcopy_Panel_Main_New_StarResource(uiNode)
      uiRes.Image_Icon:SetActive(isGot)
      binder:SetText(uiRes.Text_StarInfo, taskCfg.Desc)
      binder:SetText(self.ui.Text_Test, taskCfg.Desc)
      CS.Framework.TransformUtil.SetAnchoredPos(uiNode.transform, 0, totalHeight * -1)
      local height = StrUtils.SetPreferredHeight(self.ui.Text_Test)
      self:_SetItemHeight(uiRes.Text_StarInfo, height)
      totalHeight = totalHeight + height + space
    end
  end
  self:_SetItemHeight(self.ui.Group_StarInfo, totalHeight - space)
  totalHeight = totalHeight + 36
  self:_SetItemHeight(self.ui.Group_Star, totalHeight)
end

function WorldStageDescPanel:OnBindAchieveGroup(binder)
  local stageData = MainCopyDataUtils.GetStageData(self.stageId)
  local isHideByEmptyAchieve = not self.achieveList or 0 == #self.achieveList
  local isHideByDisplayAchieveUI = self.stageCfg.DisplayAchieveUI and 0 == self.stageCfg.DisplayAchieveUI
  if not stageData or isHideByEmptyAchieve or isHideByDisplayAchieveUI then
    self.ui.Group_Achievement:SetActive(false)
    return
  end
  local taskStates = {}
  for i = 1, 3 do
    local achieveId = self.achieveList and self.achieveList[i]
    local uiNode = self.ui["UI_Dbgcopy_Panel_Main_New_Achievement" .. i]
    uiNode:SetActive(achieveId)
    if achieveId then
      local uiRes = UI_Dbgcopy_Panel_Main_New_AchievementResource(uiNode)
      binder:BindToRaw(function(cBinder, nVal)
        local achieveState = nVal[1]
        if not achieveState then
          return
        end
        local showType = TaskDataUtils.GetStageTaskShowType(achieveId)
        local showingState = self:GetAchieveShowingState(achieveId, achieveState, showType)
        table.insert(taskStates, showingState)
        if showingState == ShowingAchieveState.Hide then
          uiNode:SetActive(false)
          return
        end
        local tailDesc = ""
        if nil ~= showType then
          local progress, limit = self:GetTaskProgressAndLimit(achieveId)
          tailDesc = TaskDataUtils.GetStageTaskProgressShowText(achieveId, progress, limit)
        end
        cBinder:SetActive(uiRes.Image_Win, showingState == ShowingAchieveState.Green)
        cBinder:SetActive(uiRes.Image_Lose, showingState == ShowingAchieveState.Red)
        cBinder:SetActive(uiRes.Image_Nor, showingState == ShowingAchieveState.Normal)
        local desc = string.format("%s%s", LT.Text(DT.Task[achieveId].Desc), tailDesc)
        cBinder:SetText(self.ui.Text_Test, desc)
        cBinder:SetText(uiRes.Text_Achievement, desc)
        binder:BindToTextColor(uiRes.Text_Achievement, function()
          return showingState2ColorType[showingState]
        end)
        local height = StrUtils.SetPreferredHeight(self.ui.Text_Test)
        self:_SetItemHeight(uiRes.Text_Achievement, height)
        self:_SetItemHeight(uiNode, height)
        self:_NeedScroll()
      end, function()
        local progress = self:GetTaskStatsCount(achieveId)
        local achivement = stageData.achivement or {}
        return {
          achivement[achieveId],
          progress
        }
      end)
    end
  end
  local needShowAchievement = false
  for _, taskState in ipairs(taskStates) do
    if taskState ~= ShowingAchieveState.Hide then
      needShowAchievement = true
      break
    end
  end
  self.ui.Group_Achievement:SetActive(needShowAchievement)
end

function WorldStageDescPanel:GetTaskProgressAndLimit(taskId)
  local cfg = DT.Task[taskId]
  local progress = self:GetTaskStatsCount(taskId) or 0
  local limit = self.GetCompleteCond(cfg)
  return tonumber(progress), tonumber(limit)
end

function WorldStageDescPanel:GetTaskStatsCount(taskId)
  local stageData = WorldStageManager.Instance:GetCurStageData()
  if stageData.achivement and stageData.achivement[taskId] and (stageData.achivement[taskId].count or 0) > 0 then
    return stageData.achivement[taskId].count
  end
  return 0
end

function WorldStageDescPanel.GetCompleteCond(cfg)
  local rst = 0
  if not cfg.CompleteCondPara or not cfg.CompleteCondPara[1] then
    return rst
  end
  if type(cfg.CompleteCondPara[1]) == "string" then
    rst = cfg.CompleteCondPara[2] or 0
  elseif type(cfg.CompleteCondPara[1]) == "number" then
    rst = cfg.CompleteCondPara[1]
  end
  if type(rst) == "string" then
    rst = 0
  end
  return rst
end

function WorldStageDescPanel:GetCurTaskCfg()
  local taskId = self:GetCurTaskId()
  local taskCfg = DT.Task[taskId]
  return taskCfg or {}
end

function WorldStageDescPanel:GetCurTaskDesc()
  local taskCfg = self:GetCurTaskCfg()
  return taskCfg.Desc or ""
end

function WorldStageDescPanel:GetCurTaskId()
  local TaskState = CommonDefine.TaskState
  for _, v in pairs(self.taskList) do
    if not v.lock and (v.state == TaskState.UnDone or v.state == TaskState.Doing) then
      return v.tid
    end
  end
end

function WorldStageDescPanel:GetBossTargetDesc()
  local levelTaskId = table.unpack(self.stageCfg.LevelObjective or {})
  if levelTaskId then
    local taskCfg = DT.Task[levelTaskId] or {}
    local bossId = WorldStageManager.Instance:GetBossId()
    if taskCfg and bossId and DT.MonsterConfig[bossId] then
      local bossCfg = DT.MonsterConfig[bossId]
      do return LT.Textf, taskCfg.Desc, LT.Text(bossCfg.MonsterName) end
      return LT.Textf, taskCfg.Desc, LT.Text(bossCfg.MonsterName)
    end
  end
  return ""
end

function WorldStageDescPanel:_SetItemHeight(go, height)
  if not go then
    return
  end
  local sizeDelta = go.transform.sizeDelta
  local Vector2 = CS.UnityEngine.Vector2(0, 0)
  Vector2.x = sizeDelta.x
  Vector2.y = height
  go.transform.sizeDelta = Vector2
end

function WorldStageDescPanel:_NeedScroll()
  local scrollRect = self.ui.InfoView.gameObject:GetComponent(typeof(CS.UnityEngine.UI.ScrollRect))
  local notDrawImage = scrollRect.gameObject:GetComponent(typeof(CS.UnityEngine.UI.NotDrawImage))
  local viewportMask = scrollRect.viewport.gameObject:GetComponent(typeof(CS.UnityEngine.UI.Mask))
  local maskGrahpic = scrollRect.viewport.gameObject:GetComponent(typeof(CS.UnityEngine.UI.MaskableGraphic))
  CS.Framework.UIUtilTool.RefreshLayoutImmediate(self.ui.Content)
  local contentSizeDelta = self.ui.Content.gameObject.transform.sizeDelta
  local scrollSizeDelta = scrollRect.gameObject.transform.sizeDelta
  notDrawImage.enabled = contentSizeDelta.y >= scrollSizeDelta.y
  viewportMask.enabled = contentSizeDelta.y >= scrollSizeDelta.y
  maskGrahpic.enabled = contentSizeDelta.y >= scrollSizeDelta.y
end

function WorldStageDescPanel:OnUnbind()
  if self.renderTimer then
    self.binder:StopTimer(self.renderTimer)
    self.renderTimer = nil
  end
  if self.timer then
    self.binder:StopTimer(self.timer)
    self.timer = nil
  end
end

function WorldStageDescPanel:OnStoryStart()
  self.ui.uiNode:SetActive(false)
end

function WorldStageDescPanel:OnStoryEnd()
  self.ui.uiNode:SetActive(true)
end

function WorldStageDescPanel:GetStageStar()
  local stageData = MainCopyDataUtils.GetStageData(self.stageId)
  if stageData then
    return stageData.star or 0
  else
    local stageGroupType = DT.StageGroup[self.stageGroupId].Type
    if stageGroupType == CommonDefine.StageGroupType.DisposableSchoolTower or stageGroupType == CommonDefine.StageGroupType.AlternationSchoolTower then
      do return SchoolTowerDataUtils.GetTowerStageStar, self.stageGroupId end
      return SchoolTowerDataUtils.GetTowerStageStar, self.stageGroupId, self.stageId
    end
  end
  return 0
end

function WorldStageDescPanel:GetAchieveShowingState(achieveId, achieveState, showType)
  achieveState = achieveState or CommonDefine.MainCopyAchieveState.NotAchieved
  if achieveState ~= CommonDefine.MainCopyAchieveState.NotAchieved then
    return ShowingAchieveState.Hide
  end
  if not showType then
    return ShowingAchieveState.Normal
  end
  local taskCfg = DT.Task[achieveId]
  local isGreen
  local compareType = TaskDataUtils.GetStageTaskCompareType(achieveId)
  if not compareType then
    return ShowingAchieveState.Normal
  end
  local progress, limit = self:GetTaskProgressAndLimit(achieveId)
  if compareType == CommonDefine.CompareType.Greater then
    isGreen = limit <= progress
    return isGreen and ShowingAchieveState.Green or ShowingAchieveState.Normal
  elseif compareType == CommonDefine.CompareType.Less then
    isGreen = progress <= limit
    return isGreen and ShowingAchieveState.Green or ShowingAchieveState.Red
  end
  return ShowingAchieveState.Normal
end

function WorldStageDescPanel:InitUIBothSidesUI(binder)
  local leftUIGroup = {
    [self.ui.Image_Empty] = 0
  }
  local rightUIGroup = {}
  leftUIGroup, rightUIGroup = UIManager.Instance:InitBothSidesUIOriPos(leftUIGroup, rightUIGroup)
  UIManager.Instance:UIBothSidesAdaptation(leftUIGroup, rightUIGroup, CommonDefine.BothSideUILimitDeltaLen.WorldStage)
end

return WorldStageDescPanel
