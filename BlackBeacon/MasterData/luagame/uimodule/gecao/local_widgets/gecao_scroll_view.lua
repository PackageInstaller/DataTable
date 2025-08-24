local Base = require("ui.widget.widget_base")
local M = Util.create_child_mt(Base)
local chapter_bg_show_time = 0.2
local chapter_text_show_time = 0.3
local chapter_bg_and_text_interval_time = 0.05
local chapter_show_all_time = chapter_bg_show_time + chapter_text_show_time + chapter_bg_and_text_interval_time
local generate_chapter_interval_time = 0.1

function M:_init(parent_ui, scroll_rect_obj, content_gameobj, template_class, template_key)
  self.v_gameobj = content_gameobj
  self.v_content_transform = content_gameobj.transform
  self.v_content_rect_trans = Util.get_rect_transform(nil, self.v_gameobj)
  self.v_parent_rect_trans = Util.get_rect_transform(nil, self.v_content_rect_trans.parent)
  self.v_scroll_view = Util.get_scrollrect(nil, scroll_rect_obj)
  local template = content_gameobj.transform:GetChild(0).gameObject
  self.v_item_template_key = template_key
  self.v_template = template
  self.v_parent_ui = parent_ui
  self.ItemClass = template_class
  parent_ui:register_exist_auto_template(template_key, template, self.v_gameobj)
  self.v_item_count = 0
  self.v_items = {}
end

function M:update_list(res_list)
  self:clear()
  if not res_list then
    return
  end
  for i = 1, #res_list do
    self:add_item(res_list[i], i)
  end
  self.v_scroll_view.horizontalNormalizedPosition = 0
end

function M:get_item_at_index(index)
  return self.v_items and self.v_items[index]
end

function M:get_item()
  local obj = self.v_parent_ui:get_auto_cache(self.v_item_template_key)
  local item = self.ItemClass:ui_wrap_ex(nil, obj)
  item.go = obj
  return item
end

function M:add_item(data, index)
  local item = self:get_item()
  local item_gameobj = item.go
  item_gameobj.transform:SetParent(self.v_content_transform)
  local rect_transform = Util.get_rect_transform(nil, item_gameobj)
  self.v_item_count = self.v_item_count + 1
  if item.set_data then
    data.index = index
    item:set_data(data, self)
  end
  item.rect_trans = rect_transform
  table.insert(self.v_items, item)
  item_gameobj:SetActive(true)
end

function M:clear()
  for _, item in ipairs(self.v_items) do
    item:on_clear(true)
    self.v_parent_ui:give_back_auto_cache(self.v_item_template_key)
  end
  UtilTable.clear_list(self.v_items)
  self.v_item_count = 0
end

function M:get_anim_time()
  return chapter_show_all_time + self.v_item_count * generate_chapter_interval_time
end

return M
