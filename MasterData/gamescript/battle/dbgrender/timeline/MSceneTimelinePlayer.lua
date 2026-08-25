local GameObject = CS.UnityEngine.GameObject
local MSceneTimelinePlayer, Super = System.NewClass("MSceneTimelinePlayer", TimelinePlayer)
local AMResourcesCache = CS.AMTimeline.AMResourcesCache

function MSceneTimelinePlayer:ctor(player)
  if not player then
    self._tempPlayer = GameObject("MScenePlayer")
    player = self._tempPlayer
  end
  Super.ctor(self, player)
  self.timelineConfig = TimelineConfig()
end

function MSceneTimelinePlayer:PlayTimeline(assetPath, looping, onComplete, onEvent, abortSignal)
  self:UnregisterGameObjects()
  self:RegisterGameObjects()
  self.timelineConfig:Reset()
  self.timelineConfig.assetPath = assetPath
  self.timelineConfig.looping = looping or 0
  self.timelineConfig.onComplete = onComplete
  self.timelineConfig.abortSignal = abortSignal
  self.timelineConfig.onEvent = onEvent
  self:Play(self.timelineConfig)
  return self
end

function MSceneTimelinePlayer:Dispose()
  self:UnregisterGameObjects()
  if self._tempPlayer then
    GameObject.Destroy(self._tempPlayer)
    self._tempPlayer = nil
  end
end

function MSceneTimelinePlayer:RegisterGameObjects()
  local scenes = CS.UnityEngine.GameObject.Find("Scenes")
  if not scenes then
    return
  end
  for i = 0, scenes.transform.childCount - 1 do
    local go = scenes.transform:GetChild(i).gameObject
    AMResourcesCache.AddGameObject("Scenes/" .. go.name, go)
  end
  AMResourcesCache.RemoveGameObject("Main Camera", GameObject.Find("Main Camera"))
end

function MSceneTimelinePlayer:UnregisterGameObjects()
  local scenes = GameObject.Find("Scenes")
  if not scenes then
    return
  end
  for i = 0, scenes.transform.childCount - 1 do
    local go = scenes.transform:GetChild(i).gameObject
    AMResourcesCache.RemoveGameObject("Scenes/" .. go.name)
  end
  AMResourcesCache.RemoveGameObject("Main Camera")
end

return MSceneTimelinePlayer
