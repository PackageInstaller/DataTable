local MapManager, Super = System.NewClass("MapManager", Manager, IUpdater)

function MapManager:Awake(binder)
  Super.Awake(self)
  self.mapId = 0
end

function MapManager:SetLoadingCallback(callback)
  self.loadingCb = callback
end

function MapManager:SetMapId(sceneId)
  self.mapId = sceneId
  if self.mapId > 0 then
    self:RemoveCurMap()
    self:LoadNewMap(self.mapId)
  else
    self:RemoveCurMap()
  end
end

function MapManager:LoadNewMap(sceneId)
  self.co = SceneLoader.StartMapLoading(function()
    self.currentMap = Map(sceneId)
    self.currentMap:EnterMap(function()
      SceneLoader.EndLoading(function()
        if self.loadingCb then
          self.loadingCb()
          self.loadingCb = nil
        end
        EventMgr.Instance.ConnectYeld:Dispatch(false)
        self:CreateMapUINode()
      end)
    end)
  end)
end

function MapManager:RemoveCurMap()
  if self.currentMap ~= nil then
    self:DestoryMapUINode()
    self.currentMap:ExitMap()
    self.currentMap:Destroy()
    self.currentMap = nil
  end
end

function MapManager:GetNodeInfoByKeyId(keyId)
  if self.currentMap ~= nil then
    do return self.currentMap.GetNodeInfoByKeyId, self.currentMap end
    return self.currentMap.GetNodeInfoByKeyId, self.currentMap, keyId
  end
  return nil
end

function MapManager:GetPatrolPathById(pathId)
  if self.currentMap then
    do return self.currentMap.GetPathById, self.currentMap end
    return self.currentMap.GetPathById, self.currentMap, pathId
  end
  error("GetPatrolPathById 错误:currentMap未创建")
end

function MapManager:GetMapPath()
  if self.currentMap ~= nil then
    do return self.currentMap.GetMapPath end
    return self.currentMap.GetMapPath, self.currentMap
  end
end

function MapManager:GetMapTid()
  if self.currentMap ~= nil then
    return self.currentMap.id
  end
end

function MapManager:GetBornNodeInfo()
  if 0 == DataCenter.copiesData.BornKeyId then
    local list = self:GetNodeInfoByNodeType(CommonDefine.NodeType.CopiesEnterBorn)
    if list and #list > 0 then
      return list[1]
    end
    Logger.Info("没有找到副本入口出生点 keyID")
  end
  local list = self:GetNodeInfoByNodeType(CommonDefine.NodeType.Born)
  if list and #list > 0 then
    for _, value in ipairs(list) do
      if value.keyId == DataCenter.copiesData.BornKeyId then
        Logger.Info("找到出生点 keyID == %s ", DataCenter.copiesData.BornKeyId)
        return value
      end
    end
    Logger.Info("没有找到出生点 keyID == %s ", DataCenter.copiesData.BornKeyId)
    return list[1]
  end
  return nil
end

function MapManager:GetNodeInfoByNodeType(nodeType)
  if self.currentMap ~= nil then
    do return self.currentMap.GetNodeInfoByNodeType, self.currentMap end
    return self.currentMap.GetNodeInfoByNodeType, self.currentMap, nodeType
  end
  return nil
end

function MapManager:GetNodeHitBoxInfo(keyId)
  local nodeInfo = self:GetNodeInfoByKeyId(keyId)
  if nodeInfo then
    return nodeInfo.hitBoxInfo
  end
  return nil
end

function MapManager:GetNodeAudioHitBoxInfo(keyId)
  local nodeInfo = self:GetNodeInfoByKeyId(keyId)
  if nodeInfo then
    return nodeInfo.audioHitBoxInfo
  end
  return nil
end

function MapManager:GetNodeHitBoxShowRang(keyId)
  local nodeInfo = self:GetNodeInfoByKeyId(keyId)
  if nodeInfo and nodeInfo.showRange then
    return 1 == nodeInfo.showRange
  end
  return false
end

function MapManager:GetNodeIconPos(keyId)
  local nodeInfo = self:GetNodeInfoByKeyId(keyId)
  if nodeInfo and nodeInfo.iconPos then
    return nodeInfo.iconPos
  end
  return nil
end

function MapManager:Update()
  if self.currentMap ~= nil then
    self.currentMap:Update()
  end
end

function MapManager:OnDestroy()
  Super.OnDestroy(self)
  self:RemoveCurMap()
  self.mapId = 0
end

function MapManager:GetBoundNodes()
  if self.currentMap ~= nil then
    local list1 = self.currentMap:GetNodeInfoByNodeType(CommonDefine.NodeType.LeftBottom)
    local list2 = self.currentMap:GetNodeInfoByNodeType(CommonDefine.NodeType.RightTop)
    local leftLowerNode = #list1 > 0 and list1[1] or nil
    local rightUpperNode = #list2 > 0 and list2[1] or nil
    return leftLowerNode, rightUpperNode
  end
  return nil, nil
end

function MapManager:CreateMapUINode()
  local prefab = self.binder:LoadAsset("GameBasePrefab/MapSceneUI.prefab")
  self.mapUINode = CS.UnityEngine.GameObject.Instantiate(prefab)
  local sceneRootNode = CS.UnityEngine.GameObject.Find("SceneRoot")
  self.mapUINode.transform:SetParent(sceneRootNode.transform)
  self.storyLayer = UIRootMgr.FindChild(self.mapUINode.transform, "StoryLayer")
  local uiCanvas = self.storyLayer:GetComponent(typeof(CS.UnityEngine.Canvas))
  uiCanvas.worldCamera = UIRootMgr.GetUICamera()
end

function MapManager:DestoryMapUINode()
  if self.mapUINode then
    CS.UnityEngine.GameObject.Destroy(self.mapUINode)
  end
end

function MapManager:GetStoryLayer()
  return self.storyLayer
end

return MapManager
