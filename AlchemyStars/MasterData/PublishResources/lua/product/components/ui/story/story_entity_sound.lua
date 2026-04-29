_class("StoryEntitySound", StoryEntity)
StoryEntitySound = StoryEntitySound

function StoryEntitySound:Constructor(ID, resourceName, storyManager)
  StoryEntitySound.super.Constructor(self, ID, nil, nil, storyManager)
  self._ID = ID
  self._resName = resourceName
  self._storyManager = storyManager
  self._type = StoryEntityType.Sound
  self._soundPlayingID = -1
  self._loop = false
  AudioHelperController.RequestUISoundSync(tonumber(resourceName))
end

function StoryEntitySound:PlaySound()
  self._soundPlayingID = AudioHelperController.PlayUISoundResource(self._resName, self._loop)
  AudioHelperController.SetUISoundPlaySpeed(UnityEngine.Time.timeScale)
end

function StoryEntitySound:StopSound()
  AudioHelperController.StopUISound(self._soundPlayingID)
end

function StoryEntitySound:PlayBgm(bgmFadeTime)
  AudioHelperController.PlayBGM(self._resName, bgmFadeTime)
end

function StoryEntitySound:_TriggerKeyframe(keyframeData)
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

function StoryEntitySound:Destroy()
  StoryEntitySound.super.Destroy(self)
  AudioHelperController.StopUISound(self._soundPlayingID)
  AudioHelperController.ReleaseUISoundResource(self._resName)
end
