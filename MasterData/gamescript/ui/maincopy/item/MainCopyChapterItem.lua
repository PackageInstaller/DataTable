local MainCopyChapterItem, Super = System.NewComponent("MainCopyChapterItem")

function MainCopyChapterItem:ctor(uiNode, stageData, model, view)
  Super.ctor(self)
  local stageCfg = CopyDataUtils.GetStageCfg(stageData.stageID)
  local isBoss = CopyDataUtils.IsWorldBossStage(stageData.stageID)
  local uiRes = isBoss and UI_Chaper_Item_Boss_ContentResource or UI_Chaper_Item_Level_ContentResource
  self.ui = uiRes(uiNode)
  self.stageData = stageData
  self.stageCfg = stageCfg
  self.model = model
  self.view = view
end

function MainCopyChapterItem:OnBind(binder)
  local model = self.model
  binder:LoadAllLangFont(self.ui.Text_Level_Name)
  self:_OnBindLockGroup(binder)
  self:_OnBindHighDifficultyUI(binder)
  binder:BindButtonClick(self.ui.Button_Click, function()
    if self.stageData.unlocked then
      UIManager.Instance:Reopen(Urls.CopyStageDetailView, self.stageData.stageID, function()
        StageExitPanelManager.Instance:PushWhenMainCopyExit(self.stageData.stageID)
      end)
      self:SetSelected(true)
      local result = RedPointDataUtils.GetRedPointState(RedPointDataUtils.RedType.NewStageUnlock, {
        self.stageData.stageID
      })
      if result then
        RedPointDataUtils.ReqRemoveData(RedPointDataUtils.RedType.NewStageUnlock, RedPointDataUtils.RedAttrType.IsNew, self.stageData.stageID)
      end
    end
  end)
  if self.ui.Group_Lock then
    binder:BindToVisible(self.ui.Group_Lock, function()
      return not self.stageData.unlocked
    end)
  end
  if self.ui.Image_Select then
    self.ui.Image_Select:SetActive(false)
  end
  binder:BindToText(self.ui.Text_Level_Number, function()
    local stageId = self.stageData.stageID
    local cfg = DT.Stage[stageId]
    return cfg.NameNumber
  end)
  binder:BindToText(self.ui.Text_Level_Name, function()
    local stageId = self.stageData.stageID
    do return StageCfgUtils.GetStageName, stageId end
    return StageCfgUtils.GetStageName, stageId, self.ui.Text_Level_Name
  end)
  local isStoryReivewMode = StoryReviewModel.Instance:IsReviewingStory()
  if self.ui.Star_1 then
    binder:BindToVisible(self.ui.Star_1, function()
      if model:IsHaveMap(self.stageData.stageID) and not isStoryReivewMode then
        return model:GetStarCount(self.stageData) >= 1
      end
    end)
    binder:BindToVisible(self.ui.Star_2, function()
      if model:IsHaveMap(self.stageData.stageID) and not isStoryReivewMode then
        return model:GetStarCount(self.stageData) >= 2
      end
    end)
    binder:BindToVisible(self.ui.Star_3, function()
      if model:IsHaveMap(self.stageData.stageID) and not isStoryReivewMode then
        return model:GetStarCount(self.stageData) >= 3
      end
    end)
  end
  if self.ui.Group_Fight then
    binder:BindToVisible(self.ui.Group_Fight, function()
      return model:IsHaveMap(self.stageData.stageID) and not isStoryReivewMode
    end)
  end
  if self.ui.Group_AVG then
    binder:BindToVisible(self.ui.Group_AVG, function()
      return not model:IsHaveMap(self.stageData.stageID) or isStoryReivewMode
    end)
  end
  if self.ui.Image_Icon_Trophy then
    binder:BindToVisible(self.ui.Image_Icon_Trophy, function()
      return false
    end)
  end
  if self.ui.Text_Achievement then
    binder:BindToVisible(self.ui.Text_Achievement, function()
      return false
    end)
  end
  if isStoryReivewMode then
    self.ui.RedDot:SetActive(false)
  else
    self.ui.RedDot:SetActive(true)
    self.view:AddRedPoint(self.ui.RedDot, RedDotDefine.ServerRedDotID.StageNewRedDot, {
      stageTid = self.stageData.stageID
    })
  end
  binder:onDestroy(function()
    MainCopyChapterItem._SelectedItem = nil
  end)
end

function MainCopyChapterItem:_OnBindLockGroup(binder)
  binder:BindToVisible(self.ui.Btn_Open, function()
    return not CopyDataUtils.CheckStageIsUnlocked(self.stageData.stageID)
  end)
  binder:BindZ1Button(self.ui.Btn_Open, function()
    local isInOpenTime = CopyDataUtils.CheckStageIsInOpenTime(self.stageData.stageID)
    if not isInOpenTime then
      local leftTimeText = TimeUtils.UnlockedCountDownFormat(CopyDataUtils.GetStageOpenCountDown(self.stageData.stageID))
      local tipStr = DT.TipsType[10647].Desc
      tipStr = LT.Textf(tipStr, leftTimeText)
      Alert.Show(10647, nil, nil, nil, tipStr)
    else
      local isUnlocked, lockReason = CopyDataUtils.CheckStageIsUnlocked(self.stageData.stageID)
      if not isUnlocked then
        Alert.ShowStr(lockReason)
      end
    end
  end)
  binder:BindToText(self.ui.Text_Open, function()
    local isUnlocked, lockReason = CopyDataUtils.CheckStageIsUnlocked(self.stageData.stageID)
    if not isUnlocked then
      do return LT.Text end
      return LT.Text, lockReason
    end
  end)
end

function MainCopyChapterItem:_OnBindHighDifficultyUI(binder)
  local stageCfg = DT.Stage[self.stageData.stageID]
  local isHighDifficulty = false
  if stageCfg and stageCfg.StageHighDifficulty and 1 == stageCfg.StageHighDifficulty then
    isHighDifficulty = true
  end
  local isStoryReivewMode = StoryReviewModel.Instance:IsReviewingStory()
  if self.ui.Image_Select_Effect1 then
    binder:SetActive(self.ui.Image_Select_Effect1, isHighDifficulty and not isStoryReivewMode)
  end
  if self.ui.Image_Select_Effect2 then
    binder:SetActive(self.ui.Image_Select_Effect2, isHighDifficulty and not isStoryReivewMode)
  end
  if self.ui.Image_Icon_Fight then
    binder:SetActive(self.ui.Image_Icon_Fight, not isHighDifficulty)
  end
  if self.ui.Image_Icon_Fight_Difficulty then
    binder:SetActive(self.ui.Image_Icon_Fight_Difficulty, isHighDifficulty)
  end
  if not CopyDataUtils.IsWorldBossStage(self.stageData.stageID) then
    binder:BindToTextColor(self.ui.Text_Level_Number, function()
      return isHighDifficulty and CommonDefine.ColorType.Light or CommonDefine.ColorType.Normal
    end)
    binder:BindToTextColor(self.ui.Text_Level_Name, function()
      return isHighDifficulty and CommonDefine.ColorType.Light or CommonDefine.ColorType.Normal
    end)
  end
end

function MainCopyChapterItem:SetSelected(isSelected)
  if self.ui.Image_Select then
    self.ui.Image_Select:SetActive(isSelected)
  end
  if isSelected then
    if MainCopyChapterItem._SelectedItem and MainCopyChapterItem._SelectedItem ~= self then
      MainCopyChapterItem._SelectedItem:SetSelected(false)
    end
    MainCopyChapterItem._SelectedItem = self
  end
end

function MainCopyChapterItem:OnUnbind()
  if self.view then
    self.view:RemoveRedPoint(self.ui.RedDot)
  end
end

function MainCopyChapterItem:OnTodoFunc()
end

return MainCopyChapterItem
