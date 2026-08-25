local GameObject = CS.UnityEngine.GameObject
local PooledGameObject = System.NewClass("PooledGameObject")

function PooledGameObject:ctor(assetPath, poolRoot)
  self.assetPath = assetPath
  self.poolRoot = poolRoot
  local prefab = ResLoadMgr.LoadAsset(assetPath, self)
  if nil ~= prefab then
    self.rootNode = GameObject.Instantiate(prefab, poolRoot)
    self.rootNode:SetActive(false)
  else
    Logger.Error("prefab is nil, assetPath =" .. assetPath)
  end
end

function PooledGameObject:OnRecycle()
  if self.rootNode == nil then
    return
  end
  self.rootNode:SetActive(false)
  if self.poolRoot then
    self.rootNode.transform:SetParent(self.poolRoot)
  end
end

function PooledGameObject:UnloadAsset()
  ResLoadMgr.UnloadAssetByTarget(self)
end

function PooledGameObject:Dispose()
  ResLoadMgr.UnloadAssetByTarget(self)
  if IsNil(self.rootNode) then
    return
  end
  GameObject.Destroy(self.rootNode)
end

return PooledGameObject
