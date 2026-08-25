local cloud_config = require("ejoysdk_lua.cloud_game.cloud_config")
local current_biz_strategy
local M = {}

function M.get_biz_strategy()
  if current_biz_strategy then
    return current_biz_strategy
  end
  if cloud_config.ResourceType == cloud_config.RESOURCE_TYPE.GAME_RES then
    current_biz_strategy = require("ejoysdk_lua.cloud_game.biz_strategy.cloud_game_res_biz")
  elseif cloud_config.ResourceType == cloud_config.RESOURCE_TYPE.PACKAGE then
    current_biz_strategy = require("ejoysdk_lua.cloud_game.biz_strategy.cloud_pkg_res_biz")
  end
  current_biz_strategy.init()
  return current_biz_strategy
end

function M.dispatch_download_biz_state(download_biz_state, download_state_info)
  local strategy = M.get_biz_strategy()
  if strategy then
    strategy.handle_download_biz_state_change(download_biz_state, download_state_info)
  end
end

function M.dispatch_connect_biz_state(connect_biz_state)
  local strategy = M.get_biz_strategy()
  if strategy then
    strategy.handle_connect_biz_state_change(connect_biz_state)
  end
end

function M.start_game_activity()
  local strategy = M.get_biz_strategy()
  if strategy then
    strategy.start_game_activity()
  end
end

function M.open_full_download()
  local strategy = M.get_biz_strategy()
  if strategy then
    strategy.open_full_download()
  end
end

function M.if_need_refresh_remain_time_when_download_complete()
  return cloud_config.ResourceType == cloud_config.RESOURCE_TYPE.GAME_RES
end

return M
