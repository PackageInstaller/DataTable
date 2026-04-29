_class("Monitor", Singleton)
Monitor = Monitor

function Monitor:Constructor()
  if App.SpeedStatistics then
    self.appHomeCB = GameHelper:GetInstance():CreateCallback(function()
      self:ABLoadTimes()
      self:AssetLoadTimes()
      self:GameObjectLoadTimes()
    end, self)
    GameGlobal.EventDispatcher():AddCallbackListener(GameEventType.AppHome, self.appHomeCB)
    GameGlobal.EventDispatcher():AddCallbackListener(GameEventType.ApplicationQuit, self.appHomeCB)
  end
end

function Monitor:GC()
  local c = collectgarbage("count")
  Log.error(string.format("Begin gc count = %f kb", c))
  collectgarbage("collect")
  App.ClearMemory()
  collectgarbage("collect")
  App.ClearMemory()
  collectgarbage("collect")
  App.ClearMemory()
  c = collectgarbage("count")
  Log.error(string.format("End gc count =  %f kb", c))
end

function Monitor:Profile()
  self:GC()
  local class = {}
  for inst, trace in next, monitorObjs, nil do
    local name = inst._className
    class[name] = class[name] or {num = 0}
    class[name].num = class[name].num + 1
    class[name][trace] = class[name][trace] or 0
    class[name][trace] = class[name][trace] + 1
    if name == "UIMainInterfaceHead" or name == "UISetController" or name == "UICardList" then
      Log.error(tostring(inst) .. " " .. name)
      local o = debug.findobj(_G, function(tb)
        return inst == tb
      end)
      local s2 = table.tostr(o)
      local dir = string.format("%sAssetMemoryProfileOutput/", App.StoragePath)
      local file = dir .. string.format("%s%s.txt", name, TimeToDate2(_now()))
      self:WriteToFile(dir, file, string.gsub(s2, "},", "},\n"))
    end
  end
  return class
end

function Monitor:SnapShot()
  self.beforReses = App.GetResRequests()
end

function Monitor:CompareSnapShot(memeryMsg)
  local beforReses = self.beforReses
  assert(beforReses, "need snapshot frist")
  local allTraces = ResourceManager:GetInstance():GetTraces()
  local assets = {}
  local nowReses = App.GetResRequests()
  local iter = nowReses:GetEnumerator()
  while iter:MoveNext() do
    local guid = iter.Current.Key
    local name = iter.Current.Value
    if not beforReses:ContainsKey(guid) then
      local guids = assets[name]
      if not guids then
        guids = {}
        assets[name] = guids
      end
      local traces = allTraces[name]
      if traces and traces[guid] then
        table.insert(guids, {
          guid,
          traces[guid]
        })
      else
        table.insert(guids, {
          guid,
          App.GetTrace(name, guid) or "norecord"
        })
      end
    end
  end
  if not next(assets) then
    return
  end
  local diffs = {}
  for name, guids in next, assets, nil do
    local time = App.GetAssetTime(name)
    assert(0 < time, string.format("asset[%s] can not get loadtime", name))
    table.insert(diffs, {name, time})
  end
  table.sort(diffs, function(a, b)
    return a[2] < b[2]
  end)
  local now = UnityEngine.Time.realtimeSinceStartup
  local tb = {memeryMsg}
  for i = 1, #diffs do
    local diff = diffs[i]
    local name = diff[1]
    local load = diff[2]
    table.insert(tb, string.format("assetname[%s], time[%f]", name, now - load))
    local guids = assets[name]
    for j = 1, #guids do
      local guid = guids[j]
      table.insert(tb, string.format("guid[%s] trace[%s]", guid[1], guid[2]))
    end
    table.insert(tb, "----------------------------------------------------------------------------")
  end
  local dir = string.format("%sAssetMemoryProfileOutput/", App.StoragePath)
  local file = dir .. string.format("LeakInfo%s.txt", TimeToDate2(_now()))
  self:WriteToFile(dir, file, table.concat(tb, "\n"))
  return file
end

function Monitor:WriteToFile(dir, file, content)
  App.MakeDir(dir)
  local f, error = io.open(file, "w")
  if not f then
    Log.error("can't open file " .. file .. " error " .. error)
    return
  end
  f:write(content)
  f:close()
end

function Monitor:ABLoadTimes()
  if not App.SpeedStatistics then
    Log.error("please turn on the SpeedStatistics switch in switch.lua")
    return
  end
  local times = App.GetABLoadTimes()
  local asyncTimes = App.GetABAsyncLoadTimes()
  local tb = {}
  local iter = times:GetEnumerator()
  while iter:MoveNext() do
    local name = iter.Current.Key
    local time = iter.Current.Value
    local count = time.Count
    local total = 0
    for i = 0, count - 1 do
      total = total + time[i]
    end
    local average = total / count
    table.insert(tb, {
      name,
      average,
      count
    })
  end
  table.sort(tb, function(a, b)
    return a[2] > b[2]
  end)
  local logs = {}
  for i = 1, #tb do
    local v = tb[i]
    table.insert(logs, string.format("sync time[%f ms], cnt[%d], abname[%s]", v[2], v[3], v[1]))
  end
  tb = {}
  local iter = asyncTimes:GetEnumerator()
  while iter:MoveNext() do
    local name = iter.Current.Key
    local time = iter.Current.Value
    local count = time.Count
    local total = 0
    for i = 0, count - 1 do
      total = total + time[i]
    end
    local average = total / count
    table.insert(tb, {
      name,
      average,
      count
    })
  end
  table.sort(tb, function(a, b)
    return a[2] > b[2]
  end)
  for i = 1, #tb do
    local v = tb[i]
    table.insert(logs, string.format("async time[%f ms], cnt[%d], abname[%s]", v[2], v[3], v[1]))
  end
  local dir = string.format("%sAssetMemoryProfileOutput/", App.StoragePath)
  local file = dir .. string.format("ABLoadTimes%s.txt", TimeToDate2(_now()))
  self:WriteToFile(dir, file, table.concat(logs, "\n"))
  return file
end

function Monitor:AssetLoadTimes()
  if not App.SpeedStatistics then
    Log.error("please turn on the SpeedStatistics switch in switch.lua")
    return
  end
  local times = App.GetAssetLoadTimes()
  local asyncTimes = App.GetAssetAsyncLoadTimes()
  local tb = {}
  local iter = times:GetEnumerator()
  while iter:MoveNext() do
    local name = iter.Current.Key
    local time = iter.Current.Value
    local count = time.Count
    local total = 0
    for i = 0, count - 1 do
      total = total + time[i]
    end
    local average = total / count
    table.insert(tb, {
      name,
      average,
      count
    })
  end
  table.sort(tb, function(a, b)
    return a[2] > b[2]
  end)
  local logs = {}
  for i = 1, #tb do
    local v = tb[i]
    table.insert(logs, string.format("sync time[%f ms], cnt[%d], name[%s]", v[2], v[3], v[1]))
  end
  tb = {}
  local iter = asyncTimes:GetEnumerator()
  while iter:MoveNext() do
    local name = iter.Current.Key
    local time = iter.Current.Value
    local count = time.Count
    local total = 0
    for i = 0, count - 1 do
      total = total + time[i]
    end
    local average = total / count
    table.insert(tb, {
      name,
      average,
      count
    })
  end
  table.sort(tb, function(a, b)
    return a[2] > b[2]
  end)
  for i = 1, #tb do
    local v = tb[i]
    table.insert(logs, string.format("async time[%f ms], cnt[%d], name[%s]", v[2], v[3], v[1]))
  end
  local dir = string.format("%sAssetMemoryProfileOutput/", App.StoragePath)
  local file = dir .. string.format("AssetLoadTimes%s.txt", TimeToDate2(_now()))
  self:WriteToFile(dir, file, table.concat(logs, "\n"))
  return file
end

function Monitor:GameObjectLoadTimes()
  if not App.SpeedStatistics then
    Log.error("please turn on the SpeedStatistics switch in switch.lua")
    return
  end
  local times = App.GetGameObjectLoadTimes()
  local tb = {}
  local iter = times:GetEnumerator()
  while iter:MoveNext() do
    local name = iter.Current.Key
    local time = iter.Current.Value
    local count = time.Count
    local total = 0
    for i = 0, count - 1 do
      total = total + time[i]
    end
    local average = total / count
    table.insert(tb, {
      name,
      average,
      count
    })
  end
  table.sort(tb, function(a, b)
    return a[2] > b[2]
  end)
  local logs = {}
  for i = 1, #tb do
    local v = tb[i]
    table.insert(logs, string.format("time[%f ms], cnt[%d], name[%s]", v[2], v[3], v[1]))
  end
  local dir = string.format("%sAssetMemoryProfileOutput/", App.StoragePath)
  local file = dir .. string.format("GameObjectLoadTimes%s.txt", TimeToDate2(_now()))
  self:WriteToFile(dir, file, table.concat(logs, "\n"))
  return file
end

function Monitor:NullObjectPrint()
  local msg = debug.dumpreg()
  local msg1 = string.format("当前mono内存：%s MB\n当前lua内存：%s MB\n", App.CMem / 1024, collectgarbage("count") / 1024)
  local dir = string.format("%sAssetMemoryProfileOutput/", App.StoragePath)
  local file = dir .. string.format("NullObjectPrint%s.txt", TimeToDate2(_now()))
  self:WriteToFile(dir, file, msg1 .. msg)
  return file
end

function Monitor:CNullObjectPrint()
  local msg1 = App.GetObjects()
  local msg2 = App.GetBackUpObjects()
  local msg3 = string.format("当前mono内存：%s MB\n当前lua内存：%s MB\n", App.CMem / 1024, collectgarbage("count") / 1024)
  local dir = string.format("%sAssetMemoryProfileOutput/", App.StoragePath)
  local file = dir .. string.format("C#NullObjectPrint%s.txt", TimeToDate2(_now()))
  self:WriteToFile(dir, file, msg3 .. msg1 .. msg2)
  return file
end

function Monitor:AllAbsPrint()
  local abs = App.GetABs()
  local length = abs.Length
  local tb = {}
  for i = 0, length - 1 do
    table.insert(tb, abs[i])
  end
  local dir = string.format("%sAssetMemoryProfileOutput/", App.StoragePath)
  local file = dir .. string.format("AllAbsPrint%s.txt", TimeToDate2(_now()))
  self:WriteToFile(dir, file, table.concat(tb, "\n"))
  return file
end

function Monitor:AbLeaksPrint()
  local abs = App.GetABs()
  local length = abs.Length
  local tb = {}
  for i = 0, length - 1 do
    tb[abs[i]] = 1
  end
  local leaks = {}
  local unityAbs = App.GetUnityAbs()
  length = unityAbs.Length
  for i = 0, length - 1 do
    local ab = unityAbs[i]
    if not tb[ab] then
      table.insert(leaks, ab)
    end
  end
  if not next(leaks) then
    return
  end
  local dir = string.format("%sAssetMemoryProfileOutput/", App.StoragePath)
  local file = dir .. string.format("AbLeaksPrint%s.txt", TimeToDate2(_now()))
  self:WriteToFile(dir, file, table.concat(leaks, "\n"))
  return file
end

function Monitor:DisposeAll()
  App.DisposeAll()
end

function Monitor:LuaSnapShot()
  self:GC()
  self:GC()
  self.beforFuncs = debug.regfunc()
end

function Monitor:CompareLuaSnapShot(memeryMsg)
  local beforFuncs = self.beforFuncs
  assert(beforFuncs, "need snapshot frist")
  self:GC()
  self:GC()
  self:GC()
  local diffs = {}
  local nowFuncs = debug.regfunc()
  for k, v in pairs(nowFuncs) do
    if beforFuncs[k] == nil then
      diffs[k] = v
    elseif v > beforFuncs[k] then
      diffs[k] = v - beforFuncs[k]
    end
  end
  if not next(diffs) then
    return
  end
  local now = UnityEngine.Time.realtimeSinceStartup
  local tb = {memeryMsg}
  for k, v in pairs(diffs) do
    table.insert(tb, string.format("[%s] = [%d]", k, v))
  end
  local dir = string.format("%sAssetMemoryProfileOutput/", App.StoragePath)
  local file = dir .. string.format("LuaLeakInfo%s.txt", TimeToDate2(_now()))
  self:WriteToFile(dir, file, table.concat(tb, "\n"))
  return file
end

function Monitor:Dispose()
  if App.SpeedStatistics then
    self:ABLoadTimes()
    self:AssetLoadTimes()
    self:GameObjectLoadTimes()
  end
end
