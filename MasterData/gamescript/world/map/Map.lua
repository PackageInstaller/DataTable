local Map, Super = System.NewClass("Map", Entity)

function Map:ctor(id)
  Super.ctor(self)
  self.id = id
  self.mapConfig = DT["Map.Map_" .. self.id]
  self.effects = {}
  self.subScenes = {}
end

function Map:GetMapPath()
  return self.mapConfig.MapPath
end

function Map:EnterMap(loadingCallback)
  DataCenter.mapData.HitBoxUid = 0
  self.logic = self.mapConfig.mapResource
  ResLoadMgr.LoadSceneAsync(self.logic.sceneName, CommonDefine.LoadSceneModeType.Additive, function()
    Logger.Debug(" EnterMap self.logic.sceneName == " .. self.logic.sceneName)
    self:SetFog()
    EventMgr.Instance.MapLoadEnd:Dispatch()
    MapDataUtils.SetMoveSpeed(self.mapConfig.MoveSpeed)
    if loadingCallback then
      loadingCallback()
    end
  end)
end

function Map:SetFog()
  if self.logic.fogOpen and 1 == self.logic.fogOpen then
  else
    CS.UnityEngine.RenderSettings.fog = false
  end
end

function Map:GetNodeInfoByKeyId(keyId)
  return self.logic.nodes[keyId]
end

function Map:GetNodeInfoByNodeType(nodeType)
  local list = {}
  for _, value in pairs(self.logic.nodes) do
    if value.nodeType == nodeType then
      table.insert(list, value)
    end
  end
  return list
end

function Map:GetPathById(pathId)
  local paths = self.logic.paths or {}
  return paths[pathId]
end

function Map:ExitMap()
  for _, value in ipairs(self.effects) do
    EffectManager.Instance:DestroyEffect(value)
  end
  self.effects = {}
  ResLoadMgr.UnLoadScene(self.logic.sceneName)
  self.subScenes = nil
  Logger.Debug(" ExitMap self.logic.sceneName == " .. self.logic.sceneName)
end

return Map
