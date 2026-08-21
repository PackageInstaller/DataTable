_class("StoryEntityPostProcessing", StoryEntity)
StoryEntityPostProcessing = StoryEntityPostProcessing

function StoryEntityPostProcessing:Constructor(ID, resourceName, storyManager)
  StoryEntityPostProcessing.super.Constructor(self, ID, nil, nil, storyManager)
  self._type = StoryEntityType.PostProcessing
  self._resName = resourceName
  self._resRequest = nil
  self._postProcessing = nil
  self:_AddPostProcessing()
end

function StoryEntityPostProcessing:_TriggerKeyframe(keyframeData)
  if keyframeData.Active ~= nil then
    self._postProcessing.enabled = keyframeData.Active
  end
end

function StoryEntityPostProcessing:_AddPostProcessing()
  self._resRequest = ResourceManager:GetInstance():SyncLoadAsset(self._resName, LoadType.Asset)
  if self._resRequest ~= nil and self._resRequest.Obj then
    local camera = GameGlobal.UIStateManager():GetControllerCamera("UIStoryController")
    self._postProcessing = camera.gameObject:AddComponent(typeof(UnityEngine.H3DPostProcessing.PostProcessing))
    self._postProcessing.profile = self._resRequest.Obj
    self._postProcessing.enabled = false
  end
end

function StoryEntityPostProcessing:Destroy()
  if self._postProcessing ~= nil then
    UnityEngine.Object.Destroy(self._postProcessing)
    self._postProcessing = nil
  end
  if self._resRequest ~= nil then
    self._resRequest:Dispose()
    self._resRequest = nil
  end
end
