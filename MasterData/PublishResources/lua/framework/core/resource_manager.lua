_class("ResourceManager", Singleton)
ResourceManager = ResourceManager
local unpack = table.unpack

function ResourceManager:Constructor()
  self.finishes = {}
  self.loader = ResourceLoader:New()
  if PUBLIC then
    self.loader:CacheAB(App.ShaderABName)
    App.CacheFont = true
  end
  self.loader:OnFinish(self.OnFinish, self)
  if App.Profiler then
    self.traces = {}
    self.profiler = true
  end
  if App.SpeedStatistics then
    Monitor:GetInstance()
  end
end

function ResourceManager:SyncLoadAsset(name, loadType)
  Log.info("[ResourceManager Lua] Loading Asset: " .. name)
  local request = self.loader:SyncLoadAsset(name, loadType)
  if self.profiler then
    if not self.traces[name] then
      self.traces[name] = {}
    end
    self.traces[name][request:GetHashCode()] = debug.traceback(nil, 2)
  end
  return request
end

function ResourceManager:SyncLoad(TT, name, loadType)
  local request = self.loader:SyncLoadAsset(name, loadType)
  if self.profiler then
    if not self.traces[name] then
      self.traces[name] = {}
    end
    self.traces[name][request:GetHashCode()] = debug.traceback(nil, 2)
  end
  return request
end

function ResourceManager:AsyncLoadAsset(TT, name, loadType)
  local id = GetCurTaskId()
  local request = self:AsyncLoad(name, loadType, function(ready)
    if not ready then
      RESUME(TT, id)
    end
  end)
  if not request then
    Log.error("AsyncLoadAsset failed:", name)
    return nil
  end
  if self.profiler then
    if not self.traces[name] then
      self.traces[name] = {}
    end
    self.traces[name][request:GetHashCode()] = debug.traceback(nil, 2)
  end
  if not request:Ready() then
    SUSPEND(TT)
  end
  return request
end

function ResourceManager:AsyncLoad(name, loadType, func, ...)
  local request = self.loader:AsyncLoadAsset(name, loadType)
  if not request then
    return nil
  end
  if request:Ready() then
    func(true, ...)
  else
    self.finishes[request] = {
      func = func,
      args = {
        ...
      }
    }
  end
  return request
end

function ResourceManager:OnFinish(request)
  local finish = self.finishes[request]
  if finish then
    finish.func(unpack(finish.args, 1, table.maxn(finish.args)))
  end
  self.finishes[request] = nil
end

function ResourceManager:GetAssetPath(name, loadType)
  return self.loader:GetAssetPath(name, loadType)
end

function ResourceManager:GetTextAsset(name)
  local path = self.loader:GetAssetPath(name, LoadType.Txt)
  if path then
    local file = io.open(path, "r")
    local text = file:read("a")
    file:close()
    return text
  end
end

function ResourceManager:SetSyncLoadNum(num)
  self.loader:SetSyncLoadNum(num)
end

function ResourceManager:HasResource(name)
  return self.loader:HasResource(name)
end

function ResourceManager:HasLua(name)
  return self.loader:HasLua(name)
end

function ResourceManager:GetTraces()
  return self.traces
end

function ResourceManager:UnloadAllABs()
  if not PUBLIC then
    return
  end
  local abs = App.GetABs()
  local length = abs.Length
  local tb = {}
  for i = 0, length - 1 do
    if abs[i] ~= "h3d_ttf.bundle" then
      self.loader:DiposeAB(abs[i])
    end
  end
  local name = App.ShaderABName
  self.loader:CacheAB(name)
end

function ResourceManager:CacheAB(abName)
  self.loader:CacheAB(abName)
end

function ResourceManager:DisposeAB(abName)
  self.loader:DiposeAB(abName)
end

function ResourceManager:Dispose()
  self.loader:Dispose()
  self.loader = nil
end

function ResourceManager:WarmUpCoreGameShader()
  self.loader:WarmUpShader()
end
