local E = require("ejoysdk_lua.ejoysdk")
local Labeler = require("ejoysdk_lua.apm-sdk-lua.label.labeler")
local Stats = require("ejoysdk_lua.apm-sdk-lua.stats.stats")
local Metrics = require("ejoysdk_lua.apm-sdk-lua.common.metrics")
local Utils = require("ejoysdk_lua.apm-sdk-lua.common.utils")
local Global = require("ejoysdk_lua.apm-sdk-lua.global")
local MathUtils = require("ejoysdk_lua.apm-sdk-lua.common.math_utils")
local CommonStats = require("ejoysdk_lua.apm-sdk-lua.stats.common_stats")
local M = {}
local engine, engine_stats
local JANK_THRESHOLD = 83.33333333333333
local BIG_JANK_THRESHOLD = 125.0
local dt_queue = {}
local dt_total = 0
local dt_avg = 0
local jank_count = Metrics.new_counter("jank_count")
local big_jank_count = Metrics.new_counter("big_jank_count")
local jank_time = Metrics.new_counter("jank_time")
local delta_time = Metrics.new_aggregate("delta_time")
local fps_variance = MathUtils.new_variance()
local LOGGER = "apm_eng_stats"
local _engine_type

local function set_engine_type(engine_type)
  if #engine_type >= 6 then
    engine_type = string.sub(engine_type, 1, 6)
  end
  _engine_type = engine_type
end

local gen_engine_data_func

local function set_gen_engine_data_func(engine_data_func)
  gen_engine_data_func = engine_data_func
end

function M.set_engine(engine_type, engine_data_func)
  if not (type(engine_type) == "string" and Utils.is_metric_name_valid(engine_type)) or nil == engine_data_func then
    return
  end
  set_engine_type(engine_type)
  set_gen_engine_data_func(engine_data_func)
end

local function is_ejoy2d_engine()
  return ej2d ~= nil and nil ~= ej2d.get_debug_info
end

local function add_prefix(data)
  if not _engine_type then
    return data
  end
  local stats = {}
  for k, v in pairs(data) do
    if "fps" == k or "draw_call" == k or "tri_count" == k then
      stats[k] = v
    else
      stats[_engine_type .. "_" .. k] = v
    end
  end
  return stats
end

local function get_original_engine_stats()
  if is_ejoy2d_engine() or Global.is_old_unity_project() then
    return engine and engine.get_engine_stats() or {}
  end
  if not gen_engine_data_func then
    return {}
  end
  local data = Utils.exec(gen_engine_data_func)
  if not data then
    return {}
  end
  do return add_prefix end
  return add_prefix, data
end

local function get_engine_stats()
  local stats = get_original_engine_stats()
  local is_login = Labeler.get_resource("is_login")
  if "1" == is_login then
    local dt = delta_time:get()
    if dt.count > 0 then
      stats.max_frame_time = dt.max
      stats.min_frame_time = dt.min
      stats.avg_fps = dt.sum > 0 and 1000.0 * dt.count / dt.sum or 0
      stats.var_fps = fps_variance:get_var()
      stats.jank_count = jank_count:get()
      stats.big_jank_count = big_jank_count:get()
      stats.stutter_percent = dt.sum > 0 and jank_time:get() * 100.0 / dt.sum or 0
    end
  end
  delta_time:clear()
  fps_variance:clear()
  jank_count:clear()
  big_jank_count:clear()
  jank_time:clear()
  return stats
end

function M.init()
  local has_engine = true
  if is_ejoy2d_engine() then
    engine = require("ejoysdk_lua.apm-sdk-lua.stats.engine_stats_ejoy2d")
    Labeler.set_static_label("engine_version", ej2d.ENGINE_VER)
    E.LOG.debug(LOGGER, "engine stats collector is initialized with ejoy2d.")
  elseif _engine_type then
    E.LOG.debug(LOGGER, "engine stats collector is initialized with " .. _engine_type .. ".")
  elseif Global.is_old_unity_project() then
    engine = require("ejoysdk_lua.apm-sdk-lua.stats.engine_stats_unity")
    E.LOG.debug(LOGGER, "engine stats collector is initialized with unity.")
  else
    has_engine = false
    E.LOG.debug(LOGGER, "engine stats collector is initialized with no engine.")
  end
  if has_engine then
    engine_stats = Stats.new("engine-stats", Global.namespace_eng_stats)
    engine_stats:set_calc_func(get_engine_stats)
  end
end

local __jank_cb

function M.set_jank_cb(jank_cb)
  if type(jank_cb) ~= "function" then
    E.LOG.error(LOGGER, "jank callback must be a function.")
    return
  end
  __jank_cb = jank_cb
end

function M.update(dt)
  if not Global.is_apus_sdk_initialized() then
    return
  end
  if type(dt) ~= "number" or dt <= 0 then
    return
  end
  M.calc_jank(dt * 1000)
  fps_variance:update(1 / dt)
end

local function record_jank_metric(dt)
  local scene = Labeler.get_current_scene()
  if not scene or "" == scene then
    E.LOG.debug(LOGGER, "current scene is empty, skip record jank metric")
    return
  end
  local labels = {scene = scene}
  CommonStats.count_common_stats("apm.jank", dt, labels)
end

function M.calc_jank(dt)
  local is_login = Labeler.get_resource("is_login")
  if "1" ~= is_login then
    return
  end
  delta_time:update(dt)
  local is_jank = false
  if #dt_queue >= 3 then
    if dt > JANK_THRESHOLD and dt > dt_avg * 2 then
      E.LOG.debug(LOGGER, string.format("jank detected, delta_time=%.2f, avg=%.2f", dt, dt_avg))
      if dt > BIG_JANK_THRESHOLD then
        big_jank_count:inc()
      end
      jank_count:inc()
      jank_time:inc(dt)
      is_jank = true
      if nil ~= __jank_cb then
        Utils.exec(__jank_cb, dt)
      end
      record_jank_metric(dt)
    end
    local last = table.remove(dt_queue, 1)
    table.insert(dt_queue, 3, dt)
    dt_total = dt_total - last + dt
    dt_avg = dt_total / 3.0
  else
    dt_queue[#dt_queue + 1] = dt
    dt_total = dt_total + dt
    dt_avg = dt_total / #dt_queue
  end
  return is_jank
end

function M.get_engine_stats()
  do return end
  return get_engine_stats, nil
end

function M.shutdown()
  if nil ~= engine_stats then
    engine_stats:destroy()
  end
end

return M
