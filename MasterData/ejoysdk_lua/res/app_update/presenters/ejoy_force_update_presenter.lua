local E = require("ejoysdk_lua.ejoysdk")
local AUM = require("ejoysdk_lua.res.app_update.app_update_manager")
local DUU = require("ejoysdk_lua.res.download_url_utils")
local ES = require("ejoysdk_lua.ejoysdk_stat")
local LANG = require("ejoysdk_lua.lang.util")
local RTM = require("ejoysdk_lua.res.model.ejoy_res_type_model")
local EC = require("ejoysdk_lua.ejoysdk_constants")
local EEU = require("ejoysdk_lua.res.ejoysdk_error_utils")
local ERU = require("ejoysdk_lua.res.ejoysdk_res_utils")
local M = {}
local TAG = "APP_UPDATE#ejoy_app_update_presenter"
local app_update_downloading_key_store = E.LazyKeyStore:New("is_app_update_downloading")
local is_app_update_last_downloading = app_update_downloading_key_store:get()
local ANNOUNCEMENT_PAGEID_REGION_MAP = {
  cn = "69315c69da51101151d2cfb4",
  hk = "69493c6401b3f81395275598",
  us = "69493c8cb1f1ff13bcd8e3f9"
}
local local_announcement_config = {}

local function show_storage_insufficient_modal(pkg_size, cb)
  ES.stat_bizid_pfcomm({
    biz_group = "lq",
    biz_prod = "qz",
    biz_mod = "game_full_update",
    biz_func = "force_update_page",
    biz_act = "download_storage_low",
    biz_st = "succ",
    biz_co = "200"
  })
  local title = LANG.getStringSuitCNOverseas("storage_insufficient_title", "")
  local total_required_size = RTM.get_total_required_storage(pkg_size)
  local content = string.format(LANG.getStringSuitCNOverseas("storage_insufficient_content", ""), ERU.format_bytes(total_required_size), ERU.format_bytes(pkg_size))
  E.Modal.open(title, {
    message = content,
    buttons = {
      LANG.getStringSuitCNOverseas("confirm", "确定")
    }
  }, function()
    ES.stat_bizid_pfcomm({
      biz_group = "lq",
      biz_prod = "qz",
      biz_mod = "game_full_update",
      biz_func = "force_update_page",
      biz_act = "download_storage_low_confirm",
      biz_st = "succ",
      biz_co = "200"
    })
    cb(false)
  end)
end

local function show_network_error_modal(code, cb)
  local title = LANG.getStringSuitCNOverseas("tips", "")
  local content = LANG.getStringSuitCNOverseas("app_update_network_error_content", "") .. "(" .. tostring(code) .. ")"
  E.Modal.open(title, {
    message = content,
    buttons = {
      LANG.getStringSuitCNOverseas("confirm", "确定")
    }
  }, function()
    cb(false)
  end)
end

local function show_default_error_modal(code, cb)
  local title = LANG.getStringSuitCNOverseas("tips", "")
  local content = LANG.getStringSuitCNOverseas("app_update_default_error_content", "") .. "(" .. tostring(code) .. ")"
  E.Modal.open(title, {
    message = content,
    buttons = {
      LANG.getStringSuitCNOverseas("confirm", "确定")
    }
  }, function()
    cb(false)
  end)
end

function M.init(announcement_config, cb)
  ES.stat_bizid_pfcomm({
    biz_group = "lq",
    biz_prod = "qz",
    biz_mod = "game_full_update",
    biz_func = "force_update_check",
    biz_act = "force_update_check",
    biz_params = {need_app_update = true, is_mandatory_force_update = true},
    biz_st = "succ",
    biz_co = "200"
  })
  M.init_app_update_state_listener()
  E.LOG.debug(TAG, "is_app_update_last_downloading: " .. tostring(is_app_update_last_downloading))
  if "true" == is_app_update_last_downloading then
    AUM.start({need_jump_outside_update = true}, function()
    end)
  end
  M.show_announcement_page(announcement_config, cb)
end

function M.show_announcement_page(announcement_config, cb)
  local biz_act
  if nil == announcement_config then
    biz_act = "announcement_inner_show"
  end
  if announcement_config then
    local_announcement_config = announcement_config
  end
  local options = {
    use_fragment = true,
    hide_close_btn = true,
    disable_backkey_press = true
  }
  local announcement_h5_url = DUU.generate_raven_url(ANNOUNCEMENT_PAGEID_REGION_MAP)
  E.LOG.debug(TAG, "announcement_h5_url: " .. tostring(announcement_h5_url))
  local webview_is_opened = false
  
  local function on_js_callback(_value)
    E.LOG.debug(TAG, "h5 on_js_callback >>")
    E.log(_value)
    webview_is_opened = true
  end
  
  E.open_webview_with_options(announcement_h5_url, {}, {}, options, on_js_callback, function(_value)
    E.LOG.debug(TAG, "h5 close callback >>")
    E.log(_value)
    M.show_announcement_page(announcement_config, function()
    end)
  end)
  local timeout_threshold = 12
  local times = 0
  local check_webview_opened
  
  function check_webview_opened()
    times = times + 1
    if webview_is_opened then
      if cb then
        E.LOG.debug(TAG, "show_announcement_page success")
        ES.stat_bizid_pfcomm({
          biz_group = "lq",
          biz_prod = "qz",
          biz_mod = "game_full_update",
          biz_func = "force_update_page",
          biz_act = biz_act,
          biz_st = "succ",
          biz_co = "200"
        })
        cb(true)
        cb = nil
      end
      return
    end
    if times <= timeout_threshold then
      E.Timer.once(0.5, function()
        check_webview_opened()
      end)
    elseif cb then
      E.LOG.error(TAG, "show_announcement_page failed")
      ES.stat_bizid_pfcomm({
        biz_group = "lq",
        biz_prod = "qz",
        biz_mod = "game_full_update",
        biz_func = "force_update_page",
        biz_act = biz_act,
        biz_st = "fail",
        biz_co = "404"
      })
      cb(false, EC.BACKGROUND_DOWNLOAD_ERROR_CODES.OPEN_H5_PAGE_TIMEOUT, "announcement webview open failed")
      cb = nil
    end
  end
  
  check_webview_opened()
  cb(true)
end

function M.init_app_update_state_listener()
  local app_update_manager_static_info = AUM.get_app_update_manager_static_info()
  
  local function state_change_listener(app_update_info)
    E.LOG.debug(TAG, "state_change_listener called, app_update_info: ")
    E.log(app_update_info)
    local state = app_update_info.state
    local error_info = app_update_info.state_info or {}
    local code = error_info.code
    if state == AUM.APP_UPDATE_STATE.DOWNLOAD_FAILED then
      if code == EC.DOWNLOAD_ERROR_CODES.DOWNLOAD_DISK_NOT_ENOUGH then
        show_storage_insufficient_modal(app_update_manager_static_info.size, function()
        end)
      elseif EEU.check_is_network_error(code) then
        show_network_error_modal(code, function()
        end)
      elseif code ~= EC.DOWNLOAD_ERROR_CODES.CANCELLED then
        show_default_error_modal(code, function()
        end)
      end
      ES.stat_bizid_pfcomm({
        biz_group = "lq",
        biz_prod = "qz",
        biz_mod = "game_full_update",
        biz_func = "force_update_page",
        biz_act = "download_fail",
        biz_st = "fail",
        biz_co = code or "400",
        is_priority_high = true,
        biz_params = {error_code = code}
      })
    end
    if state == AUM.APP_UPDATE_STATE.DOWNLOAD_COMPLETE then
      app_update_downloading_key_store:set("false")
      E.LOG.debug(TAG, "download complete, now auto install")
      AUM.install({}, function(is_succ, ...)
        E.LOG.debug(TAG, "install result: " .. tostring(is_succ))
        E.log(...)
      end)
      ES.stat_bizid_pfcomm({
        biz_group = "lq",
        biz_prod = "qz",
        biz_mod = "game_full_update",
        biz_func = "force_update_page",
        biz_act = "download_complete",
        biz_st = "succ",
        biz_co = "200",
        is_priority_high = true
      })
    end
  end
  
  AUM.remove_state_change_listener(state_change_listener)
  AUM.set_state_change_listener(state_change_listener)
end

function M.get_update_announcement(_params, cb)
  cb(local_announcement_config)
end

function M.get_task_state(_params, cb)
  AUM.get_task_state(_params, cb)
end

function M.start_task(_params, cb)
  app_update_downloading_key_store:set("true")
  AUM.start({need_jump_outside_update = true}, cb)
end

function M.stop_task(_params, cb)
  app_update_downloading_key_store:set("false")
  AUM.stop(_params, cb)
end

function M.remove_task(_params, cb)
  AUM.remove(_params, cb)
end

function M.install_task(_params, cb)
  AUM.install(_params, cb)
end

function M.exit_game(_params, cb)
  local game_listeners = AUM.get_game_listeners()
  E.LOG.debug(TAG, "exit_game called, on_game_exit:" .. tostring(type(game_listeners.on_game_exit)))
  if game_listeners.on_game_exit then
    game_listeners.on_game_exit()
    cb(true)
  else
    cb(false)
  end
end

return M
