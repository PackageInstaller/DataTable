local T_UIAnimationController = typeof(CS.Z1Client.UIAnimationController)
local AddClipToPlay = AnimatorUtils.AddClipToPlay
local StageGroupHardModeIndex = CommonDefine.StageGroupHardModeIndex
local HardModeIndex_Normal = StageGroupHardModeIndex.Normal
local HardModeIndex_Hard = StageGroupHardModeIndex.Hard
local HardModeIndex_Crazy = StageGroupHardModeIndex.Crazy
local SubplotGroupView, Super = System.NewClass("SubplotGroupView", BaseView)
SubplotGroupView.uiResCls = UI_Chapter_Spur_ViewResource

function SubplotGroupView:ctor(stageGroupTid, fromActivityTid, extraParam)
  Super.ctor(self)
  self.stageGroupTid = stageGroupTid
  self.fromActivityTid = fromActivityTid
  CopySubplotGroupModel.Instance:ResetStageData()
  if stageGroupTid ~= CopySubplotGroupModel.Instance.stageGroupId then
    CopySubplotGroupModel.Instance.stageGroupId = stageGroupTid
  end
  if fromActivityTid then
    CopySubplotGroupModel.Instance:SetJumpActivityTid(fromActivityTid)
  end
  self.extraParam = extraParam or {}
  local stageGroupCfg = CopyDataUtils.GetStageGroupConfig(stageGroupTid)
  if CopyExtModel.Instance:CheckIsLinkageActivity(stageGroupCfg.Type) then
    self.uiResCls = UI_Chapter_Special_Spur_ViewResource
  end
end

function SubplotGroupView:_GetUIResCls()
  return self.uiResCls
end

function SubplotGroupView:OnBuildView()
  self.switchGroupUI = UI_Chapter_Hard_Swich_Group_NewResource(self.ui.UI_Chapter_Hard_Swich_Group_New)
  self.uiAnimController = self.ui.uiNode:GetComponent(T_UIAnimationController)
  self.compBtnClosed = self:AddViewComponent(self.ui.UI_Common_Btn_Back3, UICompBtnCloseItem, function()
    self:Close()
  end)
end

function SubplotGroupView:RegisterNotifications()
  self:RegisterNotify(NotifyId.OnCopySubplotViewRefresh, self._OnCopySubplotViewRefresh, self)
  self:RegisterLocalNotify(NotifyId.OnCopySubplotStageGroupIdChanged, self._OnCopySubplotStageGroupIdChanged, self)
  self:RegisterNotify(NotifyId.OnStageDataChanged, self._OnStageDataChanged, self)
  self:BindEvent(EventMgr.Instance.OnStoryReviewEnd, System.fn(self, self._OnStoryReviewEnd))
end

function SubplotGroupView:RegisterEvents()
  self:_CreateStagesTableview()
  self:BindEvent(EventMgr.Instance.OnSyncStageInfoEvent, System.fn(self, self._OnCopySubplotViewRefresh))
  self:AddZ1ToggleValueChangedListener(self.switchGroupUI.Toggle_Simple, System.fn(self, self._OnClickSimpleDifficulty), System.fn(self, self._OnClickSimpleDifficultyLock))
  self:AddZ1ToggleValueChangedListener(self.switchGroupUI.Toggle_Difficulty, System.fn(self, self._OnClickHardDifficulty), System.fn(self, self._OnClickHardDifficultyLock))
  self:AddZ1ToggleValueChangedListener(self.switchGroupUI.Toggle_Nightmare, System.fn(self, self._OnClickNightmareDifficulty), System.fn(self, self._OnClickNightmareDifficultyLock))
  self:AddButtonClickListener(self.ui.Btn_Progress_1, System.fn(self, self._OnClickStarPrize))
  self:AddZ1ToggleValueChangedListener(self.switchGroupUI.Toggle_Remember, function(isOn)
    if isOn then
      self:_OnClickReviewStory()
    end
  end)
  self:AddButtonClickListener(self.switchGroupUI.Image_lock_5, function()
    self:_OnClickReviewStory()
  end)
  if self.ui.Btn_Review then
    self:AddButtonClickListener(self.ui.Btn_Review, System.fn(self, self._OnClickBtnReview))
  end
end

function SubplotGroupView:_OnClickBtnReview()
  local showPopupAvgTids = StageGroupCfgUtils.GetShowPopupAvgTids(self.stageGroupTid, self.fromActivityTid)
  if 0 == #showPopupAvgTids then
    return
  end
  if 1 == #showPopupAvgTids then
    local avgTid = showPopupAvgTids[1]
    AvgStoryManager.Instance:StartStoryById(avgTid)
    return
  end
  UIManager.Instance:Show(Urls.SubplotAvgReviewView, self.stageGroupTid, self.fromActivityTid)
end

function SubplotGroupView:_CreateStagesTableview()
  self.tableview = self:CreateTableview(self.ui.ScrollView, function()
    return self.stageList and #self.stageList or 0
  end, function(view, index)
    local cell = self:DequeueCell(view, self.ui.ChapterItem)
    self:AddViewComponentOnce(cell.gameObject, UICompSubplotStageListItem, self.stageList[index])
    return cell
  end, function()
    return 576, 130
  end)
  
  function self.tableview.reloadFinishCallback()
    if 0 == #self.stageList then
      return
    end
    self.tableview:SetOffset(self.tableview:GetMaxOffset(), false)
  end
end

function SubplotGroupView:GetTempDependenciesResources()
  return {
    CopySubplotGroupModel.Instance:GetBackgroundImage()
  }
end

function SubplotGroupView:OnEnterView()
  StoryReviewModel.Instance:StopReviewStory()
  self:_ReqRelatedStageGroupData()
  self:_RefreshGroupView()
  self:EnableUIEffect()
  self.uiAnimController:PlayState("UI_Chapter_Panel_Spur_Open")
  CopyController.Instance:CheckShowUnlockCompensateView(CopySubplotGroupModel.Instance.stageGroupId)
  self:_PlayAudioEvent()
  self:_SetStageGroupLogo()
end

function SubplotGroupView:_RefreshDiffucultyRedDots()
  self:_AddRedDot(self.switchGroupUI.RedDot_Simple, HardModeIndex_Normal)
  self:_AddRedDot(self.switchGroupUI.RedDot_Hard, HardModeIndex_Hard)
  self:_AddRedDot(self.switchGroupUI.RedDot_NorNightmare, HardModeIndex_Crazy)
end

function SubplotGroupView:_RefreshStarsRedDots()
  self:AddRedPoint(self.ui.RedDot_Stars, RedDotDefine.DynamicRedDotID.StageGroupStarsProgRedDot, {
    stageGroupTid = CopySubplotGroupModel.Instance.stageGroupId
  })
end

function SubplotGroupView:OnExitView()
  Super.OnExitView(self)
  self:_ResumeAudioEvent()
end

function SubplotGroupView:_PlayAudioEvent()
  local stageGroupTid = CopySubplotGroupModel.Instance.stageGroupId
  local groupCfg = DT.StageGroup[stageGroupTid]
  if groupCfg and CopyExtModel.Instance:CheckIsSpecialSubPlot(groupCfg.Type) then
    self.audioEvent = "Set_State_Aa_Interface_Dream"
    AudioManager.Instance:PostSoundEvent(self.audioEvent)
  end
end

function SubplotGroupView:_ResumeAudioEvent()
  if self.audioEvent then
    local stageGroupTid = CopySubplotGroupModel.Instance.stageGroupId
    local groupCfg = DT.StageGroup[stageGroupTid]
    if groupCfg and CopyExtModel.Instance:CheckIsSpecialSubPlot(groupCfg.Type) then
      self:_ResumeDefaultBgAudioEvent()
    end
  end
  self.audioEvent = nil
end

function SubplotGroupView:_RefreshGroupView()
  self:SetText(self.ui.Text_Gamecopy_Name, CopySubplotGroupModel.Instance:GetStageGroupName())
  self:SetText(self.ui.Text_Description, CopySubplotGroupModel.Instance:GetStageGroupDesc())
  self:SetImageSync(self.ui.Image_SScene_BG, CopySubplotGroupModel.Instance:GetBackgroundImage())
  StrUtils.SetPreferredHeight(self.ui.Text_Description)
  self:_RefreshPortraitComp()
  self:_RefreshStarsPrized()
  self:_RefreshActivityTimer()
  self:_RefreshAchievementGroup()
  self:_RefreshTogglesGroup()
  self:_RefreshStoryReview()
  self:_RefreshStoryReviewRedStaus()
  self:_RefreshResonanceGroup()
  self:_RefreshAvgGroup()
  self:_RefreshDiffucultyRedDots()
  self:_RefreshStarsRedDots()
  local stageList = CopySubplotGroupModel.Instance:GetStageList()
  table.sort(stageList, function(a, b)
    local aCfg = DT.Stage[a]
    local bCfg = DT.Stage[b]
    return aCfg.Sequence < bCfg.Sequence
  end)
  self.stageList = stageList
  self.tableview:ReloadData()
end

function SubplotGroupView:_RefreshAvgGroup()
  if not self.ui.Btn_Review then
    return
  end
  local showPopupAvgTids = StageGroupCfgUtils.GetShowPopupAvgTids(self.stageGroupTid, self.fromActivityTid)
  if 0 == #showPopupAvgTids then
    self:SetActive(self.ui.Btn_Review, false)
    return
  end
  self:SetActive(self.ui.Btn_Review, true)
end

function SubplotGroupView:Close()
  self:_ClearActivityTimer()
  UIManager.Instance:ReShowBehindPanel(self)
  self.uiAnimController:StopPlayableGraph()
  self.uiAnimController:PlayState("UI_Chapter_Panel_Spur_Close", function()
    Super.Close(self)
  end)
end

function SubplotGroupView:_RefreshStarsPrized()
  local hasPrized = CopySubplotGroupModel.Instance:HasStarPrize()
  self.ui.Image_Progress:SetActive(hasPrized)
  if not hasPrized then
    return
  end
  self:SetText(self.ui.Text_Originally, CopySubplotGroupModel.Instance:GetCurrStageGroupTotalStar())
  self:SetText(self.ui.Text_Extent, CopySubplotGroupModel.Instance:GetCurrStageGroupStar())
end

function SubplotGroupView:_RefreshPortraitComp()
  local curGroupTid = CopySubplotGroupModel.Instance.stageGroupId
  if not curGroupTid or 0 == curGroupTid then
    return
  end
  local stageGroupConfig = CopyDataUtils.GetStageGroupConfig(curGroupTid)
  if not stageGroupConfig then
    return
  end
  local SubPlotRoleImage = DT.GetOriginalConstant("SubPlotRoleImage")
  for i = 1, #SubPlotRoleImage, 2 do
    local groupTid = SubPlotRoleImage[i]
    local roleImage = SubPlotRoleImage[i + 1]
    if groupTid == curGroupTid then
      local roleImageGo = self.ui[roleImage]
      if roleImageGo then
        roleImageGo:SetActive(true)
      end
      return
    end
  end
  local awakerTid = stageGroupConfig.RelatedAwaker
  if not awakerTid then
    return
  end
  if not DT.AwakerConfig[awakerTid] then
    local awakerSkinTid = awakerTid
    local clothersResNu = DT.AwakerSkin[awakerSkinTid].ClothersResNum
    if clothersResNu then
      self:AddViewComponentOnce(self.ui.Image_Awaker, UICompAwakerPortrait, {
        awakerTid = awakerTid,
        portraitAlign = CommonDefine.PortraitAlign.Center,
        portraitNo = clothersResNu
      })
    end
  else
    self:AddViewComponentOnce(self.ui.Image_Awaker, UICompAwakerPortrait, {
      awakerTid = awakerTid,
      portraitAlign = CommonDefine.PortraitAlign.Center
    })
  end
end

function SubplotGroupView:_RefreshActivityTimer()
  self.ui.Group_Tab_Special:SetActive(false)
end

function SubplotGroupView:_CreateActivityTimer()
  self:_ClearActivityTimer()
  local curGroupTid = CopySubplotGroupModel.Instance.stageGroupId
  local activityData = ActivityManager.Instance:GetOpeningSubplotActivity(curGroupTid)
  if not activityData then
    return
  end
  self.activityTimer = self:BindTimer(1, -1, function()
    local leftTime = ActivityDataUtils.GetLeftTime(activityData) or 0
    leftTime = leftTime - 1
    if leftTime <= 0 then
      self:_ClearActivityTimer()
      return
    end
    self:SetText(self.ui.Text_Time, TimeUtils.ActivityCountDownFormat(leftTime))
  end, function()
    self:SetText(self.ui.Text_Time, "")
    self:_ClearActivityTimer()
  end)
end

function SubplotGroupView:_ClearActivityTimer()
  if self.activityTimer then
    self:StopTimer(self.activityTimer)
    self.activityTimer = nil
  end
end

function SubplotGroupView:_RefreshAchievementGroup()
  local curGroupTid = CopySubplotGroupModel.Instance.stageGroupId
  self:AddViewComponentOnce(self.ui.Group_Success, UICompSatgeGroupArchiveGroup, curGroupTid)
end

function SubplotGroupView:_SetStageGroupLogo()
  if not self.ui.Image_Logo then
    return
  end
  local curGroupTid = CopySubplotGroupModel.Instance.stageGroupId
  local stageGroupCfg = CopyDataUtils.GetStageGroupConfig(curGroupTid)
  if stageGroupCfg and stageGroupCfg.DailyIcon and stageGroupCfg.DailyIcon[3] then
    self:SetActive(self.ui.Image_Logo, true)
    local langCode = DataCenter.gameData.CurrTextLanguage
    local targetLogoName
    local firstLogoName = stageGroupCfg.DailyIcon[3]
    for i = 3, #stageGroupCfg.DailyIcon do
      local iconName = stageGroupCfg.DailyIcon[i]
      if iconName and type(iconName) == "string" then
        local suffix = string.match(iconName, "_(%w+)$")
        if suffix == langCode then
          targetLogoName = iconName
          break
        end
      end
    end
    if not targetLogoName then
      local prefix = string.match(firstLogoName, "(.+)_%w+$")
      targetLogoName = prefix and prefix .. "_COM" or firstLogoName
    end
    local logoPath = string.format("UIResources/AtlasSource/UI_Chapter_Image/%s.png", targetLogoName)
    self:SetImage(self.ui.Image_Logo, logoPath)
  else
    self:SetActive(self.ui.Image_Logo, false)
  end
end

function SubplotGroupView:_OnClickStarPrize()
  local curGroupTid = CopySubplotGroupModel.Instance.stageGroupId
  local stageGroupCfg = CopyDataUtils.GetStageGroupConfig(curGroupTid)
  if not stageGroupCfg then
    return
  end
  local stageGroupDrop = stageGroupCfg.StageGroupDrop
  local star = CopySubplotGroupModel.Instance:GetCurrStageGroupStar()
  local curGroupData = CopySubplotGroupModel.Instance:GetGroupData()
  local data = curGroupData.starGainInfo
  UIManager.Instance:Reopen(Urls.MainCopyProgressRewardPanel, stageGroupDrop, star, curGroupTid, data)
end

function SubplotGroupView:_RefreshTogglesGroup()
  local isPureAvgStageGroup = true
  for _, hardModeIndex in pairs(CommonDefine.StageGroupHardModeIndex) do
    local stageGroupId = CopySubplotGroupModel.Instance:StageGroupHardModeIndex2Id(hardModeIndex)
    if not CopySubplotGroupModel.Instance:CheckIsPureAvgStageGroup(stageGroupId) then
      isPureAvgStageGroup = false
      break
    end
  end
  self.switchGroupUI.Group_Toggle:SetActive(not isPureAvgStageGroup)
  if not isPureAvgStageGroup then
    self:_RefreshGroupToggle(HardModeIndex_Normal, self.switchGroupUI.Toggle_Simple, self.switchGroupUI.Image_lock_1, self.switchGroupUI.CheckmarkBgSimple, self.switchGroupUI.Group_NorSimple)
    self:_RefreshGroupToggle(HardModeIndex_Hard, self.switchGroupUI.Toggle_Difficulty, self.switchGroupUI.Image_lock_2, self.switchGroupUI.CheckmarkBgDifficulty, self.switchGroupUI.Group_NorDifficulty)
    self:_RefreshGroupToggle(HardModeIndex_Crazy, self.switchGroupUI.Toggle_Nightmare, self.switchGroupUI.Image_lock_3, self.switchGroupUI.CheckmarkBgNightmare, self.switchGroupUI.Group_NorNightmare)
  end
end

function SubplotGroupView:_RefreshGroupToggle(difficultyIndex, toggle, lock, bg, norGroup)
  local curDifficultyIndex = CopySubplotGroupModel.Instance:GetCurStageGroupHardModeIndex()
  local isSelected = difficultyIndex == curDifficultyIndex and not StoryReviewModel.Instance:IsReviewingStory()
  self:SetZ1Toggle(toggle, isSelected, true)
  local stageGroupId = CopySubplotGroupModel.Instance:StageGroupHardModeIndex2Id(difficultyIndex)
  if not stageGroupId or 0 == stageGroupId then
    toggle:SetActive(false)
    return
  end
  toggle:SetActive(true)
  local isUnlocked = CopySubplotGroupModel.Instance:IsStageGroupFeatureUnlock(stageGroupId)
  local colorType = isSelected and CommonDefine.ColorType.Light or CommonDefine.ColorType.Normal
  if not isUnlocked then
    colorType = CommonDefine.ColorType.Dark
  end
  self:SetZ1ToggleTextColorType(toggle, colorType)
  self:SetZ1ToggleInteractable(toggle, not isSelected)
  lock:SetActive(not isUnlocked)
  bg:SetActive(isSelected and isUnlocked)
  norGroup:SetActive(not isSelected and isUnlocked)
end

function SubplotGroupView:_RefreshResonanceGroup()
  if StoryReviewModel.Instance:IsReviewingStory() then
    self.ui.Btn_Resonance:SetActive(false)
    return
  end
  local curDifficultyIndex = CopySubplotGroupModel.Instance:GetCurStageGroupHardModeIndex()
  local stageGroupId = CopySubplotGroupModel.Instance:StageGroupHardModeIndex2Id(curDifficultyIndex)
  local resonanceGroupId = ResonanceDataUtils.GetReonanceGroupIdByStageGroupId(stageGroupId)
  self:AddViewComponentOnce(self.ui.Btn_Resonance, UICompResonanceGroup, {
    resonanceGroupId = resonanceGroupId,
    isShowExtraItem = true,
    stageGroupTid = stageGroupId
  })
end

function SubplotGroupView:_OnClickDifficulty(curDifficultyIndex)
  local isReviewingStory = StoryReviewModel.Instance:IsReviewingStory()
  if StoryReviewModel.Instance:IsReviewingStory() then
    self.curDifficultyIndex = nil
    StoryReviewModel.Instance:StopReviewStory()
  end
  local stageGroupId = CopySubplotGroupModel.Instance:StageGroupHardModeIndex2Id(curDifficultyIndex)
  local isUnlocked = CopySubplotGroupModel.Instance:IsStageGroupFeatureUnlock(stageGroupId)
  if not isUnlocked then
    local feature = CopyDataUtils.GetStageGroupFeature(stageGroupId)
    PlayerDataUtils.AlertLockedTips(feature, stageGroupId)
    return
  end
  if self.curDifficultyIndex == curDifficultyIndex then
    return
  end
  local lastDifficultyIndex = isReviewingStory and curDifficultyIndex or self.curDifficultyIndex
  self.curDifficultyIndex = curDifficultyIndex
  self:_PlayDifficultySwitchAnim(lastDifficultyIndex, curDifficultyIndex, isReviewingStory, false)
  CopySubplotGroupModel.Instance:SetStageGroupID(stageGroupId)
end

function SubplotGroupView:_PlayDifficultySwitchAnim(lastIndex, curIndex, lastStoryReview, curStoryReview)
  local clipsToPlay = ""
  if lastStoryReview then
    clipsToPlay = AddClipToPlay(clipsToPlay, "UI_Chapter_Panel_Spur_Remember_Close")
  elseif lastIndex == HardModeIndex_Hard then
    clipsToPlay = AddClipToPlay(clipsToPlay, "UI_Chapter_Panel_Spur_Difficulty_Close")
  elseif lastIndex == HardModeIndex_Crazy then
    clipsToPlay = AddClipToPlay(clipsToPlay, "UI_Chapter_Panel_Spur_Nightmare_Close")
  end
  if curStoryReview then
    clipsToPlay = AddClipToPlay(clipsToPlay, "UI_Chapter_Panel_Spur_Remember_Open")
  elseif curIndex == HardModeIndex_Hard then
    clipsToPlay = AddClipToPlay(clipsToPlay, "UI_Chapter_Panel_Spur_Difficulty_Open")
  elseif curIndex == HardModeIndex_Crazy then
    clipsToPlay = AddClipToPlay(clipsToPlay, "UI_Chapter_Panel_Spur_Nightmare_Open")
  end
  if #clipsToPlay > 0 then
    self.uiAnimController:StopPlayableGraph()
    self.uiAnimController:PlayMultiState(clipsToPlay, function()
    end)
  end
end

function SubplotGroupView:_OnClickSimpleDifficulty(isOn)
  if not isOn then
    return
  end
  self:_OnClickDifficulty(HardModeIndex_Normal)
end

function SubplotGroupView:_OnClickSimpleDifficultyLock()
  self:_OnClickDifficulty(HardModeIndex_Normal)
end

function SubplotGroupView:_OnClickHardDifficulty(isOn)
  if not isOn then
    return
  end
  self:_OnClickDifficulty(HardModeIndex_Hard)
end

function SubplotGroupView:_OnClickHardDifficultyLock()
  self:_OnClickDifficulty(HardModeIndex_Hard)
end

function SubplotGroupView:_OnClickNightmareDifficulty(isOn)
  if not isOn then
    return
  end
  self:_OnClickDifficulty(HardModeIndex_Crazy)
end

function SubplotGroupView:_OnClickNightmareDifficultyLock()
  self:_OnClickDifficulty(HardModeIndex_Crazy)
end

function SubplotGroupView:_OnCopySubplotStageGroupIdChanged()
  self:_RefreshGroupView()
end

function SubplotGroupView:_OnStageDataChanged(stageGroupId)
  local curStageGroupId = CopySubplotGroupModel.Instance:GetStageGroupID()
  if not CopyDataUtils.IsStageGroupRelatedDifficulty(curStageGroupId, stageGroupId) then
    return
  end
  if not self.tableview then
    return
  end
  CopySubplotGroupModel.Instance:ResetStageData()
  self:_RefreshGroupView()
end

function SubplotGroupView:_ReqRelatedStageGroupData()
  local stageGroupId = CopySubplotGroupModel.Instance:GetStageGroupID()
  if not stageGroupId or 0 == stageGroupId then
    return
  end
  CopyController.Instance:ReqSubplotBranchStageData({stageGroupId})
end

function SubplotGroupView:_OnCopySubplotViewRefresh()
  CopySubplotGroupModel.Instance:ResetStageData()
  self:_RefreshGroupView()
end

function SubplotGroupView:_ResumeDefaultBgAudioEvent()
  if UIManager.Instance:GetWindow(Urls.ActivityMainPanel) then
    AudioManager.Instance:PostSoundEvent("Set_State_Aa_Interface_Welfare")
  elseif UIManager.Instance:GetWindow(Urls.CopyMainView) then
    AudioManager.Instance:PostSoundEvent("Set_State_Aa_Interface_Story")
  end
end

function SubplotGroupView:_OnStoryReviewEnd()
  if self.audioEvent then
    AudioManager.Instance:PostSoundEvent(self.audioEvent)
    return
  end
  self:_PlayAudioEvent()
  if self.audioEvent then
    return
  end
  self:_ResumeDefaultBgAudioEvent()
end

function SubplotGroupView:_AddRedDot(uiNode, hardModeIndex)
  if not uiNode then
    return
  end
  local groupTid = CopySubplotGroupModel.Instance:StageGroupHardModeIndex2Id(hardModeIndex)
  if not groupTid or 0 == groupTid then
    self:SetActive(uiNode, false)
    return
  end
  if not CopySubplotGroupModel.Instance:IsStageGroupFeatureUnlock(groupTid) then
    self:SetActive(uiNode, false)
    return
  end
  local redArgs = {stageGroupTid = groupTid, withResonanceGroup = true}
  self:AddRedPoint(uiNode, RedDotDefine.DynamicRedDotID.SubplotStageGroupRedDot, redArgs)
end

function SubplotGroupView:_RefreshStoryReview()
  local stageGroupId = CopySubplotGroupModel.Instance:StageGroupHardModeIndex2Id(HardModeIndex_Normal)
  local isUnlocked = StoryReviewModel.Instance:IsCopyStoryShouldReivew(stageGroupId)
  local isReviewing = StoryReviewModel.Instance:IsReviewingStory()
  self:SetZ1Toggle(self.switchGroupUI.Toggle_Remember, isReviewing, true)
  self.switchGroupUI.CheckmarkBgRemember:SetActive(isReviewing)
  local colorType = isReviewing and CommonDefine.ColorType.Light or CommonDefine.ColorType.Normal
  if not isUnlocked then
    colorType = CommonDefine.ColorType.Dark
  end
  self:SetZ1ToggleTextColorType(self.switchGroupUI.Toggle_Remember, colorType)
  self:SetZ1ToggleInteractable(self.switchGroupUI.Toggle_Remember, not isReviewing)
  self.switchGroupUI.Image_lock_5:SetActive(not isUnlocked)
  self.switchGroupUI.Group_NorRemember:SetActive(not isReviewing and isUnlocked)
end

function SubplotGroupView:_RefreshStoryReviewRedStaus()
  self.switchGroupUI.RedDot_Remember:SetActive(false)
end

function SubplotGroupView:_OnClickReviewStory()
  local stageGroupId = CopySubplotGroupModel.Instance:StageGroupHardModeIndex2Id(HardModeIndex_Normal)
  local isUnlocked = StoryReviewModel.Instance:IsCopyStoryShouldReivew(stageGroupId)
  if not isUnlocked then
    Alert.Show(10904)
    return
  end
  if StoryReviewModel.Instance:IsReviewingStory() then
    return
  end
  StoryReviewModel.Instance:StartReviewStory()
  local lastDifficultyIndex = self.curDifficultyIndex
  if self.curDifficultyIndex == HardModeIndex_Normal then
    self.curDifficultyIndex = nil
  end
  local curDifficultyIndex = HardModeIndex_Normal
  if self.curDifficultyIndex == curDifficultyIndex then
    return
  end
  self.curDifficultyIndex = curDifficultyIndex
  self:_PlayDifficultySwitchAnim(lastDifficultyIndex, curDifficultyIndex, false, true)
  CopySubplotGroupModel.Instance:SetStageGroupID(stageGroupId)
  StoryReviewController.Instance:PlayReviewStory()
end

function SubplotGroupView:EnableUIEffect()
  if self.ui.UI_Effect and self.extraParam.showUIEffect then
    self.ui.UI_Effect:SetActive(true)
  end
end

return SubplotGroupView
