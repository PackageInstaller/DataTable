local StoryReviewController = NewClass("StoryReviewController", BaseController)

function StoryReviewController:OnInit()
  EventMgr.Instance.SkipDialog:RegisterEvent(System.fn(self, self._SkipDialog))
  EventMgr.Instance.OnStoryReviewEnd:RegisterEvent(System.fn(self, self._OnStoryReviewEnd))
end

function StoryReviewController:StartPlayStoryReview(stageTid)
  UIAudioManager.Instance:SetMainSceneMusicState(false)
  AudioManager.Instance:PostSoundEvent("Set_State_A_AVG")
  StoryReviewModel.Instance:ResetStoryByStageTid(stageTid)
  local startIndex = 1
  self:_StartPlayStoryReview(startIndex, true)
end

function StoryReviewController:_StartPlayStoryReview(index, isPlayNext)
  if self.storyCallbackId then
    AvgStoryManager.Instance:ClearCallback(self.storyCallbackId)
    self.storyCallbackId = nil
  end
  local storyAndAudio = StoryReviewModel.Instance:GetStoryByIndex(index)
  if not storyAndAudio then
    EventMgr.Instance.OnStoryReviewEnd:Dispatch()
    return
  end
  local storyId, enterAudio = table.unpack(storyAndAudio or {})
  if enterAudio then
    AudioManager.Instance:PostSoundEvent(enterAudio)
  end
  if storyId then
    self.storyCallbackId = AvgStoryManager.Instance:StartStoryById(storyId, nil, function()
      if isPlayNext then
        self:_StartPlayStoryReview(index + 1, true)
      end
    end)
  else
    self:_StartPlayStoryReview(index + 1, true)
  end
end

function StoryReviewController:_SkipDialog()
  StoryReviewModel.Instance:ClearStories()
end

function StoryReviewController:_OnStoryReviewEnd()
  UIAudioManager.Instance:SetMainSceneMusicState(true)
end

function StoryReviewController:PlayReviewStory()
  if StoryReviewModel.Instance:IsReviewStoryPlayed() then
    return
  end
  StoryReviewModel.Instance:SetReviewStoryPlayed()
  EventMgr.Instance.StartStory:Dispatch(49414)
end

return StoryReviewController
