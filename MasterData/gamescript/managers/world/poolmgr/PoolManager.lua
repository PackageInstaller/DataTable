local PoolManager, Super = System.NewClass("PoolManager", Manager)

function PoolManager:ctor()
  Super.ctor(self)
end

local PreloadUIList

function PoolManager:_GetPreloadUIList()
  if not PreloadUIList then
    PreloadUIList = {
      Item_Shop_ArticleResource
    }
  end
  return PreloadUIList
end

function PoolManager:PreloadUIRes(callFunc)
  local loadedCount = 0
  local preloadList = self:_GetPreloadUIList()
  for _, res in pairs(preloadList) do
    ResLoadMgr.LoadAssetAsync(res.assetPath, self, function(_)
      loadedCount = loadedCount + 1
      Logger.Debug("#loadedCount:", loadedCount)
      if loadedCount >= #preloadList then
        Logger.Info("#异步加载UI资源完毕，调用回调:", loadedCount)
        if callFunc then
          callFunc()
        end
      end
    end)
  end
end

function PoolManager:ClearUIRes()
  local preloadList = self:_GetPreloadUIList()
  for _, res in pairs(preloadList) do
    ResLoadMgr.UnloadAsset(res.assetPath, self)
  end
end

function PoolManager:Awake()
  Super.Awake(self)
  local poolRoot = CS.Framework.GameObjectUtil.CreateDontDestroyObject("#PoolManager")
  poolRoot.transform.parent = UIRootMgr.GetSceneRoot().transform
  self.poolRootTrans = poolRoot.transform
  self.uiPoolTrans = self:CreatePoolNode(self.poolRootTrans, "#UIPool").transform
  self.uiItemPoolTrans = self:CreatePoolNode(self.poolRootTrans, "#uiItemPool").transform
  self.uiPool = UIResPool({maxCount = 0, releaseTime = 30})
  self.itemUIPoolMap = {}
end

function PoolManager:GetUIResource(res)
  local ui = self.uiPool:Get(res)
  ui.uiNode:SetActive(true)
  return ui
end

function PoolManager:GetItemUIResouce(res)
  local assetPath = res.assetPath
  local itemUIPool = self.itemUIPoolMap[assetPath]
  if not itemUIPool then
    self.itemUIPoolMap[assetPath] = UIResPool({maxCount = 0, releaseTime = 30})
    itemUIPool = self.itemUIPoolMap[assetPath]
  end
  local itemUI = itemUIPool:Get(res)
  itemUI.uiNode:SetActive(true)
  return itemUI
end

function PoolManager:FreeUI(ui)
  local uiNode = ui.uiNode
  uiNode.transform:SetParent(self.uiPoolTrans, false)
  uiNode:SetActive(false)
  self.uiPool:Free(ui)
end

function PoolManager:FreeItemUI(itemUI)
  local uiNode = itemUI.uiNode
  uiNode.transform:SetParent(self.uiItemPoolTrans, false)
  uiNode:SetActive(false)
  local itemUIPool = self.itemUIPoolMap[itemUI.assetPath]
  if itemUIPool then
    itemUIPool:Free(itemUI)
  end
end

function PoolManager:CreatePoolNode(rootNodeTransform, poolName)
  local poolNode = CS.Framework.GameObjectUtil.CreateDontDestroyObject(poolName)
  poolNode.transform.parent = rootNodeTransform
  return poolNode
end

function PoolManager:ClearUIPool()
  self.uiPool:Clear()
end

function PoolManager:ClearAllPool()
  self.uiPool:Clear()
  for _, itemUIPool in pairs(self.itemUIPoolMap) do
    itemUIPool:Clear()
  end
end

function PoolManager:OnDestroy()
  Super.OnDestroy(self)
  self:ClearAllPool()
  if self.poolRootTrans then
    CS.UnityEngine.GameObject.Destroy(self.poolRootTrans.gameObject)
    self.poolRootTrans = nil
  end
end

return PoolManager
