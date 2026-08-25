local enabled = false
local NetworkProfiler = {}
NetworkProfiler.NetworkProfilerType = {
  Request = 1,
  Notify = 2,
  Unzip = 3,
  HandleRespond = 4
}
NetworkProfiler.enabled = false
local data = {}

function NetworkProfiler.SetEnabled(value)
  enabled = true == value
  NetworkProfiler.enabled = enabled
end

function NetworkProfiler.IsEnabled()
  return enabled
end

function NetworkProfiler.Record(profilerType, func, elapsed)
  if not enabled then
    return
  end
  if not (profilerType and func) or not elapsed then
    return
  end
  if not data[profilerType] then
    data[profilerType] = {}
  end
  local typeData = data[profilerType]
  local entry = typeData[func]
  if not entry then
    entry = {
      count = 0,
      totalTime = 0,
      firstTime = elapsed,
      minTime = elapsed,
      maxTime = elapsed
    }
    typeData[func] = entry
  end
  entry.count = entry.count + 1
  entry.totalTime = entry.totalTime + elapsed
  if elapsed < entry.minTime then
    entry.minTime = elapsed
  end
  if elapsed > entry.maxTime then
    entry.maxTime = elapsed
  end
end

function NetworkProfiler.GetStats(profilerType, func)
  if not profilerType or not func then
    return nil
  end
  local typeData = data[profilerType]
  if not typeData then
    return nil
  end
  local entry = typeData[func]
  if not entry then
    return nil
  end
  return {
    count = entry.count,
    totalTime = entry.totalTime,
    firstTime = entry.firstTime,
    minTime = entry.minTime,
    maxTime = entry.maxTime,
    avgTime = entry.totalTime / entry.count
  }
end

function NetworkProfiler.GetAllStats(profilerType)
  if not profilerType then
    return nil
  end
  return data[profilerType]
end

function NetworkProfiler.Clear(profilerType)
  if not profilerType then
    return
  end
  data[profilerType] = nil
end

function NetworkProfiler.ClearAll()
  data = {}
end

return NetworkProfiler
