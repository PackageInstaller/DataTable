local E = require("ejoysdk_lua.ejoysdk")
local EC = require("ejoysdk_lua.ejoysdk_constants")
local JSON = require("ejoysdk_lua.ejoysdk_json")
local Win = require("ejoysdk_lua.harmonyos.ejoysdk_vm_func_window")
local jf = lunate.js_functions
local M = {}
local TAG = "FloatBrowserOpener"
local Action = {
  CREATE = 1,
  SHOW = 2,
  HIDE = 3,
  DESTROY = 4,
  OPEN_URL = 5,
  RELOAD = 6,
  SIZE = 7,
  POSITION = 8,
  DRAGGABLE = 9,
  CALL_JS = 10,
  FRAME = 11,
  SET_FRAME = 12
}
local EVENT = {
  EVENT_SHOW = 101,
  EVENT_HIDE = 102,
  EVENT_CLOSE = 103,
  EVENT_SIZE_CHANGED = 104,
  EVENT_POSITION_CHANGED = 105,
  EVENT_CLICK = 201,
  EVENT_PAGE_START = 301,
  EVENT_PAGE_FINISH = 302
}
local WEB_PAGE_LIFECYCLE = {
  ON_PAGE_START = 0,
  ON_PAGE_FINISH = 1,
  ON_PAGE_ERROR = 2,
  ON_PAGE_CLOSE = 3
}
local EJOY_FLOATER_EVENT = "EJOY_FLOATER_EVENT"
local m_float_browser_window, m_webpage
local m_draggable = true
local m_webview_controller
local m_event_callbacks = {}
local m_inject_js, m_url
local m_drag_info = {
  move_start_x = nil,
  move_start_y = nil,
  move_offset_x = nil,
  move_offset_y = nil,
  win_position_x = nil,
  win_position_y = nil
}

local function on_drag_begin(x, y)
  m_drag_info = {}
  m_drag_info.move_start_x = x
  m_drag_info.move_start_y = y
  local win_current_frame = m_float_browser_window:get_frame_sync()
  m_drag_info.win_position_x = win_current_frame.x
  m_drag_info.win_position_y = win_current_frame.y
end

local function on_drag_move(x, y)
  if not m_draggable then
    return
  end
  m_drag_info.move_offset_x = x - m_drag_info.move_start_x
  m_drag_info.move_offset_y = y - m_drag_info.move_start_y
  if not m_drag_info.win_position_x then
    return
  end
  local to_x = m_drag_info.win_position_x + m_drag_info.move_offset_x
  local to_y = m_drag_info.win_position_y + m_drag_info.move_offset_y
  M.position({x = to_x, y = to_y})
end

local function callback_event(event_id, message)
  local cb = m_event_callbacks[EJOY_FLOATER_EVENT]
  if not cb then
    E.LOG.warn(TAG, "callback_event skip, no cb for EJOY_FLOATER_EVENT")
    return
  end
  E.LOG.debug(TAG, "callback_event event_id:" .. tostring(event_id) .. ", message:" .. tostring(JSON.encode(message)))
  cb(event_id, message or {})
end

local function on_close_window()
  E.LOG.debug(TAG, "on_close_window received")
  M.destroy()
end

local function on_click_window()
  E.LOG.debug(TAG, "onclick event received")
  callback_event(EVENT.EVENT_CLICK)
end

local function on_drag_end(x, y)
  m_drag_info = {}
  E.LOG.debug(TAG, "on_drag_end x:" .. tostring(x) .. ", y:" .. tostring(y))
end

function M.call(action, params, cb)
  if action == Action.CREATE then
    E.LOG.debug(TAG, "call received create")
    E.log(params)
    M.create(params, cb)
  elseif action == Action.SHOW then
    E.LOG.debug(TAG, "call received show")
    M.show()
  elseif action == Action.HIDE then
    E.LOG.debug(TAG, "call received hide")
    M.hide()
  elseif action == Action.OPEN_URL then
    E.LOG.debug(TAG, "call received open url")
    M.open_url(params)
  elseif action == Action.RELOAD then
    E.LOG.debug(TAG, "call received reload")
    M.reload()
  elseif action == Action.SIZE then
    E.LOG.debug(TAG, "call received resize")
    M.resize(params)
  elseif action == Action.POSITION then
    E.LOG.debug(TAG, "call received position")
    M.position(params)
  elseif action == Action.DESTROY then
    E.LOG.debug(TAG, "call received destroy")
    M.destroy()
  elseif action == Action.DRAGGABLE then
    E.LOG.debug(TAG, "call received dragable")
    M.set_draggable(params)
  elseif action == Action.FRAME then
    E.LOG.debug(TAG, "call received get frame")
    M.get_frame(cb)
  elseif action == Action.SET_FRAME then
    E.LOG.debug(TAG, "call received set frame")
    M.set_frame(params)
  elseif action == Action.CALL_JS then
    E.LOG.debug(TAG, "call received call js")
    M.call_js(params, cb)
  end
end

local function get_subwindow_name(window_type)
  return "floater_browser#" .. tostring(window_type)
end

local function import_webpage(cb)
  if m_webpage then
    cb(m_webpage)
    return
  end
  if not jf.import_path then
    cb(nil, EC.BASE_API_COMMON_ERROR.CODE_NOT_SUPPORT, "import_path not support")
    return
  end
  E.LOG.debug(TAG, "begin load webview")
  jf.import_path("./pages/EjoyDraggableWebPage", function(succ, ret)
    if succ then
      m_webpage = "EjoyDraggableWebPage"
      local ns_module = ret.ns
      ns_module.setOnDraggableListener({
        onDragBegin = on_drag_begin,
        onDragMove = on_drag_move,
        onDragEnd = on_drag_end
      })
      ns_module.setNavListener({onClose = on_close_window, onClick = on_click_window})
      ns_module.setWebviewListener({
        onJsArgsEvent = function(_value)
          E.LOG.debug(TAG, "onJsArgsEvent received")
        end,
        onCloseEvent = function(_value)
          E.LOG.debug(TAG, "onCloseEvent received")
        end,
        onUrlRedirectEvent = function(_value)
          E.LOG.debug(TAG, "onUrlRedirectEvent received")
        end,
        onLifeCycleEvent = function(_value)
          E.LOG.debug(TAG, "onLifeCycleEvent received:" .. tostring(_value.type))
          if _value.type == WEB_PAGE_LIFECYCLE.ON_PAGE_FINISH then
            M.call_js({script = m_inject_js})
            E.LOG.debug(TAG, "page load finish:" .. tostring(m_url))
            callback_event(EVENT.EVENT_PAGE_FINISH, {succ = true, url = m_url})
          elseif _value.type == WEB_PAGE_LIFECYCLE.ON_PAGE_START then
            E.LOG.debug(TAG, "page load start:" .. tostring(m_url))
            callback_event(EVENT.EVENT_PAGE_START, {url = m_url})
          end
        end
      })
      cb(m_webpage)
    else
      local code = ret.code
      local msg = ret.message
      E.LOG.warn(TAG, "importWebviewPage failed, code:" .. tostring(code) .. ", msg:" .. tostring(msg))
      cb(nil, code, msg)
    end
  end)
end

local function floater_set_dragable(draggable)
  m_draggable = draggable
end

local function parse_injections(injection)
  if not injection then
    E.LOG.warn(TAG, "parse_injections failed, injection is nil or empty")
    return {}
  end
  local injection_obj = injection
  if not injection_obj then
    E.LOG.warn(TAG, "parse_injections failed, injection not a valid json string")
    return {}
  end
  local host_common_data = injection_obj.host_common_data
  if not host_common_data then
    return injection_obj
  end
  for _k, v in pairs(injection_obj) do
    local startup_data = v.startupData
    if startup_data then
      for ck, cv in pairs(host_common_data) do
        startup_data[ck] = cv
      end
    end
  end
  return injection_obj
end

local function parse_options(options)
  if not options then
    E.LOG.warn(TAG, "parse_options failed, options is nil or empty")
    return {}
  end
  local options_obj = options
  if not options_obj then
    E.LOG.warn(TAG, "parse_options failed, options not a valid json string")
    return {}
  end
  return options_obj
end

local function floater_load_url(params)
  local ctr_params = params.params
  local options = {}
  local injection = {}
  local inject_js = ""
  local dragable = false
  if ctr_params then
    inject_js = ctr_params.injectJS or ""
    dragable = ctr_params.draggable or false
    injection = ctr_params.injection or {}
    options = ctr_params.options or {}
  end
  m_inject_js = inject_js
  m_url = params.url
  floater_set_dragable(dragable)
  local injection_obj = parse_injections(injection)
  local options_obj = parse_options(options)
  m_webview_controller = jf.webview():createWebviewController()
  local web_info = {
    EjoyWebViewPage_WebViewInfo = {
      url = m_url,
      injection = JSON.encode(injection_obj),
      option = JSON.encode(options_obj),
      webViewId = E.Sysinfo.uuid(),
      controller = m_webview_controller
    }
  }
  local local_storage = jf.webview():toLocalStorage(web_info)
  local window = m_float_browser_window:get_window()
  if window then
    window.loadContentByName(m_webpage, local_storage, function(_err)
      if _err and _err.code > 0 then
        E.LOG.warn(TAG, "loadContentByName failed, code:" .. tostring(_err.code) .. ",  msg:" .. tostring(_err.message))
      else
        E.LOG.debug(TAG, "loadContentByName succ")
      end
    end)
  else
    E.LOG.warn(TAG, "floater_load_url failed, window is nil")
  end
end

local function create_webpage_window(params, cb)
  params.window_name = params.window_name or get_subwindow_name()
  if not m_float_browser_window then
    m_float_browser_window = Win:New("EjoyFloater")
  end
  m_float_browser_window:create(params, function(succ, ...)
    if succ then
      E.LOG.debug(TAG, "create window succ, now begin load url")
      floater_load_url(params)
      cb(true)
    else
      local code, msg = ...
      E.LOG.warn(TAG, "show_webpage_window failed:" .. tostring(code) .. ", msg:" .. tostring(msg))
      cb(false, code, msg)
    end
  end)
end

function M.create(params, cb)
  if not params or params.url == nil or params.url == "" then
    E.LOG.warn(TAG, "create failed for params is invalid")
    if cb then
      cb(false, EC.EJOYSDK_ERROR_CODES.PARAMS_INVALID, "show window failed params invalid")
    end
    return
  end
  
  local function cb_wrapper(succ, ...)
    if succ then
      E.LOG.debug(TAG, "create succ")
    else
      local _code, _msg = ...
      E.LOG.warn(TAG, "create failed, code:" .. tostring(_code) .. ",  msg:" .. tostring(_msg))
    end
    if cb then
      cb(succ, ...)
    end
  end
  
  import_webpage(function(webpage, ...)
    if webpage then
      E.LOG.debug(TAG, "import_webpage succ, now begin create window and show")
      create_webpage_window(params, cb_wrapper)
    else
      local _code, _msg = ...
      E.LOG.warn(TAG, "import_webpage failed, code:" .. tostring(_code) .. ", msg:" .. tostring(_msg))
      cb_wrapper(false, _code, _msg)
    end
  end)
end

function M.show()
  if not m_float_browser_window then
    E.LOG.warn(TAG, "window not exists, skip show")
    return
  end
  local show_result = m_float_browser_window:show()
  if show_result then
    callback_event(EVENT.EVENT_SHOW)
  end
end

function M.hide()
  if not m_float_browser_window then
    E.LOG.warn(TAG, "window not exists, skip hide")
    return
  end
  local ret = m_float_browser_window:minimize()
  if ret then
    callback_event(EVENT.EVENT_HIDE)
  end
end

function M.minimize()
  if not m_float_browser_window then
    E.LOG.warn(TAG, "window not exists, skip hide")
    return
  end
  m_float_browser_window:minimize()
end

function M.open_url(params)
  if not m_webview_controller then
    E.LOG.warn(TAG, "open_url failed, controller not exists")
    return
  end
  local url = params and params.url
  if not url then
    E.LOG.warn(TAG, "open url failed, url is nil")
    return
  end
  m_webview_controller.loadUrl(url)
end

function M.reload()
  if not m_webview_controller then
    E.LOG.warn(TAG, "reload failed, controller not exists")
    return
  end
  E.LOG.debug(TAG, "reload begin")
  m_webview_controller.refresh()
end

function M.resize(params)
  if not (m_float_browser_window and params and params.width) or not params.height then
    E.LOG.warn(TAG, "resize failed, params width or height is invalid")
    return false
  end
  local changed, _x, _y, _width, _height = m_float_browser_window:update_size(params.width, params.height)
  if changed then
    callback_event(EVENT.EVENT_SIZE_CHANGED, {
      x = _x,
      y = _y,
      width = _width,
      height = _height
    })
  end
  return changed
end

function M.position(params)
  if not (m_float_browser_window and params and params.x) or not params.y then
    E.LOG.warn(TAG, "position failed, params x or y is invalid")
    return false
  end
  local position_changed, x, y, w, h = m_float_browser_window:reposition(params.x, params.y)
  if position_changed then
    callback_event(EVENT.EVENT_POSITION_CHANGED, {
      x = x,
      y = y,
      width = w,
      height = h
    })
  end
end

function M.destroy()
  if not m_float_browser_window then
    E.LOG.debug(TAG, "destroy skip for window not exists")
    return
  end
  m_float_browser_window:destroy()
  m_float_browser_window = nil
  m_webview_controller = nil
  callback_event(EVENT.EVENT_CLOSE)
end

function M.set_draggable(params)
  if not m_float_browser_window or not params then
    E.LOG.warn(TAG, "set_dragable skip for window is not exists or params is nil")
    return
  end
  local _dragable = params.draggable or false
  E.LOG.debug(TAG, "set_dragable:" .. tostring(_dragable))
  m_draggable = _dragable
end

function M.get_frame(cb)
  local function cb_wrapper(frame_data)
    if cb then
      cb(frame_data)
    end
  end
  
  if not m_float_browser_window then
    cb_wrapper({})
    return
  end
  local frame = m_float_browser_window:get_frame_sync()
  cb_wrapper(frame)
end

function M.set_frame(params)
  if not m_float_browser_window then
    E.LOG.debug(TAG, "set_frame skip for window not exits")
    return
  end
  M.resize(params)
  M.position(params)
end

function M.call_js(params, cb)
  local function cb_wrapper(call_result, ...)
    if cb then
      cb(call_result, ...)
    end
  end
  
  if not m_float_browser_window then
    E.LOG.warn(TAG, "call_js skip for window not exists")
    cb_wrapper(nil, EC.EJOYSDK_ERROR_CODES.WINDOW_NOT_EXISTS, "window not exists")
    return
  end
  if not m_webview_controller then
    E.LOG.warn(TAG, "call_js skip for m_webview_controller is nil")
    cb_wrapper(nil, EC.EJOYSDK_ERROR_CODES.WEBCONTROLLER_IS_NIL, "web controller is nil")
    return
  end
  local _script = params and params.script
  if not _script then
    E.LOG.warn(TAG, "call_js skip for script is invalid")
    cb_wrapper(nil, EC.EJOYSDK_ERROR_CODES.PARAMS_INVALID, "script is nil")
    return
  end
  E.LOG.debug(TAG, "call_js javascript:" .. tostring(_script))
  m_webview_controller.runJavaScript(_script):Then(function(result_data)
    E.LOG.debug(TAG, "call_js javascript result:")
    E.log(result_data)
    local _ret = {result = result_data}
    cb_wrapper(_ret)
  end):catch(function(err)
    E.LOG.warn(TAG, "call_js failed, code:" .. tostring(err.code) .. ", msg:" .. tostring(err.message))
    cb_wrapper(nil, err.code, err.message)
  end)
end

function M.set_event_callback(event_name, cb)
  if not event_name then
    E.LOG.warn(TAG, "set_event_callback skip, for event name is nil")
    return
  end
  m_event_callbacks[event_name] = cb
end

return M
