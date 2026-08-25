local E = require("ejoysdk_lua.ejoysdk")
local Event = require("ejoysdk_lua.apm-sdk-lua.event.event")
local Labeler = require("ejoysdk_lua.apm-sdk-lua.label.labeler")
local Reporter = require("ejoysdk_lua.apm-sdk-lua.reporter.reporter")
local Utils = require("ejoysdk_lua.apm-sdk-lua.common.utils")
local JSONUtils = require("ejoysdk_lua.apm-sdk-lua.common.json_utils")
local ErrUtils = require("ejoysdk_lua.apm-sdk-lua.common.err_utils")
local ApiStats = require("ejoysdk_lua.apm-sdk-lua.stats.api_stats")
local RpcStats = require("ejoysdk_lua.apm-sdk-lua.stats.rpc_stats")
local UiStats = require("ejoysdk_lua.apm-sdk-lua.stats.ui_stats")
local CommonStats = require("ejoysdk_lua.apm-sdk-lua.stats.common_stats")
local Stats = require("ejoysdk_lua.apm-sdk-lua.stats.stats")
local EngineStats = require("ejoysdk_lua.apm-sdk-lua.stats.engine_stats")
local TraceCollector = require("ejoysdk_lua.apm-sdk-lua.trace.collector")
local APM = require("ejoysdk_lua.apm-sdk-lua.apm")
local AbnormalMetricsCb = require("ejoysdk_lua.apm-sdk-lua.stats.abnormal_metrics_callback")
local MemProfiling = require("ejoysdk_lua.apm-sdk-lua.profiling.mem_profiling")
local Flamegraph = require("ejoysdk_lua.apm-sdk-lua.profiling.flamegraph")
local File = require("ejoysdk_lua.apm-sdk-lua.file.file2oss")
local FileUploadMgr = require("ejoysdk_lua.apm-sdk-lua.file.file_upload_mgr")
local M = {
  set_namespace = Labeler.set_namespace,
  set_quality_level = Labeler.set_quality_level,
  set_device_level = Labeler.set_device_level,
  set_game_version = Labeler.set_game_version,
  set_login_func = Labeler.set_login_func,
  set_account_info = Labeler.set_account_info,
  set_player_info = Labeler.set_player_info,
  set_logout_func = Labeler.set_logout_func,
  set_static_label = Labeler.set_static_label,
  add_dynamic_label = Labeler.add_dynamic_label,
  del_dynamic_label = Labeler.del_dynamic_label,
  set_scene_func = Labeler.set_scene_func,
  set_position_func = Labeler.set_position_func,
  count_platform_api_call = ApiStats.count_platform_api_call,
  count_game_rpc_call = RpcStats.count_game_rpc_call,
  count_ui_render = UiStats.count_ui_render,
  count_common_stats = CommonStats.count_common_stats,
  new_custom_stats = Stats.new,
  engine_stats_update_delta_time = EngineStats.update,
  set_jank_cb = EngineStats.set_jank_cb,
  set_engine = EngineStats.set_engine,
  trace_collect = TraceCollector.collect,
  event_post = Event.post,
  new_event_poster = Event.new_poster,
  register_module = APM.register_module,
  set_cjson_lib_path = JSONUtils.set_cjson_lib_path,
  register_abnormal_metrics_cb = AbnormalMetricsCb.register_abnormal_metrics_cb,
  collect_mem_profiling = MemProfiling.collect_mem_profiling,
  register_flamegraph_fns = Flamegraph.register_flamegraph_fns,
  upload_file_to_oss = File.upload_file_to_oss,
  new_file_uploader = FileUploadMgr.new_file_uploader,
  trigger_report = Reporter.trigger_report
}
M.__index = M
local LOGGER = "apm_interface"

local function event_common_check(cost_ms, msg, custom_labels, custom_stats)
  if type(cost_ms) ~= "number" or cost_ms < 0 then
    E.LOG.warn(LOGGER, "illegal cost_ms:" .. tostring(cost_ms))
    return false
  end
  if msg and type(msg) ~= "string" then
    E.LOG.warn(LOGGER, "illegal msg.type:" .. type(msg))
    return false
  end
  if custom_labels and type(custom_labels) ~= "table" then
    E.LOG.warn(LOGGER, "illegal custom_labels.type:" .. type(custom_labels))
    return false
  end
  if custom_stats and type(custom_stats) ~= "table" then
    E.LOG.warn(LOGGER, "illegal custom_stats.type:" .. type(custom_stats))
    return false
  end
  return true
end

function M.record_login_event(typ, ret, cost_ms, msg, custom_labels, custom_stats)
  if nil == typ or type(typ) == "table" or "" == typ then
    E.LOG.warn(LOGGER, "illegal typ:" .. tostring(typ))
    return
  end
  if nil == ret or type(ret) == "table" or "" == ret then
    E.LOG.warn(LOGGER, "illegal ret:" .. tostring(ret))
    return
  end
  if not event_common_check(cost_ms, msg, custom_labels, custom_stats) then
    return
  end
  local labels = {type = typ, ret = ret}
  labels = Utils.merge_table(labels, custom_labels, true)
  local stats = {cost_ms = cost_ms}
  stats = Utils.merge_table(stats, custom_stats, true)
  Event.post("game_login", labels, nil, msg, stats)
end

local function is_from_scene_invalid(from_scene)
  return type(from_scene) == "table" or "" == from_scene
end

local function is_to_scene_invalid(to_scene)
  return to_scene and (type(to_scene) == "table" or "" == to_scene)
end

function M.record_loading_scene_event(from_scene, to_scene, cost_ms, msg, custom_labels, custom_stats)
  if is_from_scene_invalid(from_scene) then
    E.LOG.warn(LOGGER, "illegal from_scene:" .. tostring(from_scene))
    return
  end
  if is_to_scene_invalid(to_scene) then
    E.LOG.warn(LOGGER, "illegal to_scene:" .. tostring(to_scene))
    return
  end
  if not event_common_check(cost_ms, msg, custom_labels, custom_stats) then
    return
  end
  local labels = {from_scene = from_scene}
  if to_scene then
    labels.to_scene = to_scene
  end
  labels = Utils.merge_table(labels, custom_labels, true)
  local stats = {cost_ms = cost_ms}
  stats = Utils.merge_table(stats, custom_stats, true)
  Event.post("loading_scene", labels, nil, msg, stats)
end

function M.add(x, y)
  return x + y
end

local mt = {}
local pack_fn = table.pack or function(...)
  return {
    ...
  }
end
local unpack_fn = table.unpack or unpack
local is_lua51 = _VERSION == "Lua 5.1"

local function wrap_xpcall(t, k)
  local v = M[k]
  if type(v) ~= "function" then
    return v
  end
  local f = v
  
  function v(...)
    local ok, result = xpcall(f, ErrUtils.handle_err, ...)
    if ok then
      return result
    end
    return
  end
  
  t[k] = v
  return v
end

local function wrap_xpcall_for_lua51(t, k)
  local v = M[k]
  if type(v) ~= "function" then
    return v
  end
  local f = v
  
  function v(...)
    local args = pack_fn(...)
    
    local function fn()
      do return f, unpack_fn(args) end
      return f, unpack_fn(args)
    end
    
    local ok, result = xpcall(fn, ErrUtils.handle_err)
    if ok then
      return result
    end
    return
  end
  
  t[k] = v
  return v
end

if is_lua51 then
  mt.__index = wrap_xpcall_for_lua51
else
  mt.__index = wrap_xpcall
end
do return setmetatable, {} end
return setmetatable, {}, mt
