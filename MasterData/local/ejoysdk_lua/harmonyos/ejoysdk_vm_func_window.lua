local E = require("ejoysdk_lua.ejoysdk")
local Class = require("ejoysdk_lua.ejoysdk_class")
local EC = require("ejoysdk_lua.ejoysdk_constants")
local jf = lunate.js_functions
local DIS = lunate.import("@ohos.display")
local M = Class:Inherit("EjoyWindow")
local TAG = "HarmonyWindow"
local static_window_index = 1
M.ALIGN = {CENTER = "center"}

function M:_init()
  self._data = {
    window = nil,
    last_position = {
      align = nil,
      x = 0,
      y = 0
    },
    display_change_listener = function()
      self:_on_display_change()
    end
  }
end

function M:get_frame_sync()
  local frame = {}
  if not self._data.window then
    return frame
  else
    local ok, properties = pcall(self._data.window.getWindowProperties)
    if not ok or not properties then
      E.LOG.warn(TAG, "get_frame failed")
    else
      local rect = properties.windowRect
      frame.x = rect.left
      frame.y = rect.top
      frame.width = rect.width
      frame.height = rect.height
    end
    return frame
  end
end

function M:_check_safe_frame_before_update(x, y, width, height)
  local win_current_frame = self:get_frame_sync()
  local win_width = win_current_frame.width
  local win_height = win_current_frame.height
  local win_x = win_current_frame.x
  local win_y = win_current_frame.y
  local display_info = DIS.getDefaultDisplaySync()
  local screen_width = display_info.width
  local screen_height = display_info.height
  x = x or win_x
  y = y or win_y
  if not width then
    width = win_width
  elseif width < 0 then
    width = screen_width
  end
  if not height then
    height = win_height
  elseif height < 0 then
    height = screen_height
  end
  local max_width = screen_width - width
  local max_height = screen_height - height
  local ret_width = screen_width < width and screen_width or width
  local ret_height = screen_height < height and screen_height or height
  local ret_x = x > max_width and max_width or x
  local ret_y = y > max_height and max_height or y
  ret_x = ret_x < 0 and 0 or ret_x
  ret_y = ret_y < 0 and 0 or ret_y
  return ret_x, ret_y, ret_width, ret_height
end

function M:update_size(width, height)
  if not self._data.window then
    E.LOG.warn(TAG, "update_size failed, window is invalid")
    return false
  end
  local win_current_frame = self:get_frame_sync()
  local win_width = win_current_frame.width
  local win_height = win_current_frame.height
  local _x, _y, _width, _height = self:_check_safe_frame_before_update(nil, nil, width, height)
  local changed = win_width ~= _width or win_height ~= _height
  E.LOG.debug(TAG, "update_size width:" .. tostring(_width) .. ", height:" .. tostring(_height))
  self._data.window.resize(_width, _height)
  return changed, _x, _y, _width, _height
end

function M:reposition(x, y)
  if not self._data.window then
    E.LOG.warn(TAG, "reposition failed, window is invalid")
    return
  end
  local _x, _y, _width, _height = self:_check_safe_frame_before_update(x, y)
  E.LOG.debug(TAG, "reposition x:" .. tostring(_x) .. ", y:" .. tostring(_y))
  self._data.window.moveWindowTo(_x, _y)
  local position_changed = _x ~= self._data.last_position.x or _y ~= self._data.last_position.y
  self._data.last_position.x = _x
  self._data.last_position.y = _y
  return position_changed, _x, _y, _width, _height
end

function M:_on_display_change()
  E.LOG.debug(TAG, "on_display_change received")
  local win_current_frame = self:get_frame_sync()
  local last_win_x = self._data.last_position.x
  local last_win_y = self._data.last_position.y
  local pos_obj = self:parse_pos_with_align(self._data.last_position.align, win_current_frame.width, win_current_frame.height)
  if pos_obj then
    last_win_x = pos_obj.x
    last_win_y = pos_obj.y
  end
  self:reposition(last_win_x, last_win_y)
end

function M:window_destory()
  if not self._data.window then
    E.LOG.warn(TAG, "destory skip for m_float_browser_window is nil")
    return
  end
  self._data.window.destroyWindow()
  self._data.window = nil
  DIS.off("change", self._data.display_change_listener)
end

local function get_default_window_name()
  local win_name = "default_window_name#" .. tostring(static_window_index)
  static_window_index = static_window_index + 1
  return win_name
end

function M:parse_pos_with_align(align, width, height)
  local display_info = DIS.getDefaultDisplaySync()
  local screen_width = display_info.width
  local screen_height = display_info.height
  local pos_obj
  if align == M.ALIGN.CENTER then
    pos_obj = {}
    local center_screen_with = screen_width / 2
    local center_screen_height = screen_height / 2
    local center_win_width = width / 2
    local center_win_height = height / 2
    pos_obj.x = center_screen_with - center_win_width
    pos_obj.y = center_screen_height - center_win_height
  end
  return pos_obj
end

function M:create_window(params, cb)
  local window_stage = jf.EjoySDK():getWindowStage()
  if not window_stage then
    E.LOG.warn(TAG, "create floater failed, window_stage is nil")
    cb(false, EC.EJOYSDK_ERROR_CODES.WINDOW_STAGE_INVALID, "window stage invalid")
    return
  end
  self:window_destory()
  local window_name = params.window_name or get_default_window_name()
  E.LOG.debug(TAG, "create_window widowName:" .. tostring(window_name))
  window_stage.createSubWindow(window_name, function(err, sub_window)
    if err and err.code > 0 then
      E.LOG.warn(TAG, "createSubWindow failed:" .. tostring(err.code) .. ", msg:" .. tostring(err.message))
      cb(false, err.code, err.message)
    else
      self._data.window = sub_window
      local size_obj = params.size
      if size_obj and size_obj.width and size_obj.height then
        self:update_size(size_obj.width, size_obj.height)
      end
      local pos_obj = params.pos
      if not pos_obj and params.align and size_obj then
        self._data.last_position.align = params.align
        pos_obj = self:parse_pos_with_align(params.align, size_obj.width, size_obj.height)
      end
      if pos_obj and pos_obj.x and pos_obj.y then
        self:reposition(pos_obj.x, pos_obj.y)
      end
      DIS.on("change", self._data.display_change_listener)
      cb(true, sub_window)
    end
  end)
end

function M:create(params, cb)
  if not params then
    E.LOG.warn(TAG, "create failed for params is invalid")
    cb(false, EC.EJOYSDK_ERROR_CODES.PARAMS_INVALID, "show window failed params invalid")
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
  
  self:create_window(params, cb_wrapper)
end

function M:show()
  if not self._data.window then
    E.LOG.warn(TAG, "window not exists, skip show")
    return false
  end
  self._data.window.showWindow()
  return true
end

function M:hide()
  if not self._data.window then
    E.LOG.warn(TAG, "window not exists, skip hide")
    return
  end
  self._data.window.minimize()
end

function M:minimize()
  if not self._data.window then
    E.LOG.warn(TAG, "window not exists, skip hide")
    return false
  end
  self._data.window.minimize()
  return true
end

function M:resize(params)
  if not (params and params.width) or not params.height then
    E.LOG.warn(TAG, "resize failed, params width or height is invalid")
    return false
  end
  self:update_size(params.width, params.height)
  return true
end

function M:position(params)
  if not (params and params.x) or not params.y then
    E.LOG.warn(TAG, "position failed, params x or y is invalid")
    return false
  end
  self:reposition(params.x, params.y)
end

function M:destroy()
  self:window_destory()
end

function M:get_frame(cb)
  local frame = self:get_frame_sync()
  if cb then
    cb(frame)
  end
end

function M:set_frame(params)
  self:resize(params)
  self:position(params)
end

function M:get_window()
  return self._data.window
end

return M
