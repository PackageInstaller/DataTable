local GameObjectUtil = CS.Framework.GameObjectUtil
local SceneManager = CS.UnityEngine.SceneManagement.SceneManager
local AMTimelineUtils = CS.AMTimeline.AMTimelineUtils
local UnitySceneHelper = System.NewClass("UnitySceneHelper")

function UnitySceneHelper:ctor(assetPath)
  self.assetPath = assetPath
end

function UnitySceneHelper:IsValid()
  local scene = SceneManager.GetSceneByPath(self.assetPath)
  return scene:IsValid() and scene.isLoaded
end

function UnitySceneHelper:ActiveScene()
  SceneManager.SetActiveScene(self.scene)
end

function UnitySceneHelper:LoadSceneAsync(onComplete)
  if self:IsValid() then
    self:OnSceneLoaded()
    if onComplete then
      onComplete()
    end
    return
  end
  ResLoadMgr.LoadSceneAsync(self.assetPath, CommonDefine.LoadSceneModeType.Additive, function()
    self:OnSceneLoaded()
    if onComplete then
      onComplete()
    end
  end)
end

function UnitySceneHelper:UnloadScene()
  AMTimelineUtils.ReleaseSceneCacheRef(self.assetPath)
  if self:IsValid() then
    self:Hide()
    ResLoadMgr.UnLoadScene(self.assetPath)
  end
  self.rootObjects = nil
end

function UnitySceneHelper:OnSceneLoaded()
  if not self:IsValid() then
    return
  end
  AMTimelineUtils.AddSceneCacheRef(self.assetPath)
  self.curBattleSceneStatus = UnitySceneStatus(self.assetPath)
  self.scene = SceneManager.GetSceneByPath(self.assetPath)
  self:ActiveScene()
  self:SetupRootGameObjects()
end

function UnitySceneHelper:Show()
  if self.curBattleSceneStatus then
    self.curBattleSceneStatus:Show()
  end
end

function UnitySceneHelper:Hide()
  if self.curBattleSceneStatus then
    self.curBattleSceneStatus:Hide()
  end
end

function UnitySceneHelper:SetupRootGameObjects()
  self.rootObjects = {}
  local rootObjects = self.scene:GetRootGameObjects()
  for i = 0, rootObjects.Length - 1 do
    table.insert(self.rootObjects, rootObjects[i])
  end
end

function UnitySceneHelper:Find(name)
  if not self.rootObjects then
    return
  end
  local rootNodeName = name
  local childPath
  local index = string.find(name, "/")
  if index then
    rootNodeName = string.sub(rootNodeName, 1, index - 1)
    childPath = string.sub(rootNodeName, index + 1)
  end
  for i = 1, #self.rootObjects do
    if self.rootObjects[i].name == rootNodeName then
      if not childPath then
        return self.rootObjects[i]
      end
      local tf = GameObjectUtil.DeepFindChild(self.rootObjects[i].transform, childPath)
      if tf then
        return tf.gameObject
      end
    end
  end
end

return UnitySceneHelper
