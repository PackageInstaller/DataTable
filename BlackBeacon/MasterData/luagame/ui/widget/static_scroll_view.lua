local Base = require("ui.widget.widget_base")
local M = Util.create_child_mt(Base)
local GridLayoutGroup = UnityEngine.UI.GridLayoutGroup

function M:_init(parent_ui, content_gameobj, template_class, template_key, template_index)
  self.v_content_gameobj = content_gameobj
  self.v_content_transform = content_gameobj.transform
  self.v_content_rect_trans = Util.get_rect_transform(nil, self.v_content_gameobj)
  self.v_parent_rect_trans = Util.get_rect_transform(nil, self.v_content_rect_trans.parent)
  self.v_content_cpt = Util.get_component(nil, content_gameobj, typeof(GridLayoutGroup))
  if self.v_content_cpt ~= nil then
    self.v_content_size = self.v_content_cpt.cellSize
  end
  template_index = template_index or 0
  local template = content_gameobj.transform:GetChild(template_index).gameObject
  self.v_template_key = template_key
  self.v_template = template
  self.v_parent_ui = parent_ui
  self.ItemClass = template_class
  parent_ui:register_exist_auto_template(template_key, template, self.v_content_gameobj)
  self.v_item_count = 0
  self.v_items = {}
end

function M:get_item()
  local obj = self.v_parent_ui:get_auto_cache(self.v_template_key)
  local item = self.ItemClass:ui_wrap(self.v_parent_ui, obj)
  item.go = obj
  return item
end

function M:push_item(data)
  self:add_item(data)
end

function M:add_item(data)
  local item = self:get_item()
  local item_gameobj = item.go
  item_gameobj.transform:SetParent(self.v_content_transform)
  local rect_transform = Util.get_rect_transform(nil, item_gameobj)
  self.v_item_count = self.v_item_count + 1
  table.insert(self.v_items, item)
  item.static_scroll_view = self
  if item.set_data then
    data.idx = self.v_item_count
    item:set_data(data, self)
  end
  item.rect_trans = rect_transform
  item_gameobj:SetActive(true)
  if self.v_selected_item then
    item:set_selected(self.v_selected_item == item)
  end
end

function M:update_list(res_list)
  self:clear()
  self:remove_batch_refersh_timer()
  if not res_list then
    return
  end
  self.v_res_list = res_list
  self.v_end_index = #res_list
  self.v_start_index = 1
  if self.v_interval_count and self.v_interval_time > 0 and self.v_end_index > self.v_interval_count then
    self.v_cur_refresh_index = 0
    self:add_batch_refersh_timer()
  else
    self:_add_item(self.v_start_index, self.v_end_index)
  end
end

function M:_batch_refersh()
  if not self.v_parent_ui or self.v_parent_ui:is_destroy() then
    return
  end
  if self.v_cur_refresh_index < self.v_end_index then
    local max_index = math.min(self.v_cur_refresh_index + self.v_interval_count, self.v_end_index)
    self:_add_item(self.v_cur_refresh_index + 1, max_index)
    self.v_cur_refresh_index = max_index
  end
  return self.v_cur_refresh_index < self.v_end_index
end

function M:add_batch_refersh_timer()
  self.v_batch_refersh_timer = Timer:add_timer("batch_refersh_time", 0, self._batch_refersh, self, nil, self.v_interval_time)
end

function M:_add_item(start_index, end_index)
  if not self.v_res_list then
    return
  end
  for i = start_index, end_index do
    self:add_item(self.v_res_list[i], i)
  end
  if self.v_select_first_item and self.v_items[1] and not self.v_is_select_first_item then
    self:on_select_change(self.v_items[1])
    self.v_is_select_first_item = true
  end
  if #self.v_res_list == end_index then
    self.v_res_list = nil
  end
end

function M:get_items()
  return self.v_items
end

function M:get_item_by_idx(idx)
  return self.v_items[idx]
end

function M:select_item(index)
  local item = self.v_items and self.v_items[index]
  self:on_select_change(item)
end

function M:on_select_change(selected_item)
  self.v_selected_item = selected_item
  local list = self.v_items
  for i = 1, #list do
    list[i]:set_selected(list[i] == selected_item)
  end
  if selected_item and self.v_parent_ui.on_select_change then
    self.v_parent_ui:on_select_change(selected_item)
  end
end

function M:clear()
  for _, item in ipairs(self.v_items) do
    item:on_clear()
    item:ui_hide(true)
    item:ui_destroy()
  end
  self.v_parent_ui:give_back_auto_cache(self.v_template_key)
  self.v_selected_item = nil
  self.v_is_select_first_item = false
  UtilTable.clear_list(self.v_items)
  self.v_item_count = 0
  self.v_res_list = nil
end

function M:refresh_items()
  for _, item in ipairs(self.v_items) do
    item:on_refresh()
  end
end

function M:set_enable(param)
  self.v_content_gameobj:SetActive(param)
end

function M:sort_list(sort_func)
  local items = self.v_items
  table.sort(items, function(a, b)
    return sort_func(a, b)
  end)
  for i = 1, #items do
    items[i].transform:SetAsFirstSibling()
  end
end

function M:item_func(func, param1, param2, param3)
  for _, item in ipairs(self.v_items) do
    func(item, param1, param2, param3)
  end
end

function M:get_parent_ui()
  return self.v_parent_ui
end

function M:set_batch_refresh(interval_count, interval_time)
  self.v_interval_count = interval_count
  self.v_interval_time = interval_time
end

function M:set_select_first_item(select_first_item)
  self.v_select_first_item = select_first_item
end

function M:on_hide()
  self:clear()
  self:remove_batch_refersh_timer()
end

function M:remove_batch_refersh_timer()
  if self.v_batch_refersh_timer then
    Timer:remove_timer(self.v_batch_refersh_timer)
    self.v_batch_refersh_timer = nil
  end
end

return M
