local E = require("ejoysdk_lua.ejoysdk")
local JSON = require("ejoysdk_lua.ejoysdk_json")
local compat = require("ejoysdk_lua.compat.ejoysdk_compat")
local JSBridge = require("ejoysdk_lua.ejoysdk_js_bridge")
local bitutil = compat.bitutil
local Floater = {}
Floater.Action = {
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
Floater.Event = {
  SHOW = 101,
  HIDE = 102,
  CLOSE = 103,
  CHANGED_SIZE = 104,
  CHANGED_POSITION = 105,
  CLICK = 201,
  PAGE_LOAD_START = 301,
  PAGE_LOAD_FINISHED = 302
}
Floater.FrameType = {
  FIXED = 1,
  PCT = bitutil.lshift(1, 1),
  ALIGN = bitutil.lshift(1, 2)
}
Floater.FrameAlign = {
  LEFT = 1,
  TOP = bitutil.lshift(1, 1),
  RIGHT = bitutil.lshift(1, 2),
  BOTTOM = bitutil.lshift(1, 3),
  CENTER = bitutil.lshift(1, 4)
}
local TAG = "Floater"
local OPERATOR = "FLOATER"
local event_callback
local adjust_size = false
local auto_scaling = false
local EJOY_FLOATER_EVENT = "EJOY_FLOATER_EVENT"

local function on_floater_event(event_id, params, _chunk)
  if not event_callback then
    return
  end
  local f_event_callback = event_callback[event_id]
  if f_event_callback and type(f_event_callback) == "function" then
    f_event_callback(params)
  end
end

_ejoysdk.register_cb(EJOY_FLOATER_EVENT, on_floater_event)

local function call(async, action, params, cb)
  params = params or {}
  params.action = action
  local os = _ejoysdk.os()
  if true == async then
    if "android" == os then
      E.async_call(OPERATOR, params, nil, cb)
    elseif "ios" == os or "windows" == os then
      E.async_call(OPERATOR, cb, JSON.encode(params))
    elseif "harmonyos" == os then
      local CM = require("ejoysdk_lua.vm_channel.ejoy_vm_manager")
      local _floater = CM.cross_vm_require(CM.LUA_VM.EJOY, "ejoysdk_lua.harmonyos.ejoysdk_vm_func_floater")
      _floater.call(action, params, cb)
    end
  elseif "android" == os then
    do return E.sync_call, OPERATOR end
    return E.sync_call, OPERATOR, params, action, params, cb
  elseif "ios" == os or "windows" == os then
    do return E.sync_call, OPERATOR, -1, JSON.encode(params) end
    return E.sync_call, OPERATOR, -1, JSON.encode(params)
  end
end

local function adjustSize(is_pixel, x, y, width, height)
  x = x or 0
  y = y or 0
  width = width or 0
  height = height or 0
  if _ejoysdk.os() == "ios" then
    local screen_size = E.Sysinfo.screen()
    local scale = screen_size.scale
    local offset = 0.5
    if is_pixel then
      x = math.floor(x / scale + offset)
      y = math.floor(y / scale + offset)
      width = math.floor(width / scale + offset)
      height = math.floor(height / scale + offset)
    else
      x = math.floor(x * scale + offset)
      y = math.floor(y * scale + offset)
      width = math.floor(width * scale + offset)
      height = math.floor(height * scale + offset)
    end
  end
  return x, y, width, height
end

local function get_screen_size()
  if E.Sysinfo.screen then
    local screen_data = E.Sysinfo.screen() or {}
    local sw = screen_data.width or 0
    local sh = screen_data.height or 0
    local os = _ejoysdk.os()
    local sxlen = sw
    local sylen = sh
    if "android" == os then
      local is_portrait = screen_data.is_portrait
      if is_portrait then
        sylen = math.max(sw, sh)
        sxlen = math.min(sw, sh)
      else
        sxlen = math.max(sw, sh)
        sylen = math.min(sw, sh)
      end
    elseif "windows" == os then
      local window_height = screen_data.window_height or -1
      local window_width = screen_data.window_width or -1
      if window_height > 0 and window_width > 0 then
        sxlen = math.max(window_width, window_height)
        sylen = math.min(window_width, window_height)
      else
        sxlen = 0
        sylen = 0
      end
    elseif "ios" == os then
      local _x, _y
      _x, _y, sxlen, sylen = adjustSize(false, nil, nil, sw, sh)
    end
    return sxlen, sylen
  end
  return 0, 0
end

local function adjustToPoint(x, y, width, height)
  if true == adjust_size then
    do return adjustSize, true, x, y, width end
    return adjustSize, true, x, y, width, height
  else
    return x, y, width, height
  end
end

local function adjustToPixel(x, y, width, height)
  if true == adjust_size then
    do return adjustSize, false, x, y, width end
    return adjustSize, false, x, y, width, height
  else
    return x, y, width, height
  end
end

local function adjustToRelative(base, target)
  local base_width, base_height = base.width, base.height
  local x, y, width, height = target.x, target.y, target.width, target.height
  local offset = 0.5
  x = math.floor(x * base_width + offset)
  y = math.floor(y * base_height + offset)
  width = math.floor(width * base_width + offset)
  height = math.floor(height * base_height + offset)
  return x, y, width, height
end

local function adjustToWindow(x, y, width, height)
  x = x or 0
  y = y or 0
  width = width or 0
  height = height or 0
  local screen_width, screen_height = get_screen_size()
  if screen_width > 0 and screen_height > 0 then
    do return adjustToRelative, {width = screen_width, height = screen_height} end
    return adjustToRelative, {width = screen_width, height = screen_height}, {
      x = x,
      y = y,
      width = width,
      height = height
    }, nil
  end
  return x, y, width, height
end

local function adjustAlign(align_info, frame, is_fixed)
  local align_type = (align_info or {}).type or 0
  local align_padding = (align_info or {}).padding or {}
  local x, y, width, height = frame.x or 0, frame.y or 0, frame.width or 0, frame.height or 0
  local p_l, p_t, p_r, p_b = align_padding.left or 0, align_padding.top or 0, align_padding.right or 0, align_padding.bottom or 0
  local screen_max_width, screen_max_height = 1, 1
  if false == is_fixed then
    screen_max_width, screen_max_height = get_screen_size()
  end
  if bitutil.band(align_type or 0, Floater.FrameAlign.CENTER) > 0 then
    x = (screen_max_width - width) / 2
    y = (screen_max_height - height) / 2
  else
    if bitutil.band(align_type or 0, Floater.FrameAlign.LEFT) > 0 then
      x = p_l
    elseif bitutil.band(align_type or 0, Floater.FrameAlign.RIGHT) > 0 then
      x = screen_max_width - p_r - width
    end
    if bitutil.band(align_type or 0, Floater.FrameAlign.TOP) > 0 then
      y = p_t
    elseif bitutil.band(align_type or 0, Floater.FrameAlign.BOTTOM) > 0 then
      y = screen_max_height - p_b - height
    end
  end
  return x, y, width, height
end

function Floater.async_call(action, params, cb)
  call(true, action, params, cb)
end

function Floater.sync_call(action, params)
  do return call, false, action end
  return call, false, action, params
end

function Floater.create(url, frame, params, cb)
  params = params or {}
  E.log(params)
  params.injection = params.injection or {}
  local LIGHTBOAT = require("ejoysdk_lua.res.lightboat.ejoysdk_lightboat")
  local local_url = LIGHTBOAT.get_url_from_cache(url)
  if local_url and local_url ~= url then
    local clipping_url = E.Utils.url_clipping(local_url)
    local EWB = require("ejoysdk_lua.ejoysdk_webview_manager")
    EWB._inject_data_local_path(url, clipping_url, params.injection)
    url = local_url
    E.LOG.debug(TAG, "floater create local url:" .. tostring(url))
  end
  E.LOG.debug(TAG, "floater create final url:" .. tostring(url))
  local host_object = E.HTTP.parse(url)
  if host_object and host_object.host then
    local end_host = string.match(host_object.host, "^[%w%-]+(.*)")
    end_host = end_host or host_object.host
    params.injection[end_host] = {transparent = true}
  end
  local WU = require("ejoysdk_lua.ejoysdk_web")
  WU.fill_injection_with_common_params(params.injection, {})
  frame = frame or {}
  adjust_size = false
  auto_scaling = bitutil.band(params.frame_type or 0, Floater.FrameType.PCT) > 0
  if params.adjust_size ~= nil then
    adjust_size = params.adjust_size
  end
  local type = params.window_type or "DEFAULT"
  local x, y, width, height = frame.x or 0, frame.y or 0, frame.width or 0, frame.height or 0
  if bitutil.band(params.frame_type or 0, Floater.FrameType.ALIGN) > 0 then
    x, y, width, height = adjustAlign(params.align_info, frame, auto_scaling)
  end
  if auto_scaling then
    x, y, width, height = adjustToWindow(x, y, width, height)
    if params.drag_padding then
      params.drag_padding.left, params.drag_padding.top, params.drag_padding.right, params.drag_padding.bottom = adjustToRelative({width = width, height = height}, {
        x = params.drag_padding.left,
        y = params.drag_padding.top,
        width = params.drag_padding.right,
        height = params.drag_padding.bottom
      })
    end
  end
  x, y, width, height = adjustToPoint(x, y, width, height)
  local size = {width = width, height = height}
  if params.use_center_per then
    local center_x_per = params.center_x_per or 50
    local center_y_per = params.center_y_per or 50
    if E.Sysinfo.screen then
      local screen_data = E.Sysinfo.screen() or {}
      local sw = screen_data.width or 0
      local sh = screen_data.height or 0
      local os = _ejoysdk.os()
      local sxlen = sw
      local sylen = sh
      if "android" == os then
        local is_portrait = screen_data.is_portrait
        if is_portrait then
          sylen = math.max(sw, sh)
          sxlen = math.min(sw, sh)
        else
          sxlen = math.max(sw, sh)
          sylen = math.min(sw, sh)
        end
      elseif "windows" == os then
        local window_height = screen_data.window_height or -1
        local window_width = screen_data.window_width or -1
        if window_height > 0 and window_width > 0 then
          sxlen = math.max(window_width, window_height)
          sylen = math.min(window_width, window_height)
        else
          sxlen = 0
          sylen = 0
        end
      end
      E.LOG.debug("Floater", "sxlen :" .. tostring(sxlen) .. ", sylen :" .. tostring(sylen))
      if sxlen > 0 and sylen > 0 then
        x = math.floor(sxlen * center_x_per / 100 - width / 2)
        y = math.floor(sylen * center_y_per / 100 - height / 2)
      end
    end
  end
  if params.create_type == "webview" then
    if not params.options then
      params.options = {
        enable_loading = true,
        hide_close_btn = false,
        disable_auto_fontsize = true
      }
    end
  else
    if not params.options then
      params.options = {enable_loading = false, hide_close_btn = true}
    end
    params.options.hide_close_btn = true
  end
  local position = {x = x, y = y}
  event_callback = params.callbacks or {}
  if _ejoysdk.os() == "harmonyos" then
    local CM = require("ejoysdk_lua.vm_channel.ejoy_vm_manager")
    local _floater = CM.cross_vm_require(CM.LUA_VM.EJOY, "ejoysdk_lua.harmonyos.ejoysdk_vm_func_floater")
    _floater.set_event_callback(EJOY_FLOATER_EVENT, function(event_id, message)
      E.LOG.debug(TAG, "EJOY_FLOATER_EVENT received for harmony")
      on_floater_event(event_id, message)
    end)
  end
  params.window_type = nil
  params.callbacks = nil
  JSBridge.init()
  Floater.async_call(Floater.Action.CREATE, {
    url = url or "",
    window_type = type,
    size = size,
    pos = position,
    params = params
  }, cb)
end

function Floater.show()
  Floater.async_call(Floater.Action.SHOW)
end

function Floater.hide()
  Floater.async_call(Floater.Action.HIDE)
end

function Floater.minimize()
  local _os = _ejoysdk.os()
  if "harmonyos" == _os then
    Floater.async_call(Floater.Action.HIDE)
  else
    Floater.resize(1, 1, false)
    Floater.reposition(0, 0, false)
  end
end

function Floater.destroy()
  Floater.async_call(Floater.Action.DESTROY)
end

function Floater.get_frame()
  local os = _ejoysdk.os()
  local get_frame_data = Floater.sync_call(Floater.Action.FRAME)
  if "ios" == os or "windows" == os then
    local ret_json = JSON.safe_decode(get_frame_data) or {
      x = 0,
      y = 0,
      width = 0,
      height = 0
    }
    local x, y, width, height = adjustToPixel(ret_json.x or 0, ret_json.y or 0, ret_json.width or 0, ret_json.height or 0)
    get_frame_data = {
      x = x,
      y = y,
      width = width,
      height = height
    }
  end
  return get_frame_data
end

function Floater.get_frame_async(cb)
  if not cb then
    return
  end
  local get_frame_data
  local os = _ejoysdk.os()
  if "harmonyos" == os then
    Floater.async_call(Floater.Action.FRAME, nil, function(frame_data)
      get_frame_data = frame_data
      cb(get_frame_data)
    end)
  else
    get_frame_data = Floater.get_frame()
    cb(get_frame_data)
  end
end

function Floater.set_frame(x, y, width, height, should_scaling)
  if x and y and width and height and width >= 0 and height >= 0 then
    if true == auto_scaling and false ~= should_scaling then
      x, y, width, height = adjustToWindow(x, y, width, height)
    end
    x, y, width, height = adjustToPoint(x, y, width, height)
    Floater.async_call(Floater.Action.SET_FRAME, {
      x = x,
      y = y,
      width = width,
      height = height
    })
  end
end

function Floater.resize(width, height, should_scaling)
  if width and height and width >= 0 and height >= 0 then
    local _x, _y, w, h = nil, nil, width, height
    if true == auto_scaling and false ~= should_scaling then
      _x, _y, w, h = adjustToWindow(_x, _y, w, h)
    end
    _x, _y, w, h = adjustToPoint(_x, _y, w, h)
    Floater.async_call(Floater.Action.SIZE, {width = w, height = h})
  end
end

function Floater.reposition(x, y, should_scaling)
  if x and y then
    if true == auto_scaling and false ~= should_scaling then
      x, y = adjustToWindow(x, y)
    end
    x, y = adjustToPoint(x, y)
    Floater.async_call(Floater.Action.POSITION, {x = x, y = y})
  end
end

function Floater.open_url(url)
  Floater.async_call(Floater.Action.OPEN_URL, {url = url})
end

function Floater.reload()
  Floater.async_call(Floater.Action.RELOAD)
end

function Floater.set_draggable(able)
  Floater.async_call(Floater.Action.DRAGGABLE, {
    draggable = able or false
  })
end

function Floater.call_js(js_str, cb)
  Floater.async_call(Floater.Action.CALL_JS, {
    script = js_str or ""
  }, cb)
end

return Floater
