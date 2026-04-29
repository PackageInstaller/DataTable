_class("HomeStoryEntitySound", HomeStoryEntity)
HomeStoryEntitySound = HomeStoryEntitySound

function HomeStoryEntitySound:Constructor(ID, resourceName, storyManager)
  HomeStoryEntitySound.super.Constructor(self, ID, nil, nil, storyManager)
  self._ID = ID
  self._resName = resourceName
  self._storyManager = storyManager
  self._type = HomeStoryEntityType.Sound
  self._soundPlayingID = -1
  self._loop = false
  AudioHelperController.RequestUISoundSync(tonumber(resourceName))
end

function HomeStoryEntitySound:PlaySound()
  self._soundPlayingID = AudioHelperController.PlayUISoundResource(self._resName, self._loop)
end

function HomeStoryEntitySound:StopSound()
  AudioHelperController.StopUISound(self._soundPlayingID)
end

function HomeStoryEntitySound:PlayBgm(bgmFadeTime)
  AudioHelperController.PlayBGM(self._resName, bgmFadeTime)
end

function HomeStoryEntitySound:_TriggerKeyframe(keyframeData)
  if keyframeData.PlaySound ~= nil then
    if keyframeData.PlaySound == "Loop" then
      self._loop = true
    else
      self._loop = false
    end
    self:PlaySound()
  end
  if keyframeData.StopSound ~= nil then
    AudioHelperController.StopUISound(self._soundPlayingID)
  end
end

function HomeStoryEntitySound:Destroy()
  HomeStoryEntitySound.super.Destroy(self)
  AudioHelperController.StopUISound(self._soundPlayingID)
  AudioHelperController.ReleaseUISoundResource(self._resName)
end
