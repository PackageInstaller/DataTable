local PopupFirstChapterFinishComp = System.NewClass("PopupFirstChapterFinishComp", PopupBaseComp)

function PopupFirstChapterFinishComp:ctor()
end

function PopupFirstChapterFinishComp:OnBind(binder)
  self.binder = binder
end

function PopupFirstChapterFinishComp:Clear()
end

function PopupFirstChapterFinishComp:CheckPopup()
  if self:IsInCopyView() then
    return
  end
  local firstChapterFinishFeature = cd.FeatureId.FirstChapterFinish
  local _, isUnlocked = PlayerDataUtils.IsFeatureUnlock(firstChapterFinishFeature, 0)
  if isUnlocked and not ClientDataUtils.GetData(cd.ClientDataMainKey.AVG_Feature, firstChapterFinishFeature) then
    local featureCfg = PlayerDataUtils.GetFeatureConfigByFeatureId(firstChapterFinishFeature)
    local storyId = featureCfg.StoryId
    if not storyId then
      return
    end
    AvgStoryManager.Instance:StartStoryById(storyId, nil, function()
      ClientDataUtils.SetData(cd.ClientDataMainKey.AVG_Feature, firstChapterFinishFeature, storyId, true)
      self:SetBusy(false)
    end)
    self:SetBusy(true)
  end
end

function PopupFirstChapterFinishComp:_OnBusySafetyCheck()
  do return AvgStoryManager.Instance.IsPlaying end
  return AvgStoryManager.Instance.IsPlaying, AvgStoryManager.Instance
end

return PopupFirstChapterFinishComp
