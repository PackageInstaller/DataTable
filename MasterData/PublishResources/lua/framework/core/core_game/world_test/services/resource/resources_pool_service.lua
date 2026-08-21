_class("ResCacheInfo", Object)
ResCacheInfo = ResCacheInfo

function ResCacheInfo:Constructor()
  self.reslist = ArrayList:New()
  self.resName = ""
  self.CacheCount = 0
  self.CurUseCount = 0
  self.MaxUsedCount = 0
  self.EnableCache = true
end

function ResCacheInfo:Use()
  self.CurUseCount = self.CurUseCount + 1
  if self.MaxUsedCount < self.CurUseCount then
    self.MaxUsedCount = self.CurUseCount
  end
end

function ResCacheInfo:UnUse()
  self.CurUseCount = self.CurUseCount - 1
end

function ResCacheInfo:SetEnableCache(enable)
  self.EnableCache = enable
end

function ResCacheInfo:IsEnable()
  return self.EnableCache
end

_class("ResourcesPoolService", Object)
ResourcesPoolService = ResourcesPoolService

function ResourcesPoolService:Constructor(world)
  self._world = world
  self._cacheTable = {}
  self._assetTable = {}
  self._materialTable = {}
  self._loadTimeTable = {}
  self._donotDestroyRes = GameGlobal:GetInstance().donotDestroyRes
end

function ResourcesPoolService:LoadGameObject(resName)
  local resCacheInfo = self._cacheTable[resName]
  if resCacheInfo == nil then
    Log.notice("[respool] lua LoadGameObject not cache", resName)
    return self._world.BW_Services.Resource:LoadGameObject(resName)
  else
    resCacheInfo:Use()
    if resCacheInfo.reslist:Size() <= 0 then
      return self._world.BW_Services.Resource:LoadGameObject(resName)
    else
      local res = resCacheInfo.reslist:PopBack()
      if res == nil or res.Obj == nil then
        Log.error("[respool]ResourcesPoolService:LoadGameObject res == nil or res.Obj == nil", resName)
        return self._world.BW_Services.Resource:LoadGameObject(resName)
      else
        local u3dGo = res.Obj
        local transWork = u3dGo.transform
        transWork.localScale = Vector3(1, 1, 1)
        u3dGo:SetActive(true)
        return res
      end
    end
  end
end

function ResourcesPoolService:LoadAsset(assetName)
  local resCacheInfo = self._assetTable[assetName]
  if resCacheInfo == nil then
    Log.notice("[respool] lua Asset not cache", assetName)
    return nil
  elseif resCacheInfo.reslist:Size() <= 0 then
    Log.notice("[respool] lua Asset cache count == 0", assetName)
    return nil
  else
    local res = resCacheInfo.reslist:GetAt(1)
    if res == nil or res.Obj == nil then
      Log.error("[respool]ResourcesPoolService:Asset res == nil or res.Obj == nil", assetName)
      return nil
    else
      return res
    end
  end
end

function ResourcesPoolService:LoadMaterial(assetName)
  local resCacheInfo = self._materialTable[assetName]
  if resCacheInfo == nil then
    Log.notice("[respool] lua Asset not cache", assetName)
    return nil
  elseif resCacheInfo.reslist:Size() <= 0 then
    Log.notice("[respool] lua Asset cache count == 0", assetName)
    return nil
  else
    local res = resCacheInfo.reslist:GetAt(1)
    if res == nil or res.Obj == nil then
      Log.error("[respool]ResourcesPoolService:Asset res == nil or res.Obj == nil", assetName)
      return nil
    else
      return res
    end
  end
end

function ResourcesPoolService:DestroyView(view, noCache)
  local viewType = view.ViewType
  if viewType == "UnitySimple" then
    local _view = view
    self:UnLoad(_view.ResRequest.m_Name, _view.ResRequest, _view.ViewType, noCache)
    _view.ResRequest = nil
    _view.Transform = nil
  elseif viewType == "GridView" then
    local _view = view
    self:UnLoad(_view.ResRequest.m_Name, _view.ResRequest, _view.ViewType, noCache)
    _view.ResRequest = nil
    _view.Transform = nil
  elseif viewType == "UnityPet" then
    local _view = view
    if _view.ResRequests then
      for _, res in ipairs(_view.ResRequests) do
        self:UnLoad(res.m_Name, res, view.ViewType, noCache)
      end
      _view.ResRequests = nil
      _view.Transform = nil
      _view.GameObject = nil
    end
  else
    Log.fatal("[ResourcesPool] 未识别的ViewWrapper对象：", view.ViewType)
  end
end

function ResourcesPoolService:UnLoad(resName, res, viewType, noCache)
  if res == nil or res.Obj == nil then
    Log.error("ResourcesPoolService:UnLoad res == nil or res.Obj == nil ", resName)
    return
  end
  local u3dGo = res.Obj
  if viewType == "GridView" then
    local curPos = u3dGo.transform.position
    u3dGo.transform.position = Vector3(curPos.x, BattleConst.CacheHeight, curPos.z)
  else
    u3dGo:SetActive(false)
  end
  local resCacheInfo = self._cacheTable[resName]
  if resCacheInfo ~= nil and resCacheInfo:IsEnable() and not noCache then
    resCacheInfo:UnUse()
    resCacheInfo.reslist:PushBack(res)
  else
    res:Dispose()
  end
end

function ResourcesPoolService:_Cache(dicInfo, resName, nCount, eLoadType)
  local resCacheInfo = dicInfo[resName]
  resCacheInfo = resCacheInfo or ResCacheInfo:New()
  local t1 = os.clock()
  local originalCnt = nCount
  local t = self._donotDestroyRes:GetRes(resName)
  if t then
    for i, res in ipairs(t) do
      resCacheInfo.reslist:PushBack(res)
    end
    nCount = nCount - #t
    if nCount < 0 then
      nCount = 0
    end
  end
  for i = 1, nCount do
    local res = ResourceManager:GetInstance():SyncLoadAsset(resName, eLoadType)
    resCacheInfo.reslist:PushBack(res)
  end
  local tick = os.clock() - t1
  table.insert(self._loadTimeTable, {
    useTime = tick * 1000,
    resName = resName,
    resCount = originalCnt,
    resType = eLoadType
  })
  resCacheInfo.CacheCount = resCacheInfo.reslist:Size()
  resCacheInfo.resName = resName
  local cachelist = dicInfo[resName]
  if not cachelist then
    dicInfo[resName] = resCacheInfo
  end
end

function ResourcesPoolService:PrintLoadTime()
  table.sort(self._loadTimeTable, function(a, b)
    if a.useTime == b.useTime then
      return a.resCount < b.resCount
    end
    return a.useTime > b.useTime
  end)
  for i, t in ipairs(self._loadTimeTable) do
    Log.prof("[respool] loading idx,", i, ",loadTime,", t.useTime, ",resType,", t.resType, ",resName,", t.resName, ",resCount,", t.resCount)
  end
end

function ResourcesPoolService:PrintCurrentUseage()
  local resTable = {}
  for k, v in pairs(self._cacheTable) do
    resTable[v.resName] = {
      resName = v.resName,
      resUsedCount = v.MaxUsedCount,
      resCacheCount = v.CacheCount
    }
  end
  for k, v in pairs(self._assetTable) do
    resTable[v.resName] = {
      resName = v.resName,
      resUsedCount = v.MaxUsedCount,
      resCacheCount = v.CacheCount
    }
  end
  for k, v in pairs(self._materialTable) do
    resTable[v.resName] = {
      resName = v.resName,
      resUsedCount = v.MaxUsedCount,
      resCacheCount = v.CacheCount
    }
  end
  for i, v in ipairs(self._loadTimeTable) do
    local t = resTable[v.resName]
    if not t then
      Log.error("cache resName", v.resName, "not in loading table!")
    else
      t.loadTime = (t.loadTime or 0) + v.useTime
      t.loadCount = (t.loadCount or 0) + v.resCount
      t.resType = v.resType
    end
  end
  local outTable = {}
  for k, v in pairs(resTable) do
    table.insert(outTable, v)
  end
  table.sort(outTable, function(a, b)
    if a.loadTime == b.loadTime then
      return a.loadCount > b.loadCount
    end
    return a.loadTime > b.loadTime
  end)
  for i, v in ipairs(outTable) do
    Log.prof("[respool] idx,", i, ",loadTime,", v.loadTime, ",resType,", v.resType, ",resName,", v.resName, ",loadCount,", v.loadCount, ",cacheCount,", v.resCacheCount, ",usedCount,", v.resUsedCount)
  end
end

function ResourcesPoolService:Cache(resName, nCount)
  self:_Cache(self._cacheTable, resName, nCount, LoadType.GameObject)
end

function ResourcesPoolService:CacheAsset(resName, nCount)
  self:_Cache(self._assetTable, resName, nCount, LoadType.Asset)
end

function ResourcesPoolService:CacheMaterial(resName, nCount)
  self:_Cache(self._materialTable, resName, nCount, LoadType.Mat)
end

function ResourcesPoolService:Dispose()
  Log.prof("============================================================================")
  self:PrintCurrentUseage()
  Log.prof("============================================================================")
  self:_DisposeTable(self._cacheTable)
  self:_DisposeTable(self._assetTable)
  self:_DisposeTable(self._materialTable)
end

function ResourcesPoolService:_DisposeTable(t)
  for k, v in pairs(t) do
    local cnt = self._donotDestroyRes:GetResCount(v.resName)
    for i = 1, cnt do
      local res = v.reslist:PopBack()
      self._donotDestroyRes:PutRes(v.resName, res)
    end
    self:_DisposeArrayList(v)
  end
  table.clear(t)
end

function ResourcesPoolService:_DisposeArrayList(res)
  local arrayList = res.reslist
  local nCount = arrayList:Size()
  if nCount == 0 then
    return
  end
  for i = 1, nCount do
    arrayList:GetAt(i):Dispose()
  end
  arrayList:Clear()
end

function ResourcesPoolService:DestroyCache(resName)
  local resCacheInfo = self._cacheTable[resName]
  if resCacheInfo == nil then
    return
  end
  resCacheInfo:SetEnableCache(false)
  local resList = resCacheInfo.reslist
  if resList:Size() == 0 then
    return
  end
  for idx = 1, resList:Size() do
    local res = resList:GetAt(idx)
    res:Dispose()
  end
  resList:Clear()
end
