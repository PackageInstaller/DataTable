_class("HomeStoryEntity", Object)
HomeStoryEntity = HomeStoryEntity

function HomeStoryEntity:Constructor(ID, gameObject, resRequest, storyManager)
  self._ID = ID
  self._gameObject = gameObject
  self._resRequest = resRequest
  self._storyManager = storyManager
  self._type = HomeStoryEntityType.Invalid
  self._currentTrackData = nil
  self._keyframeDone = {}
end

function HomeStoryEntity:GetEntityGo()
  return self._gameObject
end

function HomeStoryEntity:GetEntityType()
  return self._type
end

function HomeStoryEntity:GetID()
  return self._ID
end

function HomeStoryEntity:_TriggerKeyframe(keyframeData)
end

function HomeStoryEntity:_UpdateAnimation(time)
  return true
end

function HomeStoryEntity:Update(time)
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

function HomeStoryEntity:SectionStart(trackData)
  self._currentTrackData = trackData
end

function HomeStoryEntity:SectionEnd()
  self._currentTrackData = nil
  self._keyframeDone = {}
end

function HomeStoryEntity:Destroy()
  if self._resRequest ~= nil then
    self._resRequest:Dispose()
    self._resRequest = nil
  end
end
