local Profile = CS.UnityEngine.Profiling.Profiler
local luaBoomer = require("Managers.LuaboomerManager.Core")
local FAIL_LIMIT_NUM = 10
local failTime = 0
local LuaboomerMgr, Super = System.NewClass("LuaboomerMgr", Manager, IUpdater)

local function canOpen(...)
  return true
end

local function OnChangeProfileConfig()
end

local function GetPerformanceData()
  local p_data = CS.Performance.Sample.GetStats()
  local data_list = {}
  local perfor_data = {}
  local r_data = {}
  local time = os.date("%Y-%m-%d %H:%M:%S")
  local data = {}
  perfor_data.fps = p_data.fps
  perfor_data.dp = p_data.drawcall
  perfor_data.v_count = p_data.tris
  perfor_data.d_count = p_data.verts
  perfor_data.setpass = p_data.setPassCalls
  perfor_data.batches = p_data.batches
  local total_mem = p_data.usedMems
  local lua_mem = collectgarbage("count") / 1024
  perfor_data.lua_mem = lua_mem
  perfor_data.total_mem = total_mem
  perfor_data.cpu_time = p_data.timeCPU
  perfor_data.render_thread_time = p_data.timeRenderThread
  local unity_mem = Profile.GetTotalAllocatedMemoryLong() * 1.0 / 1024 / 1024
  local gfx_mem = Profile.GetAllocatedMemoryForGraphicsDriver() * 1.0 / 1024 / 1024
  local mono_mem = Profile.GetMonoHeapSizeLong() * 1.0 / 1024 / 1024
  perfor_data.unity_mem = unity_mem
  perfor_data.gfx_mem = gfx_mem
  perfor_data.mono_mem = mono_mem
  data.uid = 3
  data.capturedAt = time
  data.location = {
    0,
    0,
    0,
    0,
    0,
    0
  }
  data.performanceData = perfor_data
  table.insert(data_list, data)
  r_data.data = data_list
  for k, v in pairs(perfor_data) do
    print(k, v)
  end
  return r_data
end

local function luaBoomerInit(gm_cb)
  if not canOpen() then
    return
  end
  local boomer_conf = {
    LogViewModule = {
      switch = true,
      approach = "overwrite",
      project = "Z1"
    },
    ProtoTestModule = {switch = true, project = "Z1"},
    ProfileModule = {
      switch = false,
      duration = 1,
      engineProfileFunc = GetPerformanceData,
      profileConf = {},
      onChangeConfig = OnChangeProfileConfig
    }
  }
  luaBoomer.init("11.158.142.45:20019", boomer_conf, true, "LuaBoomer.NetworkModule.SocketXlua", "z1")
  local logger_level = 2
  luaBoomer.setLoggerLevel(logger_level)
  luaBoomer.setInitSuccess()
  return true
end

local function luaBoomerSetRoleAndServer(...)
  if DataCenter.loginData ~= nil and nil ~= DataCenter.playerData and nil ~= DataCenter.playerData.DRole then
    luaBoomer.setDeviceInfo({
      debug_account = DataCenter.playerData.DRole.name,
      server_name = DataCenter.loginData.serverName
    })
  end
  return
end

local function luaBoomerUpdate(...)
  if not canOpen() then
    return
  end
  luaBoomer.update(...)
end

function LuaboomerMgr:init(...)
  local success, result = xpcall(luaBoomerInit, function(error)
    print("LUA BOOMER ERROR: " .. tostring(error))
    print(debug.traceback())
  end, ...)
  if not success then
    self:InitOrUpdateFail()
    print("lua boomer init failed ", error)
    error("LUA BOOMER ERROR")
  end
  return result
end

function LuaboomerMgr:update(...)
  local success, result = xpcall(luaBoomerUpdate, function(error)
    print("LUA BOOMER ERROR: " .. tostring(error))
    print(debug.traceback())
  end, ...)
  if not success then
    self:InitOrUpdateFail()
    print("lua boomer update failed ", error)
    error("LUA BOOMER ERROR")
  end
  pcall(luaBoomerSetRoleAndServer)
end

function LuaboomerMgr:ctor()
  Super.ctor(self)
end

function LuaboomerMgr:Awake(...)
  Super.Awake(self)
  if not self:IsFailedOverLimit() then
    LuaboomerMgr:init(...)
  end
end

function LuaboomerMgr:Update()
  if not self:IsFailedOverLimit() then
    local deltaTime = CS.UnityEngine.Time.deltaTime
    LuaboomerMgr:update(deltaTime)
  end
end

function LuaboomerMgr:IsFailedOverLimit()
  return failTime > FAIL_LIMIT_NUM
end

function LuaboomerMgr:InitOrUpdateFail()
  failTime = failTime + 1
end

return LuaboomerMgr
