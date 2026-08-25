local E_UTILS = require("ejoysdk_lua.ejoysdk_utils")
local JSON_UTILS = require("ejoysdk_lua.ejoysdk_json")
local EM = require("ejoysdk_lua.ejoysdk_module")
local CJSON = require("ejoysdk_lua.ejoysdk_cjson")
local TAG = EM.MODULE.EJOYSDK_BASE_MODULE .. "log"
local M = {}
local _compat_log_args = false
if _ejoysdk.os() == "android" then
  if _ejoysdk.log_compat then
    _ejoysdk.log2 = _ejoysdk.log_compat
    _compat_log_args = true
  end
elseif _ejoysdk.os() == "harmonyos" then
  local jf = lunate.js_functions
  if jf and jf.utils and jf.utils().logUtil then
    _ejoysdk.log("use log2 print log")
    
    function _ejoysdk.log2(msg, level, tag, struct_msg)
      jf.utils().logUtil:log(msg, level, tag, struct_msg)
    end
    
    _compat_log_args = true
  end
elseif _ejoysdk.os() == "weixin" or _ejoysdk.os() == "douyin" then
  _ejoysdk.log = _ejoysdk.js_log
  _ejoysdk.log2 = _ejoysdk.js_log
  _compat_log_args = true
else
  _compat_log_args = true
end
local IVK_OPEN_LOG = "OPEN_LOG"
local IVK_OPEN_LOG_WITH_CONFIG = "OPEN_LOG_WITH_CONFIG"
local CONST_LEVEL = {
  none = 0,
  error = 1,
  warn = 2,
  info = 3,
  debug = 4
}
local CONST_PASS_LEVEL = 99
local CONST_LEVEL_STR = {
  [CONST_LEVEL.none] = "none",
  [CONST_LEVEL.error] = "error",
  [CONST_LEVEL.warn] = "warn",
  [CONST_LEVEL.info] = "info",
  [CONST_LEVEL.debug] = "debug",
  [CONST_PASS_LEVEL] = "p"
}
local CONST_APUS_LEVEL_STR = {
  [CONST_LEVEL.none] = "NON",
  [CONST_LEVEL.error] = "ERR",
  [CONST_LEVEL.warn] = "WAR",
  [CONST_LEVEL.info] = "INF",
  [CONST_LEVEL.debug] = "DBG"
}
local CONST_STYLE = {DEFAULT = "default", JSON = "json"}
M.CONFIG_PRIORTY = {
  HIGH = 1,
  DEFAULT = 2,
  LOW = 3
}
local block_tag_enable = false
local block_tags = {}
local white_modules = {}
local white_modules_enable = false
M.LOG_LEVEL = CONST_LEVEL
M.LOG_STYLE = CONST_STYLE
M.LOG_MAX_LENGTH = 16384
M.CONSOLE_LOG_MAX_LENGTH = 16384
M.ENABLE_CONSOLE_LOG_LIMIT = true
local s_log_level
local is_log_open = false
local elog_config
local is_log_open_from_cl = false
local ej_debugable = false

function M.setup_ej_debugable(debugable)
  ej_debugable = debugable or false
end

local is_native = false

function M.set_native(native)
  is_native = native
end

local function _open_log_inside(_is_open, _config)
  local final_config = _config or {}
  final_config.priority = _config.priority or M.CONFIG_PRIORTY.DEFAULT
  if elog_config and elog_config.priority < final_config.priority then
    _ejoysdk.log(TAG .. "#open_log_with_config ignore: current log priority is higher:" .. tostring(elog_config.priority))
    return
  end
  is_log_open = _is_open
  elog_config = final_config
  local is_save = final_config.is_save or false
  local is_console = final_config.is_console or false
  if _config and _config.level and type(_config.level) == "string" and CONST_LEVEL[_config.level] ~= nil then
    M.set_log_level(CONST_LEVEL[_config.level])
  end
  if _config and _config.white_modules then
    white_modules = {}
    white_modules_enable = false
    if #_config.white_modules > 0 then
      M.set_white_modules(_config.white_modules)
      white_modules_enable = true
    end
  end
  local c_params = {
    is_save = is_save,
    is_console = is_console or ej_debugable
  }
  if _config.level then
    c_params.level = _config.level
  end
  local optStr = JSON_UTILS.encode(c_params)
  local E = require("ejoysdk_lua.ejoysdk")
  if _ejoysdk.os and _ejoysdk.os() == "android" then
    if _ejoysdk.log2 then
      E.invoke(IVK_OPEN_LOG, {is_open = _is_open})
    else
      E.invoke(IVK_OPEN_LOG, {is_open = is_console})
    end
    E.async_call(IVK_OPEN_LOG_WITH_CONFIG, c_params, "", nil)
  elseif _ejoysdk.os and _ejoysdk.os() == "ios" then
    E.async_call("open_log_with_config", nil, optStr)
  elseif _ejoysdk.os and _ejoysdk.os() == "windows" then
    if _ejoysdk.log2 then
      E.async_call("open_log_with_config", nil, optStr)
    else
      _ejoysdk.open_log(is_console)
    end
  elseif _ejoysdk.os and _ejoysdk.os() == "harmonyos" and _ejoysdk.log2 then
    local jf = lunate.js_functions
    jf.utils().logUtil:openLogWithConfig(c_params)
  end
  if _config then
    _ejoysdk.log(TAG .. "#open_log_with_config#is_save=" .. tostring(_config.is_save) .. ", is_console=" .. tostring(_config.is_console) .. ", level=" .. tostring(_config.level) .. ", priority=" .. tostring(final_config.priority))
  end
end

function M.open_log(is_open)
  local last_is_save = elog_config and elog_config.is_save or false
  _open_log_inside(is_open, {is_console = is_open, is_save = last_is_save})
end

function M.is_log_open()
  return is_log_open
end

function M.log_config()
  return elog_config or {}
end

function M.open_log_from_cc(_config)
  if _config then
    _config.is_from_cc = true
    is_log_open_from_cl = _config.is_save or _config.is_console or false
    _open_log_inside(_config.is_console or _config.is_save or false, _config)
    local white_modules_str = ""
    for i, v in pairs(_config.white_modules or {}) do
      if i == #_config.white_modules then
        white_modules_str = white_modules_str .. tostring(v) .. ";"
      else
        white_modules_str = white_modules_str .. tostring(v) .. ", "
      end
    end
    _ejoysdk.log(TAG .. "#white_modules=" .. tostring(white_modules_str))
    local ESTAT = require("ejoysdk_lua.ejoysdk_stat")
    local params = E_UTILS.deepcopy(_config)
    params.is_priority_high = true
    ESTAT.stat_action_with_limit(TAG, "open_log_from_cc", "open_log_from_cc", "open_log_from_cc", params)
  end
end

function M.open_log_with_config(_config)
  if _config then
    _open_log_inside(_config.is_console or _config.is_save or false, _config)
  end
end

function M.set_log_level(_level)
  s_log_level = _level
end

function M.get_log_level()
  return s_log_level or M.LOG_LEVEL.none
end

local function level_pass(level, tag)
  if white_modules_enable and tag then
    local E = require("ejoysdk_lua.ejoysdk")
    local split_module = E.Utils.split_string(tag, "##")
    if #split_module >= 1 then
      local temp_module = split_module[1]
      if white_modules[temp_module] then
        return true
      end
    end
  end
  return level <= M.get_log_level() or nil == s_log_level or level == CONST_PASS_LEVEL
end

function M.open_log_block(_enable)
  block_tag_enable = _enable
end

function M.add_block_tags(f_tags)
  for _, v in pairs(f_tags) do
    if v then
      block_tags[v] = true
    end
  end
end

function M.del_block_tags(f_tags)
  for _, v in pairs(f_tags) do
    if v then
      block_tags[v] = false
    end
  end
end

function M.get_block_tags()
  do return E_UTILS.deepcopy end
  return E_UTILS.deepcopy, block_tags
end

function M.is_block_tag()
  return block_tag_enable
end

function M.set_white_modules(f_modules)
  for _, v in pairs(f_modules) do
    if v then
      white_modules[v] = true
    end
  end
end

function M.get_white_modules()
  do return E_UTILS.deepcopy end
  return E_UTILS.deepcopy, white_modules
end

local function log_time()
  if _ejoysdk.system_ms then
    do return math.floor, _ejoysdk.system_ms() end
    return math.floor, _ejoysdk.system_ms()
  else
    return os.time() * 1000
  end
end

local _enable_sdk_struct_log = true

local function get_struct_str(msg, level, p_header_str, p_struct)
  local p_struct_str
  if _ejoysdk_lua_cjson then
    if nil == p_struct and _enable_sdk_struct_log then
      p_struct = {
        m = msg or "",
        lv = CONST_APUS_LEVEL_STR[level],
        mo = "app",
        e = "ejoysdk",
        ti = log_time(),
        ext = p_header_str
      }
    end
    if type(p_struct) == "table" then
      if nil ~= p_struct.m and #p_struct.m > M.LOG_MAX_LENGTH then
        p_struct.m = string.sub(p_struct.m, 1, M.LOG_MAX_LENGTH)
      end
      if p_struct._pt then
        local _pt_str = p_struct._pt
        p_struct._pt = nil
        p_struct_str = tostring(_pt_str) .. CJSON.safe_encode(p_struct)
      else
        p_struct_str = CJSON.safe_encode(p_struct)
      end
    end
  end
  return p_struct_str
end

local log = {}
M.LOG = log

function log.enable_sdk_struct_log(is_enable)
  _enable_sdk_struct_log = is_enable
end

local _log_compat_v

function _log_compat_v(msg, level, tag, p_header, p_struct)
  local append_p_header_str = ""
  if p_header and type(p_header) == "string" and #p_header > 0 then
    append_p_header_str = "\n" .. tostring(p_header) .. "\n"
  end
  if _ejoysdk.log2 then
    if _compat_log_args then
      if false == _enable_sdk_struct_log and nil == p_struct and false == M.log_config().is_console and false == ej_debugable then
        return
      end
      local struct_msg = get_struct_str(msg, level, append_p_header_str, p_struct)
      if M.ENABLE_CONSOLE_LOG_LIMIT and nil ~= msg and #msg > M.CONSOLE_LOG_MAX_LENGTH and false == ej_debugable then
        msg = string.sub(msg, 1, M.CONSOLE_LOG_MAX_LENGTH)
      end
      _ejoysdk.log2("[l][" .. CONST_LEVEL_STR[level] .. "]" .. tostring(tag) .. append_p_header_str .. msg, CONST_LEVEL_STR[level], tag, struct_msg or "")
    else
      _ejoysdk.log2("[" .. CONST_LEVEL_STR[level] .. "]" .. tostring(tag) .. append_p_header_str .. msg, CONST_LEVEL_STR[level], tag)
    end
  elseif M.log_config().is_console or ej_debugable then
    _ejoysdk.log("[" .. CONST_LEVEL_STR[level] .. "]" .. tostring(tag) .. append_p_header_str .. msg)
  end
end

local _log

function _log(level, tag, msg, p_header, style, p_struct)
  level = level or CONST_LEVEL.debug
  style = style or CONST_STYLE.DEFAULT
  if block_tag_enable and tag and not is_log_open_from_cl and not ej_debugable and block_tags[tag] then
    return
  end
  if tag and type(tag) ~= "string" then
    return
  end
  tag = tag and tag .. "#" or ""
  if (M.is_log_open() or is_log_open_from_cl) and level_pass(level, tag) or ej_debugable then
    if type(msg) == "table" then
      local msg_str
      if style == CONST_STYLE.JSON then
        msg_str = E_UTILS.log_util.table_tojson(msg) or ""
      else
        msg_str = E_UTILS.log_util.table_tostring(msg) or ""
      end
      _log_compat_v(msg_str, level, tag, p_header, p_struct)
    else
      _log_compat_v(tostring(msg), level, tag, p_header, p_struct)
    end
  end
end

function log.debug(tag, msg, p_header, style)
  _log(CONST_LEVEL.debug, tag, msg, p_header, style)
end

function log.info(tag, msg, p_header, style)
  _log(CONST_LEVEL.info, tag, msg, p_header, style)
end

function log.warn(tag, msg, p_header, style)
  _log(CONST_LEVEL.warn, tag, msg, p_header, style)
end

function log.error(tag, msg, p_header, style)
  if type(msg) == "string" then
    local ej_module_tips_url = EM.MODULE_USER_TIPS_URL[tag]
    if is_native then
      ej_module_tips_url = EM.MODULE_EXTERNAL_USER_TIPS_URL[tag]
    end
    if ej_module_tips_url then
      msg = msg .. ", you can try to find a solution on the documentation: " .. tostring(ej_module_tips_url)
    end
  end
  _log(CONST_LEVEL.error, tag, msg, p_header, style)
end

function log.tips(tag, msg)
  local ej_module_tips_url = EM.MODULE_USER_TIPS_URL[tag]
  if is_native then
    ej_module_tips_url = EM.MODULE_EXTERNAL_USER_TIPS_URL[tag]
  end
  if ej_module_tips_url then
    msg = msg .. ", you can try to find a solution on the documentation: " .. tostring(ej_module_tips_url)
    _log(CONST_LEVEL.debug, tag, msg)
  end
end

function log.debugt(p_struct)
  if p_struct and p_struct.m and p_struct.e then
    _log(CONST_LEVEL.debug, "", p_struct.m, nil, nil, p_struct)
  end
end

function log.infot(p_struct)
  if p_struct and p_struct.m and p_struct.e then
    _log(CONST_LEVEL.info, "", p_struct.m, nil, nil, p_struct)
  end
end

function log.warnt(p_struct)
  if p_struct and p_struct.m and p_struct.e then
    _log(CONST_LEVEL.warn, "", p_struct.m, nil, nil, p_struct)
  end
end

function log.errort(p_struct)
  if p_struct and p_struct.m and p_struct.e then
    _log(CONST_LEVEL.error, "", p_struct.m, nil, nil, p_struct)
  end
end

function log.ignore_level(p_struct)
  if p_struct and p_struct.m and p_struct.e then
    _log(CONST_PASS_LEVEL, "", p_struct.m, nil, nil, p_struct)
  end
end

function log.save_with_prefix(p_struct, pre_type)
  if p_struct and p_struct.m and p_struct.e then
    if pre_type then
      p_struct._pt = pre_type
    end
    _log(CONST_PASS_LEVEL, "", p_struct.m, nil, nil, p_struct)
  end
end

log.e = log.error
log.w = log.warn
log.i = log.info
log.d = log.debug

function M.log(params)
  M.LOG.debug(nil, params)
end

function M.set_log_max_length(log_length)
  M.CONSOLE_LOG_MAX_LENGTH = log_length
end

function M.set_log_length_limit(enable)
  M.ENABLE_CONSOLE_LOG_LIMIT = enable
end

function M.log_traceback()
  M.LOG.debug(nil, debug.traceback())
end

return M
