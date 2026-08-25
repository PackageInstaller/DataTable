local CG = require("ejoysdk_lua.vendors.cloud_game")
local JSBridge = require("ejoysdk_lua.ejoysdk_js_bridge")
local E = require("ejoysdk_lua.ejoysdk")
local panel_url = "file:///android_asset/demo/js/cloud_game/control.html"
local INJECTION_PATH = "android_asset/demo/js/cloud_game/control.html"
if _ejoysdk.os() == "ios" then
  local paths = _ejoysdk.sysinfo_paths()
  local bundle_path_ios = paths.bundle_path .. "/cloudgame.bundle/"
  panel_url = "file://" .. bundle_path_ios .. "cloud_game/control.html"
  INJECTION_PATH = bundle_path_ios .. "cloud_game/control.html"
end
local M = {}
local TAG = "cloud_floater"
local js_bridge_init = false
local can_show_floater = false
local injection = {
  [INJECTION_PATH] = {
    transparent = true,
    startupData = {
      init_params = {}
    }
  },
  [".ejoy.com"] = {},
  [".test.com"] = {}
}
local option = {
  compactMode = true,
  hide_close_btn = true,
  use_cutout = true,
  disable_backkey_press = true
}
local params = {
  panel_url = panel_url,
  injection = injection,
  option = option
}
local default_tips_show_time = 5
local current_tips_message

local function show_floater_tips(show_time, message, color)
  local facade = require("ejoysdk_lua.cloud_game.cloud_game_facade")
  if not facade.is_cloud_game_visible() then
    E.LOG.debug(TAG, "current cloud state is pause, do not show any view")
    return
  end
  current_tips_message = message
  CG.show_floater_tips(message, color)
  local actual_show_time = show_time or default_tips_show_time
  E.Timer.once(actual_show_time, function()
    if current_tips_message == message then
      CG.hide_floater_tips()
    end
  end)
end

function M.show_floater()
  if not can_show_floater and _ejoysdk.os() == "android" then
    E.LOG.debug(TAG, "can show floater tag is false, return")
    return
  end
  if not js_bridge_init then
    JSBridge.init()
    js_bridge_init = true
  end
  CG.show_floater(params)
end

function M.hide_floater()
  CG.hide_floater()
end

function M.mark_can_show_floater()
  can_show_floater = true
  local CSM = require("ejoysdk_lua.cloud_game.cloud_state_manager")
  if CSM.is_cloud_connected() then
    M.show_floater()
    return true
  end
  return false
end

function M.show_try_play_time_coming(show_time)
  local message = "免费时长即将到期"
  local color = "#F45829"
  show_floater_tips(show_time, message, color)
end

function M.show_download_complete_coming(show_time)
  local message = "完整版即将下载完成"
  local color = "#FFFFFF"
  show_floater_tips(show_time, message, color)
end

function M.show_download_with_mobile_net(show_time)
  local message = "请注意流量消耗"
  local color = "#FFFFFF"
  show_floater_tips(show_time, message, color)
end

function M.show_download_complete(time, show_time)
  local message = tostring(time) .. "分钟后将自动打开完整版"
  local color = "#FFFFFF"
  show_floater_tips(show_time, message, color)
end

function M.show_pkg_installed(show_time)
  local message = "完整版本已准备好"
  local color = "#FFFFFF"
  show_floater_tips(show_time, message, color)
end

function M.show_install_pkg(show_time)
  local message = "下载官方完整版可获得更优体验"
  local color = "#FFFFFF"
  show_floater_tips(show_time, message, color)
end

return M
