local CacheUtils = System.NewClass("CacheUtils")
CacheUtils.cacheMap = {}

function CacheUtils.CacheData(cacheKey, cacheData, timeoutToClear)
  CacheUtils.cacheMap[cacheKey] = CacheUtils.cacheMap[cacheKey] or {}
  local map = CacheUtils.cacheMap[cacheKey]
  local lastTimerId = map[cacheData]
  if lastTimerId and 0 ~= lastTimerId then
    TimerManager.Instance:StopTimer(lastTimerId)
  end
  map[cacheData] = 0
  if timeoutToClear then
    map[cacheData] = TimerManager.Instance:CreateTimer(timeoutToClear, 0, nil, function()
      map[cacheData] = nil
    end)
  end
end

function CacheUtils.ClearCacheData(cacheKey, cacheData)
  CacheUtils.cacheMap[cacheKey] = CacheUtils.cacheMap[cacheKey] or {}
  local map = CacheUtils.cacheMap[cacheKey]
  local lastTimerId = map[cacheData]
  if lastTimerId and 0 ~= lastTimerId then
    TimerManager.Instance:StopTimer(lastTimerId)
  end
  map[cacheData] = nil
end

function CacheUtils.IsCached(cacheKey, cacheData)
  CacheUtils.cacheMap[cacheKey] = CacheUtils.cacheMap[cacheKey] or {}
  local map = CacheUtils.cacheMap[cacheKey]
  return nil ~= map[cacheData]
end

return CacheUtils
