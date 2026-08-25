local E = require("ejoysdk_lua.ejoysdk")
local Ratelimit = require("ejoysdk_lua.apm-sdk-lua.common.ratelimit")
local Cfg = require("ejoysdk_lua.apm-sdk-lua.config.configurator")
local EU = require("ejoysdk_lua.apm-sdk-lua.common.ejoysdk_utils")
local Utils = require("ejoysdk_lua.apm-sdk-lua.common.utils")
local HTTPUtils = require("ejoysdk_lua.apm-sdk-lua.common.http_utils")
local Labeler = require("ejoysdk_lua.apm-sdk-lua.label.labeler")
local Global = require("ejoysdk_lua.apm-sdk-lua.global")
local E_UTILS = require("ejoysdk_lua.ejoysdk_utils")
local LOGGER = "apm_file2oss"
local M = {
  enabled = true,
  ratelimiter = nil,
  rate_limit = 1,
  burst = 1,
  retry_opts = {}
}
M.__index = M
local CFG_ENABLED = "enabled"
local CFG_RETRY_BUDGET = "retry_budget"
local CFG_RETRY_CODE_LIST = "retry_code_list"
local CFG_LIMIT = "rate_limit"
local CFG_BURST = "burst"

function M.init()
  local cat = Cfg.CATEGORY_FILE_REPORT
  M.enabled = Cfg.get(cat, CFG_ENABLED, true)
  M.rate_limit = Cfg.get(cat, CFG_LIMIT, 1)
  M.burst = Cfg.get(cat, CFG_BURST, 1)
  M.retry_opts = {
    retry_budget = Cfg.get(cat, CFG_RETRY_BUDGET, 3),
    retry_code_list = Cfg.get(cat, CFG_RETRY_CODE_LIST, {})
  }
  local err
  M.ratelimiter, err = Ratelimit.new_limiter(M.rate_limit, M.burst, "apus_upload_file_to_oss")
  if nil ~= err then
    E.LOG.error(LOGGER, "new limiter err:" .. err)
  else
    E.LOG.debug(LOGGER, "new limiter succ")
  end
end

local function get_file_server_url()
  local domain = Cfg.get_ingester_server()
  local env = Labeler.get_resource("env")
  if not domain or not env then
    return nil
  end
  return tostring(domain) .. "/" .. tostring(env) .. "/v1/files/oss"
end

local is_uploading = false
local BAD_REQUEST_CODE = 400

function M.upload_file_to_oss(file_full_path, upload_file_cb, extra_labels)
  assert(type(file_full_path) == "string" and "" ~= file_full_path, "params#1 file_full_path expect a non-nil string")
  local file_server_url = get_file_server_url()
  assert(type(file_server_url) == "string" and "" ~= file_server_url, "file_server_url expect a non-nil string")
  if is_uploading then
    upload_file_cb(false, BAD_REQUEST_CODE, "is_uploading,skip")
    return
  end
  if not Global.is_apus_sdk_initialized() then
    upload_file_cb(false, BAD_REQUEST_CODE, "apus sdk has not initialized")
    return
  end
  if M.rate_limit > 0 and M.ratelimiter ~= nil and not M.ratelimiter:allow() then
    upload_file_cb(false, BAD_REQUEST_CODE, "rejected by ratelimiter")
    return
  end
  
  local function _upload_file_cb(succ, ...)
    is_uploading = false
    if succ then
      local resp = (...)
      local resp_body = resp and resp.resp_body or ""
      E.LOG.debug(LOGGER, "resp.body:" .. tostring(resp_body))
      local oss_access_url = HTTPUtils.cal_oss_access_url(resp_body)
      if "" ~= oss_access_url then
        upload_file_cb(true, oss_access_url)
        return
      else
        local code = -1
        local msg = "cannot resolve oss_access_url from resp body"
        upload_file_cb(false, code, msg)
      end
    else
      local code, msg = ...
      upload_file_cb(false, code, msg)
    end
  end
  
  local resource = Utils.merge_table(Labeler.get_resource(), extra_labels)
  resource.__file_name = file_full_path
  local retry_opts = E_UTILS.deepcopy(M.retry_opts)
  E.LOG.debug(LOGGER, "ready to call upload_file_to_oss,url:" .. tostring(file_server_url) .. " file_full_path:" .. file_full_path)
  is_uploading = true
  EU.upload_file_to_apus(file_server_url, {form_header = resource}, file_full_path, retry_opts, _upload_file_cb)
end

return M
