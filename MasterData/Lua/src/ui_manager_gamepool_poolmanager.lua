local this = class("poolManager", G_EventManagerBase)
local _typeImg = typeof(C_LImage)

function this:ctor()
  this.super.ctor(self)
  
  function C_LRichText.OnGetPrefab(imgPath)
    local go = L_ResPool:syncGameObject("UI/Pages/Flymsg/pre_commonImg.prefab")
    local img = go:GetComponent(_typeImg)
    img:LoadSprite(imgPath)
    return go
  end
  
  function C_LRichText.OnReleasePrefab(go)
    C_BoundGameObject.Destroy(go)
  end
end

function this:getResPool(...)
  return require("ui.manager.gamePool.pool.resPool").new(...)
end

function this:getSpawnPool(...)
  return require("ui.manager.gamePool.pool.spawnPool").new(...)
end

function this:getAsyncSpawnPool(...)
  return require("ui.manager.gamePool.pool.asyncSpawnPool").new(...)
end

return this
