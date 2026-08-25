local E = require("ejoysdk_lua.ejoysdk")
local AUU = require("ejoysdk_lua.res.download_url_utils")
local SP = require("ejoysdk_lua.vendors.splitpkg")
local ES = require("ejoysdk_lua.ejoysdk_stat")
local NS = require("ejoysdk_lua.res.model.strategies.network_strategy")
local ET = require("ejoysdk_lua.ejoysdk_topic")
local SPU = require("ejoysdk_lua.res.splitpkg.splitpkg_utils")
local LANG = require("ejoysdk_lua.lang.util")
local JSON = require("ejoysdk_lua.ejoysdk_json")
local M = {}
local TAG = "ejoy_res_splitpkg_presenter"
local SPLIT_PKG_TIP_SHOWN = E.LazyKeyStore:New("EJOY_SPLIT_PKG_TIP_SHOWN", false, false, false)
local NETWORK_TYPE_WIFI = 1
local NETWORK_TYPE_MOBILE = 2
local NETWORK_TYPE_UNKNOWN = 3
local PB = SP.ProgressBox
local PAGE_TYPE = {
  DATA_DOWNLOAD = "data_download",
  WIFI_DOWNLOAD = "wifi_download",
  SUCCESS = "success",
  PROGRESS = "progress"
}
local DOWNLOAD_STATE = {
  UNKNOWN = "unknown",
  IDLE = "idle",
  FAILED = "failed",
  STOPPED = "stopped",
  WATTING = "waitting",
  DOWNLOADING = "downloading",
  COMPLETE = "complete"
}
local RAVEN_PAGEID_REGION_MAP = {
  cn = "69d4ee2f94765b0f77a9baa3",
  hk = "69d8738dc739c9183c601c82",
  us = "69d87408c35a1c0cd0548725"
}
local m_initialized = false
local m_completed = false
local m_start_download, m_change_strategy
local m_current_state = DOWNLOAD_STATE.UNKNOWN
local m_current_state_obj, m_current_progress_info
local m_tip_count_down = false
local m_rewards_data
local WEBVIEW_STATE = {
  IDLE = 0,
  OPENING = 1,
  OPENED = 2
}
local m_webview_state = WEBVIEW_STATE.IDLE
local m_webview_page_type
local m_download_size = 0

local function is_wifi_network(type)
  return type == NETWORK_TYPE_WIFI
end

local function is_mobile_network(type)
  return type == NETWORK_TYPE_MOBILE or type == NETWORK_TYPE_UNKNOWN
end

function M.open_block_popup_h5(resource_path)
  local percent = (m_current_progress_info or {}).percent or "0"
  SPU.splitpkg_download_track("block_popup", "missing_file_load", {
    is_priority_high = true,
    resource_path = resource_path,
    percent = percent
  })
  M.open_h5_page(PAGE_TYPE.PROGRESS)
end

function M.open_h5_page(page_type)
  E.LOG.debug(TAG, "open_h5_page: current_state=" .. tostring(m_webview_state) .. "(0=IDLE,1=OPENING,2=OPENED), current_page_type=" .. tostring(m_webview_page_type) .. ", target_page_type=" .. tostring(page_type))
  if m_webview_state == WEBVIEW_STATE.OPENING or m_webview_state == WEBVIEW_STATE.OPENED then
    if m_webview_page_type == page_type then
      E.LOG.debug(TAG, "open_h5_page skipped, webview is " .. (m_webview_state == WEBVIEW_STATE.OPENING and "opening" or "opened") .. " with same page_type:" .. tostring(page_type))
      return
    else
      E.LOG.debug(TAG, "open_h5_page: webview is " .. (m_webview_state == WEBVIEW_STATE.OPENING and "opening" or "opened") .. " with different page_type, closing current and opening new, current:" .. tostring(m_webview_page_type) .. ", new:" .. tostring(page_type))
      E.WebView.close()
    end
  end
  m_webview_state = WEBVIEW_STATE.OPENING
  m_webview_page_type = page_type
  local url = AUU.generate_raven_url(RAVEN_PAGEID_REGION_MAP)
  if page_type then
    url = url .. "?view=" .. page_type
  end
  E.LOG.debug(TAG, "open_h5_page, page_type:" .. tostring(page_type) .. ", url:" .. tostring(url))
  local hostname = AUU.extract_hostname_from_url(url)
  local injection = {
    [hostname] = {transparent = true}
  }
  local options = {
    use_cutout = false,
    hide_close_btn = true,
    compactMode = true,
    use_fragment = true
  }
  if page_type == PAGE_TYPE.PROGRESS then
    if m_completed then
      E.LOG.debug(TAG, "open_h5_page skipped, m_completed is " .. tostring(m_completed))
      return
    end
    options.disable_backkey_press = true
    options.use_cutout = true
    local need_resume = m_current_state == DOWNLOAD_STATE.STOPPED or m_current_state == DOWNLOAD_STATE.WATTING
    E.LOG.debug(TAG, "open_h5_page progress, state:" .. tostring(m_current_state) .. ", need_resume:" .. tostring(need_resume))
    if need_resume and m_start_download and m_change_strategy then
      m_change_strategy(NS.STRATEGY.BOTH_MOBILE_WIFI_NETWORK)
      m_start_download()
      E.LOG.debug(TAG, "open_h5_page progress, resumed download")
    end
  end
  E.WebView.open(url, injection, options, function(data)
    if m_webview_state == WEBVIEW_STATE.OPENED and m_webview_page_type == PAGE_TYPE.PROGRESS and m_completed then
      E.LOG.debug(TAG, "progress webview opened and completed, page_type: " .. page_type)
      E.WebView.close()
    end
    local args = data.args
    if args.type == "splitpkg_webview_opened" then
      E.LOG.debug(TAG, "webview opened, page_type: " .. page_type)
      E.LOG.debug(TAG, data)
      m_webview_state = WEBVIEW_STATE.OPENED
      m_webview_page_type = page_type
    end
  end, function(value)
    E.LOG.debug(TAG, "h5 close callback >>")
    E.log(value)
    m_webview_state = WEBVIEW_STATE.IDLE
    m_webview_page_type = nil
    E.LOG.debug(TAG, "webview state reset to IDLE")
  end)
end

function M.get_download_rewards(cb)
  if type(m_rewards_data) == "table" and next(m_rewards_data) ~= nil then
    E.LOG.debug("get_download_rewards", "use m_rewards_data")
    cb(true, m_rewards_data)
    return
  end
  local BASE_API = require("ejoysdk_lua.libs.base_api")
  local vortex_api = BASE_API:New("campaign-center")
  vortex_api:post("/campaign_center/download_reward/get_all", {}, {}, {}, function(succ, ...)
    if succ then
      local data = (...)
      E.LOG.debug("get_download_rewards result: ")
      E.log(data)
      local UTILS = require("ejoysdk_lua.res.download_url_utils")
      if data and data.items then
        for _, item in ipairs(data.items) do
          if item.banner_img then
            item.banner_img = UTILS.get_banner_url(item.banner_img)
          end
          if item.reward and item.reward.package_items then
            for _, package_item in ipairs(item.reward.package_items) do
              if package_item.icon then
                package_item.icon = UTILS.get_icon_url(package_item.icon)
              end
            end
          end
        end
      end
      E.LOG.debug("get_download_rewards", "get_download_rewards result: ")
      E.log(data)
      cb(true, data)
    else
      E.LOG.debug("get_download_rewards failed: ")
      E.log(...)
      local code, msg = ...
      cb(false, code, msg)
    end
  end)
end

local function convertBytesTo(bytes, unit, decimals)
  decimals = decimals or 0
  if type(bytes) ~= "number" or bytes ~= bytes or bytes == math.huge or bytes == -math.huge then
    return 0
  end
  local base = 1024
  local factors = {
    KB = base,
    MB = base ^ 2,
    GB = base ^ 3
  }
  if not factors[unit] then
    error("Invalid unit: " .. tostring(unit) .. ". Use 'KB', 'MB', or 'GB'.")
  end
  local value = bytes / factors[unit]
  if decimals >= 0 then
    local format_str = "%." .. decimals .. "f"
    do return tonumber, string.format(format_str, value) end
    return tonumber, string.format(format_str, value)
  else
    return value
  end
end

local function show_tip(cb)
  cb = cb or function()
  end
  local tip_shown_status = SPLIT_PKG_TIP_SHOWN:get()
  if "shown" == tip_shown_status then
    E.LOG.debug(TAG, "show_tip skipped, tip already shown before")
    cb(true)
    return
  end
  m_tip_count_down = true
  local download_size_tip
  if m_download_size >= 1.073741824E9 then
    local value = convertBytesTo(m_download_size, "GB", 1)
    download_size_tip = value .. "GB"
  else
    local value = convertBytesTo(m_download_size, "MB")
    download_size_tip = value .. "MB"
  end
  local total_sec = 5
  local tip_download_size = string.format(LANG.getString("splitpkg_tip_download_size", "游戏内需下载%s完整资源，下载完成后游戏体验更流畅"), download_size_tip)
  local tip_countdown = string.gsub(LANG.getString("splitpkg_tip_countdown", "当前为移动网络，<highlight>%s秒</highlight>后自动开始下载"), "<highlight>(.-)</highlight>", "<font color='#418CFF'>%1</font>")
  local tips_text_format = "<b><font color='#FFFFFF'>" .. tip_download_size .. "</font></b><br>" .. tip_countdown
  local show_tips_count_down
  
  function show_tips_count_down()
    if not m_tip_count_down then
      E.LOG.debug(TAG, "show_view timer cancelled, skip")
      cb(true)
      return
    end
    if total_sec > 0 then
      PB.show_tips(string.format(tips_text_format, total_sec))
    else
      m_tip_count_down = false
      E.LOG.debug(TAG, "show_view timer fired, hide tips and start download")
      PB.hide_tips()
      SPLIT_PKG_TIP_SHOWN:set("shown")
      if m_change_strategy then
        m_change_strategy(NS.STRATEGY.BOTH_MOBILE_WIFI_NETWORK)
      end
      SPU.splitpkg_download_track("common", "auto_switch_mobile_policy")
      cb(true)
      return
    end
    total_sec = total_sec - 1
    E.Timer.once(1, show_tips_count_down)
  end
  
  E.Timer.once(1, show_tips_count_down)
  if m_change_strategy then
    m_change_strategy(NS.STRATEGY.WIFI_ONLY)
  end
end

function M.show_view(params, handlers, cb)
  params = params or {}
  handlers = handlers or {}
  cb = cb or function()
  end
  m_start_download = handlers.start_download
  m_change_strategy = handlers.change_strategy
  m_download_size = params.download_size or 0
  local user_strategy = params.user_strategy or nil
  if not m_start_download or not m_change_strategy then
    E.LOG.warn(TAG, "show_view failed, start_download or change_strategy is nil")
    return
  end
  local network_type = E.Sysinfo.network_type()
  if is_wifi_network(network_type) then
    E.LOG.debug(TAG, "show_view, wifi network, start download directly")
    PB.hide()
    cb(true)
  elseif is_mobile_network(network_type) then
    E.LOG.debug(TAG, "show_view, non-wifi network, show progress box with tips")
    PB.show()
    if user_strategy == NS.STRATEGY.WIFI_ONLY then
      m_current_state = DOWNLOAD_STATE.STOPPED
      PB.update_state(DOWNLOAD_STATE.STOPPED)
      cb(true)
    elseif user_strategy == NS.STRATEGY.BOTH_MOBILE_WIFI_NETWORK then
      cb(true)
    else
      show_tip(cb)
    end
  else
    cb(true)
  end
  m_current_progress_info = {total_size = m_download_size}
  m_initialized = true
  E.LOG.debug(TAG, "show_view done, initialized:" .. tostring(m_initialized))
  M.get_download_rewards(function(success, rewards_data)
    if success and rewards_data then
      E.LOG.debug("get_download_rewards", "pre_get background tasks rewards data")
      E.log(rewards_data.items)
      m_rewards_data = rewards_data
    end
  end)
end

function M.destroy()
  E.LOG.debug(TAG, "destroy")
  m_initialized = false
  m_completed = false
  m_start_download = nil
  m_change_strategy = nil
  m_current_state = DOWNLOAD_STATE.UNKNOWN
  m_current_state_obj = nil
  m_current_progress_info = nil
  m_tip_count_down = false
  m_download_size = 0
  m_rewards_data = nil
  m_webview_state = WEBVIEW_STATE.IDLE
  m_webview_page_type = nil
  PB.update_state(DOWNLOAD_STATE.UNKNOWN)
  PB.update_progress(0)
end

local function on_network_change_handler()
  E.LOG.debug(TAG, "on_network_change_handler, m_initialized: " .. tostring(m_initialized) .. ", m_completed: " .. tostring(m_completed))
  if not m_initialized or m_completed then
    return
  end
  local network_type = E.Sysinfo.network_type()
  E.LOG.debug(TAG, "on_network_change_handler, network_type: " .. tostring(network_type))
  if is_mobile_network(network_type) then
    PB.show()
    show_tip()
  end
end

ET.subscribe(ET.gangplank.NETWORK_STATE_CHANGE, on_network_change_handler)

function M.on_res_download_progress_change_listener(state, state_obj, progress_info)
  state_obj = state_obj or {}
  progress_info = progress_info or {}
  E.LOG.debug(TAG, "on_res_download_progress_change_listener, state:" .. tostring(state) .. ", state_obj:" .. JSON.safe_encode(state_obj) .. ", percent:" .. tostring(progress_info.percent))
  m_current_state = state or DOWNLOAD_STATE.UNKNOWN
  m_current_state_obj = state_obj
  m_current_progress_info = progress_info
  if state == DOWNLOAD_STATE.WATTING then
    state = DOWNLOAD_STATE.STOPPED
  end
  PB.update_state(state)
  if progress_info and progress_info.percent then
    PB.update_progress(progress_info.percent)
  end
  if state == DOWNLOAD_STATE.COMPLETE then
    m_completed = true
    local JF = require("ejoysdk_lua.vendors.jf")
    local _acc_info = ES.acc_info()
    if _acc_info and _acc_info.accountId ~= nil then
      E.LOG.debug(TAG, "sdk.resource.playing_download.success start:")
      JF.commit_event("sdk.resource.playing_download.success", {
        account = _acc_info.accountId
      }, {
        [JF.OPTION_KEY.IS_PRIORITY_HIGH] = true
      })
    end
    if m_webview_state == WEBVIEW_STATE.OPENED and m_webview_page_type == PAGE_TYPE.PROGRESS then
      E.LOG.debug(TAG, "download complete, close progress webview, state:" .. tostring(m_webview_state))
      E.WebView.close()
    end
  end
end

function M.handle_click()
  E.LOG.debug(TAG, "handle_click, initialized:" .. tostring(m_initialized) .. ", state:" .. tostring(m_current_state))
  if not m_initialized then
    E.LOG.debug(TAG, "handle_click ignored, not initialized")
    return
  end
  if m_current_state == DOWNLOAD_STATE.IDLE or m_current_state == DOWNLOAD_STATE.UNKNOWN then
    M.open_h5_page(PAGE_TYPE.DATA_DOWNLOAD)
  elseif m_current_state == DOWNLOAD_STATE.DOWNLOADING or m_current_state == DOWNLOAD_STATE.FAILED then
    if is_wifi_network(E.Sysinfo.network_type()) then
      M.open_h5_page(PAGE_TYPE.WIFI_DOWNLOAD)
    else
      M.open_h5_page(PAGE_TYPE.DATA_DOWNLOAD)
    end
  elseif m_current_state == DOWNLOAD_STATE.STOPPED or m_current_state == DOWNLOAD_STATE.WATTING then
    if m_start_download and m_change_strategy then
      E.LOG.debug(TAG, "handle_click, stopped state, resume download")
      m_change_strategy(NS.STRATEGY.BOTH_MOBILE_WIFI_NETWORK)
      m_start_download()
      SPU.splitpkg_download_track("common", "manual_switch_mobile_policy", {is_priority_high = true})
    end
  elseif m_current_state == DOWNLOAD_STATE.COMPLETE then
    M.open_h5_page(PAGE_TYPE.SUCCESS)
  end
end

PB.set_onclick_listener(M.handle_click)

function M.download_until_wifi(cb)
  E.LOG.debug(TAG, "download_until_wifi called")
  if m_tip_count_down then
    m_tip_count_down = false
    PB.hide_tips()
    E.LOG.debug(TAG, "download_until_wifi, timer cancelled and tips hidden")
  end
  if m_change_strategy then
    m_change_strategy(NS.STRATEGY.WIFI_ONLY)
    E.LOG.debug(TAG, "download_until_wifi, change_strategy called")
  end
  cb(true)
end

function M.get_download_state_and_progress(cb)
  if not m_initialized then
    cb(false)
    return
  end
  cb(true, {
    state = m_current_state,
    state_obj = m_current_state_obj,
    progress_info = m_current_progress_info
  })
end

function M.hide_progress_box(cb)
  if not m_initialized then
    cb(false)
    return
  end
  PB.hide()
  cb(true)
end

function M.page_track(funciton_name, action_name, _params)
  SPU.splitpkg_download_track(funciton_name, action_name, _params)
end

return M
