local Vendor = require("ejoysdk_lua.vendors.vendor")
local E = require("ejoysdk_lua.ejoysdk")
local EG = require("ejoysdk_lua.ejoysdk_gangplank")
local md5 = require("ejoysdk_lua.libs.md5")
local guuid = require("ejoysdk_lua.ejoysdk_uuid")
local compat = require("ejoysdk_lua.compat.ejoysdk_compat")
local compat_string = compat.string
local MEDIA_LOG_PROTOCOL = require("ejoysdk_lua.media_log.media_log_protocol")
local EM = require("ejoysdk_lua.ejoysdk_module")
local TAG = EM.MODULE.VENDORS.MEDIA_LOG .. "media_log"
local OVERSEA_APPLOG = require("ejoysdk_lua.vendors.oversea_applog")
local CHANNEL = "MEDIA_LOG"
local LOG_EXT_TYPE = 0
local LOG_PROTOCOL_VER = 1
local M = Vendor:Inherit(CHANNEL)
M.OPT_KEY = {
  MEDIAS = "medias",
  COMMIT_ONLY_ONCE = "only_once",
  INCLUDE_ALL_MEDIAS = "include_all_medias"
}
local seq_retry_record = {}
local MAX_RETRY_COUNT = 3

local function pack_event(event_name, seq, ext)
  local package_name = E.Sysinfo.package_name()
  local account_id = EG.user_info().uid or ""
  local dev_id = E.Sysinfo.utdid()
  local ext_str = ext or ""
  local timestamp = os.time()
  local row_data = LOG_PROTOCOL_VER .. seq .. package_name .. account_id .. dev_id .. event_name .. timestamp .. LOG_EXT_TYPE .. ext_str
  E.LOG.debug(TAG, "seq is " .. tostring(seq))
  E.LOG.debug(TAG, "event_pack_data is " .. tostring(row_data))
  local row_data_md5 = string.upper(md5.sumhexa(row_data))
  local check = string.sub(row_data_md5, 1, 2)
  local pack = compat_string.pack("<Bc16s1s1s1s1I4Bs1c2", LOG_PROTOCOL_VER, seq, package_name, account_id, dev_id, event_name, timestamp, LOG_EXT_TYPE, ext_str, check)
  do return _ejoysdk_crypt.base64encode end
  return _ejoysdk_crypt.base64encode, pack, seq, package_name, account_id, dev_id, event_name, timestamp, LOG_EXT_TYPE, ext_str, check
end

local function commit_event_to_medias(event_name, params, opt)
  OVERSEA_APPLOG.commit_event(event_name, params, opt)
end

local retry_commit_on_fail

local function commit_event_with_seq(seq, event_name, params, opt)
  local pack_event_data = pack_event(event_name, seq, "")
  local request_params = {event = pack_event_data}
  MEDIA_LOG_PROTOCOL.post(MEDIA_LOG_PROTOCOL.SERVICE.QUERY_EVENT_SEQ, request_params, function(succ, ...)
    local data = (...)
    if succ and data then
      E.LOG.debug(TAG, data)
      if data.utdidSeq == seq and data.accountIdSeq == seq then
        commit_event_to_medias(event_name, params, opt)
      else
        E.LOG.debug(TAG, "ignore commit event " .. event_name)
      end
    else
      local code, msg = ...
      E.LOG.debug(TAG, "media log request fail, code is " .. tostring(code) .. " msg is " .. tostring(msg))
      E.Timer.once(3, function()
        retry_commit_on_fail(seq, event_name, params, opt)
      end)
    end
  end)
end

function retry_commit_on_fail(seq, event_name, params, opt)
  local current_seq_retry_count = seq_retry_record.seq or 0
  if current_seq_retry_count < MAX_RETRY_COUNT then
    seq_retry_record.seq = current_seq_retry_count + 1
    commit_event_with_seq(seq, event_name, params, opt)
  else
    E.LOG.debug(TAG, "retry max count fail")
  end
end

function M.commit_event(event_name, params, opt)
  opt = opt or {}
  local commit_only_once = opt[M.OPT_KEY.COMMIT_ONLY_ONCE]
  if nil == commit_only_once then
    commit_only_once = true
  end
  if commit_only_once then
    local seq = guuid.random_i64()
    commit_event_with_seq(seq, event_name, params, opt)
  else
    commit_event_to_medias(event_name, params, opt)
  end
end

return M
