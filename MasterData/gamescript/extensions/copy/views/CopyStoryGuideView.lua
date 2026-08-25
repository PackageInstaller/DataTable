local Vector2 = CS.UnityEngine.Vector2
local T_ScrollRect = typeof(CS.UnityEngine.UI.ScrollRect)
local CopyStoryGuideView, Super = NewClass("CopyStoryGuideView", BaseView)
CopyStoryGuideView.uiResCls = "UI/UI_Chapter/UI_Chapter_Prefab/Optimized/UI_Copy_Story_View.prefab"

function CopyStoryGuideView:ctor(targetStageGroupTid)
  Super.ctor(self)
  self.stageChapterText = StoryDefine.MainCopyPanelChapter.Morimens
  self.inited = false
  self.sequence = 0
  self.jumpIndex = 1
  self.model = CopyStoryGuideModel.Instance
  self.model:ParseCfgStoryData()
  self.selectUI = {}
  self.awakerBinder = {}
  self.targetStageGroupTid = targetStageGroupTid
end

function CopyStoryGuideView:OnEnterView()
  Super.OnEnterView(self)
  self:RefreshData()
  self:AddViewComponentOnce(self.ui.UI_Common_Item_Coin_Group, UICompCommonCurrencyGroupItem, DT.Constant.SilverRoadCurrencies.Data)
end

function CopyStoryGuideView:RegisterNotifications()
  self:RegisterLocalNotify(NotifyId.OnGuideNoteMainModuleChanged, self.RefreshData, self)
end

function CopyStoryGuideView:RegisterEvents()
  self.binder:BindEvent(EventMgr.Instance.TopUIChangeEvent, System.fn(self, self.RefreshData))
end

function CopyStoryGuideView:RefreshData(curPage)
  local checkUrlsList = {
    GuideNoteDefine.Page.StoryGuide,
    Urls.CopyStoryGuideView,
    Urls.GuideNoteDailyTaskView,
    Urls.GuideNoteWeeklyTaskView,
    Urls.GuideNoteAwakerStrengthView,
    Urls.GuideNotePermTrainingView,
    Urls.GuideNoteResExplorationView
  }
  if curPage and not table.contains(checkUrlsList, curPage) then
    return
  end
  self.model:RefreshAllStates()
  local hasTargetLocation = self:TrySetTargetStageGroup()
  if not hasTargetLocation and not self.inited then
    self:SetNewestChapter()
  end
  self:CreateChapterStageTableView()
  if not self.inited then
    local index = self.model:GetIndexByChapter(self.stageChapterText, self.sequence)
    if index > 10 then
      local preferrHeight = 0
      for i = 1, index do
        preferrHeight = preferrHeight + (-1 == self.model.storyList[i].sequence and 104 or 70)
      end
      self.ui.StageChapterView:GetComponent(T_ScrollRect).content.transform.anchoredPosition = Vector2(0, math.max(0, preferrHeight - 844))
    end
  end
  self:TogglePage(self.stageChapterText, self.sequence, true, true)
end

function CopyStoryGuideView:TrySetTargetStageGroup()
  if not self.targetStageGroupTid then
    return false
  end
  local stageChapterText, sequence, storyIndex = self.model:GetStoryLocationByStageGroupTid(self.targetStageGroupTid)
  self.targetStageGroupTid = nil
  if not stageChapterText then
    return false
  end
  self.stageChapterText = stageChapterText
  self.sequence = sequence
  self.jumpIndex = storyIndex or 1
  self.inited = false
  return true
end

function CopyStoryGuideView:SetNewestChapter()
  local function ResetJumpIndex()
    self.stageChapterText = StoryDefine.MainCopyPanelChapter.Morimens
    
    self.sequence = 0
    self.jumpIndex = 1
  end
  
  for _, sinStory in ipairs(self.model.storyList) do
    local stageChapterText, sequence = sinStory.stageChapterText, sinStory.sequence
    local haveUnFinish = false
    self.stageChapterText, self.sequence = stageChapterText, sequence
    if self.model.storyData[stageChapterText][sequence + 1] then
      for ind, sinStoryData in ipairs(self.model.storyData[stageChapterText][sequence + 1]) do
        if sinStoryData.state ~= StoryDefine.StoryState.Finished then
          self.jumpIndex = ind
          haveUnFinish = true
          break
        end
      end
      if haveUnFinish then
        break
      end
      ResetJumpIndex()
    end
  end
end

local childTag = {Chapter = 1, StoryGroup = 2}

function CopyStoryGuideView:CreateChapterStageTableView()
  local storyList = self.model.storyList
  local nowChapter, nowSequence
  self.chapterStageTableView = self:CreateTableview(self.ui.StageChapterView, function()
    return storyList and #storyList or 0
  end, function(view, index)
    nowChapter, nowSequence = self.model:GetStoryGroup(index)
    local cell
    if -1 == nowSequence then
      cell = self:DequeueCellByTag(view, childTag.Chapter, self.ui.UI_Copy_Btn_Story_StageChapter)
      self:FillChapterStageHeadCell(cell.gameObject, nowChapter)
    else
      cell = self:DequeueCellByTag(view, childTag.StoryGroup, self.ui.UI_Copy_Btn_StoryChapter)
      self:FillChapterStageCell(cell.gameObject, nowChapter, nowSequence)
    end
    return cell
  end, function(_, index)
    nowChapter, nowSequence = self.model:GetStoryGroup(index)
    if -1 == nowSequence then
      return 362, 144
    else
      return 362, 75
    end
  end)
  self.chapterStageTableView:ReloadData()
end

function CopyStoryGuideView:FillChapterStageHeadCell(cellGO, stageChapterText)
  local cellUI = UI_Copy_Btn_Story_StageChapterResource(cellGO)
  self:SetImage(cellUI.Icon_StageChapter, StoryDefine.ChapterRes[stageChapterText].ToggleIcon)
  self:SetText(cellUI.Text_StageChapterName, StoryDefine.ChapterRes[stageChapterText].FullName)
  local index = self.model:GetIndexByChapter(stageChapterText, -1)
  self.selectUI[index] = cellUI.Btn_Click
  self:SetActive(cellUI.Btn_Click, false)
end

function CopyStoryGuideView:FillChapterStageCell(cellGO, stageChapterText, sequence)
  local cellUI = UI_Copy_Btn_StoryChapterResource(cellGO)
  
  local function GetMainCopyName()
    if stageChapterText == StoryDefine.MainCopyPanelChapter.Morimens then
      if 9 == sequence then
        do return LT.Text end
        return LT.Text, "MainLines_Chapter9", nil
      elseif 0 == sequence then
        do return LT.Text end
        return LT.Text, "MainLines_Chapter0", nil
      end
    end
    do return LT.Textf, "MainLines_Chapterx" end
    return LT.Textf, "MainLines_Chapterx", sequence
  end
  
  self:SetText(cellUI.Text_Name, GetMainCopyName())
  local index = self.model:GetIndexByChapter(stageChapterText, sequence)
  self.selectUI[index] = cellUI.Select
  self:SetActive(cellUI.Select, self.stageChapterText == stageChapterText and self.sequence == sequence)
  self:AddButtonClickListener(cellUI.Btn_Click, function()
    self:TogglePage(stageChapterText, sequence)
  end)
  local finishedStory, totalStory = self.model:GetChapterProgress(stageChapterText, sequence)
  self:SetText(cellUI.Text_Progress, string.format("%s<color=#959595>/%s</color>", finishedStory, totalStory))
end

function CopyStoryGuideView:CreateStoryTableView(stageChapterText, sequence)
  local storyGroupData = self.model:GetStoryGroupData(stageChapterText, sequence)
  self.storyTableView = self:CreateTableview(self.ui.ChapterView, function()
    return storyGroupData and #storyGroupData or 0
  end, function(view, index)
    local cell = self:DequeueCell(view, self.ui.UI_Copy_Item_StoryChapter)
    local sinStoryData = storyGroupData[index]
    self:FillStoryCell(cell.gameObject, sinStoryData)
    return cell
  end, function()
    return 358, 796
  end)
  self.storyTableView:ReloadData()
end

function CopyStoryGuideView:FillStoryCell(cellGO, sinStoryData)
  local cellUI = UI_Copy_Item_StoryChapterResource(cellGO)
  cellGO.name = "StoryCell_" .. sinStoryData.stageGroupTid
  local stageGroupCfg = DT.StageGroup[sinStoryData.stageGroupTid]
  local storyType = sinStoryData.type
  self:SetImage(cellUI.Icon_StageGroupType, StoryDefine.StoryTypeRes[storyType].Icon)
  self:SetText(cellUI.Text_StageGroupType, StoryDefine.StoryTypeRes[storyType].Title)
  local storyState = sinStoryData.state
  self:SetText(cellUI.Text_ChapterName, LT.Text(stageGroupCfg.Name))
  self:SetActive(cellUI.Group_Over, storyState == StoryDefine.StoryState.Finished)
  self:SetText(cellUI.Text_Localization, LT.Text("Localized"))
  self:SetActive(cellUI.Group_Localization, SettingManager.Instance:IsTranslationProgressEnabled({
    stageGroupTid = sinStoryData.stageGroupTid
  }))
  if self.model:IsMainCopyType(storyType) then
    self:SetActive(cellUI.Group_MainCopy, true)
    self:SetActive(cellUI.Image_SScene, true)
    self:SetActive(cellUI.Group_MainCopy_Lock, storyState == StoryDefine.StoryState.Locked)
    self:SetActive(cellUI.Group_Subplot, false)
    self:SetActive(cellUI.Group_Subplot_Lock, false)
    self:SetActive(cellUI.Image_Subplot_Locking, false)
    self:SetActive(cellUI.Image_Subplot_Bg, false)
    if storyState ~= StoryDefine.StoryState.Locked then
      local imageIndex = self.model:GetMainCopyStoryIndex(stageGroupCfg.StageChapterText, stageGroupCfg.Sequence)
      local imageIndexStr = imageIndex > 9 and tostring(imageIndex) or "0" .. tostring(imageIndex)
      self:SetImage(cellUI.Image_SScene, "Icon/Chaper/Chaper_Bg_Small_" .. imageIndexStr .. ".png")
    end
  else
    self:SetActive(cellUI.Group_MainCopy, false)
    self:SetActive(cellUI.Image_SScene, false)
    self:SetActive(cellUI.Group_MainCopy_Lock, false)
    self:SetActive(cellUI.Group_Subplot, true)
    self:SetActive(cellUI.Group_Subplot_Lock, storyState == StoryDefine.StoryState.Locked or storyState == StoryDefine.StoryState.CanUnlock)
    if storyState == StoryDefine.StoryState.CanUnlock then
      self:SetText(cellUI.Text_Condition, LT.Text("Unlockable"))
    elseif storyState == StoryDefine.StoryState.Locked then
      local feature = CopyDataUtils.GetStageGroupFeature(sinStoryData.stageGroupTid)
      self:SetText(cellUI.Text_Condition, PlayerDataUtils.GetFeatureLogicUnlockTips(feature, sinStoryData.stageGroupTid))
    end
    self:SetActive(cellUI.Image_Subplot_Locking, storyState == StoryDefine.StoryState.FreeNow)
    self:SetActive(cellUI.Image_Subplot_Bg, true)
    local awakerTid = stageGroupCfg.RelatedAwaker
    self:SetActive(cellUI.Image_Logo, false)
    if storyType == cd.StageGroupType.LinkageActivityNormal then
      self:SetImage(cellUI.Image_Subplot_Bg, StoryDefine.StoryTypeRes[storyType].Bg)
      self:SetActive(cellUI.Image_Logo, true)
      if stageGroupCfg and stageGroupCfg.DailyIcon and stageGroupCfg.DailyIcon[3] then
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
        self:SetImage(cellUI.Image_Logo, logoPath)
      end
    elseif storyType == cd.StageGroupType.SpecialSubplotNormal then
      self:SetImage(cellUI.Image_Subplot_Bg, StoryDefine.StoryTypeRes[storyType].Bg)
    elseif awakerTid then
      self:SetImage(cellUI.Image_Subplot_Bg, AwakerDataUtils.GetSchoolSubplotCover(AwakerDataUtils.GetAwakerConfig(awakerTid).School))
    else
      self:SetImage(cellUI.Image_Subplot_Bg, stageGroupCfg.DailyIcon[1])
    end
    if awakerTid and (not (stageGroupCfg.DailyIcon and stageGroupCfg.DailyIcon[2]) or type(stageGroupCfg.DailyIcon[2]) ~= "string") then
      self:SetActive(cellUI.Image_Awaker, false)
      self:SetActive(cellUI.Group_Awaker, true)
      if self.awakerBinder[cellUI.Image_Portrait] then
        self.awakerBinder[cellUI.Image_Portrait]:teardown()
        self.awakerBinder[cellUI.Image_Portrait] = nil
      end
      self.awakerBinder[cellUI.Image_Portrait] = self.binder:createChild()
      local isSkin = not DT.AwakerConfig[awakerTid]
      self.awakerBinder[cellUI.Image_Portrait]:BindComponent(AwakerPortraitComp(cellUI.Image_Portrait, nil, AwakerDataUtils.GetAwakerResNum(awakerTid, true, isSkin and awakerTid or 0), nil, CommonDefine.PortraitAlign.Center))
    else
      self:SetActive(cellUI.Image_Awaker, true)
      self:SetActive(cellUI.Group_Awaker, false)
      self:SetImage(cellUI.Image_Awaker, stageGroupCfg.DailyIcon and type(stageGroupCfg.DailyIcon[2]) == "string" and stageGroupCfg.DailyIcon[2])
    end
  end
  self:AddButtonClickListener(cellUI.Btn_Click, function()
    self:OnClickStage(cellUI, sinStoryData)
  end)
end

function CopyStoryGuideView:OnClickStage(cellUI, sinStoryData)
  local stageGroupId = sinStoryData.stageGroupTid
  local storyType = sinStoryData.type
  local storyState = sinStoryData.state
  if storyType == cd.StageGroupType.Prologue then
    Alert.Show(20356, nil, function()
      for _, guideId in ipairs(DT.GetOriginalConstant("PrologueResetGuideConfig", {})) do
        GuideManager.Instance:ResetTrigeredGuideId(guideId)
      end
      local plots = table.clone(DT.GetOriginalConstant("PrologueBeginPlot"))
      AvgStoryManager.Instance:ClearSkipPlot()
      self:PlayPlot(plots, function()
        for stageId, stageCfg in pairs(DT.Stage) do
          if stageCfg.BelongGroup == stageGroupId then
            StageExitPanelManager.Instance:PushWhenMainCopyExit(stageId)
            WorldStageManager.Instance:CheckOpen(stageId)
            break
          end
        end
      end)
    end)
  elseif storyType == cd.StageGroupType.MainCopy then
    AudioManager.Instance:PostSoundEvent("UI_STORY_CHAPSELECT_CHAPBOX_CLICK")
    if storyState ~= StoryDefine.StoryState.Locked then
      local model = self.binder:createModel(MainCopyModel)
      model:SetStageGroupID(stageGroupId)
      model:SetHardMode(CommonDefine.Difficulty.Normal)
      MainCopyDataUtils.OpenMainCopyChapterPanel(stageGroupId, nil, nil, model)
    else
      Alert.ShowStr(LT.Text(PlayerDataUtils.GetFeatureLogicUnlockTips(CommonDefine.FeatureId.MainCopy, stageGroupId)))
    end
  else
    local isFeatureLocked = CopyDataUtils.IsStageGroupFeatureLocked(stageGroupId)
    local hasOpenningSubplotActivity = ActivityManager.Instance:HasOpeningSubplotActivity(stageGroupId)
    if isFeatureLocked and not hasOpenningSubplotActivity then
      local feature = CopyDataUtils.GetStageGroupFeature(stageGroupId)
      if not feature then
        return
      end
      PlayerDataUtils.AlertLockedTips(feature, stageGroupId)
      return
    end
    
    local function _ReqUnlockStageGroup()
      CopyDataUtils.ReqUnlockStageGroup(stageGroupId, false, function()
        storyState = StoryDefine.StoryState.Unlocked
        if not cellUI or not cellUI.uiNode then
          return
        end
        local parent = cellUI.uiNode.transform and cellUI.uiNode.transform.parent
        if not parent then
          return
        end
        local targetName = "StoryCell_" .. stageGroupId
        for i = 0, parent.childCount - 1 do
          local child = parent:GetChild(i)
          local childGO = child and child.gameObject
          if childGO and childGO.name == targetName then
            local realCellUI = UI_Copy_Item_StoryChapterResource(childGO)
            if realCellUI then
              self:SetActive(realCellUI.Group_Subplot_Lock, false)
              self:SetActive(realCellUI.Image_Subplot_Locking, false)
            end
          end
        end
        local lockSucAlertKey = 10755
        Alert.Show(lockSucAlertKey)
      end)
    end
    
    if CopyDataUtils.IsStageGroupNeedUnlockItem(stageGroupId) then
      local hasUseUnlockItem = CopyDataUtils.IsStageGroupUseUnlockItem(stageGroupId)
      if not hasUseUnlockItem then
        if hasOpenningSubplotActivity then
          Alert.Show(20138, nil, _ReqUnlockStageGroup)
          return
        end
        
        local function CheckUnlock()
          if not CopyDataUtils.IsStageGroupUnlockItemEnough(stageGroupId) then
            local itemNameCostStr = CopyDataUtils.GetStageGroupUnlockItemCostStr(stageGroupId, false)
            local tipsText = LT.Textf(DT.TipsType[10646].Desc, itemNameCostStr)
            Alert.Show(10646, nil, nil, nil, tipsText)
            return
          end
          _ReqUnlockStageGroup()
        end
        
        local itemName, itemNum = CopyDataUtils.GetStageGroupFirstUnlockItemInfo(stageGroupId)
        local stageGroupName = CopyDataUtils.GetStageGroupName(stageGroupId)
        local tipsText = LT.Textf(DT.TipsType[20139].Desc, itemName, stageGroupName, itemNum)
        Alert.Show(20139, nil, CheckUnlock, nil, tipsText)
        return
      end
    end
    CopyDataUtils.OpenSubPlotGroupPanel(stageGroupId)
  end
  self.model:SetPendingReturnStageGroupTid(stageGroupId)
end

function CopyStoryGuideView:TogglePage(stageChapterText, sequence, isForce, isBackView)
  if not isForce and self.stageChapterText == stageChapterText and self.sequence == sequence then
    return
  end
  self.model:RefreshStates(stageChapterText, sequence)
  local imageIndex = self.model:GetMainCopyStoryIndex(stageChapterText, sequence)
  self:SetText(self.ui.Text_StageChapterDesc, LT.Text("StorylineGuide_" .. imageIndex))
  if isForce or self.stageChapterText ~= stageChapterText then
    self:SetImage(self.ui.Image_Cg, StoryDefine.ChapterRes[stageChapterText].TopIcon)
  end
  local oldIndex = self.model:GetIndexByChapter(self.stageChapterText, self.sequence)
  local newIndex = self.model:GetIndexByChapter(stageChapterText, sequence)
  if self.selectUI[oldIndex] then
    self:SetActive(self.selectUI[oldIndex], false)
  end
  if self.selectUI[oldIndex] then
    self:SetActive(self.selectUI[newIndex], true)
  end
  self.stageChapterText = stageChapterText
  self.sequence = sequence
  self:CreateStoryTableView(stageChapterText, sequence)
  if self.jumpIndex > #self.model.storyData[stageChapterText][sequence + 1] - 3 then
    self.jumpIndex = #self.model.storyData[stageChapterText][sequence + 1] - 2.7
  end
  if isForce and not self.inited then
    self.inited = true
    self.ui.ChapterView:GetComponent(T_ScrollRect).content.transform.anchoredPosition = Vector2(-328 * (self.jumpIndex - 1) + 10, 0)
  elseif not isBackView then
    self.ui.ChapterView:GetComponent(T_ScrollRect).content.transform.anchoredPosition = Vector2(10, 0)
  end
end

function CopyStoryGuideView:PlayPlot(plots, finishCb)
  UICompMainCopyItem.PlayPlot(self, plots, finishCb)
end

return CopyStoryGuideView
