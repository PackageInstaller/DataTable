local this = class("petHouseTimelinePrefabHandle", require("ui.manager.hero.timeline.timelinePrefabHandle"))
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
  L_Vector3.setPos(prefab.transform, L_Vector3.getTemp())
  L_Vector3.setRot(prefab.transform, L_Vector3.getTemp())
  self:loadTimelinePrefabFinish(timelineName, prefab)
end

function this:getFilePath(timelineName)
  local lowerName = string.lower(timelineName)
  local path = "Timeline/UI/PetHouse/" .. timelineName .. "/pre_pethousecamera_" .. lowerName .. ".prefab"
  return path
end

function this:loadEggHatchPrefab(timelineName)
  local prefab
  local path = "Timeline/UI/EggHatch/pre_egghatch/pre_timeline_pet.prefab"
  if self._prefabMap[timelineName] then
    prefab = self._prefabMap[timelineName]
  else
    prefab = L_ResPool:syncGameObject(path)
    prefab.transform.parent = self._root.transform
  end
  L_Vector3.setPos(prefab.transform, L_Vector3.getTemp())
  L_Vector3.setRot(prefab.transform, L_Vector3.getTemp())
  self:loadTimelinePrefabFinish(timelineName, prefab)
end

function this:loadBreedPetPrefab(timelineName)
  local prefab
  local path = "Timeline/UI/PetBreed/pre_petbreed_common/pre_timeline_pet.prefab"
  if self._prefabMap[timelineName] then
    prefab = self._prefabMap[timelineName]
  else
    prefab = L_ResPool:syncGameObject(path)
    prefab.transform.parent = self._root.transform
  end
  L_Vector3.setPos(prefab.transform, L_Vector3.getTemp())
  L_Vector3.setRot(prefab.transform, L_Vector3.getTemp())
  self:loadTimelinePrefabFinish(timelineName, prefab)
end

function this:disableEggHatchPrefab()
  if self._prefabMap.pre_egghatch then
    self._prefabMap.pre_egghatch:ActiveTrans(false)
  end
end

function this:disableBreedPetPrefab()
  if self._prefabMap.pre_petbreed then
    self._prefabMap.pre_petbreed:ActiveTrans(false)
  end
end

function this:getCinemaBrain()
  return self._cameraBrain
end

function this:resetCamera(isInit)
  if isInit == true then
    self._camera = C_CameraManager.mainCamera
    self._cameraBrain = C_CameraManager.mainCamera:GetComponent(typeof(C_CinemachineBrain))
    self._cameraBrain.enabled = false
  else
    self._cameraBrain.enabled = true
  end
end

function this:playTimelineAsset(timelineName)
  local state = self._timelineStateMap[timelineName]
  if state then
    state.director:SetGenericBinding()
    if self._camera then
      state:SetCamera(self._camera)
    end
    if self._cameraBrain and self._cameraBrain.enabled == false then
      self._cameraBrain.enabled = true
    end
    state.director:Play()
    self:onTimelinePlay(state.director)
  end
end

return this
