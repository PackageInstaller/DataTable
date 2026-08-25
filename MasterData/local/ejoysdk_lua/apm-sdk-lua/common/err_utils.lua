local E = require("ejoysdk_lua.ejoysdk")
local ApmStats = require("ejoysdk_lua.apm-sdk-lua.stats.apm_stats")
local Global = require("ejoysdk_lua.apm-sdk-lua.global")
local JSONUtils = require("ejoysdk_lua.apm-sdk-lua.common.json_utils")
local TBUtils = require("ejoysdk_lua.apm-sdk-lua.common.tb_utils")
local Labeler = require("ejoysdk_lua.apm-sdk-lua.label.labeler")
local Cfg = require("ejoysdk_lua.apm-sdk-lua.config.configurator")
local LOGGER = "apm_err_utils"
local exception_counter = ApmStats:new_counter("exception_times", true)
local M = {}
M.__index = M
local collect_stopper, report_stopper

function M.set_collect_stopper(cs)
  if type(cs) == "function" then
    collect_stopper = cs
  end
end

function M.set_report_stopper(rs)
  if type(rs) == "function" then
    report_stopper = rs
  end
end

local MAX_TOLERANT_EXCEPTION_COUNT = 5

local function shutdown_apus()
  Global.set_apus_sdk_initialized(false)
  if collect_stopper then
    collect_stopper()
  end
  if report_stopper then
    report_stopper()
  end
end

local function report_err_stack_info(err_stack_info)
  local ingester_server = Cfg.get_ingester_server() or ""
  if "" == ingester_server then
    E.LOG.error(LOGGER, "cannot get ingester_server from conf")
    return
  end
  local url = ingester_server .. "/v1/report_apus_crash"
  local timeout = Cfg.get_http_post_timeout() or 10
  local param = {
    err_stack_info = err_stack_info,
    exception_count = exception_counter:get(),
    resource = Labeler.get_resource() or nil
  }
  local data = JSONUtils.encode(param)
  
  local function cb(resp)
    if not resp then
      return
    end
    local status = tostring(resp.status)
    local resp_body = tostring(resp.body)
    E.LOG.debug(LOGGER, " report_apus_crash status=" .. status .. " body:" .. resp_body)
    if resp.status ~= 200 then
      E.LOG.error(LOGGER, "report_apus_crash err " .. ",status:" .. status .. " body:" .. resp_body)
    end
  end
  
  E.HTTP.post(url, {timeout = timeout}, E.HTTP.CT_JSON, data, cb)
end

local function handle_err(err)
  exception_counter:inc(1)
  if exception_counter:get() >= MAX_TOLERANT_EXCEPTION_COUNT then
    E.LOG.error(LOGGER, "too many exceptions occur,ready to shutdown apus...")
    pcall(shutdown_apus)
  end
  local err_stack_info = string.format([[
Executing function error. Error: %s. Traceback:
%s]], err, TBUtils.get_traceback_info())
  E.LOG.error(LOGGER, err_stack_info)
  if Global.is_apus_sdk_initialized() then
    report_err_stack_info(err_stack_info)
  end
end

M.handle_err = handle_err

function M.init()
  Cfg.set_hanlder_err_fn(handle_err)
end

return M
