local E = require("ejoysdk_lua.ejoysdk")
local Utils = require("ejoysdk_lua.apm-sdk-lua.common.utils")
local File = require("ejoysdk_lua.apm-sdk-lua.file.file2oss")
local Event = require("ejoysdk_lua.apm-sdk-lua.event.event")
local Time = require("ejoysdk_lua.apm-sdk-lua.common.time.init")
local Global = require("ejoysdk_lua.apm-sdk-lua.global")
local LOGGER = "apm_file_upload_mgr"
local M = {}
local file_uploader = {metric_name = ""}
file_uploader.__index = file_uploader
local file_uploaders = {}
local support_metric_names = {
  [Global.AbnormalMetricNameEnum.DRAW_CALL] = 1,
  [Global.AbnormalMetricNameEnum.FPS] = 1,
  [Global.AbnormalMetricNameEnum.JANK] = 1,
  [Global.AbnormalMetricNameEnum.TRI_COUNT] = 1,
  [Global.AbnormalMetricNameEnum.APP_MEM] = 1,
  [Global.AbnormalMetricNameEnum.LUA_MEM] = 1,
  [Global.AbnormalMetricNameEnum.OTHER] = 1
}

function file_uploader.new(metric_name)
  assert(type(metric_name) == "string" and "" ~= metric_name, "params#1 metric_name expect a non-nil string")
  assert(nil == file_uploaders[metric_name], "metric_name:" .. metric_name .. " has already registered")
  assert(nil ~= support_metric_names[metric_name], "metric_name:" .. metric_name .. " is not supportted")
  file_uploaders[metric_name] = 0
  local obj = {metric_name = metric_name}
  do return setmetatable, obj end
  return setmetatable, obj, file_uploader, " is not supportted"
end

function file_uploader:upload(file_path, extra_labels)
  E.LOG.debug(LOGGER, "file_uploader is upload for metric_name:" .. self.metric_name)
  local event_name = "apus_" .. self.metric_name .. "_abnormal"
  local start = Time.system_clock()
  
  local function upload_file_cb(succ, ...)
    local elapsed = Time.system_clock() - start
    if succ then
      local oss_access_url = (...)
      E.LOG.debug(LOGGER, "upload_file_to_oss succ, oss_access_url:" .. tostring(oss_access_url))
      local labels = {
        url = oss_access_url,
        metric_name = self.metric_name,
        success = "true"
      }
      labels = Utils.merge_table(labels, extra_labels, true)
      Event.post_with_high_priority(event_name, labels, oss_access_url, {cost = elapsed})
    else
      local code, msg = ...
      local labels = {
        success = "false",
        metric_name = self.metric_name,
        code = code
      }
      labels = Utils.merge_table(labels, extra_labels, true)
      Event.post_with_high_priority(event_name, labels, msg, {cost = elapsed})
      E.LOG.error(LOGGER, "upload_file_to_oss failed, code:" .. tostring(code) .. " msg:" .. tostring(msg))
    end
  end
  
  File.upload_file_to_oss(file_path, upload_file_cb, extra_labels)
end

function M.new_file_uploader(metric_name)
  do return file_uploader.new end
  return file_uploader.new, metric_name
end

return M
