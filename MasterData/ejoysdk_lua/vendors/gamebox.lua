local E = require("ejoysdk_lua.ejoysdk")
local UNI = require("ejoysdk_lua.vendors.unisdk")
local Vendor = require("ejoysdk_lua.vendors.vendor")
local ECC = require("ejoysdk_lua.ejoysdk_config_center")
local EW = require("ejoysdk_lua.ejoysdk_web")
local EG = require("ejoysdk_lua.ejoysdk_gangplank")
local EM = require("ejoysdk_lua.ejoysdk_module")
local ET = require("ejoysdk_lua.ejoysdk_topic")
local AEGIS_DATA = require("ejoysdk_lua.aegis.aegis_collect_data")
local BADGE_MGR = require("ejoysdk_lua.badge.ejoysdk_badge_manager")
local BADGE_ANN = require("ejoysdk_lua.badge.ejoysdk_badge_anns")
local V2_HISTORY = require("ejoysdk_lua.airline_v2.airline_v2_history")
local CHANNEL = "GAMEBOX"
local native_vendor = CHANNEL
local TAG = EM.MODULE.VENDORS.GAMEBOX .. CHANNEL
local inited = false
local STATE = {
  NOT_INIT = 0,
  INITED = 1,
  ACCOUNT_LOGINED = 2,
  PLAYER_LOGINED = 3
}
local state = STATE.NOT_INIT
local SYNC_SHOW_GAMEBOX = "SYNC_SHOW_GAMEBOX"
local SYNC_HIDE_GAMEBOX = "SYNC_HIDE_GAMEBOX"
local SYNC_SHOW_FLOATER = "SYNC_SHOW_FLOATER"
local SYNC_HIDE_FLOATER = "SYNC_HIDE_FLOATER"
local CAST_UPDATE_GAMEBOX = "CAST_UPDATE_GAMEBOX"
local CAST_UPDATE_BADGE = "CAST_UPDATE_BADGE"
local SYNC_ISSHOWING_GAMEBOX = "SYNC_ISSHOWING_GAMEBOX"
local SYNC_ISSHOWING_FLOATER = "SYNC_ISSHOWING_FLOATER"
local floater_config
local M = Vendor:Inherit(CHANNEL)
M.SYSCODE = {
  ANNOUNCEMENT = "announcement",
  ACCOUNT = "account",
  ACTIVITY = "activity",
  BBS = "bbs",
  EXCHANGE = "exchange",
  CUSTOMER = "customer"
}

local function is_empty(str)
  return not str or "" == str
end

local function has_inited()
  return inited
end

local function has_login()
  local user_info = EG.user_info()
  local ret = user_info and user_info.uid and user_info.token and user_info.uid ~= "" and user_info.token ~= ""
  return ret
end

local function has_player_info()
  local player_info = EG.player_info()
  local ret = player_info and player_info.player_id and player_info.player_id ~= ""
  return ret
end

local function get_scene()
  local scene = 0
  if has_inited() then
    scene = 0
  end
  if has_login() then
    scene = scene + 1
  end
  if has_player_info() then
    scene = scene + 1
  end
  return scene
end

local function get_config_from_cc()
  local usercenter_config
  local is_overseas = E.CONFIG.get_config(E.CONFIG.KEY.MULTI_REGIONS_ENABLED)
  if is_overseas then
    usercenter_config = ECC.get_config(ECC.NAMESPACE.USERCENTER_OVERSEA)
  else
    usercenter_config = ECC.get_config(ECC.NAMESPACE.USERCENTER_CN)
  end
  if usercenter_config and usercenter_config.config then
    return usercenter_config.config
  end
  return nil
end

local function usercenter_config_handler(_config)
  local uc_namespace_config = _config or {}
  local ucc_config = uc_namespace_config.config
  if nil ~= ucc_config then
    M.update_gamebox_config(ucc_config, {})
  end
end

function M.update_gamebox_config(ucc_config, params)
  local had_config_data = false
  local total_config = {}
  if ucc_config and ucc_config.game_box_tab then
    local _params = params or {}
    local auth_info = V2_HISTORY.get_auth_info()
    local local_start_up_data = {
      init_params = _params,
      airlineToken = (auth_info or {}).airlineToken,
      accountId = (auth_info or {}).accountId,
      aegis_data = AEGIS_DATA.get_encrypt_data()
    }
    local options = EW.get_fill_default_options({})
    if _ejoysdk.os() == "ios" then
      options.use_cutout = true
    end
    local injection = {}
    local game_box_i18n = ucc_config.game_box_i18n or {}
    local scene = get_scene()
    local game_box_tab = {}
    local badge_tree = {}
    for _, info in ipairs(ucc_config.game_box_tab) do
      if scene >= info.showScene then
        local url = info.url
        if url and type(url) == "string" then
          local host = string.match(url, "[%w%-%.]*%(.[%w%-]+%.%w+)%/([^?#]*)")
          if host then
            injection[host] = {
              startupData = local_start_up_data,
              transparent = options.transparent
            }
          end
        end
        local map_name_key = tostring(info.sysCode) .. "." .. tostring(info.name)
        if game_box_i18n and game_box_i18n[map_name_key] then
          info.name = game_box_i18n[map_name_key]
        end
        if not is_empty(info.badgeAppId) then
          local tree = {
            app_id = info.badgeAppId,
            tree_id = info.badgeTreeId or ""
          }
          if info.sysCode == M.SYSCODE.ANNOUNCEMENT then
            tree.app_id = BADGE_ANN.APP.announcement
            tree.ann_type = info.ext.ann_type
            info.badgeAppId = BADGE_ANN.APP.announcement
            info.badgeTreeId = BADGE_ANN.TYPE.GAMEBOX
          end
          table.insert(badge_tree, tree)
        end
        table.insert(game_box_tab, info)
      end
    end
    E.LOG.debug(TAG, badge_tree)
    BADGE_MGR.batch_get_tree(badge_tree)
    EW.fill_injection_with_common_params(injection, options)
    total_config.gamebox_config = {
      game_box_tab = game_box_tab,
      webview_config = {injection = injection, options = options},
      game_box_i18n = game_box_i18n
    }
    total_config.user_info = EG.user_info() or {}
    if floater_config then
      total_config.floater_config = floater_config
    end
    E.LOG.debug(TAG, total_config)
    UNI.cast(CHANNEL, CAST_UPDATE_GAMEBOX, total_config)
    had_config_data = true
  else
    E.LOG.debug(CHANNEL, "configcenter game_box_tab config is nil")
  end
  return had_config_data
end

function M.show_gamebox()
  UNI.sync_call(native_vendor, SYNC_SHOW_GAMEBOX, {})
end

function M.hide_gamebox()
  UNI.sync_call(native_vendor, SYNC_HIDE_GAMEBOX, {})
end

function M.show_floater()
  UNI.sync_call(native_vendor, SYNC_SHOW_FLOATER, {})
end

function M.hide_floater()
  UNI.sync_call(native_vendor, SYNC_HIDE_FLOATER, {})
end

function M.update_badge(_config)
  local config = _config or {}
  UNI.cast(CHANNEL, CAST_UPDATE_BADGE, config)
end

function M.is_showing_gamebox()
  local ret = UNI.sync_call(CHANNEL, SYNC_ISSHOWING_GAMEBOX, {}) or {}
  return ret.value or false
end

function M.is_showing_floater()
  local ret = UNI.sync_call(CHANNEL, SYNC_ISSHOWING_FLOATER, {}) or {}
  return ret.value or false
end

local function scene_handler()
  E.LOG.debug(TAG, "scene update")
  local ucc_config = get_config_from_cc()
  M.update_gamebox_config(ucc_config, {})
end

function M.init(opt, cb)
  require("ejoysdk_lua.ejoysdk_js_bridge").init()
  ET.subscribe(ET.gangplank.INITED, function()
    inited = true
    state = STATE.INITED
    scene_handler()
  end)
  ET.subscribe(ET.gangplank.ACQUIRE, function()
    if state >= STATE.INITED then
      scene_handler()
    end
    state = STATE.ACCOUNT_LOGINED
  end)
  ET.subscribe(ET.gangplank.LOGOUT, function()
    if state >= STATE.INITED then
      scene_handler()
    end
    state = STATE.INITED
  end)
  ET.subscribe(ET.gangplank.PLAYER_OFFLINE, function()
    if state >= STATE.INITED then
      scene_handler()
    end
    state = STATE.ACCOUNT_LOGINED
  end)
  ET.subscribe(ET.gangplank.PLAYER_ONLINE, function()
    if state <= STATE.ACCOUNT_LOGINED then
      scene_handler()
    end
    state = STATE.PLAYER_LOGINED
  end)
  if opt and opt.position and opt.align then
    floater_config = {
      position = opt.position,
      align = opt.align
    }
  end
  local is_overseas = E.CONFIG.get_config(E.CONFIG.KEY.MULTI_REGIONS_ENABLED)
  if is_overseas then
    ECC.subscribe(ECC.NAMESPACE.USERCENTER_OVERSEA, usercenter_config_handler)
  else
    ECC.subscribe(ECC.NAMESPACE.USERCENTER_CN, usercenter_config_handler)
  end
  local init_config = get_config_from_cc()
  local had_config_data = M.update_gamebox_config(init_config, {})
  BADGE_MGR.init()
  if not had_config_data and not ECC.is_data_inited then
    local function wait4_cc_handler(...)
      E.LOG.debug(CHANNEL, "configcenter getdata inited")
      
      local ucc_config = get_config_from_cc()
      M.update_gamebox_config(ucc_config, {})
    end
    
    ET.subscribe(ET.config_center.DATA_INITED, wait4_cc_handler)
  end
  if cb then
    cb(true)
  end
end

return M
