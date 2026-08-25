local _utils = require("ejoysdk_lua.ejoysdk_utils")
local EM = require("ejoysdk_lua.ejoysdk_module")
local _TAG = EM.MODULE.EJOYSDK_BASE_MODULE .. "log_mgr"
local M = {}
M.LOG_LEVEL = {HIGH = "high", LOW = "low"}

function M.call_api(_header, tag, api_name, _log_level, _opt, ...)
  _log_level = _log_level or M.LOG_LEVEL.LOW
  local content = {}
  content.type = "call_api"
  if _log_level == M.LOG_LEVEL.HIGH then
    content.level = "info"
  else
    content.level = "debug"
  end
  local data = {}
  data.tag = tag
  data.api_name = api_name
  if _opt and _opt.params then
    data.params = _opt.params
  end
  content.data = data
  local E = require("ejoysdk_lua.ejoysdk")
  if _log_level == M.LOG_LEVEL.HIGH then
    E.LOG.info(tag, content, _header)
  else
    E.LOG.debug(tag, content, _header)
  end
end

function M.call_api_sync_return(_header, tag, api_name, _log_level, _opt, ...)
  _log_level = _log_level or M.LOG_LEVEL.LOW
  local content = {}
  content.type = "api_cb"
  if _log_level == M.LOG_LEVEL.HIGH then
    content.level = "info"
  else
    content.level = "debug"
  end
  local data = {}
  data.cb_type = "sync"
  data.tag = tag
  data.api_name = api_name
  if _opt and _opt.params then
    data.params = _opt.params
  end
  content.data = data
  local E = require("ejoysdk_lua.ejoysdk")
  if _log_level == M.LOG_LEVEL.HIGH then
    E.LOG.info(tag, content, _header)
  else
    E.LOG.debug(tag, content, _header)
  end
end

function M.call_api_async_callback(_header, tag, api_name, _log_level, _opt, cb, ...)
  _log_level = _log_level or M.LOG_LEVEL.LOW
  local content = {}
  content.type = "api_cb"
  if _log_level == M.LOG_LEVEL.HIGH then
    content.level = "info"
  else
    content.level = "debug"
  end
  local data = {}
  data.cb_type = "async"
  data.tag = tag
  data.api_name = api_name
  data.cb = cb or "_cb_miss"
  if _opt and _opt.params then
    data.params = _opt.params
  end
  content.data = data
  local E = require("ejoysdk_lua.ejoysdk")
  if _log_level == M.LOG_LEVEL.HIGH then
    E.LOG.info(tag, content, _header)
  else
    E.LOG.debug(tag, content, _header)
  end
end

function M.debug(_header, tag, action, action_type, params, _opt)
  local content = {}
  content.type = "user_event"
  content.level = "debug"
  local data = {}
  data.tag = tag
  data.action = action or ""
  data.action_type = action_type or ""
  data.params = params
  content.data = data
  local E = require("ejoysdk_lua.ejoysdk")
  E.LOG.debug(tag, content, _header)
end

function M.info(_header, tag, action, action_type, params, _opt)
  local content = {}
  content.type = "user_event"
  content.level = "info"
  local data = {}
  data.tag = tag
  data.action = action or ""
  data.action_type = action_type or ""
  data.params = params
  content.data = data
  local E = require("ejoysdk_lua.ejoysdk")
  E.LOG.info(tag, content, _header)
end

function M.error(_header, tag, error_code, error_msg, params, _opt)
  local content = {}
  content.type = "user_event"
  content.level = "error"
  local data = {}
  data.tag = tag
  if error_code then
    data.err_code = tostring(error_code)
  else
    data.err_code = "nil"
  end
  data.err_msg = error_msg or ""
  data.params = params or {}
  content.data = data
  local E = require("ejoysdk_lua.ejoysdk")
  E.LOG.error(tag, content, _header)
end

function M.warn(_header, tag, warn_msg, params, _opt)
  local content = {}
  content.type = "user_event"
  content.level = "warn"
  local data = {}
  data.tag = tag
  data.warn_msg = warn_msg or ""
  data.params = params or {}
  content.data = data
  local E = require("ejoysdk_lua.ejoysdk")
  E.LOG.warn(tag, content, _header)
end

function M.rpc_send(_header, tag, _log_level, req_data, _opt)
  local content = {}
  content.type = "rpc_req"
  if _log_level == M.LOG_LEVEL.HIGH then
    content.level = "info"
  else
    content.level = "debug"
  end
  local data = {}
  data.tag = tag or ""
  if req_data and req_data.content_body then
    data.cmd = req_data.content_body.cmd or ""
  else
    data.cmd = ""
  end
  data.req_data = req_data or {}
  content.data = data
  local E = require("ejoysdk_lua.ejoysdk")
  if _log_level == M.LOG_LEVEL.HIGH then
    E.LOG.info(tag, content, _header)
  else
    E.LOG.debug(tag, content, _header)
  end
end

function M.rpc_receive(_header, tag, _log_level, content_data, _opt)
  local content = {}
  content.type = "rpc_resp"
  if _log_level == M.LOG_LEVEL.HIGH then
    content.level = "info"
  else
    content.level = "debug"
  end
  local data = {}
  data.tag = tag or ""
  if content_data and content_data.msg then
    data.cmd = content_data.msg.cmd or ""
  else
    data.cmd = ""
  end
  data.resp_data = content_data
  content.data = data
  local E = require("ejoysdk_lua.ejoysdk")
  if _log_level == M.LOG_LEVEL.HIGH then
    E.LOG.info(tag, content, _header)
  else
    E.LOG.debug(tag, content, _header)
  end
end

function M.http_send(_header, tag, _log_level, content_data, _opt)
  local content = {}
  content.type = "rpc_req"
  if _log_level == M.LOG_LEVEL.HIGH then
    content.level = "info"
  else
    content.level = "debug"
  end
  local data = {}
  data.tag = tag or ""
  data.req_data = content_data
  content.data = data
  local E = require("ejoysdk_lua.ejoysdk")
  if _log_level == M.LOG_LEVEL.HIGH then
    E.LOG.info(tag, content, _header)
  else
    E.LOG.debug(tag, content, _header)
  end
end

function M.http_receive(_header, tag, _log_level, content_data, _opt)
  local content = {}
  content.type = "rpc_resp"
  if _log_level == M.LOG_LEVEL.HIGH then
    content.level = "info"
  else
    content.level = "debug"
  end
  local data = {}
  data.tag = tag or ""
  data.resp_data = content_data
  content.data = data
  local E = require("ejoysdk_lua.ejoysdk")
  if _log_level == M.LOG_LEVEL.HIGH then
    E.LOG.info(tag, content, _header)
  else
    E.LOG.debug(tag, content, _header)
  end
end

function M.list_by_section(list, max_item_count_on_section)
  local res = {}
  max_item_count_on_section = max_item_count_on_section or 3
  local section_index = 0
  local single_section
  for i, item in pairs(list) do
    local item_section_index = math.floor((i - 1) / max_item_count_on_section)
    if section_index ~= item_section_index then
      if single_section then
        table.insert(res, single_section)
        single_section = nil
      end
      section_index = section_index + 1
    end
    if section_index == item_section_index then
      single_section = single_section or {}
      item.log_orig_index = i
      table.insert(single_section, item)
    end
  end
  if single_section then
    table.insert(res, single_section)
  end
  return res
end

function M.encode_header(header)
  if not header or type(header) ~= "table" then
    return ""
  end
  local encode_header = ""
  local k_list = {}
  for k, _ in pairs(header) do
    table.insert(k_list, k)
  end
  table.sort(k_list)
  for i, k_item in pairs(k_list) do
    if i == #k_list then
      encode_header = encode_header .. tostring(k_item) .. "=" .. tostring(header[k_item])
    else
      encode_header = encode_header .. tostring(k_item) .. "=" .. tostring(header[k_item]) .. " "
    end
  end
  return encode_header
end

return M
