local this = class("petHouseTimelineSceneHandle")
local petEggTpl = L_GameTpl:getPetEggTpl()
local gameTpl = L_GameTpl:getGameConstTpl()

function this:ctor(_timelinePrefabHandle)
  self._timelinePrefabHandle = _timelinePrefabHandle
  self._scenePrefabMap = {}
  self._sceneName = nil
  self.sceneNpcEntity = {}
  self.updateNpcTimer = Timer.repeated(0.1, handler(self, self.updateNpc), self)
end

function this:dispose()
  for i, v in pairs(self._scenePrefabMap) do
    C_GameObject.DestroyImmediate(v)
    self._scenePrefabMap[i] = nil
  end
  self._scenePrefabMap = nil
  self._sceneName = nil
  self.sceneNpcEntity = nil
  Timer.remove(self.updateNpcTimer)
  self.updateNpcTimer = nil
end

function this:loadScenePrefab(sceneName)
  if self._sceneName == sceneName then
    return
  end
  local prefab
  if self._scenePrefabMap[self._sceneName] then
    self._scenePrefabMap[self._sceneName]:ActiveTrans(false)
  end
  self._sceneName = sceneName
  if self._scenePrefabMap[sceneName] then
    prefab = self._scenePrefabMap[sceneName]
  else
    prefab = L_ResPool:syncGameObject(sceneName)
    prefab.transform.parent = self._timelinePrefabHandle:getRoot().transform
    L_Vector3.setPos(prefab.transform, L_Vector3.getTemp())
    L_Vector3.setRot(prefab.transform, L_Vector3.getTemp())
    self._scenePrefabMap[sceneName] = prefab
  end
  prefab:ActiveTrans(true)
end

function this:getHatchEggPrefab()
  local name = "egg_hatch"
  return self._scenePrefabMap[name]
end

function this:loadHatchEggPrefab(eggInfo, disable)
  local prefabPath = eggInfo.modPath
  local name = "egg_hatch"
  return self:loadUnitPrefab(name, prefabPath, disable)
end

function this:loadUnitPrefab(name, prefabPath, disable)
  local prefab
  if self._scenePrefabMap[name] and disable then
    self._scenePrefabMap[name]:ActiveTrans(false)
    C_GameObject.DestroyImmediate(self._scenePrefabMap[name])
    self._scenePrefabMap[name] = nil
    return nil
  end
  if self._scenePrefabMap[name] then
    prefab = self._scenePrefabMap[name]
  elseif not string.isEmpty(prefabPath) then
    prefab = L_ResPool:syncGameObject(prefabPath)
    prefab.transform.parent = self._timelinePrefabHandle:getRoot().transform
    L_Vector3.setPos(prefab.transform, L_Vector3.getTemp())
    L_Vector3.setRot(prefab.transform, L_Vector3.getTemp())
    L_Vector3.setSize(prefab.transform, 1)
    self._scenePrefabMap[name] = prefab
  end
  if prefab then
    prefab:ActiveTrans(true)
  end
  return prefab
end

function this:getUnitPrefab(name)
  return self._scenePrefabMap[name]
end

function this:sceneNpcLoadAiBehavior(unitId, json)
  self.sceneNpcEntity[unitId]:loadAIBehavior(json)
end

function this:sceneNpcLoadAiBehaviorByState(unitId, state)
  if state == L_Const.petTimelineState.Main then
    self.sceneNpcEntity[unitId]:loadAIBehavior("behavior_petmanagermain")
  elseif state == L_Const.petTimelineState.Shop then
    self.sceneNpcEntity[unitId]:loadAIBehavior("behavior_petmanagershop")
  else
    self.sceneNpcEntity[unitId]:loadAIBehavior("behavior_petmanagermain")
  end
end

function this:setAssetsActive(isActive)
  self._timelinePrefabHandle:getRoot():ActiveTrans(isActive)
end

return this
