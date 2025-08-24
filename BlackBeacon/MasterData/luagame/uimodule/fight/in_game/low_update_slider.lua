local M = Util.create_class()
local UPDATE_FRAME_INTERVAL = 5

function M:_init(unity_slider, init_value, update_frame_interval, lua_obj)
  self.v_update_frame_interval = update_frame_interval or UPDATE_FRAME_INTERVAL
  assert(unity_slider)
  self.v_slider = unity_slider
  self.v_slider_go = unity_slider.gameObject
  self.v_lua_obj = lua_obj
  local cur_frame = Global.frame_id
  self.v_cur_frame = cur_frame
  self.v_last_update_frame_id = cur_frame
  init_value = init_value or 0
  self:force_set_value(init_value)
end

function M:on_destroy()
  self.v_slider = nil
  self.v_slider_go = nil
end

function M:update()
  if self.v_cur_val == self.v_cache_val then
    return
  end
  local cur_frame = Global.frame_id
  if cur_frame - self.v_last_update_frame_id > self.v_update_frame_interval then
    self.v_slider.value = self.v_cache_val
    self.v_last_update_frame_id = cur_frame
    self.v_cur_val = self.v_cache_val
  end
end

function M:set_value(val)
  self.v_cache_val = val
end

function M:force_set_value(val)
  self.v_cache_val = val
  self.v_cur_val = val
  self.v_slider.value = val
end

function M:get_go()
  return self.v_slider_go
end

function M:is_go_active()
  return self.v_slider_go.activeSelf
end

function M:get_cache_value()
  return self.v_cache_val
end

function M:get_lua_obj()
  return self.v_lua_obj
end

return M
