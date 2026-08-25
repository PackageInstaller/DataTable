local Difficulty = CommonDefine.Difficulty
local T_ScrollRect = typeof(CS.UnityEngine.UI.ScrollRect)
local T_CanvasGroup = typeof(CS.UnityEngine.CanvasGroup)
local MOVE_LEN_SHORT = -130
local MOVE_LEN_LONG = -360
local SCROLL_TIME = 0.333
local CopyMainChapterView, Super = NewClass("CopyMainChapterView", BaseView)
CopyMainChapterView.uiResCls = UI_Copy_MainChapter_ViewResource

function CopyMainChapterView:ctor(difficulty)
  Super.ctor(self)
  self.openDifficulty = difficulty or Difficulty.Normal
  self._isStoryReview = false
  self._curStageChapterName = cd.StageChapterName.StageChapterMorimens
end

function CopyMainChapterView:RefreshOnRendered()
  self:SetIsStoryReview(self._isStoryReview)
end

function CopyMainChapterView:OnBuildView()
  self.switchGroupUI = UI_Chapter_Hard_Swich_Group_NewResource(self.ui.UI_Chapter_Hard_Swich_Group_New)
  self.canvasGroup = self.ui.uiNode:GetComponent(T_CanvasGroup)
  self.rollListRT = self.ui.Content.transform
  self.viewPortRT = self.ui.ViewPort.transform
  self.viewportSize = self.viewPortRT.rect.width
  self.scrollRect = self.ui.uiNode:GetComponent(T_ScrollRect)
  self.scrollWidth = self.ui.uiNode.transform.sizeDelta.x
  self:_AjustCopyChapter()
end

function CopyMainChapterView:_RefreshDifficultyRedDot()
  self:AddRedPoint(self.switchGroupUI.RedDot_Simple, RedDotDefine.DynamicRedDotID.MainStageGroupSimpleRedDotEntry, {
    stageChapterName = self._curStageChapterName
  })
  self:AddRedPoint(self.switchGroupUI.RedDot_Hard, RedDotDefine.DynamicRedDotID.MainStageGroupHardRedDotEntry, {
    stageChapterName = self._curStageChapterName
  })
  self:AddRedPoint(self.switchGroupUI.RedDot_NorNightmare, RedDotDefine.DynamicRedDotID.MainStageGroupNorNightmareRedDotEntry, {
    stageChapterName = self._curStageChapterName
  })
  self:AddRedPoint(self.switchGroupUI.RedDot_Remember, RedDotDefine.DynamicRedDotID.StageGroupRememberRedDotEntry)
end

function CopyMainChapterView:_AjustCopyChapter()
  local _, isUnlock = PlayerDataUtils.IsFeatureUnlock(cd.FeatureId.FirstChapterFinish, 0)
  if isUnlock then
    self.viewPortRT.offsetMin = CS.UnityEngine.Vector2(446, 0)
    self.binder:SetActive(self.ui.Group_StageChapter, true)
    self:SetText(self.ui.Txt_StageChapterName1, LT.Text("StageChapterMorimens_Full"))
    self:SetText(self.ui.Txt_StageChapterName2, LT.Text("StageChapterStarsCameRight_Full"))
  else
    self.viewPortRT.offsetMin = CS.UnityEngine.Vector2(0, 0)
    self.binder:SetActive(self.ui.Group_StageChapter, false)
  end
  local exitBattleGroupTid = CopyMainModel.Instance:GetExitBattleGroupTid()
  if exitBattleGroupTid then
    local stageChapterName = StageGroupCfgUtils.GetCfgField("StageChapterText", exitBattleGroupTid)
    if stageChapterName == cd.StageChapterName.StageChapterStarsCameRight then
      self._curStageChapterName = cd.StageChapterName.StageChapterStarsCameRight
      self:SetZ1Toggle(self.ui.UI_Copy_Item_StageChapter2, true, true)
    else
      self._curStageChapterName = cd.StageChapterName.StageChapterMorimens
    end
  elseif isUnlock then
    self._curStageChapterName = cd.StageChapterName.StageChapterStarsCameRight
    self:SetZ1Toggle(self.ui.UI_Copy_Item_StageChapter2, true, true)
  else
    self._curStageChapterName = cd.StageChapterName.StageChapterMorimens
  end
end

function CopyMainChapterView:_AdjustDifficultyTextSizer()
  local textSimpleMaxSizer = AddLuaCompOnce(self.switchGroupUI.Text_C_Simple, TextWidthAdapter)
  local textDifficultyMaxSizer = AddLuaCompOnce(self.switchGroupUI.Text_C_Difficulty, TextWidthAdapter)
  local textNightmareMaxSizer = AddLuaCompOnce(self.switchGroupUI.Text_C_Nightmare, TextWidthAdapter)
  textSimpleMaxSizer.limitMinWidth = 108
  textDifficultyMaxSizer.limitMinWidth = 108
  textNightmareMaxSizer.limitMinWidth = 108
  textSimpleMaxSizer.limitMaxWidth = 144
  textDifficultyMaxSizer.limitMaxWidth = 144
  textNightmareMaxSizer.limitMaxWidth = 144
  textSimpleMaxSizer:AddNode(self.switchGroupUI.Group_NorSimple, 0)
  textSimpleMaxSizer:AddNode(self.switchGroupUI.CheckmarkSimple, 0)
  textSimpleMaxSizer:AddNode(self.switchGroupUI.Image_lock_1, 0)
  textDifficultyMaxSizer:AddNode(self.switchGroupUI.Group_NorDifficulty, -20)
  textDifficultyMaxSizer:AddNode(self.switchGroupUI.CheckmarkDifficulty, -20)
  textDifficultyMaxSizer:AddNode(self.switchGroupUI.Image_lock_2, -20)
  textNightmareMaxSizer:AddNode(self.switchGroupUI.Group_NorNightmare, -20)
  textNightmareMaxSizer:AddNode(self.switchGroupUI.CheckmarkNightmare, -20)
  textNightmareMaxSizer:AddNode(self.switchGroupUI.Image_lock_3, -20)
end

function CopyMainChapterView:RegisterNotifications()
  self:RegisterLocalNotify(NotifyId.OnCopyMainDifficultyChanged, self._OnCopyDifficultyChanged, self)
  self:RegisterLocalNotify(NotifyId.OnCopyMainStageGroupIdChanged, self._OnCopyStageGroupIdChanged, self)
  self:RegisterNotify(NotifyId.OnStoryReviewRedStatusChanged, self._OnStoryReviewRedStatusChanged, self)
end

function CopyMainChapterView:RegisterEvents()
  self:_RegisterDifficultyTaps()
  self:BindEvent(EventMgr.Instance.TouchBeginEvent, System.fn(self, self._OnTouchBegin))
end

function CopyMainChapterView:_RegisterDifficultyTaps()
  self:AddZ1ToggleValueChangedListener(self.switchGroupUI.Toggle_Simple, function(isOn)
    if isOn then
      self:SwitchDifficulty(Difficulty.Normal)
    end
  end)
  self:AddZ1ToggleValueChangedListener(self.switchGroupUI.Toggle_Difficulty, function(isOn)
    if isOn then
      self:SwitchDifficulty(Difficulty.Hard)
    end
  end)
  self:AddZ1ToggleValueChangedListener(self.switchGroupUI.Toggle_Nightmare, function(isOn)
    if isOn then
      self:SwitchDifficulty(Difficulty.Super)
    end
  end)
  self:AddButtonClickListener(self.switchGroupUI.Image_lock_1, function()
    self:_OnClickDifficultyTypeLock(Difficulty.Normal)
  end)
  self:AddButtonClickListener(self.switchGroupUI.Image_lock_2, function()
    self:_OnClickDifficultyTypeLock(Difficulty.Hard)
  end)
  self:AddButtonClickListener(self.switchGroupUI.Image_lock_3, function()
    self:_OnClickDifficultyTypeLock(Difficulty.Super)
  end)
  self:AddZ1ToggleValueChangedListener(self.switchGroupUI.Toggle_Remember, function(isOn)
    if isOn then
      self:_OnClickReviewStory()
    end
  end)
  self:AddButtonClickListener(self.switchGroupUI.Image_lock_5, function()
    self:_OnClickReviewStory()
  end)
  self:AddZ1ToggleValueChangedListener(self.ui.UI_Copy_Item_StageChapter1, function(isOn)
    if isOn then
      self:_ChangeStageChapter(cd.StageChapterName.StageChapterMorimens)
    end
  end)
  self:AddZ1ToggleValueChangedListener(self.ui.UI_Copy_Item_StageChapter2, function(isOn)
    if isOn then
      self:_ChangeStageChapter(cd.StageChapterName.StageChapterStarsCameRight)
    end
  end)
end

function CopyMainChapterView:OnEnterView()
  self:SetIsStoryReview(false)
  Super.OnEnterView(self)
  self.binder:UpdateLocalizedTextAndResouce(self.ui.UI_Chapter_Item_Chapter)
  self:_CheckDifficulty()
  self:_RequestAllResonanceData()
  self:_RefreshDifficultyRedDot()
  self:ShowByDifficulty(CopyMainModel.Instance.curDifficulty)
  self.canvasGroup.alpha = 0
end

function CopyMainChapterView:_CheckDifficulty()
  if self.openDifficulty then
    CopyMainModel.Instance.curDifficulty = self.openDifficulty
  end
end

function CopyMainChapterView:OnExitView()
  Super.OnExitView(self)
end

function CopyMainChapterView:_ChangeStageChapter(stageChapterName)
  self._curStageChapterName = stageChapterName
  self:_RefreshDifficultyRedDot()
  self:ShowByDifficulty(CopyMainModel.Instance.curDifficulty)
end

function CopyMainChapterView:SwitchDifficulty(difficulty)
  if CopyMainModel.Instance:CheckMainChapterDifficultyModeUnlocked(difficulty, true) then
    if StoryReviewModel.Instance:IsReviewingStory() then
      CopyMainModel.Instance.curDifficulty = nil
    end
    CopyMainModel.Instance:SetCurDifficulty(difficulty)
    EventMgr.Instance.MainCopyDifficultySelect:Dispatch()
  end
end

function CopyMainChapterView:ShowByDifficulty(difficulty)
  self.preStoryReview = StoryReviewModel.Instance:IsReviewingStory()
  self.curStoryReview = false
  self:SetIsStoryReview(false)
  self.preDifficulty = self.difficulty
  self.difficulty = difficulty
  local stageGroupId = CopyMainModel.Instance:GetExitBattleGroupTid() or MainCopyDataUtils.GetLatestCopyID(difficulty)
  CopyMainModel.Instance.stageGroupId = stageGroupId
  self.stageGroupId = stageGroupId
  self:SetGroupIdList(CopyDataUtils.CalculateChapterIndex(difficulty, self._curStageChapterName))
  if difficulty == cd.Difficulty.Normal and self._curStageChapterName == cd.StageChapterName.StageChapterMorimens then
    table.insert(self.groupIdList, 1, DT.GetConstant("PrologueStageGroup"))
  end
  self:_PushReBuildGroupViewCommoand()
  self:_RefreshDifficultiesTap()
  self:_RefreshStoryReview()
end

function CopyMainChapterView:SetIsStoryReview(isReview)
  self._isStoryReview = isReview
  if isReview then
    StoryReviewModel.Instance:StartReviewStory()
  else
    StoryReviewModel.Instance:StopReviewStory()
  end
end

function CopyMainChapterView:SetGroupIdList(list)
  self.groupIdList = list
end

function CopyMainChapterView:_RefreshDifficultiesTap()
  self:_RefreshDifficulty(Difficulty.Normal, self.switchGroupUI.Toggle_Simple, self.switchGroupUI.CheckmarkBgSimple, self.switchGroupUI.Image_lock_1, self.switchGroupUI.Group_NorSimple)
  self:_RefreshDifficulty(Difficulty.Hard, self.switchGroupUI.Toggle_Difficulty, self.switchGroupUI.CheckmarkBgDifficulty, self.switchGroupUI.Image_lock_2, self.switchGroupUI.Group_NorDifficulty)
  self:_RefreshDifficulty(Difficulty.Super, self.switchGroupUI.Toggle_Nightmare, self.switchGroupUI.CheckmarkBgNightmare, self.switchGroupUI.Image_lock_3, self.switchGroupUI.Group_NorNightmare)
end

function CopyMainChapterView:_RefreshDifficulty(difficulty, toggle, checkmarkBg, lock, norGroup)
  local curDifficulty = CopyMainModel.Instance:GetCurDifficulty()
  local isSelected = difficulty == curDifficulty and not StoryReviewModel.Instance:IsReviewingStory()
  self:SetZ1Toggle(toggle, isSelected, true)
  self:SetZ1ToggleInteractable(toggle, not isSelected)
  checkmarkBg:SetActive(isSelected)
  local isUnlocked = CopyMainModel.Instance:CheckMainChapterDifficultyModeUnlocked(difficulty)
  local colorType = isSelected and CommonDefine.ColorType.Light or CommonDefine.ColorType.Normal
  if not isUnlocked then
    colorType = CommonDefine.ColorType.Dark
  end
  self:SetZ1ToggleTextColorType(toggle, colorType)
  lock:SetActive(not isUnlocked)
  norGroup:SetActive(not isSelected and isUnlocked)
end

function CopyMainChapterView:_RefreshStoryReview()
  local isUnlocked = StoryReviewModel.Instance:IsMainCopyReviewStoryUnlock()
  local isReviewing = StoryReviewModel.Instance:IsReviewingStory()
  self:SetZ1Toggle(self.switchGroupUI.Toggle_Remember, isReviewing, true)
  self.switchGroupUI.Group_NorRemember:SetActive(not isReviewing and isUnlocked)
  self.switchGroupUI.CheckmarkBgRemember:SetActive(isReviewing)
  self:SetZ1ToggleInteractable(self.switchGroupUI.Toggle_Remember, not isReviewing)
  local colorType = isReviewing and CommonDefine.ColorType.Light or CommonDefine.ColorType.Normal
  if not isUnlocked then
    colorType = CommonDefine.ColorType.Dark
  end
  self:SetZ1ToggleTextColorType(self.switchGroupUI.Toggle_Remember, colorType)
  self.switchGroupUI.Image_lock_5:SetActive(not isUnlocked)
end

function CopyMainChapterView:_OnClickReviewStory()
  if StoryReviewModel.Instance:IsReviewingStory() then
    return
  end
  local isUnlocked = StoryReviewModel.Instance:IsMainCopyReviewStoryUnlock()
  if not isUnlocked then
    Alert.Show(10905)
    return
  end
  self:ShowByStoryReview()
end

function CopyMainChapterView:ShowByStoryReview()
  local curDifficulty = Difficulty.Normal
  CopyMainModel.Instance.curDifficulty = curDifficulty
  self:SetIsStoryReview(true)
  self.preDifficulty = self.difficulty
  self.preStoryReview = false
  self.curStoryReview = true
  self.difficulty = Difficulty.Normal
  self:SetGroupIdList(CopyDataUtils.CalculateChapterIndex(curDifficulty, self._curStageChapterName))
  self.stageGroupId = self.groupIdList[1]
  for i = 1, #self.groupIdList do
    if StoryReviewModel.Instance:IsCopyStoryShouldReivew(self.groupIdList[i]) then
      self.stageGroupId = self.groupIdList[i]
    else
      break
    end
  end
  CopyMainModel.Instance.stageGroupId = self.stageGroupId
  self:_PushReBuildGroupViewCommoand()
  self:_RefreshDifficultiesTap()
  self:_RefreshStoryReview()
  StoryReviewController.Instance:PlayReviewStory()
end

function CopyMainChapterView:_OnCopyDifficultyChanged(difficulty)
  self:ShowByDifficulty(difficulty)
end

function CopyMainChapterView:_OnClickDifficultyTypeLock(difficulty)
  if CopyMainModel.Instance:CheckMainChapterDifficultyModeUnlocked(difficulty, true) then
    self:ShowByDifficulty(difficulty)
  end
end

function CopyMainChapterView:_OnTouchBegin()
  if UIManager.Instance:GetWindow(Urls.NewbieGuideView) then
    self.scrollRect.horizontal = false
  else
    self.scrollRect.horizontal = true
  end
end

function CopyMainChapterView:_RequestAllResonanceData()
  if not self.groupIdList or 0 == #self.groupIdList then
    return
  end
  for i = 1, #self.groupIdList do
    local groupId = self.groupIdList[i]
    local resonanceGroupId = ResonanceDataUtils.GetReonanceGroupIdByStageGroupId(groupId)
    ResonanceDataUtils.ReqResonanceData(resonanceGroupId, function()
      if not self.ui then
        return
      end
      if i == #self.groupIdList then
        self:_PushReBuildGroupViewCommoand()
      end
    end)
  end
end

function CopyMainChapterView:_PushReBuildGroupViewCommoand()
  self:PushCommand(self._ReBuildGroupView, self)
end

function CopyMainChapterView:_ReBuildGroupView()
  local mainCopyItemNum = #self.groupIdList
  local childCount = self.rollListRT.childCount
  while mainCopyItemNum > childCount do
    Instantiate(self.ui.UI_Chapter_Item_Chapter, self.ui.Content.transform)
    childCount = childCount + 1
  end
  for i = 1, mainCopyItemNum do
    local go = self.rollListRT:GetChild(i - 1).gameObject
    local groupId = self.groupIdList[i]
    if groupId == DT.GetConstant("PrologueStageGroup") and (self.difficulty ~= cd.StageDiffType.Normal or self.curStoryReview) then
      self:SetActive(go, false)
    else
      self:SetActive(go, true)
      local copyItemCls = self:_GetCopyItemCls(groupId)
      local comp = GetLuaComp(go, copyItemCls)
      local animated = true
      if not comp then
        comp = AddLuaComp(go, copyItemCls)
        animated = false
      end
      comp:FillByData(self, groupId, i, self:IsPrologueStageGroup(groupId))
      comp:SetSelect(self.stageGroupId == groupId, animated)
      comp:PlayDiffcultEnterAnim(self.preDifficulty, self.difficulty, self.preStoryReview, self.curStoryReview)
    end
  end
  for i = mainCopyItemNum + 1, childCount do
    local go = self.rollListRT:GetChild(i - 1).gameObject
    go:SetActive(false)
  end
  self:_SetSelectGroupItemToCenter()
  CopyMainModel.Instance:SetExitBattleGroupTid(nil)
end

function CopyMainChapterView:_OnCopyStageGroupIdChanged()
  self.stageGroupId = CopyMainModel.Instance:GetStageGroupID()
  for i = 1, #self.groupIdList do
    local go = self.rollListRT:GetChild(i - 1).gameObject
    local groupId = self.groupIdList[i]
    local comp = AddLuaCompOnce(go, self:_GetCopyItemCls(groupId))
    comp:SetSelect(groupId == self.stageGroupId, true)
  end
  self:_MoveSelectGroupItemToCenter()
  self:_RefreshStoryReview()
end

function CopyMainChapterView:_GetCopyItemCls(stageGroupId)
  return UICompMainCopyItem
end

function CopyMainChapterView:IsPrologueStageGroup(stageGroupId)
  do return CopyDataUtils.IsPrologue end
  return CopyDataUtils.IsPrologue, stageGroupId
end

function CopyMainChapterView:_SetSelectGroupItemToCenter()
  local endPos = self:GetScrollEndPos()
  FrameWaiter.OnNextFrame(function()
    if not IsNil(self.rollListRT) then
      self.rollListRT.anchoredPosition = CS.UnityEngine.Vector2(endPos, self.rollListRT.anchoredPosition.y)
    end
  end, 1)
end

function CopyMainChapterView:_MoveSelectGroupItemToCenter()
  local endPos = self:GetScrollEndPos()
  FrameWaiter.OnNextFrame(function()
    if not IsNil(self.rollListRT) then
      self.rollListRT:DOAnchorPosX(endPos, SCROLL_TIME)
    end
  end, 1)
end

function CopyMainChapterView:_GetSelectGroupItemIndex()
  if 0 == self.stageGroupId then
    return
  end
  for i = 1, #self.groupIdList do
    if self.groupIdList[i] == self.stageGroupId then
      return i
    end
  end
end

function CopyMainChapterView:GetScrollEndPos()
  local rst = 0
  local idx = self:_GetSelectGroupItemIndex()
  if not idx then
    return rst
  end
  local groupLen = #self.groupIdList
  if idx <= 1 then
    return rst
  end
  for i = 2, idx do
    if 2 == i or i == groupLen then
      rst = rst + MOVE_LEN_SHORT
    else
      rst = rst + MOVE_LEN_LONG
    end
  end
  return rst
end

function CopyMainChapterView:_OnStoryReviewRedStatusChanged()
  self:_RefreshStoryReview()
end

return CopyMainChapterView
