local E = require("ejoysdk_lua.ejoysdk")
local Q = require("ejoysdk_lua.ejoysdk_queue")
local WU = require("ejoysdk_lua.ejoysdk_web")
local JSBridge = require("ejoysdk_lua.ejoysdk_js_bridge")
local JSON = require("ejoysdk_lua.ejoysdk_json")
local EWT = require("ejoysdk_lua.ejoysdk_webview_toolbar")
local ET = require("ejoysdk_lua.ejoysdk_topic")
local LIGHTBOAT = require("ejoysdk_lua.res.lightboat.ejoysdk_lightboat")
local IVK_WEBVIEW_OPEN = "WEBVIEW_OPEN"
local SYNC_WEBVIEW_OPERATOR = "WEBVIEW_OPERATOR"
local ACT_WEBVIEW_UPDATE_TOOLBAR = "update_toolbar"
local SUPPORT_PRELOAD
local M = {}
local TAG = "ejoysdk_webview_manager"
M.WEBVIEW_STATUS = {
  IN_LINE = 1,
  SHOWING = 2,
  CLOSED = 3
}
local WEBVIEW_QUEUE_CAPACITY = 10
local queue = Q.create(WEBVIEW_QUEUE_CAPACITY)
local current_show_webview, check_queue

local function is_support_toolbar_version()
  if _ejoysdk.os() == "android" then
    local version = E.Sdkinfo.getSDKVersionName("EJOYSDK")
    local version_check = require("ejoysdk_lua.ejoysdk_version_check")
    local result = version_check.compare_versions(version, "2.10.11")
    if tonumber(result) >= 0 then
      return true
    else
      E.LOG.debug(TAG, "version not support toolbar")
      return false
    end
  end
  return true
end

local function open_webview_with_default_options(_options)
  _options = _options or {}
  if _options.use_cutout == nil then
    _options.use_cutout = false
  end
  return _options
end

local function show_webview_real(webview, injection, option)
  if not injection[".ejoy.com"] then
    injection[".ejoy.com"] = {}
  end
  if _ejoysdk.os() == "ios" then
    option.support_luacall = true
  elseif _ejoysdk.os() == "android" then
    option.support_luacall = true == option.use_fragment
  elseif _ejoysdk.os() == "harmonyos" then
    option.support_luacall = true
  end
  if option.enable_toolbar and is_support_toolbar_version() then
    if option.toolbar == nil then
      option.toolbar = EWT.default_toolbar_theme(option.toolbar_theme or EWT.theme.light)
    else
      option.toolbar = EWT.toolbar_checker(option.toolbar)
    end
  end
  WU.fill_injection_with_common_params(injection, option)
  option = open_webview_with_default_options(option)
  if type(option.stat_timestamp) == "table" then
    option.stat_timestamp.real_show = E.system_ms()
  end
  if _ejoysdk.os() == "android" then
    do return E.invoke, IVK_WEBVIEW_OPEN end
    return E.invoke, IVK_WEBVIEW_OPEN, {
      url = webview.url,
      injection = injection,
      option = option
    }, webview.url, nil, nil
  elseif _ejoysdk.os() == "harmonyos" then
    do return E.async_call, "webview_open", function(topic, value)
      E.LOG.debug(TAG, "webview_open cb, topic is " .. tostring(topic))
      ET.publish(topic, value)
    end, webview.url, injection end
    return E.async_call, "webview_open", function(topic, value)
      E.LOG.debug(TAG, "webview_open cb, topic is " .. tostring(topic))
      ET.publish(topic, value)
    end, webview.url, injection, option
  else
    local optionString = "{}"
    if option then
      local succ, msg = pcall(JSON.encode, option)
      if succ then
        optionString = msg
      end
    end
    local injectionString = JSON.encode(injection)
    do return _ejoysdk.webview_open, webview.url, injectionString end
    return _ejoysdk.webview_open, webview.url, injectionString, optionString
  end
end

local function show_webview(webview)
  E.LOG.debug(TAG, "show_webview url is " .. tostring(webview.url))
  local injection = webview.injection or {}
  local option = webview.option or {}
  if option.preload ~= true then
    current_show_webview = webview
  end
  webview.status = M.WEBVIEW_STATUS.SHOWING
  JSBridge.init()
  local close_loading_task
  if _ejoysdk.os() == "android" and option.enable_loading ~= false and option.preload ~= true then
    local ejoysdk_version = E.get_sdk_version_name("EJOYSDK")
    E.LOG.debug(TAG, "ejoysdk version >> " .. tostring(ejoysdk_version))
    local VER_CHECK = require("ejoysdk_lua.ejoysdk_version_check")
    if VER_CHECK.compare_versions(ejoysdk_version, "2.10.53") >= 0 and VER_CHECK.compare_versions(ejoysdk_version, "2.10.55") <= 0 then
      function close_loading_task()
        E.Loading.dismiss()
      end
      
      E.Timer.once(5, function()
        if close_loading_task then
          E.LOG.debug(TAG, "execute close loading task")
          close_loading_task()
          close_loading_task = nil
        else
          E.LOG.debug(TAG, "close loading task is nil")
        end
      end)
    end
  end
  WU.webview_callback_helper(webview.url, option, webview.on_js_callback, function(_value)
    current_show_webview = nil
    webview.status = M.WEBVIEW_STATUS.CLOSED
    if close_loading_task then
      E.LOG.debug(TAG, "close loading task not nil , and execute it")
      close_loading_task()
      close_loading_task = nil
    end
    if webview.on_close_callback then
      E.LOG.debug(TAG, "on_close_callback not nil, now callback >>")
      webview.on_close_callback(_value)
    else
      E.LOG.warn(TAG, "on_close_callback is nil, NOT callback >>")
    end
    E.LOG.debug(TAG, "webview close callback, delay one second to check")
    E.Timer.once(1, function()
      E.WebView.is_opened_async(function(is_opened)
        if not is_opened then
          E.LOG.debug(TAG, "webview close callback, webview is not open, check queue")
          check_queue()
        else
          E.LOG.debug(TAG, "webview close callback, after one second later, webview is open, do not check queue")
        end
      end)
    end)
  end)
  show_webview_real(webview, injection, option)
end

local function inject_data_local_path(url, local_path, injection)
  if not injection or not local_path then
    return
  end
  if E.Utils.start_with(local_path, "file://") then
    local_path = string.gsub(local_path, "file://", "")
  end
  if next(injection) then
    local first_data
    for host, data in pairs(injection) do
      local index = string.find(url, host, 1, true)
      if index and index > 0 then
        injection[local_path] = data
        return
      end
      first_data = first_data or data
    end
    injection[local_path] = first_data or {}
  else
    injection[local_path] = {}
  end
end

function check_queue()
  if not Q.isEmpty(queue) then
    local webview = Q.dequeue(queue)
    if webview.is_cancel then
      check_queue()
    else
      current_show_webview = webview
      show_webview(webview)
    end
  else
    E.LOG.debug(TAG, "the queue is empty")
  end
end

ET.subscribe("webview_hide", function(_value)
  E.WebView.is_opened_async(function(is_web_open)
    E.log("receive webview hide event, and is_web_open >> " .. tostring(is_web_open))
    if not is_web_open then
      current_show_webview = nil
      WU.handle_hide_event()
      check_queue()
    end
  end)
end)

local function is_support_preload()
  if nil == SUPPORT_PRELOAD then
    SUPPORT_PRELOAD = E.is_support_function(E.NATIVE_SUPPORT_FUNCTION_NAMES.SUPPORT_WEBVIEW_PRELOAD) or false
  end
  return SUPPORT_PRELOAD
end

local function preload_check(url, injection, option, on_js_callback, on_close_callback, tag)
  if not is_support_preload() then
    E.LOG.debug(TAG, "Page-Preload Not Supported")
    return false
  elseif LIGHTBOAT.has_inited == false then
    local load_cb
    
    function load_cb()
      E.LOG.debug(TAG, "Page-Preload Ready")
      M.add_webview(url, injection, option, on_js_callback, on_close_callback, tag)
      ET.unsubscribe(ET.lightboat.INITED, load_cb)
    end
    
    E.LOG.debug(TAG, "Page-Preload Not Ready")
    ET.subscribe(ET.lightboat.INITED, load_cb)
    return false
  end
  return true
end

function M.add_webview(url, injection, option, on_js_callback, on_close_callback, tag)
  injection = injection or {}
  option = option or {}
  if option.preload == true and false == preload_check(url, injection, option, on_js_callback, on_close_callback, tag) then
    return
  end
  local local_url = LIGHTBOAT.get_url_from_cache(url)
  if _ejoysdk.os() == "windows" and option and option.nonmodal_window then
    local sdk_version = E.Sdkinfo.getSDKVersionName("EJOYSDK")
    local VC = require("ejoysdk_lua.ejoysdk_version_check")
    local check_result_min = VC.compare_versions(sdk_version, "2.6.22")
    local check_result_max = VC.compare_versions(sdk_version, "2.7.8")
    if check_result_min >= 0 and check_result_max <= 0 then
      E.LOG.info(TAG, "[old version]0x25-encode-twice bug, ignore local url")
      local_url = nil
    end
  end
  if local_url and local_url ~= url then
    local clipping_url = E.Utils.url_clipping(local_url)
    inject_data_local_path(url, clipping_url, injection)
    if not option.fallback_url and not option.disable_fill_fallback_url then
      option.fallback_url = url
    end
    url = local_url
  end
  if nil == tag and current_show_webview and current_show_webview.status < M.WEBVIEW_STATUS.CLOSED and nil ~= current_show_webview.url and url == current_show_webview.url then
    E.LOG.debug(TAG, "url has been shown previously, ignored")
    return
  end
  local webview = {
    url = url,
    injection = injection,
    option = option,
    on_js_callback = on_js_callback,
    on_close_callback = on_close_callback,
    tag = tag,
    is_cancel = false
  }
  if current_show_webview and current_show_webview.tag and current_show_webview.tag == tag then
    E.LOG.debug(TAG, "current showing webview is same, reload it, tag >> " .. tostring(tag))
    E.WebView.close()
  end
  local ignore_queque = option and (option.nonmodal_window and nil ~= option.webview_id or option.preload) or false
  if ignore_queque then
    show_webview(webview)
    return
  end
  E.LOG.debug(TAG, "enqueue webview into queue >> " .. tostring(url) .. " and tag >> " .. tostring(tag))
  Q.replace(queue, webview, function(origin, new)
    E.LOG.debug(TAG, "compare the webview")
    return origin.tag and origin.tag == new.tag
  end)
  webview.status = M.WEBVIEW_STATUS.IN_LINE
  E.WebView.is_opened_async(function(is_opened)
    if not current_show_webview and not is_opened then
      E.LOG.debug(TAG, "current_show_webview is nil, now check queue")
      check_queue()
    else
      E.LOG.debug(TAG, "double check webview open")
      local last_show_webview = current_show_webview
      E.Timer.once(2, function()
        E.WebView.is_opened_async(function(delay_is_opened)
          E.LOG.debug(TAG, "2 s check state >> is_open " .. tostring(is_opened) .. " and delay_is_opened >> " .. tostring(delay_is_opened))
          E.LOG.debug(TAG, "last show webview >>" .. tostring(last_show_webview))
          E.LOG.debug(TAG, "current show webview >>" .. tostring(current_show_webview))
          if false == is_opened and false == delay_is_opened and last_show_webview == current_show_webview then
            E.LOG.debug(TAG, "double check webview open , check queue")
            check_queue()
          else
            E.LOG.debug(TAG, "double check webview open , queue")
          end
        end)
      end)
    end
  end)
end

function M.add_webview_priority(url, injection, option, on_js_callback, on_close_callback, tag)
  local webview = {
    url = url,
    injection = injection,
    option = option,
    on_js_callback = on_js_callback,
    on_close_callback = on_close_callback,
    tag = tag,
    is_cancel = false
  }
  if not Q.isEmpty(queue) then
    Q.clear(queue)
  end
  Q.enqueue(queue, webview)
  if current_show_webview then
    E.LOG.debug(TAG, "current showing webview is not nil, close it >> " .. tostring(tag))
    E.WebView.close()
    local last_show_webview = current_show_webview
    E.Timer.once(2, function()
      E.WebView.is_opened_async(function(is_web_open)
        if not is_web_open and last_show_webview == current_show_webview then
          E.LOG.debug(TAG, "double check webview open , check queue-1")
          check_queue()
        end
      end)
    end)
  else
    check_queue()
  end
end

function M.close_view(tag)
  if current_show_webview and current_show_webview.tag and current_show_webview.tag == tag then
    E.LOG.debug(TAG, "current showing webview is same, close it, tag >> " .. tostring(tag))
    E.WebView.close()
  end
  if not Q.isEmpty(queue) then
    local function cancel_func(webview)
      if webview and webview.tag and webview.tag == tag then
        E.LOG.debug(TAG, "find the same tag in queue, set it cancel. tag >> " .. tostring(tag))
        
        webview.is_cancel = true
      end
    end
    
    Q.traverse(queue, cancel_func)
  end
end

function M.hide_all_web()
  Q.clear(queue)
  if current_show_webview then
    E.WebView.close()
  end
end

function M.current_show_webview()
  return current_show_webview
end

function M.update_toolbar(toolbar_config)
  if not toolbar_config then
    return
  end
  local os = _ejoysdk.os()
  if "android" == os then
    E.sync_call(SYNC_WEBVIEW_OPERATOR, {type = ACT_WEBVIEW_UPDATE_TOOLBAR, data = toolbar_config})
  elseif "ios" == os then
    local toolbarOptionString
    local parmas = {type = ACT_WEBVIEW_UPDATE_TOOLBAR, data = toolbar_config}
    if toolbar_config then
      local succ, msg = pcall(JSON.encode, parmas)
      if succ then
        toolbarOptionString = msg or "{}"
        E.sync_call("webview_operator", toolbarOptionString)
      end
    end
  end
end

function M.update_toolbar_item(params)
  if current_show_webview and params then
    local option = current_show_webview.option or {}
    if option.enable_toolbar and option.toolbar then
      EWT.update_toolbar_with_type(option.toolbar, params)
      M.update_toolbar(option.toolbar)
    end
  end
end

return M
