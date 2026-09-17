local this = class("rogueEntryTimelineSceneHandle")
local VolumeCtr = CS.UnityEngine.Rendering.Azur.Volume
local WeatherCtr = CS.UnityEngine.Rendering.Azur.RealWeatherController

function this:ctor(_timelinePrefabHandle)
  self._timelinePrefabHandle = _timelinePrefabHandle
  self._scenePrefabMap = {}
  self._sceneName = nil
end

function this:dispose()
  self.isDispose = true
  for i, v in pairs(self._scenePrefabMap) do
    C_GameObject.DestroyImmediate(v)
    self._scenePrefabMap[i] = nil
  end
  self._scenePrefabMap = nil
  self._sceneName = nil
  self.weather = nil
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
    L_Vector3.setLocalPos(prefab.transform, L_Vector3.getTemp())
    L_Vector3.setRot(prefab.transform, L_Vector3.getTemp())
    self._scenePrefabMap[sceneName] = prefab
  end
  local Weather = prefab:GetComponentInChildren(typeof(WeatherCtr))
  if Weather ~= nil then
    print("成功在子物体中找到了 VolumeController 组件！")
    self.weather = Weather
  else
    print("警告：未能在预制体的子物体中找到 VolumeController 组件。")
  end
  prefab:ActiveTrans(true)
end

function this:loadScenePrefabAsync(sceneName, onLoaded)
  local function onResourceeLoaded(id, prefab)
    if self.isDispose then
      return
    end
    prefab.transform.parent = self._timelinePrefabHandle:getRoot().transform
    L_Vector3.setLocalPos(prefab.transform, L_Vector3.getTemp())
    L_Vector3.setRot(prefab.transform, L_Vector3.getTemp())
    local volume = prefab:GetComponentInChildren(typeof(VolumeCtr))
    if volume ~= nil then
      print("成功在子物体中找到了 VolumeController 组件！")
    else
      print("警告：未能在预制体的子物体中找到 VolumeController 组件。")
    end
    local Weather = prefab:GetComponentInChildren(typeof(WeatherCtr))
    if Weather ~= nil then
      print("成功在子物体中找到了 VolumeController 组件！")
      self.weather = Weather
    else
      print("警告：未能在预制体的子物体中找到 VolumeController 组件。")
    end
    self._scenePrefabMap[sceneName] = prefab
    prefab:ActiveTrans(true)
    if onLoaded then
      onLoaded()
    end
  end
  
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
    prefab:ActiveTrans(true)
    if onLoaded then
      onLoaded()
    end
  else
    L_ResPool:asyncGameObject(sceneName, onResourceeLoaded)
  end
end

function this:setAssetsActive(isActive)
  self._timelinePrefabHandle:setAssetsActive(isActive)
end

function this:setSceneActive(isActive)
  local prefab = self._scenePrefabMap[self._sceneName]
  if prefab then
    prefab:ActiveTrans(isActive)
  end
end

function this:setSceneTime(time, tick)
  if self.weather then
    local timeValue = time or 0
    local tickValue = tick or 0
    self.weather:SetTime(timeValue, tickValue)
  else
    error("没有获取到场景的天气控制组件")
  end
end

return this
