local Class = require("ejoysdk_lua.ejoysdk_class")
local M = Class:Inherit("CloudUI")
do
  local method = {
    "show_flash_screen",
    "get_storage_error",
    "get_mobile_network_tips",
    "get_download_finish",
    "stop_cloud_game_with_finish_download",
    "stop_cloud_game_by_server_and_download_finish",
    "stop_cloud_game_by_server",
    "network_error",
    "network_error_retry",
    "cloud_error",
    "cloud_error_without_download",
    "set_download_progress"
  }
  for _, v in pairs(method) do
    M[v] = function()
      assert(false, v .. " unimplemented")
    end
  end
end
return M
