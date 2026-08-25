local client_config = require("ejoysdk_lua.shark_sdk.config.client_config")
local hotfix = require("ejoysdk_lua.shark_sdk.hotfix.hotfix")
local logger = require("ejoysdk_lua.shark_sdk.util.logger")
local sdk_version = require("ejoysdk_lua.shark_sdk.version")
local ejoysdk = require("ejoysdk_lua.ejoysdk")
local M = {}

function M.init(config)
  logger.info("Shark SDK version: %s, 当前 utdid: %s", sdk_version.VERSION, ejoysdk.Sysinfo.utdid())
  local final_config, err = client_config.init(config)
  if nil ~= err then
    return nil, err
  end
  return final_config, nil
end

function M.start_fetch_hotfix()
  hotfix.start()
end

function M.stop_fetch_hotfix()
  hotfix.stop()
end

function M.fetch_hotfix_once()
  hotfix.fetch()
end

function M.on_fetch_hotfix_finished(callback)
  hotfix.on_fetch_hotfix_finished(callback)
end

function M.on_fetch_hotfix_failed(callback)
  hotfix.on_fetch_hotfix_failed(callback)
end

return M
