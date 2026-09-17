local this = class("petTimelinePrefabHandle", require("ui.manager.timeline.commonTimelinePrefabHandle"))
local TimelineSpliteHelper = CS.Gameplay.Tools.TimelineSplitTool.TimelineSpliteHelper

function this:loadTimelinePrefab(timelineName)
  if self._timelineName == timelineName then
    return
  end
  local prefab
  if self._prefabMap[timelineName] then
    prefab = self._prefabMap[timelineName]
  else
    local prefabPath = self:getFilePath(timelineName)
    prefab = L_ResPool:syncGameObject(prefabPath)
    prefab.transform.parent = self._root.transform
  end
  prefab.transform.transform.localPosition = C_Vector3(0, 0, 0)
  self:loadTimelinePrefabFinish(timelineName, prefab)
end

function this:getFilePath(timelineName)
  local path = timelineName .. "/pre_timeline_pet.prefab"
  return path
end

function this:getTimelineStateComponent(prefab)
  return prefab:GetComponent(typeof(CS.Gameplay.Tools.TimelineSplitTool.Pet.TimelinePetState))
end

function this:prepareTimelineState(timelineName)
  local state = self._timelineStateMap[timelineName or self._timelineName]
  if state == nil then
    return nil
  end
  if self._camera then
    state:SetCamera(self._camera)
  end
  return state
end

function this:playTimelineAsset(timelineAsset)
  self.isEnd = false
  local state = self:prepareTimelineState(self._timelineName)
  if state then
    self.subDirIndex = nil
    self.bindparent = {}
    self.moveMode = {}
    local actorPlayerInfos = state.actorPlayerInfos
    local dynamicBinds = {}
    for i, v in pairs(actorPlayerInfos) do
      local actor = self:getRealActorEntity(v.actorPath, v.name)
      if actor ~= nil and v.actorPath ~= nil then
        dynamicBinds[v.actorPath] = actor
      end
    end
    self:bindMainPlayer(self._timelineName, dynamicBinds)
    state.onSubDirectorStart = handler(self, self.onSubDirectorStart)
    state.director:Play()
  end
end

function this:onTimelinePlayEndInter(director)
end

return this
