_class("StoryBgmTrackController", Object)
StoryBgmTrackController = StoryBgmTrackController

function StoryBgmTrackController:Constructor(storyManager)
  self._storyManager = storyManager
  self._currentTrackData = nil
  self._keyframeDone = {}
  self._bgmFadeTime = 0.5
end

function StoryBgmTrackController:SectionStart(trackData)
  self._currentTrackData = trackData
end

function StoryBgmTrackController:SectionEnd()
  self._currentTrackData = nil
  self._keyframeDone = {}
end

function StoryBgmTrackController:Update(time)
  if not self._currentTrackData then
    return true
  end
  for index, keyframe in ipairs(self._currentTrackData.KeyFrames) do
    if not self._keyframeDone[keyframe] and time > keyframe.Time then
      if keyframe.StartBgm ~= nil then
        self._storyManager:PlayBgm(keyframe.StartBgm, keyframe.FadeTime or self._bgmFadeTime)
      end
      if keyframe.StopBgm ~= nil then
        AudioHelperController.StopBGM(keyframe.FadeTime or self._bgmFadeTime)
      end
      self._keyframeDone[keyframe] = true
    end
  end
  return true
end
