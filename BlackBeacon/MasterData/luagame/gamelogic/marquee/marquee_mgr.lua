local Base = require("gamelogic.base_system")
local _tinsert = table.insert
local _tremove = table.remove
local _tsort = table.sort
local M = Util.create_child_mt(Base)

function M:_reset_data()
  self.v_msg_list = {}
  self.v_area_list = {}
  self.v_counter = 0
end

function M:init_sys()
  Base.init_sys(self)
  self:_reset_data()
  self:sys_mq_bind(Const.MSG_SCENE_LOAD, self._handle_scene_load, self)
end

function M:on_reconnect()
  self:_reset_data()
end

function M:_handle_scene_load()
  local is_main_scene = SceneMgr:check_main_scene()
  if is_main_scene then
    self:_check_play()
  else
    local view = UIMgr:try_get_visible_ui("marquee")
    if view then
      view:ui_hide()
    end
  end
end

function M:_next_counter()
  self.v_counter = self.v_counter + 1
  return self.v_counter
end

function M:_check_play()
  local is_main_scene = SceneMgr:check_main_scene()
  if not is_main_scene then
    return
  end
  local len = #self.v_msg_list
  if len <= 0 then
    return
  end
  local view = UIMgr:try_get_visible_ui("marquee")
  if not view then
    UIMgr:get_ui("marquee"):ui_show()
  end
end

function M:_refresh_cur_area()
  local area = self.v_area_list[1]
  local view = UIMgr:try_get_visible_ui("marquee")
  if view then
    view:refresh_area(area)
  end
end

function M:add_msg(msg, loop_time, msg_index)
  msg = string.gsub(msg, "[\n\r]", "")
  _tinsert(self.v_msg_list, {
    content = msg,
    loop_time = loop_time,
    msg_index = msg_index
  })
  self:_check_play()
end

function M:pop_msg()
  local len = #self.v_msg_list
  if len <= 0 then
    return
  end
  return _tremove(self.v_msg_list, 1)
end

function M:get_msg_count()
  return #self.v_msg_list
end

function M:remove_msg(msg_index)
  local is_have = false
  for i, v in ipairs(self.v_msg_list) do
    if v.msg_index == msg_index then
      is_have = true
      _tremove(self.v_msg_list, i)
      break
    end
  end
  if is_have then
    return
  end
  local view = UIMgr:try_get_visible_ui("marquee")
  if view then
    view:remove_msg(msg_index)
  end
end

function M:get_cur_area()
  return self.v_area_list[1]
end

do
  local function _area_sorter(a, b)
    return a.cnt > b.cnt
  end
  
  function M:push_area(instance_id, pos, width)
    _tinsert(self.v_area_list, {
      id = instance_id,
      pos = pos,
      width = width,
      cnt = self:_next_counter()
    })
    _tsort(self.v_area_list, _area_sorter)
    self:_refresh_cur_area()
  end
  
  function M:pop_area(instance_id)
    UtilTable.list_delete_by_key_value(self.v_area_list, "id", instance_id)
    self:_refresh_cur_area()
  end
end
return M
