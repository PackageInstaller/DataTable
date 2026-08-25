local typeof = _ENV.typeof
local AddClipToPlay = AnimatorUtils.AddClipToPlay
local MainCopyItem, Super = System.NewClass("MainCopyItem", UIBasePanel)
MainCopyItem.uiResCls = UI_Chapter_Item_Chapter_SmallResource

function MainCopyItem:ctor(uiNode, stageGroupId, index, model, oldHardMode)
  Super.ctor(self)
  self.ui = UI_Chapter_Item_Chapter_SmallResource(uiNode)
  self.stageGroupId = stageGroupId and Vue.ref(stageGroupId) or nil
  self.index = Vue.ref(index)
  self.model = model
  self.oldHardMode = oldHardMode
end

function MainCopyItem:OnBind(binder)
  self.binder = binder
  local model = self.model
  binder:BindButtonClick(self.ui.Button_Click, function()
    if self.stageGroupId then
      model:SetStageGroupID(self.stageGroupId.value)
    end
    if MainCopyItem._SelectedItem == self then
      if self.stageGroupId ~= nil then
        AudioManager.Instance:PostSoundEvent("UI_STORY_CHAPSELECT_CHAPBOX_CLICK")
        if self:IsUnlock() then
          MainCopyDataUtils.OpenMainCopyChapterPanel(self.stageGroupId.value, nil, nil, self.model)
        else
          local featureId = self.model:GetFeatureId()
          local tips = PlayerDataUtils.GetFeatureLogicUnlockTips(featureId, self.stageGroupId.value)
          if tips then
            Alert.ShowStr(LT.Text(tips))
          end
        end
      end
    else
      if MainCopyItem._SelectedItem then
        MainCopyItem._SelectedItem:SetSelect(false)
      end
      self:SetSelect(true)
    end
  end)
  self.uiAnimController = self.ui.uiNode:GetComponent(typeof(CS.UIAnimationController))
  if self.stageGroupId == nil then
    self.ui.Group_Expect:SetActive(true)
    self.ui.Group_Normal:SetActive(false)
    self.ui.Group_Lock:SetActive(false)
    return
  end
  self.ui.Group_Lock:SetActive(false)
  binder:onDestroy(function()
    MainCopyItem._SelectedItem = nil
  end)
  binder:BindToRaw(function(_, isDefault, _)
    if isDefault then
      MainCopyItem._SelectedItem = self
      self:PlayBig()
      self.model:SetStageGroupID(self.stageGroupId.value)
    end
  end, function()
    return MainCopyDataUtils.GetLatestCopyID(model.hardMode) == self.stageGroupId.value
  end)
  if self.oldHardMode == nil then
    self.ui.Image_BgDifficulty:SetActive(false)
    self.ui.Image_BgNightmare:SetActive(false)
  end
  self:FinishDiffcultEnterAnim(model.hardMode)
  binder:BindToVisible(self.ui.Group_Expect, function()
    return not self:IsUnlock()
  end)
  binder:BindToVisible(self.ui.Text_Stroy, function()
    do return self.IsUnlock end
    return self.IsUnlock, self
  end)
  binder:BindToVisible(self.ui.Text_Name, function()
    do return self.IsUnlock end
    return self.IsUnlock, self
  end)
  binder:BindToVisible(self.ui.Image_NameUnknown, function()
    return not self:IsUnlock()
  end)
  binder:BindToVisible(self.ui.Group_InfoIcon, function()
    do return self.IsUnlock end
    return self.IsUnlock, self
  end)
  binder:BindToText(self.ui.Text_Num01, function()
    local cfg = DT.StageGroup[self.stageGroupId.value]
    if cfg then
      local showNum = tostring(cfg.Sequence)
      return string.len(showNum) > 1 and showNum or "0" .. showNum
    end
    return ""
  end)
  binder:BindToText(self.ui.Text_Progress, function()
    local percent = MainCopyDataUtils.GetMainCopyProgress(self.stageGroupId.value)
    return math.floor(percent * 100) .. "%"
  end)
  binder:BindToVisible(self.ui.Image_Finish, function()
    local percent = MainCopyDataUtils.GetMainCopyProgress(self.stageGroupId.value)
    return percent >= 1
  end)
  binder:BindComponent(RedDotComponent(self.ui.Com_RedDot, CommonDefine.RedDotType.Dot, nil, function()
    if not MainCopyDataUtils.IsStageGroupUnlock(self.stageGroupId.value) then
      return false
    end
    do return RedPointDataUtils.IsShowStageGroupRedPoint end
    return RedPointDataUtils.IsShowStageGroupRedPoint, self.stageGroupId.value
  end))
  binder:BindEvent(EventMgr.Instance.MainCopyStageGroupSelectPlaySmall2Big, function()
  end)
  binder:BindEvent(EventMgr.Instance.MainCopyStageGroupSelectSwitchSmall2Big, function()
  end)
  binder:BindToRaw(function(childBinder, cfg, _)
    if not cfg then
      return
    end
    childBinder:SetText(self.ui.Text_Number, CopyDataUtils.GetMainCopyName(self.index.value))
    childBinder:SetText(self.ui.Text_Name, cfg.Name)
    childBinder:SetText(self.ui.Text_Stroy, cfg.Desc)
    local pathIdx = CopyDataUtils.GetIconPathIdx(cfg.ID)
    if not self:IsUnlock() then
      childBinder:SetImage(self.ui.Image_SSceneLock, string.format(CommonDefine.MainCopyBackGroudBGPath.StageGroupSelectItemLock, pathIdx))
    else
      childBinder:SetImage(self.ui.Image_SScene, string.format(CommonDefine.MainCopyBackGroudBGPath.StageGroupSelectItemUnlock, pathIdx))
    end
  end, function()
    return DT.StageGroup[self.stageGroupId.value]
  end)
  self:OnBindStageGroupInfo(binder, model)
end

function MainCopyItem:PlayDiffcultEnterAnim(oldMode, newMode)
  local clipsToPlay = ""
  if oldMode then
    if oldMode == CommonDefine.Difficulty.Hard then
      clipsToPlay = AddClipToPlay(clipsToPlay, "chapter_small_Difficulty_Close")
      self.uiAnimController:PlayState("chapter_small_Difficulty_Close")
    elseif oldMode == CommonDefine.Difficulty.Super then
      clipsToPlay = AddClipToPlay(clipsToPlay, "chapter_small_Nightmarey_Close")
    end
  end
  if newMode == CommonDefine.Difficulty.Hard then
    clipsToPlay = AddClipToPlay(clipsToPlay, "chapter_small_Difficulty_Open")
  elseif newMode == CommonDefine.Difficulty.Super then
    clipsToPlay = AddClipToPlay(clipsToPlay, "chapter_small_Nightmarey_Open")
  else
    self.ui.Image_BgDifficulty:SetActive(false)
    self.ui.Image_BgNightmare:SetActive(false)
  end
  self.uiAnimController:PlayMultiState(clipsToPlay, function()
  end)
end

function MainCopyItem:FinishDiffcultEnterAnim(newMode)
  if newMode == CommonDefine.Difficulty.Hard then
    self.ui.Image_BgDifficulty:SetActive(true)
    self.ui.Image_BgNightmare:SetActive(false)
  elseif newMode == CommonDefine.Difficulty.Super then
    self.ui.Image_BgDifficulty:SetActive(false)
    self.ui.Image_BgNightmare:SetActive(true)
  else
    self.ui.Image_BgDifficulty:SetActive(false)
    self.ui.Image_BgNightmare:SetActive(false)
  end
  self.binder:SetImageAlpha(self.ui.Image_BgDifficulty, 1)
  self.binder:SetImageAlpha(self.ui.Image_BgNightmare, 1)
end

function MainCopyItem:PlayToBig()
  EventMgr.Instance.MainCopyStageGroupSelectPlaySmall2Big:Dispatch(self.index.value)
  self.uiAnimController:PlayState("chapter_small_2_big", function()
    if self.stageGroupId.value == self.model.stageGroupId then
    end
  end)
  AudioManager.Instance:PostSoundEvent("UI_STORY_CHAPSELECT_CHAPBOX_OPEN")
end

function MainCopyItem:PlayToSmall()
  self.uiAnimController:PlayState("chapter_big_2_small")
end

function MainCopyItem:PlayBig()
  EventMgr.Instance.MainCopyStageGroupSelectSwitchSmall2Big:Dispatch(self.index.value)
  self.uiAnimController:PlayState("chapter_big", function()
  end)
end

function MainCopyItem:PlaySmall()
  self.uiAnimController:PlayState("chapter_small")
end

function MainCopyItem:SetSelect(isSelected)
  if isSelected then
    self:PlayToBig()
    MainCopyItem._SelectedItem = self
  else
    self:PlayToSmall()
  end
end

function MainCopyItem:OnBindStageGroupInfo(binder, _)
  if not self.stageGroupId then
    return
  end
  local curProgress, limitProgress = MainCopyDataUtils.GetAchievementProgress(self.stageGroupId.value)
  binder:BindToText(self.ui.Text_AchievementNum01, function()
    return curProgress
  end)
  binder:BindToText(self.ui.Text_AchievementNum02, function()
    return limitProgress
  end)
  local resonanceGroupId = ResonanceDataUtils.GetReonanceGroupIdByStageGroupId(self.stageGroupId.value)
  binder:BindToText(self.ui.Text_ResonanceNum01, function()
    local totalLevel = ResonanceDataUtils.GetResonanceGroupTotalLevel(resonanceGroupId)
    return totalLevel
  end)
  binder:BindToText(self.ui.Text_ResonanceNum02, function()
    local maxLevel = ResonanceDataUtils.GetResonanceGroupMaxLevel(resonanceGroupId)
    return maxLevel
  end)
  binder:BindToText(self.ui.Text_StarNum01, function()
    local curStar = MainCopyDataUtils.GetStageGroupCurStar(self.stageGroupId.value)
    return curStar
  end)
  binder:BindToText(self.ui.Text_StarNum02, function()
    local totalStar = MainCopyDataUtils.GetTotalStar(self.stageGroupId.value)
    return totalStar
  end)
end

function MainCopyItem:IsUnlock()
  do return MainCopyDataUtils.IsStageGroupUnlock end
  return MainCopyDataUtils.IsStageGroupUnlock, self.stageGroupId.value
end

return MainCopyItem
