local T_UIAnimationController = typeof(CS.Z1Client.UIAnimationController)
local StageGroupSelectItemLock = CommonDefine.MainCopyBackGroudBGPath.StageGroupSelectItemLock
local StageGroupSelectItemUnlock = CommonDefine.MainCopyBackGroudBGPath.StageGroupSelectItemUnlock
local AddClipToPlay = AnimatorUtils.AddClipToPlay
local UICompMainCopyItem = NewClass("UICompMainCopyItem")

function UICompMainCopyItem:ctor(container)
  self.gameObject = container.gameObject
  self.ui = UI_Chapter_Item_ChapterResource(container.gameObject)
  self.uiAnimController = self.ui.uiNode:GetComponent(T_UIAnimationController)
  self.difficultyAnimCtrl = self.ui.Group_Item:GetComponent(T_UIAnimationController)
  self.notificationsMgr = UIViewNotificationsMgr(self)
  self.notificationsMgr:RegisterNotify(NotifyId.OnResonanceDataChanged, self._OnResonanceDataChanged, self)
end

function UICompMainCopyItem:FillByData(view, stageGroupId, index, isPrologue)
  self.view = view
  self.stageGroupId = stageGroupId
  self.index = index
  self.isPrologue = isPrologue
  view:AddButtonClickListener(self.ui.Button_Click, System.fn(self, self._OnClickCopyStageGroup))
  if not self.stageGroupId then
    self.ui.Group_Expect:SetActive(true)
    self.ui.Group_Normal:SetActive(false)
    self.ui.Group_Lock:SetActive(false)
    return
  end
  self.ui.Group_Lock:SetActive(false)
  self:_FillStageGroupInfo()
  self:_RefreshReddots()
end

function UICompMainCopyItem:_OnResonanceDataChanged(resonanceGroupId)
  if self.isPrologue then
    return
  end
  if resonanceGroupId == self.resonanceGroupId and not IsNil(self.gameObject) then
    self:_FillStageGroupInfo()
  end
end

function UICompMainCopyItem:_RefreshReddots()
  if StoryReviewModel.Instance:IsReviewingStory() or self.isPrologue then
    self.ui.RedDot:SetActive(false)
    return
  end
  self.ui.RedDot:SetActive(true)
  self.view:AddRedPoint(self.ui.RedDot, RedDotDefine.DynamicRedDotID.StageGroupRedDot, {
    stageGroupTid = self.stageGroupId
  })
end

function UICompMainCopyItem:_FillStageGroupInfo()
  if self.isPrologue then
    self:_FillPrologueStageGroupInfo()
    return
  end
  local isUnlocked = self:_IsStageGroupUnlock()
  local cfg = DT.StageGroup[self.stageGroupId]
  self.view:SetText(self.ui.Text_Number, CopyDataUtils.GetMainCopyName(cfg.Sequence or self.index))
  self.view:SetText(self.ui.Text_Name, cfg.Name)
  self.view:SetText(self.ui.Text_Stroy, cfg.Desc)
  self.view:SetActive(self.ui.Image_NameUnknown, not isUnlocked)
  self.view:SetActive(self.ui.Group_Expect, not isUnlocked)
  self.view:SetActive(self.ui.Group_Lock, not isUnlocked)
  self.view:SetActive(self.ui.Text_Stroy, isUnlocked)
  self.view:SetActive(self.ui.Text_Name, isUnlocked)
  local pathIdx = CopyDataUtils.GetIconPathIdx(cfg.ID)
  if isUnlocked then
    self.view:SetImage(self.ui.Image_SScene, string.format(StageGroupSelectItemUnlock, pathIdx))
  end
  local isReviewingStory = StoryReviewModel.Instance:IsReviewingStory()
  self.view:SetActive(self.ui.Text_Progress, false)
  self.view:SetActive(self.ui.Image_Finish, false)
  local resonanceGroupId = ResonanceDataUtils.GetReonanceGroupIdByStageGroupId(self.stageGroupId)
  self.resonanceGroupId = resonanceGroupId
  ResonanceDataUtils.ReqResonanceData(resonanceGroupId, function()
    if not self.ui or IsNil(self.ui.uiNode) then
      return
    end
    local showNum = tostring(cfg.Sequence)
    local percent = MainCopyDataUtils.GetMainCopyProgress(self.stageGroupId)
    self.view:SetText(self.ui.Text_Num01, string.len(showNum) > 1 and showNum or "0" .. showNum)
    self.view:SetText(self.ui.Text_Progress, math.floor(percent * 100) .. "%")
    self.view:SetActive(self.ui.Image_Finish, percent >= 1)
    self.view:SetActive(self.ui.Text_Progress, not isReviewingStory)
  end)
  self.view:SetActive(self.ui.ImageBg2, not isReviewingStory)
  self.view:SetActive(self.ui.Text_C_Tips, not isReviewingStory)
  self.view:SetActive(self.ui.Group_LvProgress, isUnlocked)
  if 1 == cfg.Sequence then
    self.view:BindTimer(0.3, 0, nil, function()
      NewbieGuideManager.Instance:RegisterNewbieGo("GuideGo_BtnChapter1", self.ui.Image_SScene, Urls.CopyMainView)
    end)
  end
end

function UICompMainCopyItem:_FillPrologueStageGroupInfo()
  local isUnlocked = self:_IsStageGroupUnlock()
  local cfg = DT.StageGroup[self.stageGroupId]
  self.view:SetText(self.ui.Text_Number, LT.Text("MainLines_Chapter0"))
  self.view:SetText(self.ui.Text_Name, cfg.Name)
  self.view:SetText(self.ui.Text_Stroy, cfg.Desc)
  self.ui.Image_NameUnknown:SetActive(not isUnlocked)
  self.ui.Group_Expect:SetActive(not isUnlocked)
  self.ui.Group_Lock:SetActive(not isUnlocked)
  self.ui.Text_Stroy:SetActive(isUnlocked)
  self.ui.Text_Name:SetActive(isUnlocked)
  local pathIdx = CopyDataUtils.GetIconPathIdx(cfg.ID)
  if not isUnlocked then
    self.view:SetImage(self.ui.Image_SSceneLock, string.format(StageGroupSelectItemLock, pathIdx))
  else
    self.view:SetImage(self.ui.Image_SScene, string.format(StageGroupSelectItemUnlock, pathIdx))
  end
  self.ui.Text_Progress:SetActive(false)
  self.ui.Image_Finish:SetActive(false)
  self.view:SetText(self.ui.Text_Num01, "00")
  self.view:SetActive(self.ui.Group_LvProgress, false)
end

function UICompMainCopyItem:SetSelect(isSelected, animated)
  if isSelected and self.isExpanded or not isSelected and not self.isExpanded then
    return
  end
  if isSelected then
    self:ExpandItem(animated or false)
  else
    self:ShrinkItem(true)
  end
end

function UICompMainCopyItem:ExpandItem(animated)
  self.isExpanded = true
  EventMgr.Instance.MainCopyStageGroupSelectPlaySmall2Big:Dispatch(self.index)
  if animated then
    self.uiAnimController:PlayState("chapter_small_2_big")
    AudioManager.Instance:PostSoundEvent("UI_STORY_CHAPSELECT_CHAPBOX_OPEN")
  else
    self.uiAnimController:PlayState("chapter_big")
  end
end

function UICompMainCopyItem:ShrinkItem(animated)
  self.isExpanded = false
  if animated then
    self.uiAnimController:PlayState("chapter_big_2_small")
  else
    self.uiAnimController:PlayState("chapter_small")
  end
end

function UICompMainCopyItem:_OnClickCopyStageGroup()
  local curStageGroupId = CopyMainModel.Instance:GetStageGroupID()
  if curStageGroupId == self.stageGroupId then
    AudioManager.Instance:PostSoundEvent("UI_STORY_CHAPSELECT_CHAPBOX_CLICK")
    if StoryReviewModel.Instance:IsReviewingStory() then
      if StoryReviewModel.Instance:IsCopyStoryShouldReivew(self.stageGroupId) then
        self:_EnterChapterView()
      else
        Alert.Show(10904)
      end
    elseif CopyMainModel.Instance:CheckStageGroupUnlocked(self.stageGroupId, true) then
      self:_EnterChapterView()
    end
    return
  end
  if self.stageGroupId then
    CopyMainModel.Instance:SetStageGroupID(self.stageGroupId)
  end
end

function UICompMainCopyItem:_EnterChapterView()
  if self.isPrologue then
    do return self._EnterPrologue end
    return self._EnterPrologue, self, nil, nil, nil, nil, nil, nil
  end
  
  local function OpenMainChapter()
    local model = self.view.binder:createModel(MainCopyModel)
    model:SetStageGroupID(self.stageGroupId)
    model:SetHardMode(CopyMainModel.Instance:GetCurDifficulty())
    MainCopyDataUtils.OpenMainCopyChapterPanel(self.stageGroupId, nil, nil, model)
  end
  
  local tipsId = CopyDataUtils.GetGroupBestExperienceCondTipsId(self.stageGroupId)
  if not tipsId then
    OpenMainChapter()
    return
  end
  local isCloseBestPrompt = ClientDataUtils.GetClientSubData(cd.ClientSubKey.CloseBestPromptToday)
  if 1 == isCloseBestPrompt then
    OpenMainChapter()
    return
  end
  local viewData = {
    tipsTypeTid = tipsId,
    stageTidList = StageGroupCfgUtils.GetCfgField("BestExperienceCondition", self.stageGroupId),
    confirmFunc = OpenMainChapter
  }
  UIManager.Instance:Reopen(Urls.BestExpeirenceMsgView, viewData)
end

function UICompMainCopyItem:_EnterPrologue()
  Alert.Show(20356, nil, function()
    for _, guideId in ipairs(DT.GetOriginalConstant("PrologueResetGuideConfig", {})) do
      GuideManager.Instance:ResetTrigeredGuideId(guideId)
    end
    local plots = table.clone(DT.GetOriginalConstant("PrologueBeginPlot"))
    AvgStoryManager.Instance:ClearSkipPlot()
    self:PlayPlot(plots, function()
      for stageId, stageCfg in pairs(DT.Stage) do
        if stageCfg.BelongGroup == self.stageGroupId then
          StageExitPanelManager.Instance:PushWhenMainCopyExit(stageId)
          WorldStageManager.Instance:CheckOpen(stageId)
          break
        end
      end
    end)
  end)
end

function UICompMainCopyItem:PlayPlot(plots, finishCb)
  if not self.ui or IsNil(self.ui.uiNode) then
    return
  end
  local tid = table.remove(plots, 1)
  local stepName = table.remove(plots, 1)
  if "AvgDialog" == stepName then
    AvgStoryManager.Instance:StartStoryById(tid, nil, nil, function()
      self:PlayPlot(plots, finishCb)
    end)
    return
  end
  if "GetAwaker" == stepName then
    local animData = {
      summonNum = 1,
      skipBeginAnim = true,
      isSpecialAwakerTid = true,
      forbidShare = true
    }
    local summonItemData = {awakerItemTid = tid}
    SummonDataUtils.ShowGainItems(summonItemData)
    UIManager.Instance:Reopen(Urls.SummonNewItemPanel, nil, nil, nil, animData, function()
      self:PlayPlot(plots, finishCb)
    end)
    return
  end
  if tid then
    self:PlayPlot(plots, finishCb)
    return
  end
  if finishCb then
    finishCb()
  end
end

function UICompMainCopyItem:_IsStageGroupUnlock()
  if self.isPrologue then
    return true
  end
  local isUnlocked = false
  if StoryReviewModel.Instance:IsReviewingStory() then
    isUnlocked = StoryReviewModel.Instance:IsCopyStoryShouldReivew(self.stageGroupId)
  else
    isUnlocked = CopyMainModel.Instance:CheckStageGroupUnlocked(self.stageGroupId)
  end
  return isUnlocked
end

function UICompMainCopyItem:PlayDiffcultEnterAnim(oldMode, newMode, oldStoryReview, newStoryReview)
  local clipsToPlay = ""
  if oldStoryReview then
    clipsToPlay = AddClipToPlay(clipsToPlay, "chapter_small_Nightmarey3_Close")
  elseif oldMode ~= newMode then
    if oldMode == CommonDefine.Difficulty.Hard then
      clipsToPlay = AddClipToPlay(clipsToPlay, "chapter_small_Difficulty_Close")
    elseif oldMode == CommonDefine.Difficulty.Super then
      clipsToPlay = AddClipToPlay(clipsToPlay, "chapter_small_Nightmarey_Close")
    end
  end
  if newStoryReview then
    clipsToPlay = AddClipToPlay(clipsToPlay, "chapter_small_Nightmarey3_Open")
  elseif newMode == CommonDefine.Difficulty.Hard then
    clipsToPlay = AddClipToPlay(clipsToPlay, "chapter_small_Difficulty_Open")
  elseif newMode == CommonDefine.Difficulty.Super then
    clipsToPlay = AddClipToPlay(clipsToPlay, "chapter_small_Nightmarey_Open")
  else
    self.view:SetActive(self.ui.Image_BgDifficulty, false)
    self.view:SetActive(self.ui.Image_BgNightmare, false)
    self.view:SetActive(self.ui.Image_BgNightmare3, false)
  end
  if #clipsToPlay > 0 then
    self.difficultyAnimCtrl:PlayMultiState(clipsToPlay, nil)
  end
end

function UICompMainCopyItem:OnDestroy()
  self.resonanceGroupId = nil
  self.notificationsMgr:Clear()
  self.notificationsMgr = nil
end

return UICompMainCopyItem
