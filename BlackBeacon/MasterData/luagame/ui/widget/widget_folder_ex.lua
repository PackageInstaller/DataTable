local Base = require("ui.widget.widget_base")
local M = Util.create_child_mt(Base)
local ANI_VERTICAL = "RightArrowVer"
local ANI_HORI = "RightArrowHori"
local COLOR_NORMAL = 6576709
local COLOR_HIGH_LIGHT = 16775910

function M:_init(ui)
  Base._init(self)
  self.v_ui = ui
  self.v_sort_objs = {}
  self.v_gen_num = 0
  self.v_click_cb = nil
  self.v_fill_parent_cb = nil
  self.v_fill_child_cb = nil
end

function M:init_folder(name, ui, obj_scroll)
  self.v_entry_key = name .. "_entry"
  self.v_child_key = name .. "_child_key"
  local obj_content = obj_scroll.content
  self.v_entry_scroll = obj_scroll
  self.v_entry_content = obj_content
  self.v_entry_obj = ui:get_child_gameobj("Entry", obj_content)
  self.v_child_content = ui:get_child_transform("Entry", obj_content)
  self.v_child_obj = ui:get_child_gameobj("Entry/Child", obj_content)
  ui:register_exist_auto_template(self.v_entry_key, self.v_entry_obj, self.v_entry_content)
  self.v_ui = ui
  self.v_elements = {}
  self.v_select_idx = nil
  self.v_select_subidx = nil
end

function M:set_open_sub_default(b)
  self.v_open_default = b
end

function M:_refresh_element(element)
  local title_obj = self.v_ui:get_child_gameobj("Title", element.obj)
  self:fill_title(title_obj, element.idx)
  local arrow = self.v_ui:get_child_gameobj("Arrow", title_obj)
  if arrow then
    if element.subs and #element.subs > 0 then
      arrow:SetActive(true)
      element.animator = self.v_ui:get_animator(nil, title_obj)
    else
      arrow:SetActive(false)
    end
  end
  Util.set_click(nil, title_obj, self, function(...)
    self:select_element(element.idx)
  end)
end

function M:_gen_element(idx, subs)
  local element = {}
  local obj = self.v_ui:get_auto_cache(self.v_entry_key)
  obj:SetActive(true)
  element.obj = obj
  element.idx = idx
  element.subs = subs
  element.is_opening = false
  element.sub_elements = {}
  local child_key = self.v_child_key .. self:gen_next_num()
  self.v_ui:register_exist_auto_template(child_key, self.v_ui:get_child_gameobj("Child", element.obj), element.obj.transform)
  for i, sub in ipairs(element.subs) do
    local sub_element = self:_gen_sub_element(child_key, element, i)
    table.insert(element.sub_elements, sub_element)
  end
  element.child_key = child_key
  self:_refresh_element(element)
  return element
end

function M:_refresh_sub_element(element, sub_element)
  self:fill_child(sub_element.obj, element.idx, sub_element.idx)
  Util.set_click(nil, sub_element.obj, self, function(...)
    self:select_element(element.idx, sub_element.idx)
  end)
end

function M:_gen_sub_element(child_key, element, subidx)
  local sub_element = {}
  local obj = self.v_ui:get_auto_cache(child_key)
  if element.is_opening then
    obj:SetActive(true)
  else
    obj:SetActive(false)
  end
  sub_element.obj = obj
  sub_element.idx = subidx
  self:_refresh_sub_element(element, sub_element)
  return sub_element
end

function M:init_data(data, def_idx, def_subidx, jump_to)
  self.v_ui:give_back_auto_cache(self.v_entry_key)
  self.v_elements = {}
  for i, subs in ipairs(data) do
    self.v_elements[i] = self:_gen_element(i, subs)
  end
  self:select_element(def_idx, def_subidx)
  if jump_to then
    self:_jump_to_element(def_idx)
  end
end

function M:_jump_to_element(idx)
  if self.v_timer then
    Timer:remove_timer(self.v_timer)
  end
  local cb = self.v_ui:new_async_task(function()
    self:_do_jump_to_element(idx)
    self.v_timer = nil
  end)
  self.v_timer = Timer:add_timer("folder_ex_jump", 0.1, cb)
end

function M:_do_jump_to_element(idx)
  local element = self.v_elements[idx]
  if not element then
    return
  end
  local element_obj = element.obj
  local element_height = self:_get_rect_height(element_obj)
  local _, element_y, _ = element_obj.transform:GetLocalPositionA()
  local target_y = -element_y - element_height / 2
  local content_obj = self.v_entry_content
  local total_height = self:_get_rect_height(content_obj)
  local viewport_obj = self.v_entry_scroll.gameObject:FindChild("Viewport")
  local viewport_height = self:_get_rect_height(viewport_obj)
  if total_height < viewport_height then
    target_y = 0
  elseif viewport_height > total_height - target_y then
    target_y = math.max(0, total_height - viewport_height)
  end
  local content_trans = content_obj.transform
  local cx, _ = content_trans:getanchoredPositionA()
  content_trans:setanchoredPositionA(cx, target_y)
end

function M:_get_rect_height(obj)
  local trans = obj.transform
  local rect = trans.rect
  return rect.height
end

function M:on_select(idx, subidx)
  local element = assert(self.v_elements[idx], idx)
  local last_element = self.v_last_element
  local last_sub_element = self.v_last_sub_element
  if last_element and last_element ~= element then
    if self.v_unselect_title_cb then
      self.v_unselect_title_cb(last_element.obj)
    end
    local last_element_obj = last_element.obj
    self:_high_light_title_arrow(last_element_obj, false)
    self:_high_light_title_bg(last_element_obj, false)
    self:_high_light_title_text(last_element_obj, false)
    self:_unactive_title_shadow(last_element_obj)
    local need_open_sub = self.v_open_default and nil ~= subidx
    if need_open_sub and last_sub_element then
      if self.v_unselect_child_cb then
        self.v_unselect_child_cb(last_sub_element.obj)
      end
      local last_sub_obj = last_sub_element.obj
      self:_high_light_sub_bg(last_sub_obj, false)
      self:_high_light_sub_selected(last_sub_obj, false)
    end
    if self.v_auto_fold then
      self:fold_child(last_element)
    end
  end
  if self.v_select_title_cb then
    self.v_select_title_cb(element.obj)
  end
  self.v_last_element = element
  local element_obj = element.obj
  self:_high_light_title_arrow(element_obj, true)
  self:_high_light_title_bg(element_obj, true)
  self:_high_light_title_text(element_obj, true)
  self:_active_title_shadow(element_obj)
  if subidx and element.sub_elements[subidx] then
    if last_sub_element then
      self:_high_light_sub_bg(last_sub_element.obj, false)
      self:_high_light_sub_selected(last_sub_element.obj, false)
    end
    local sub_element = element.sub_elements[subidx]
    if self.v_select_child_cb then
      self.v_select_child_cb(sub_element.obj)
    end
    self.v_last_sub_element = sub_element
    self:_high_light_sub_bg(sub_element.obj, true)
    self:_high_light_sub_selected(sub_element.obj, true)
  end
end

function M:_high_light_bg(parent_obj, item_path, is_high_light)
  local path_tmpl = "%s/%s"
  local normal_path = string.format(path_tmpl, item_path or "", "Bg")
  local high_light_path = string.format(path_tmpl, item_path or "", "HeightBg")
  local high_light_bg = self.v_ui:get_child_gameobj(high_light_path, parent_obj)
  local normal_bg = self.v_ui:get_child_gameobj(normal_path, parent_obj)
  if high_light_bg then
    high_light_bg:SetActive(is_high_light)
  end
  if normal_bg then
  end
end

function M:_high_light_text(parent_obj, item_path, is_high_light)
  local path_tmpl = "%s/%s"
  local text_path = string.format(path_tmpl, item_path or "", "Text_name")
  local text = self.v_ui:get_text(text_path, parent_obj)
  if text then
    local color_hex
    if is_high_light then
      color_hex = COLOR_HIGH_LIGHT
    else
      color_hex = COLOR_NORMAL
    end
    text.color = Util.get_unity_color_by_hex(color_hex)
  end
end

function M:_high_light_title_bg(obj, is_high_light)
  local path = "Title"
  self:_high_light_bg(obj, path, is_high_light)
end

function M:_high_light_sub_bg(obj, is_high_light)
  local path = "Template"
  self:_high_light_bg(obj, path, is_high_light)
end

function M:_high_light_title_text(obj, is_high_light)
  local path = "Title"
  self:_high_light_text(obj, path, is_high_light)
end

function M:_high_light_title_arrow(obj, is_high_light)
  local arrow = self.v_ui:get_image("Title/Arrow", obj)
  if arrow then
    if is_high_light then
      altas = "Common"
      key = "Arrow-SelectDown-2"
      Util.set_sprite_with_atlas_key(self.v_ui, arrow, altas, key)
    else
      arrow.overrideSprite = nil
    end
  end
end

function M:_active_title_shadow(obj)
  local shadow = self.v_ui:get_shadow("Title/Text_name", obj)
  if shadow then
    shadow.enabled = true
  end
  local shadow = self.v_ui:get_shadow("Title/Text_num", obj)
  if shadow then
    shadow.enabled = true
  end
end

function M:_unactive_title_shadow(obj)
  local shadow = self.v_ui:get_shadow("Title/Text_name", obj)
  if shadow then
    shadow.enabled = false
  end
  local shadow = self.v_ui:get_shadow("Title/Text_num", obj)
  if shadow then
    shadow.enabled = false
  end
end

function M:_high_light_sub_selected(obj, is_high_light)
  local select_bg = self.v_ui:get_child_gameobj("Template/SelectBg", obj)
  if select_bg then
    select_bg:SetActive(is_high_light)
  end
end

function M:gen_next_num(...)
  self.v_gen_num = self.v_gen_num + 1
  return self.v_gen_num
end

function M:fold_child(element, ...)
  if not element.is_opening then
    return
  end
  if self.v_fold_before_cb then
    self.v_fold_before_cb(element.idx)
  end
  for _, sub_element in ipairs(element.sub_elements) do
    sub_element.obj:SetActive(false)
  end
  if element.animator then
    element.animator:Play(ANI_HORI, -1, 0.0)
  end
  element.is_opening = false
  if self.v_fold_after_cb then
    self.v_fold_after_cb(element.idx)
  end
end

function M:set_fold_before_cb(cb)
  self.v_fold_before_cb = cb
end

function M:set_fold_after_cb(cb)
  self.v_fold_after_cb = cb
end

function M:unfold_child(element)
  if element.is_opening then
    return
  end
  if self.v_unfold_before_cb then
    self.v_unfold_before_cb(element.idx)
  end
  for _, sub_element in ipairs(element.sub_elements) do
    sub_element.obj:SetActive(true)
  end
  if element.animator then
    element.animator:Play(ANI_VERTICAL, -1, 0.0)
  end
  element.is_opening = true
  if self.v_unfold_after_cb then
    self.v_unfold_after_cb(element.idx)
  end
  if element.idx == #self.v_elements then
    self:_jump_to_element(element.idx)
  end
end

function M:set_unfold_before_cb(cb)
  self.v_unfold_before_cb = cb
end

function M:set_unfold_after_cb(cb)
  self.v_unfold_after_cb = cb
end

function M:fold(idx)
  if not idx then
    return
  end
  local element = self.v_elements[idx]
  if not element then
    return
  end
  self:fold_child(element)
end

function M:unfold(idx)
  if not idx then
    return
  end
  local element = self.v_elements[idx]
  if not element then
    return
  end
  self:unfold_child(element)
end

function M:click_element(...)
  if self.v_click_cb then
    self.v_click_cb(...)
  end
end

function M:fill_title(...)
  if self.v_fill_title_cb then
    self.v_fill_title_cb(...)
  end
end

function M:fill_child(...)
  if self.v_fill_child_cb then
    self.v_fill_child_cb(...)
  end
end

function M:select_element(idx, subidx)
  if not idx then
    return
  end
  local element = self.v_elements[idx]
  if not element then
    return
  end
  if subidx then
    if element.subs then
      if subidx > #element.subs then
        return
      end
      self:unfold_child(element)
      self:on_select(idx, subidx)
      self:click_element(idx, subidx)
    end
  elseif element.subs and #element.subs > 0 then
    local default
    if self.v_open_default then
      default = 1
    end
    if element.is_opening then
      self:fold_child(element)
      self:on_select(idx)
    else
      self:unfold_child(element)
      if self.v_select_idx ~= idx then
        self:on_select(idx, default)
        self:click_element(idx, default)
      end
    end
  else
    self:on_select(idx)
    self:click_element(idx)
  end
  self.v_select_idx = idx
  self.v_select_subidx = subidx
end

function M:get_select(...)
  return self.v_select_idx, self.v_select_subidx
end

function M:set_click_cb(cb)
  self.v_click_cb = cb
end

function M:set_fill_title_cb(cb)
  self.v_fill_title_cb = cb
end

function M:set_fill_child_cb(cb)
  self.v_fill_child_cb = cb
end

function M:set_select_title_cb(cb)
  self.v_select_title_cb = cb
end

function M:set_unselect_title_cb(cb)
  self.v_unselect_title_cb = cb
end

function M:set_select_child_cb(cb)
  self.v_select_child_cb = cb
end

function M:set_unselect_child_cb(cb)
  self.v_unselect_child_cb = cb
end

function M:on_reset(...)
  self.v_last_element = nil
  self.v_last_sub_element = nil
  self.v_select_idx = nil
  self.v_select_subidx = nil
end

function M:add_element(idx, subs)
  local element = self:_gen_element(idx, subs)
  table.insert(self.v_elements, idx, element)
  for i = idx + 1, #self.v_elements do
    local element = self.v_elements[i]
    element.idx = i
  end
  local insert_element = self.v_elements[idx + 1]
  if insert_element then
    element.obj.transform:SetSiblingIndex(insert_element.obj.transform:GetSiblingIndex())
  end
end

function M:del_element(idx)
  local element = table.remove(self.v_elements, idx)
  for i = idx, #self.v_elements do
    local element = self.v_elements[i]
    element.idx = i
  end
  self:unfold_child(element)
  if self.v_last_element == element then
    self.v_last_element = nil
    self.v_last_sub_element = nil
  end
  self.v_ui:give_back_auto_cache_obj(self.v_entry_key, element.obj, true)
end

function M:get_element_obj(idx, subidx)
  if not idx then
    return
  end
  local element = self.v_elements[idx]
  if not element then
    return
  end
  if not subidx then
    return element
  end
  local sub_element = element.sub_elements[subidx]
  if not sub_element then
    return
  end
  return sub_element
end

function M:update_element(idx, subidx)
  if not idx then
    return
  end
  local element = self.v_elements[idx]
  if not element then
    return
  end
  if not subidx then
    self:_refresh_element(element)
    return
  end
  local sub_element = element.sub_elements[subidx]
  if not sub_element then
    return
  end
  self:_refresh_sub_element(element, sub_element)
end

function M:add_sub_element(idx, subidx, sub)
  local element = self.v_elements[idx]
  table.insert(element.subs, subidx, sub)
  self:_refresh_element(element)
  local sub_element = self:_gen_sub_element(element.child_key, element, subidx)
  table.insert(element.sub_elements, subidx, sub_element)
  for i = subidx + 1, #element.sub_elements do
    local sub_element = element.sub_elements[i]
    sub_element.idx = i
  end
  local insert_sub_element = element.sub_elements[subidx + 1]
  if insert_sub_element then
    sub_element.obj.transform:SetSiblingIndex(insert_sub_element.obj.transform:GetSiblingIndex())
  end
end

function M:del_sub_element(idx, subidx)
  local element = self.v_elements[idx]
  table.remove(element.subs, subidx)
  self:_refresh_element(element)
  local sub_element = table.remove(element.sub_elements, subidx)
  for i = subidx, #element.sub_elements do
    local sub = element.sub_elements[i]
    sub.idx = i
  end
  if self.v_last_sub_element == sub_element then
    self.v_last_sub_element = nil
  end
  self.v_ui:give_back_auto_cache_obj(element.child_key, sub_element.obj, true)
end

function M:center_to(idx, subidx)
  if not idx then
    return
  end
  local element = self.v_elements[idx]
  if not element then
    return
  end
  local rect = self.v_ui:get_rect_transform(nil, element.obj)
  local rect_p = self.v_ui:get_rect_transform(nil, self.v_entry_content.gameObject)
  local y = rect.anchoredPosition.y
  if subidx and element.is_opening then
    local sub_element = element.sub_elements[subidx]
    if sub_element then
      local rect = self.v_ui:get_rect_transform(nil, sub_element.obj)
      y = y + rect.anchoredPosition.y
    end
  end
  self.v_entry_scroll.verticalNormalizedPosition = 1 + y / rect_p.rect.height
end

function M:set_auto_fold(auto_fold)
  self.v_auto_fold = auto_fold
end

return M
