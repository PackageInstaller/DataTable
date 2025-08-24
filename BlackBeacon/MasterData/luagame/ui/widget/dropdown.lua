local Base = require("ui.widget.widget_base")
local M = Util.create_child_mt(Base)

function M:_init(ui, dropdown, cb, ud)
  Base._init(self)
  assert(dropdown)
  assert(cb)
  assert(ud)
  self.v_ui = ui
  self.v_dropdown = dropdown
  self.v_cb = cb
  self.v_ud = ud
  self.v_value_list = nil
  self.v_select_idx = nil
end

function M:set_options(value_list, show_text_list, is_inherit_select)
  assert(#value_list > 0)
  assert(#show_text_list > 0)
  assert(#value_list == #show_text_list)
  self.v_dropdown:ClearOptions()
  self.v_dropdown.onValueChanged:RemoveAllListeners()
  local select_idx = 1
  if is_inherit_select and self.v_value_list and self.v_select_idx then
    local select_value = self:get_select_value()
    local find_result = UtilTable.table_find(value_list, select_value)
    if nil ~= find_result then
      select_idx = find_result
    end
  end
  for idx, show_text in ipairs(show_text_list) do
    self.v_dropdown:AddOptionWithoutRefresh(show_text)
  end
  self.v_dropdown:RefreshShownValue()
  self:_set_select_idx(select_idx)
  Global.listener_mgr:add_listener(self, self.v_dropdown.onValueChanged, function(idx)
    self:_on_select(idx)
  end)
  self.v_value_list = value_list
end

function M:get_select_idx()
  return self.v_select_idx
end

function M:get_select_value()
  local select_value = self.v_value_list[self.v_select_idx]
  return select_value
end

function M:_on_select(idx)
  local lua_idx = self:_c_sharp_idx_to_lua_idx(idx)
  if lua_idx ~= self.v_select_idx then
    self:_set_select_idx(lua_idx)
    local select_value = self:get_select_value()
    self.v_cb(self.v_ud, lua_idx, select_value)
  end
end

function M:on_select_from_lua(lua_idx)
  if lua_idx ~= self.v_select_idx then
    self:_set_select_idx(lua_idx)
    local select_value = self:get_select_value()
    self.v_cb(self.v_ud, lua_idx, select_value)
    return true
  end
end

function M:_set_select_idx(select_idx)
  self.v_select_idx = select_idx
  local c_sharp_idx = self:_lua_idx_to_c_sharp_idx(select_idx)
  self.v_dropdown.value = c_sharp_idx
end

function M:_lua_idx_to_c_sharp_idx(idx)
  return idx - 1
end

function M:_c_sharp_idx_to_lua_idx(idx)
  return idx + 1
end

return M
