local UICompSubplotStageListItem, Super = NewViewComponent("UICompSubplotStageListItem")
local TaskUnlockCfg = {
  [124801] = {
    TipsTypeId = 10920,
    JumpFunc = function()
      UIManager.Instance:Reopen(Urls.ActivityMainPanel, {targetActivityTid = 124801})
    end
  }
}

function UICompSubplotStageListItem:ctor(uiNode, view, stageTid)
  Super.ctor(self, uiNode, view)
  self.ui = UI_Chapter_Item_Level_ContentResource(uiNode)
  self.stageTid = stageTid
end

function UICompSubplotStageListItem:RegisterEvents()
  self:AddButtonClickListener(self.ui.Button_Click, System.fn(self, self._OnClick))
end

function UICompSubplotStageListItem:OnEnterComponent()
  self.ui.Image_Icon_Trophy:SetActive(false)
  self:LoadAllLangFont(self.ui.Text_Level_Number)
  self:SetText(self.ui.Text_Level_Number, CopySubplotGroupModel.Instance:GetStageName(self.stageTid))
  self:SetText(self.ui.Text_Achievement, CopySubplotGroupModel.Instance:GetAchivementProgress(self.stageTid))
  local isReviewingStory = StoryReviewModel.Instance:IsReviewingStory()
  local isAvgGroup = CopySubplotGroupModel.Instance:IsStoryStage(self.stageTid)
  isAvgGroup = isAvgGroup or isReviewingStory
  local curStageId = CopySubplotGroupModel.Instance:GetStageID()
  self.ui.Image_Select:SetActive(curStageId == self.stageTid)
  self.ui.Group_AVG:SetActive(isAvgGroup)
  self:_RefreshFightNode()
  self:_UpdateLockStatus()
  if not isReviewingStory then
    self.view:AddRedPoint(self.ui.Com_RedDot, RedDotDefine.DynamicRedDotID.SubplotStageRedDot, {
      stageTid = self.stageTid
    })
  else
    self.ui.Com_RedDot:SetActive(false)
  end
  UpdateBeat.Instance:Add(self.Update, self)
end

function UICompSubplotStageListItem:OnExitComponent()
  UpdateBeat.Instance:Remove(self.Update, self)
  Super.OnExitComponent(self)
end

function UICompSubplotStageListItem:Update()
  self:_UpdateLockStatus()
end

function UICompSubplotStageListItem:_RefreshFightNode()
  local isAvgGroup = CopySubplotGroupModel.Instance:IsStoryStage(self.stageTid)
  isAvgGroup = isAvgGroup or StoryReviewModel.Instance:IsReviewingStory()
  self.ui.Group_Fight:SetActive(not isAvgGroup)
  if isAvgGroup then
    return
  end
  local stageData = CopySubplotGroupModel.Instance:GetStageData(self.stageTid)
  local star = stageData and (stageData.star or 0) or 0
  for i = 1, 3 do
    local obj = self.ui["Star_" .. i]
    if obj then
      obj:SetActive(i <= star)
    end
  end
end

function UICompSubplotStageListItem:_UpdateLockStatus()
  local isUnlocked = CopySubplotGroupModel.Instance:IsStageUnlock(self.stageTid)
  self.ui.Group_Lock:SetActive(not isUnlocked)
  self.ui.Image_Time:SetActive(not CopySubplotGroupModel.Instance:IsStageInOpenTime(self.stageTid))
  if isUnlocked then
    return
  end
  local leftTime = CopySubplotGroupModel.Instance:GetStageUnlockLeftTime(self.stageTid)
  if leftTime <= 0 then
    return
  end
  self:SetText(self.ui.Text_Time, TimeUtils.UnlockedCountDownFormat(leftTime))
end

function UICompSubplotStageListItem:_StageRedFunc()
  local isUnlocked = CopySubplotGroupModel.Instance:IsStageUnlock(self.stageTid)
  if not isUnlocked then
    return
  end
  local red = SubplotRedUtils.GetRedByStageTid(self.stageTid)
  return red
end

function UICompSubplotStageListItem:_OnClick()
  if not CopySubplotGroupModel.Instance:IsStageInOpenTime(self.stageTid) then
    local leftTime = CopySubplotGroupModel.Instance:GetStageUnlockLeftTime(self.stageTid)
    local leftTimeText = TimeUtils.UnlockedCountDownFormat(leftTime)
    local tipStr = DT.TipsType[10647].Desc
    tipStr = LT.Textf(tipStr, leftTimeText)
    Alert.Show(10647, nil, nil, nil, tipStr)
    return
  end
  if not CopySubplotGroupModel.Instance:IsStageConditionOk(self.stageTid) then
    local taskTid = CopySubplotGroupModel.Instance:GetStageTaskCondition(self.stageTid)
    local stageGroupTid = CopyDataUtils.GetStageGroupId(self.stageTid)
    if taskTid and stageGroupTid and TaskUnlockCfg[stageGroupTid] then
      local taskCfg = DT.Task[taskTid]
      local taskCompleteCondPara = taskCfg.CompleteCondPara and taskCfg.CompleteCondPara[1] or 0
      Alert.ShowWithParams(TaskUnlockCfg[stageGroupTid].TipsTypeId, {taskCompleteCondPara}, nil, TaskUnlockCfg[stageGroupTid].JumpFunc)
      return
    else
      local isShowTips = true
      CopySubplotGroupModel.Instance:IsStageConditionOk(self.stageTid, isShowTips)
      return
    end
  end
  SubplotRedUtils.RemoveStageNew(self.stageTid)
  local withoutOpenItem = false
  local jumpActivityTid = CopySubplotGroupModel.Instance:GetJumpActivityTid()
  
  local function challengeCallback()
    StageExitPanelManager.Instance:PushWhenSubplotExit(self.stageTid, jumpActivityTid)
  end
  
  UIManager.Instance:Reopen(Urls.CopyStageDetailView, self.stageTid, challengeCallback, withoutOpenItem, CopySubplotGroupModel.Instance:IsSubplotInActivity())
end

return UICompSubplotStageListItem
