require("custom_profiler")
_class("AutoProfiler", Object)
AutoProfiler = AutoProfiler
local func_cache = {__mode = "k"}
local custom_profiler = {}

function AutoProfiler:Constructor()
  self.mCustomProfiler = CustomProfiler:New()
  self._cache_init = false
  custom_profiler = self.mCustomProfiler
  if not tolua then
    tolua = {}
  end
end

function AutoProfiler:Init()
  self.mCustomProfiler:Init()
end

function AutoProfiler:ClearFrameData()
  self.mCustomProfiler:ClearFrameData()
end

function auto_profiler_hook(event, line)
  if event == "call" then
    local func = debug.getinfo(2, "f").func
    local info = func_cache[func]
    if info ~= nil then
      custom_profiler:BeginSample(info.name)
    end
  elseif event == "return" then
    local func = debug.getinfo(2, "f").func
    local info = func_cache[func]
    if info ~= nil then
      custom_profiler:EndSample()
    end
  end
end

function AutoProfiler:Start()
  if self._cache_init == false then
    self.mark = {}
    self:scan(_G, nil)
    self:scanlibs()
    self.mark = nil
    self._cache_init = true
  end
  debug.sethook(auto_profiler_hook, "cr", 0)
  self.mCustomProfiler:Start()
  Log.prof("AutoProfiler:Start")
end

function AutoProfiler:Print()
  self.mCustomProfiler:Print()
end

function AutoProfiler:PrintNodeData(treeData, frameindex)
  self.mCustomProfiler:PrintNodeData(treeData, frameindex)
end

function AutoProfiler:PrintInfo(info, frameindex)
  self.mCustomProfiler:PrintInfo(info, frameindex)
end

function AutoProfiler:StoreSamepleData()
  self.mCustomProfiler:StoreSamepleData()
end

function AutoProfiler:Stop()
  debug.sethook(nil)
  self.mCustomProfiler:Stop()
  Log.prof("CustomProfiler:Stop")
end

function AutoProfiler:BeginSample(samplename)
end

function AutoProfiler:EndSample()
end

local ffnames = {
  event = {
    [20] = "_xpcall.__call",
    [142] = "event.__call"
  },
  slot = {
    [11] = "slot.__call"
  },
  MainScene = {
    [250] = "MainScene.Update"
  }
}
local blacklist = {
  ipairs_aux = 1,
  ["_xpcall.__call"] = 1,
  unknow = 1
}

function AutoProfiler:scan(t, name)
  if self.mark[t] then
    return
  end
  self.mark[t] = true
  for k, v in pairs(t) do
    if type(k) == "string" then
      if type(v) == "function" then
        local str = k
        if name then
          str = name .. "." .. str
        end
        if not blacklist[str] and k ~= "__index" and k ~= "__newindex" then
          func_cache[v] = {name = str, id = -1}
        end
      elseif type(v) == "table" and not self.mark[v] then
        self:scan(v, k)
      end
    elseif name and k == tolua.gettag or k == tolua.settag then
      self:scan(v, name)
    end
  end
end

function AutoProfiler:scanlibs()
  local t = package.loaded
  self.mark[t] = true
  for k, v in pairs(t) do
    if type(k) == "string" and type(v) == "table" then
      self:scan(v, k)
      local mt = getmetatable(v)
      if mt then
        self:scan(mt, k)
      end
    end
  end
end
