local byte = string.byte
local char = string.char
local compat = require("ejoysdk_lua.compat.ejoysdk_compat")
local bitutil, xpcall = compat.bitutil, compat.xpcall
local EM = require("ejoysdk_lua.ejoysdk_module")
local CONSTANTS = require("ejoysdk_lua.ejoysdk_constants")
local TAG = EM.MODULE.EJOYSDK_BASE_MODULE .. "utils"
local M = {}
M.INNER_LOG_LEVEL = {
  INFO = 0,
  DEBUG = 1,
  WARN = 2,
  ERROR = 3
}
local XORCipher = {}
XORCipher.__index = XORCipher

function XORCipher.new(key)
  do return setmetatable, {key = key, now = 0} end
  return setmetatable, {key = key, now = 0}, XORCipher
end

function XORCipher:encrypt(data)
  local key = self.key
  local key_len = #key
  local now = self.now
  local ret = {}
  for i = 1, #data do
    now = now + 1
    ret[i] = char(bitutil.bxor(byte(data, i), byte(key, now)))
    now = now % key_len
  end
  self.now = now
  do return table.concat end
  return table.concat, ret, 1, nil, char(bitutil.bxor(byte(data, i), byte(key, now))), bitutil.bxor(byte(data, i), byte(key, now))
end

XORCipher.decrypt = XORCipher.encrypt
M.XORCipher = XORCipher

local function deepcopy(orig, seen)
  local orig_type = type(orig)
  seen = seen or {}
  local copy
  if "table" == orig_type then
    if seen[orig] then
      copy = seen[orig]
    else
      copy = {}
      seen[orig] = copy
      for orig_key, orig_value in next, orig, nil, nil do
        copy[deepcopy(orig_key, seen)] = deepcopy(orig_value, seen)
      end
    end
  else
    copy = orig
  end
  return copy
end

M.deepcopy = deepcopy

local function deep_copy_with_metatable(original, seen)
  seen = seen or {}
  if seen[original] then
    return seen[original]
  end
  local copy = {}
  seen[original] = copy
  local meta = getmetatable(original)
  if meta and type(meta) ~= "table" then
    setmetatable(copy, nil)
  end
  for key, value in pairs(original) do
    if type(value) == "table" then
      copy[key] = deep_copy_with_metatable(value, seen)
    else
      copy[key] = value
    end
  end
  return copy
end

M.deep_copy_with_metatable = deep_copy_with_metatable
local deepcopy_once_record_mt = {__mode = "kv"}
local deepcopy_once_record = {}
setmetatable(deepcopy_once_record, deepcopy_once_record_mt)

local function deepcopy_only_once(orig)
  local orig_type = type(orig)
  local copy
  if "table" == orig_type then
    local copyed = deepcopy_once_record[orig]
    if type(copyed) == "table" then
      copy = copyed
    else
      copy = {}
      deepcopy_once_record[orig] = copy
      for orig_key, orig_value in next, orig, nil, nil do
        copy[deepcopy_only_once(orig_key)] = deepcopy_only_once(orig_value)
      end
    end
  else
    copy = orig
  end
  return copy
end

M.deepcopy_only_once = deepcopy_only_once

local function reset_deepcopy_only_once_record()
  deepcopy_once_record = {}
end

M.reset_deepcopy_only_once_record = reset_deepcopy_only_once_record

local function tablelength(T)
  local count = 0
  for _ in pairs(T) do
    count = count + 1
  end
  return count
end

M.tablelength = tablelength

function M.safe_call_cb(cb, ...)
  if cb then
    cb(...)
  end
end

function M.safe_get_array_item(tbl, idx)
  if not tbl or next(tbl) == nil then
    return nil
  end
  if idx < 1 or idx > #tbl then
    return nil
  end
  return tbl[idx]
end

local unpack = unpack or table.unpack
local machine = {}
machine.__index = machine
local ASYNC = "async"
local SYNC = "sync"

local function call_handler(handler, ...)
  if handler then
    do return handler, ... end
    return handler, ...
  end
end

local machine_log_enable = true

function M.set_global_log_enable(is_enable)
  machine_log_enable = is_enable
end

function machine:log(log_msg)
  if not machine_log_enable then
    return
  end
  _ejoysdk.log(log_msg)
end

function machine:transition(from, to, ...)
  if not self.states[from] then
    return
  end
  if from == self.current and from ~= to then
    call_handler(self["onleave" .. from], self, to, ...)
    self.current = to
    call_handler(self["onenter" .. to], self, from, ...)
    call_handler(self.onstatechange, self, from, to, ...)
    local undo_events = self.undo_events[self.current]
    if not undo_events then
      return
    end
    self.undo_events[self.current] = {}
    for _, undo_event in ipairs(undo_events) do
      _ejoysdk.log("do undo event: " .. (undo_event.name or ""))
      self[undo_event.name](self, unpack(undo_event.params))
    end
  end
end

function machine:on_event_finish(event)
  if not event or event == self.current_event then
    self:log("on_event_finish：" .. tostring(event))
    self.current_event = nil
  end
  if self.msg_queue and nil ~= next(self.msg_queue) then
    local event_obj, can_consume_event
    repeat
      event_obj = table.remove(self.msg_queue, 1)
      if event_obj then
        can_consume_event = self:can(event_obj.name)
        if can_consume_event then
          self:log("on_event_finish process event:" .. tostring(event_obj.name))
          self[event_obj.name](self, unpack(event_obj.params))
        else
          _ejoysdk.log("on_event_finish cannot process event, remove it:" .. tostring(event_obj and event_obj.name))
        end
      else
        can_consume_event = true
      end
    until can_consume_event
  end
end

function machine:notify_async_finish(event)
  self:on_event_finish(event)
end

function machine:on_event_begin(event_name)
  self:log("on_event_begin: " .. tostring(event_name))
  self.current_event = event_name
end

local function create_event_handler(event_name)
  local can, to, from
  
  local function handle_event(self, ...)
    can = self:can(event_name)
    if not can then
      return
    end
    from = self.current
    self:on_event_begin(event_name)
    local result = {
      call_handler(self["on" .. event_name], self, from, ...)
    }
    if not result[1] then
      return
    end
    if result[1] == ASYNC then
      return
    end
    if result[1] == SYNC then
      to = result[2]
      if to then
        table.remove(result, 1)
        table.remove(result, 1)
        self:transition(from, to, unpack(result))
      end
      self:on_event_finish(event_name)
    end
  end
  
  return handle_event
end

function machine.create(options)
  assert(options.events)
  local fsm = {}
  setmetatable(fsm, machine)
  fsm.initial = options.initial
  fsm.current = options.initial or "none"
  fsm.undo_events = {}
  fsm.states = {}
  fsm.events = {}
  for _, event in ipairs(options.events or {}) do
    local name = event.name
    local from = event.from
    fsm[name] = fsm[name] or create_event_handler(name)
    fsm.events[name] = from
    fsm.states[from] = fsm.states[from] or {}
    fsm.states[from][name] = true
  end
  for name, callback in pairs(options.callbacks or {}) do
    fsm[name] = callback
  end
  return fsm
end

function machine:is(state)
  return self.current == state
end

function machine:can(event_name)
  local state = self.states[self.current]
  if not state then
    _ejoysdk.log("can event check false, current:" .. tostring(self.current) .. ", event:" .. tostring(event_name))
    return false
  else
    return nil ~= state[event_name]
  end
end

function machine:cannot(e)
  return not self:can(e)
end

function machine:add_event(event, ...)
  if self:can(event) then
    self[event](self, ...)
  else
    _ejoysdk.log(TAG .. "not support event: " .. tostring(event) .. " ,in current state: " .. tostring(self.current))
  end
end

function machine:enqueue_event(event, at_front, ...)
  self:log("enqueue_event, current_event:" .. tostring(self.current_event) .. ", enqueue event:" .. tostring(event))
  self.msg_queue = self.msg_queue or {}
  local event_obj = {
    name = event,
    params = {
      ...
    }
  }
  if at_front then
    self:log("enqueue_event at queue front:" .. tostring(event))
    table.insert(self.msg_queue, 1, event_obj)
  else
    self:log("enqueue_event at queue tail:" .. tostring(event))
    table.insert(self.msg_queue, event_obj)
  end
  if not self.current_event then
    self:log("enqueue_event no current event, try pick event from queue head")
    self:on_event_finish()
  else
    self:log("enqueue_event has current event, wait for current event finish:" .. tostring(self.current_event))
  end
end

function machine:reset()
  self.current = self.initial
  self.current_event = nil
  self.undo_events = {}
end

function M.appstore_score()
  if _ejoysdk.os() == "ios" then
    local EJOY_IOS = require("ejoysdk_lua.ejoysdk_ios")
    EJOY_IOS.async_call("appstore_score")
  else
    _ejoysdk.log(TAG .. "appstore_score function only for ios operating system")
  end
end

function M.appstore_write_comment(appId)
  if nil == appId or 0 == #appId then
    _ejoysdk.log(TAG .. "appId can not be null or empty")
    return
  end
  if _ejoysdk.os() == "ios" then
    local EJOY_IOS = require("ejoysdk_lua.ejoysdk_ios")
    EJOY_IOS.async_call("appstore_write_comment", nil, appId)
  else
    _ejoysdk.log(TAG .. "appstore_write_comment function only for ios operating system")
  end
end

function M.set_file_to_pasteboard(filePath, pasteType)
  if nil == filePath or 0 == #filePath then
    _ejoysdk.log(TAG .. "filePath can not be null or empty")
    return
  end
  if _ejoysdk.os() == "ios" then
    local EJOY_IOS = require("ejoysdk_lua.ejoysdk_ios")
    local pasteName = EJOY_IOS.sync_call("unisdk_set_file_to_pasteboard", filePath, pasteType)
    return pasteName
  else
    _ejoysdk.log(TAG .. "unisdk_set_file_to_pasteboard function only for ios operating system")
  end
end

machine.ASYNC = ASYNC
machine.SYNC = SYNC
M.fsm = machine
local lang_util = {}
lang_util.lang_area_to_script = {
  zh = {
    _ = "hans",
    cn = "hans",
    hk = "hant",
    tw = "hant"
  }
}

function lang_util.get_script()
  local E = require("ejoysdk_lua.ejoysdk")
  local area = E.Sysinfo.country()
  local lang = E.Sysinfo.language()
  if not area or not lang then
    return ""
  end
  local area_to_script = lang_util.lang_area_to_script[lang]
  if area_to_script then
    local script = area_to_script[area:lower()] or area_to_script._ or ""
    return script
  else
    return ""
  end
end

M.lang_util = lang_util
local log_util = {}

function log_util.table_tostring(table, key_to_val_symbol, log_table_name)
  local _indent = "   "
  key_to_val_symbol = key_to_val_symbol or " => "
  if nil == log_table_name then
    log_table_name = true
  end
  
  local function output(t, indent)
    local result_value
    if type(t) == "table" then
      result_value = (log_table_name and tostring(t) or "") .. "{\n"
      for key, val in pairs(t) do
        local next_indent = indent .. _indent
        result_value = result_value .. indent .. "[" .. output(key, next_indent) .. "]" .. key_to_val_symbol .. output(val, next_indent) .. "\n"
      end
      result_value = result_value .. indent:sub(#_indent + 1) .. "}"
    elseif type(t) == "string" then
      result_value = "\"" .. t .. "\""
    else
      result_value = tostring(t)
    end
    return result_value
  end
  
  do return output, table end
  return output, table, _indent
end

function log_util.table_tojson(table)
  local _indent = "   "
  local key_to_val_symbol = ":"
  local log_table_name = false
  
  local function output(t, indent)
    local result_value
    if type(t) == "table" then
      local is_array = M.is_array_table(t)
      local left_bracket_symbol = "{"
      local right_bracket_symbol = "}"
      if is_array then
        left_bracket_symbol = "["
        right_bracket_symbol = "]"
      end
      result_value = (log_table_name and tostring(t) or "") .. left_bracket_symbol .. "\n"
      for key, val in pairs(t) do
        local next_indent = indent .. _indent
        if not is_array then
          result_value = result_value .. indent .. output(key, next_indent) .. key_to_val_symbol .. output(val, next_indent) .. "\n"
        else
          result_value = result_value .. indent .. output(val, next_indent) .. "\n"
        end
      end
      result_value = result_value .. indent:sub(#_indent + 1) .. right_bracket_symbol
    elseif type(t) == "string" then
      result_value = "\"" .. t .. "\""
    else
      result_value = "\"" .. tostring(t) .. "\""
    end
    return result_value
  end
  
  do return output, table end
  return output, table, _indent
end

M.log_util = log_util

function M.get_user_ip_info(cb)
  require("ejoysdk_lua.user_center.usercenter_api").get_user_ip_info(cb)
end

local function is_array_table(t)
  if type(t) ~= "table" then
    return false
  end
  local n = #t
  for i, _ in pairs(t) do
    if type(i) ~= "number" then
      return false
    end
    if i > n or i < 1 or i > math.floor(i) then
      return false
    end
  end
  return true
end

M.is_array_table = is_array_table

function M.version_compare(v1, v2)
  v1 = v1 or ""
  v2 = v2 or ""
  local v1_length = #v1
  local v2_length = #v2
  if "" == v1 or "" == v2 then
    if v1_length < v2_length then
      return -1
    elseif v1_length > v2_length then
      return 1
    else
      return 0
    end
  end
  local asc_dot = string.byte(".")
  local asc_nine = string.byte("9")
  local asc_zero = string.byte("0")
  
  local function calc(params)
    local c1 = asc_zero
    local x = 0
    while params.index <= params.length and c1 ~= asc_dot do
      c1 = string.byte(params.str, params.index)
      if c1 >= asc_zero and c1 <= asc_nine then
        x = x * 10 + c1 - asc_zero
      end
      params.index = params.index + 1
    end
    return x
  end
  
  local v1_params = {
    str = v1,
    index = 1,
    length = v1_length
  }
  local v2_params = {
    str = v2,
    index = 1,
    length = v2_length
  }
  while v1_length >= v1_params.index or v2_length >= v2_params.index do
    local x = calc(v1_params)
    local y = calc(v2_params)
    if x < y then
      return -1
    elseif x > y then
      return 1
    end
  end
  return 0
end

function M.verify_utf_char(raw_string)
  if type(raw_string) ~= "string" then
    return raw_string
  end
  local len = string.len(raw_string)
  if nil == raw_string or 0 == len then
    return raw_string
  end
  local new_string = {}
  local index_of_raw_string = 1
  while len >= index_of_raw_string do
    local count_1_of_byte = M.get_continuous_1_count_of_byte(string.byte(raw_string, index_of_raw_string))
    if count_1_of_byte < 0 then
      return raw_string
    end
    if count_1_of_byte <= 3 then
      local sub_char = string.sub(raw_string, index_of_raw_string, index_of_raw_string + count_1_of_byte - 1)
      local is_valid_utf8_char = M.is_valid_utf8_char(sub_char, count_1_of_byte)
      if is_valid_utf8_char then
        table.insert(new_string, sub_char)
      else
        table.insert(new_string, "?")
      end
    else
      table.insert(new_string, "?")
    end
    index_of_raw_string = index_of_raw_string + count_1_of_byte
  end
  do return table.concat end
  return table.concat, new_string, new_string, "?", new_string, "?"
end

function M.get_continuous_1_count_of_byte(num)
  if nil == num then
    return -1
  end
  local count = 0
  while 0 ~= bitutil.band(num, 128) do
    count = count + 1
    num = bitutil.lshift(num, 1)
  end
  if 0 == count then
    count = 1
  end
  return count
end

function M.is_valid_utf8_char(sub_char, len)
  if string.len(sub_char) ~= len then
    return false
  end
  local first_byte = string.byte(sub_char, 1)
  if 1 == len and 0 ~= bitutil.band(first_byte, 128) then
    return false
  end
  if len >= 2 then
    if 2 == len and bitutil.band(first_byte, 224) ~= 192 then
      return false
    end
    if 3 == len and bitutil.band(first_byte, 240) ~= 224 then
      return false
    end
    if 4 == len and bitutil.band(first_byte, 248) ~= 240 then
      return false
    end
    if 5 == len and bitutil.band(first_byte, 252) ~= 248 then
      return false
    end
    if 6 == len and bitutil.band(first_byte, 254) ~= 252 then
      return false
    end
    for i = 2, len do
      local follow_byte = string.byte(sub_char, i)
      if 128 ~= bitutil.band(follow_byte, 192) then
        return false
      end
    end
  end
  return true
end

function M.empty_array_ensure(array)
  if nil == array or array and 0 == #array then
    local JSON = require("ejoysdk_lua.ejoysdk_json")
    array = JSON.newArray()
  end
  return array
end

function M.do_export_wrapping(target, error_handler_tp)
  if type(target) ~= "table" then
    return
  end
  local E = require("ejoysdk_lua.ejoysdk")
  for k, v in pairs(target) do
    if type(v) == "function" and not E.Utils.start_with(k, "_") and not E.Utils.start_with(k, "async_") then
      local function func_wraper(...)
        do return M.ejoysdk_call, error_handler_tp, v, ... end
        
        return M.ejoysdk_call, error_handler_tp, v, ...
      end
      
      target[k] = func_wraper
    end
  end
end

local _ejoysdk_call

function M.ejoysdk_call(error_handler_tp, func, ...)
  local E = require("ejoysdk_lua.ejoysdk")
  
  local function error_handler_funtion(err)
    if "chat" == error_handler_tp then
      local CALLBACK = require("ejoysdk_lua.chat.ejoysdk_chat_callback_manager")
      local notify_succ = pcall(CALLBACK.callback, "chat", CALLBACK.HANDLER_NAME.ON_HANDLERS_ERROR, "", err)
      if not notify_succ then
        E.log("ejoysdk_call:chat_notify_cp_error")
      end
    end
  end
  
  if nil == _ejoysdk_call then
    _ejoysdk_call = true
    local ms_start = E.system_ms()
    local ok, msg = xpcall(func, error_handler_funtion, ...)
    local ms_end = E.system_ms()
    local diff = ms_end - ms_start
    if diff > 5 then
      E.LOG.d(TAG, "exe method spend time=" .. tostring(diff) .. " ms")
    end
    _ejoysdk_call = nil
    if ok then
      return msg
    else
      return {
        code = CONSTANTS.EJOYSDK_ERROR_CODES.LUA_ERROR,
        message = "sdk_inner_error"
      }
    end
  else
    do return func, ... end
    return func, ...
  end
end

function M.merge_table(old_table, new_table)
  assert(type(old_table) == "table", "param old_table must be table type")
  assert(type(new_table) == "table", "param new_table must be table type")
  for k, v in pairs(new_table) do
    if type(v) ~= type(old_table[k]) then
      old_table[k] = v
    elseif type(v) == "table" then
      old_table[k] = M.merge_table(old_table[k], v)
    else
      old_table[k] = v
    end
  end
  return old_table
end

function M.merge_array(array_1, array_2)
  local complement = {}
  array_1 = array_1 or {}
  array_2 = array_2 or {}
  for _, item2 in ipairs(array_2) do
    local exist = false
    for _, item1 in ipairs(array_1) do
      if item1 == item2 then
        exist = true
        break
      end
    end
    if false == exist then
      table.insert(complement, item2)
    end
  end
  for _, itemc in ipairs(complement) do
    table.insert(array_1, itemc)
  end
  return array_1
end

function M.replace_empty_table(orig_table, new_value, seen)
  seen = seen or {}
  if not orig_table or type(orig_table) ~= "table" then
    return
  end
  if seen[orig_table] then
    return
  end
  seen[orig_table] = true
  for k, v in pairs(orig_table) do
    if type(v) == "table" then
      if next(v) ~= nil then
        M.replace_empty_table(v, new_value, seen)
      else
        orig_table[k] = new_value
      end
    end
  end
end

function M.is_text_empty(text)
  return nil == text or "" == text
end

function M.table_maxn(t)
  local mn = 0
  for k, _ in pairs(t) do
    if k > mn then
      mn = k
    end
  end
  return mn
end

function M.compareTable(t1, t2)
  if type(t1) ~= "table" or type(t2) ~= "table" then
    return false
  end
  local mt1 = getmetatable(t1)
  local mt2 = getmetatable(t2)
  if mt1 and mt1.__eq then
    do return mt1.__eq, t1 end
    return mt1.__eq, t1, t2, nil, nil, nil, nil, nil, nil
  end
  if mt2 and mt2.__eq then
    do return mt2.__eq, t1 end
    return mt2.__eq, t1, t2, nil, nil, nil, nil, nil, nil
  end
  if #t1 ~= #t2 then
    return false
  end
  for k, v in pairs(t1) do
    if type(v) == "table" then
      if not M.compareTable(v, t2[k]) then
        return false
      end
    elseif v ~= t2[k] then
      return false
    end
  end
  for k, v in pairs(t2) do
    if type(v) == "table" then
      if not M.compareTable(t1[k], v) then
        return false
      end
    elseif t1[k] ~= v then
      return false
    end
  end
  return true
end

function M.filter_table(ft1, ft2, accept_func)
  local k = 1
  while k <= #ft1 do
    local keep = false
    for i = 1, #ft2 do
      if accept_func(ft1[k], ft2[i]) then
        keep = true
        break
      end
    end
    if keep then
      k = k + 1
    else
      table.remove(ft1, k)
    end
  end
end

function M.toast_msg(desc_key, default_desc, duration)
  local LANG = require("ejoysdk_lua.lang.util")
  local E = require("ejoysdk_lua.ejoysdk")
  local message = LANG.getString(desc_key, default_desc or "")
  duration = duration or 3
  if message and "" ~= message then
    local function show_funciton()
      E.Toast.show(message, {use_native = true, duration = duration})
      
      E.Timer.once(duration, function()
        E.Toast.hide()
      end)
    end
    
    if _ejoysdk.os() == "ios" then
      local VC = require("ejoysdk_lua.ejoysdk_version_check")
      local sdk_version = E.Sdkinfo.getSDKVersionName("EJOYSDK")
      local check_result = VC.compare_versions(sdk_version, "2.11.0")
      if tonumber(check_result) >= 0 then
        show_funciton()
      end
    else
      show_funciton()
    end
  end
end

function M.dump_stack(deep_level, logger)
  local _level = deep_level or 1
  local traceback_str = ""
  while true do
    local info = debug.getinfo(_level, "nSl")
    if not info then
      break
    end
    traceback_str = (traceback_str or "") .. "\n" .. string.format("[%d] %s:%d in function '%s'", _level, info.short_src, info.currentline, info.name or "<unknown>")
    _level = _level + 1
  end
  if logger and type(logger) == "function" then
    logger(traceback_str or "")
  else
    local E = require("ejoysdk_lua.ejoysdk")
    E.log(traceback_str or "")
  end
end

function M.is_module_available(name)
  if package.loaded[name] then
    return true
  else
    for _, searcher in ipairs(package.searchers or package.loaders) do
      local loader = searcher(name)
      if type(loader) == "function" then
        local succ, ret = pcall(loader, name)
        if true == succ and ret then
          return true
        end
      end
    end
    return false
  end
end

function M.load_properties(file_path)
  local properties = {}
  local file = io.open(file_path, "r")
  if not file then
    local E = require("ejoysdk_lua.ejoysdk")
    E.log("do not load properties form " .. tostring(file_path))
    return properties
  end
  for line in file:lines() do
    local key, value = line:match("^([^=]*)=(.*)$")
    if key and value then
      key = key:gsub("^%s+", ""):gsub("%s+$", "")
      if string.sub(key, 1, 1) ~= "#" then
        value = value:gsub("^%s+", ""):gsub("%s+$", "")
        value = value:gsub("\\(.)", {
          ["\\\\"] = "\\",
          ["\\t"] = "\t",
          ["\\n"] = "\n",
          ["\\r"] = "\r",
          ["\\f"] = "\f",
          ["\\b"] = "\b"
        })
        properties[key] = value
      end
    end
  end
  file:close()
  return properties
end

M.STR = require("ejoysdk_lua.ejoysdk_utils_str")

function M.func_retry_with_times(target_func, cb, times, opts)
  times = times or 3
  local fail_rules = {
    fail_interval_sec = 1,
    fail_increase_sec = 2,
    max_fail_interval = 15
  }
  if opts then
    if type(opts.fail_interval_sec) == "number" then
      fail_rules.fail_interval_sec = opts.fail_interval_sec
    end
    if type(opts.fail_increase_sec) == "number" then
      fail_rules.fail_increase_sec = opts.fail_increase_sec
    end
    if type(opts.max_fail_interval) == "number" then
      fail_rules.max_fail_interval = opts.max_fail_interval
    end
  end
  _ejoysdk.log("func_retry_with_times rules, fail_interval_sec:" .. tostring(fail_rules.fail_interval_sec) .. ", fail_increase_sec:" .. tostring(fail_rules.fail_increase_sec) .. ", max_fail_interval:" .. tostring(fail_rules.max_fail_interval) .. ", times:" .. tostring(times))
  local E = require("ejoysdk_lua.ejoysdk")
  local tried_times = 0
  local target_func_wrapper
  
  function target_func_wrapper()
    target_func(function(succ, code, msg)
      if succ then
        _ejoysdk.log("func_retry_with_times succ")
        cb(true)
      else
        tried_times = tried_times + 1
        if times < 0 or tried_times <= times then
          local interval = fail_rules.fail_interval_sec
          local increase_interval = (tried_times - 1) * fail_rules.fail_increase_sec
          interval = interval + increase_interval
          if interval > fail_rules.max_fail_interval then
            interval = fail_rules.max_fail_interval
          end
          E.Timer.once(interval, function()
            _ejoysdk.log("func_retry_with_times failed and retry times:" .. tostring(tried_times))
            target_func_wrapper()
          end)
        else
          _ejoysdk.log("func_retry_with_times failed, code:" .. tostring(code) .. ", msg:" .. tostring(msg))
          cb(false, code, msg)
        end
      end
    end)
  end
  
  _ejoysdk.log("func_retry_with_times call begin")
  target_func_wrapper()
end

function M.deep_equals(ta, tb, opts)
  if type(ta) ~= type(tb) then
    return false, ta, tb
  end
  if type(ta) == "table" then
    local is_array = true
    for k in pairs(ta) do
      if type(k) ~= "number" then
        is_array = false
      end
    end
    if is_array and #ta ~= #tb then
      return false, ta, tb
    end
    for k, v in pairs(ta) do
      local sret, sta, stb = M.deep_equals(v, tb[k], opts)
      if not sret then
        return false, sta, stb
      end
    end
    for k, v in pairs(tb) do
      local sret, sta, stb = M.deep_equals(ta[k], v, opts)
      if not sret then
        return false, sta, stb
      end
    end
    return true
  else
    if opts and opts.string_cmp_func and type(ta) == "string" then
      return opts.string_cmp_func(ta, tb), ta, tb
    end
    return ta == tb, ta, tb
  end
end

function M.get_media_base_url()
  local EGC = require("ejoysdk_lua.ejoysdk_gangplank_config")
  local base_url = EGC.get_base_url_for_service("media-cdn")
  return base_url
end

function M.insert_array(tb, value)
  if type(tb) == "table" then
    for _, val in ipairs(tb) do
      if val == value then
        return tb
      end
    end
    table.insert(tb, value)
  end
end

return M
