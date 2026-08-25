local SceneManager = CS.UnityEngine.SceneManagement.SceneManager
local AMResourcesCache = CS.AMTimeline.AMResourcesCache
local UnitySceneStatus = System.NewClass("UnitySceneStatus")

function UnitySceneStatus:ctor(assetPath)
  self.assetPath = assetPath
  local scene = SceneManager.GetSceneByPath(assetPath)
  local rootObjects = scene:GetRootGameObjects()
  self.rootGameObjects = {}
  for i = 0, rootObjects.Length - 1 do
    table.insert(self.rootGameObjects, rootObjects[i])
  end
  self:SaveStatus()
end

function UnitySceneStatus:SaveStatus()
  if self.sceneStatus then
    return
  end
  self.sceneStatus = {}
  local sceneObjs = AMResourcesCache.GetSceneObjects(self.assetPath)
  if sceneObjs then
    local rootObjs = sceneObjs:GetSceneRootObjects()
    if rootObjs then
      for i = 0, rootObjs.Length - 1 do
        local rootGo = rootObjs[i]
        if rootGo and not IsNil(rootGo.gameObject) then
          self.sceneStatus[rootGo.gameObject] = rootGo.isActive
        end
      end
      return
    end
  end
  for i = 1, #self.rootGameObjects do
    local rootGo = self.rootGameObjects[i]
    if not IsNil(rootGo) then
      self.sceneStatus[rootGo] = rootGo.activeSelf
    end
  end
end

function UnitySceneStatus:Show()
  self.isHided = false
  if not self.sceneStatus then
    return
  end
  for i = 1, #self.rootGameObjects do
    local rootGo = self.rootGameObjects[i]
    if not IsNil(rootGo) and self.sceneStatus[rootGo] ~= nil then
      rootGo:SetActive(self.sceneStatus[rootGo])
    end
  end
end

function UnitySceneStatus:Hide()
  self.isHided = true
  if self.rootGameObjects then
    for i = 1, #self.rootGameObjects do
      local rootGo = self.rootGameObjects[i]
      if not IsNil(rootGo) then
        rootGo:SetActive(false)
      end
    end
  end
end

return UnitySceneStatus
