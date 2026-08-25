local Logger = require("ejoysdk_lua.apm-sdk-lua.log.logger")
local Vconfig = require("ejoysdk_lua.apm-sdk-lua.log.vconfig")
local Cfg = require("ejoysdk_lua.apm-sdk-lua.config.configurator")
local ErrUtils = require("ejoysdk_lua.apm-sdk-lua.common.err_utils")
local Global = require("ejoysdk_lua.apm-sdk-lua.global")
local logger = Logger.new()
local mt_v = {}

function mt_v:__call(verbose)
  return verbose <= logger.verbose
end

function mt_v:__index(verbose)
  error(verbose)
end

local V = setmetatable({}, mt_v)
local pack_fn = table.pack or function(...)
  local ret = {
    ...
  }
  ret.n = select("#", ...)
  return ret
end
local unpack_fn = table.unpack or unpack

local function index_log(t, k)
  local v = logger[k]
  if type(v) == "function" then
    local f = v
    
    function v(...)
      local args = pack_fn(...)
      
      local function action()
        do return f, logger, unpack_fn(args, 1, args.n) end
        return f, logger, unpack_fn(args, 1, args.n)
      end
      
      local ok, result = xpcall(action, ErrUtils.handle_err)
      if ok then
        return result
      end
      return
    end
    
    t[k] = v
  end
  return v
end

local Log = setmetatable({V = V}, {__index = index_log})

local function empty_function()
end

local vlt, eft = {}, {}
for fname in pairs(Vconfig.available_fnames) do
  vlt[fname] = Log[fname]
  eft[fname] = empty_function
end

local function reset_verbose()
  for i = 1, Vconfig.max_level do
    if i <= logger.verbose then
      V[i] = vlt
    else
      V[i] = eft
    end
  end
end

reset_verbose()

function Log.config(...)
  local res = logger:config(...)
  reset_verbose()
  return res
end

function Log.set_bucket(bucket)
  do return logger.set_bucket end
  return logger.set_bucket, bucket
end

function Log.get_bucket()
  do return end
  return logger.get_bucket, nil
end

function Log.set_module(module_name)
  do return logger.set_module, logger end
  return logger.set_module, logger, module_name
end

function Log.set_log_level(log_level)
  do return logger.set_log_level, logger end
  return logger.set_log_level, logger, log_level
end

function Log.disable_dedup()
  do return logger.disable_dedup end
  return logger.disable_dedup, logger
end

function Log.set_deduper(deduper)
  do return logger.set_deduper, logger end
  return logger.set_deduper, logger, deduper
end

local function handle_config_update(key, value)
  if "level" == key and (value == Logger.DEBUG or value == Logger.INFO or value == Logger.WARNING or value == Logger.ERROR or value == Logger.CRITICAL) then
    logger:set_log_level(value)
  end
  if "disable_debug_stack" == key and type(value) == "boolean" then
    Global.set_disable_debug_stack(value)
  end
end

function Log.init()
  Cfg.set_update_callback(Cfg.CATEGORY_LOG, handle_config_update)
end

return Log
