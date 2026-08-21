require("base_service")
_class("EntityPoolServiceRender", BaseService)
EntityPoolServiceRender = EntityPoolServiceRender

function EntityPoolServiceRender:Constructor(world)
  self._world = world
  self._entityCacheConfig = {}
  self._entityCacheConfig[EntityConfigIDRender.SkillRangeOutline] = 20
  self._entityCacheConfig[EntityConfigIDRender.MonsterAreaOutLine] = 10
  self._entityCacheConfig[EntityConfigIDRender.LinkNum_Any] = 5
  self._entityCacheConfig[EntityConfigIDRender.LinkNum_Red] = 5
  self._entityCacheConfig[EntityConfigIDRender.LinkNum_Green] = 5
  self._entityCacheConfig[EntityConfigIDRender.LinkNum_Blue] = 5
  self._entityCacheConfig[EntityConfigIDRender.LinkNum_Yellow] = 5
  self._entityCacheConfig[EntityConfigIDRender.LinkNumStep] = 5
  self._entityCacheConfig[EntityConfigIDRender.LinkGridDot_Any] = 5
  self._entityCacheConfig[EntityConfigIDRender.LinkGridDot_Red] = 5
  self._entityCacheConfig[EntityConfigIDRender.LinkGridDot_Green] = 5
  self._entityCacheConfig[EntityConfigIDRender.LinkGridDot_Blue] = 5
  self._entityCacheConfig[EntityConfigIDRender.LinkGridDot_Yellow] = 5
  self._entityCacheConfig[EntityConfigIDRender.LinkLine_Any] = 5
  self._entityCacheConfig[EntityConfigIDRender.LinkLine_Red] = 5
  self._entityCacheConfig[EntityConfigIDRender.LinkLine_Green] = 5
  self._entityCacheConfig[EntityConfigIDRender.LinkLine_Blue] = 5
  self._entityCacheConfig[EntityConfigIDRender.LinkLine_Yellow] = 5
  self._entityCacheConfig[EntityConfigIDRender.MoveRange] = 5
  self._entityCacheConfig[EntityConfigIDRender.MoveRangePro] = 5
  self._entityCacheConfig[EntityConfigIDRender.MoveRangeArrow] = 5
  self._entityCacheConfig[EntityConfigIDRender.MoveRangeGrid] = 5
  self._entityCacheConfig[EntityConfigIDRender.WarningArea] = 5
  self._entityCacheConfig[EntityConfigIDRender.DeathArea] = 5
  self._entityCacheConfig[EntityConfigIDRender.WaringDeathArea] = 1
  self._entityCacheConfig[EntityConfigIDRender.TrapAurasArea] = 1
  self._entityCacheConfig[EntityConfigIDRender.TrapAreaOutline] = 10
  self._lineRenderEntityList = {
    EntityConfigIDRender.LinkLine_Any,
    EntityConfigIDRender.LinkLine_Yellow,
    EntityConfigIDRender.LinkLine_Blue,
    EntityConfigIDRender.LinkLine_Green,
    EntityConfigIDRender.LinkLine_Red
  }
  self._entityCacheTable = {}
end

function EntityPoolServiceRender:CacheEntities()
  local linkageRenderService = self._world:GetService("LinkageRender")
  for cacheID, cahceNum in pairs(self._entityCacheConfig) do
    for cacheIndex = 1, cahceNum do
      local cacheEntity = self:_CreateCahceEntity(cacheID)
      local cacheList = self._entityCacheTable[cacheID]
      if cacheList == nil then
        cacheList = {}
        self._entityCacheTable[cacheID] = cacheList
      end
      if table.icontains(self._lineRenderEntityList, cacheID) then
        linkageRenderService:ResetLinkLineEntity(cacheEntity)
      end
      cacheList[#cacheList + 1] = cacheEntity
    end
  end
end

function EntityPoolServiceRender:HideCacheEntities()
  for _, entityList in pairs(self._entityCacheTable) do
    for _, entity in pairs(entityList) do
      local viewCmpt = entity:View()
      if viewCmpt ~= nil then
        viewCmpt:GetGameObject().transform.position = Vector3(0, BattleConst.CacheHeight, 0)
      end
    end
  end
end

function EntityPoolServiceRender:_CreateCahceEntity(cacheID)
  local sEntity = self._world:GetService("RenderEntity")
  local cacheEntity = sEntity:CreateRenderEntity(cacheID)
  cacheEntity:SetViewVisible(true)
  return cacheEntity
end

function EntityPoolServiceRender:GetCacheEntityCountByID(cacheID)
  local entityList = self._entityCacheTable[cacheID]
  if entityList == nil then
    Log.notice("has not cache entity,which config id is:", cacheID)
    return nil
  end
  local curCount = #entityList
  return curCount
end

function EntityPoolServiceRender:GetCacheEntityByConfigID(cacheID)
  local entityList = self._entityCacheTable[cacheID]
  if entityList == nil then
    Log.fatal("has not cache entity,which config id is:", cacheID)
    return nil
  end
  local curCount = #entityList
  if curCount <= 0 then
    local cacheEntity = self:_CreateCahceEntity(cacheID)
    return cacheEntity
  end
  local cacheIndex = 1
  local curEntity = entityList[cacheIndex]
  table.remove(entityList, cacheIndex)
  return curEntity
end

function EntityPoolServiceRender:DestroyCacheEntity(cacheEntity, entityConfigID)
  local entityList = self._entityCacheTable[entityConfigID]
  if entityList == nil then
    Log.fatal("DestroyCacheEntity,has not cache entity,which config id is:", entityConfigID)
    return nil
  end
  self:_HideCacheEntity(cacheEntity)
  entityList[#entityList + 1] = cacheEntity
end

function EntityPoolServiceRender:_HideCacheEntity(cacheEntity)
  local viewCmpt = cacheEntity:View()
  if viewCmpt == nil then
    Log.fatal("cache entity has no view")
    return
  end
  local gameObj = viewCmpt:GetGameObject()
  local curPos = gameObj.transform.position
  gameObj.transform.position = Vector3(curPos.x, BattleConst.CacheHeight, curPos.z)
  cacheEntity:SetLocationHeight(BattleConst.CacheHeight)
  local lineRender = gameObj:GetComponent("LineRenderer")
  if lineRender == nil then
    lineRender = gameObj:GetComponentInChildren(typeof(UnityEngine.LineRenderer))
    if lineRender then
      lineRender.positionCount = 2
      local pos = Vector3(0, 1000, 0)
      lineRender:SetPosition(0, pos)
      lineRender:SetPosition(1, pos)
    end
  end
end
