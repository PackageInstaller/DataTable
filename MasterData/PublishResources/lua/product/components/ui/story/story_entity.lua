_class("StoryEntity", Object)
StoryEntity = StoryEntity

function StoryEntity:Constructor(ID, gameObject, resRequest, storyManager)
  self._ID = ID
  self._gameObject = gameObject
  self._resRequest = resRequest
  self._storyManager = storyManager
  self._Type = StoryEntityType.Invalid
  self._currentTrackData = nil
  self._keyframeDone = {}
end

function StoryEntity:GetEntityType()
  return self._type
end

function StoryEntity:GetID()
  return self._ID
end

function StoryEntity:_TriggerKeyframe(keyframeData)
end

function StoryEntity:_UpdateAnimation(time)
  return true
end

function StoryEntity:Update(time)
  local allTrackEnd = true
  if self._currentTrackData and self._currentTrackData.KeyFrames then
    for index, keyframe in ipairs(self._currentTrackData.KeyFrames) do
      if not self._keyframeDone[keyframe] then
        if time >= keyframe.Time then
          self:_TriggerKeyframe(keyframe)
          self._keyframeDone[keyframe] = true
        else
          allTrackEnd = false
        end
      end
    end
    allTrackEnd = self:_UpdateAnimation(time) and allTrackEnd
    return allTrackEnd
  else
    return true
  end
end

function StoryEntity:SectionStart(trackData)
  self._currentTrackData = trackData
end

function StoryEntity:SectionEnd()
  self._currentTrackData = nil
  self._keyframeDone = {}
end

function StoryEntity:Destroy()
  if self._resRequest ~= nil then
    self._resRequest:Dispose()
    self._resRequest = nil
  end
end
