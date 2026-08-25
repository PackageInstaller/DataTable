local E = require("ejoysdk_lua.ejoysdk")
local Stats = require("ejoysdk_lua.apm-sdk-lua.stats.stats")
local Global = require("ejoysdk_lua.apm-sdk-lua.global")
local EjoysdkUtils = require("ejoysdk_lua.apm-sdk-lua.common.ejoysdk_utils")
local cpu, cpu_total, memory, rss_mem, temperature, voltage, run_time
local device_info_filter = {"cpu", "memory"}
local battery_ext_filter = {
  "temperature",
  "voltage"
}

local function get_run_time()
  local sysinfo = E.Sysinfo
  if not EjoysdkUtils.is_windows_os() then
    do return math.floor end
    return math.floor, sysinfo.run_time() / 1000
  end
  sysinfo.run_time_async(function(ret)
    if ret and ret.succ then
      run_time = math.floor(ret.run_time / 1000)
    end
  end)
  return run_time
end

local function get_app_stats()
  local sysinfo = E.Sysinfo
  sysinfo.device_info(device_info_filter, function(ok, result)
    if ok and type(result) == "table" then
      if "table" == type(result.cpu) then
        cpu = result.cpu.usage_solaris_mode
        cpu_total = result.cpu.usage
      end
      if "table" ~= type(result.memory) then
        return
      end
      if result.memory.appPSS and result.memory.appPSS > 0 then
        memory = result.memory.appPSS / 1048576
      end
      if result.memory.VmRSS and result.memory.VmRSS > 0 then
        rss_mem = result.memory.VmRSS / 1048576
      end
    else
      cpu = nil
      cpu_total = nil
      memory = nil
      rss_mem = nil
    end
  end)
  sysinfo.battery_ext(battery_ext_filter, function(ret)
    if not ret then
      return
    end
    if ret.temperature and ret.temperature >= 0 then
      temperature = ret.temperature
    end
    if ret.voltage and ret.voltage >= 0 then
      voltage = ret.voltage
    end
  end)
  return {
    cpu = cpu,
    cpu_total = cpu_total,
    mem = memory,
    rss_mem = rss_mem,
    lua_mem = math.floor(collectgarbage("count") / 1024 + 0.5),
    temperature = temperature,
    voltage = voltage,
    runtime = get_run_time()
  }
end

local M = {}

function M.init()
  local app_stats = Stats.new("app_stats", Global.namespace_app_stats)
  app_stats:set_calc_func(get_app_stats)
end

return M
