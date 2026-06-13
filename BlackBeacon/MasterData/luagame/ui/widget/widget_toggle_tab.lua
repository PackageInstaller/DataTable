local Base = require("ui.widget.widget_base")
local M = Util.create_child_mt(Base)
local TypeUnityUIText = _ENV.TypeUnityUIText
local NAME_TOGGLE_LIGHT = "Toggle_Hight{1}"
local NAME_TOGGLE_TEXT = "Text"
local COLOR_DIME = tonumber("6A779E", 16)
local COLOR_LIGHT = tonumber("FFFFFF", 16)

function M:_init(ui)
  Base._init(self)
  self.v_ui = ui
  return self
end

function M:init_by_obj(obj_toggle, page_count, callback, default_select, use_text_color, init_callback)
  self:dispose()
  local toggle_list = {}
  for i = 1, page_count do
    toggle_list[i] = Util.get_toggle(Util.format_str(NAME_TOGGLE_LIGHT, i), obj_toggle)
  end
  self:_init_by_toggles(toggle_list, callback, default_select, use_text_color, init_callback)
end

function M:init_by_toggles(toggle_list, callback, default_select, use_text_color, init_callback, custom_color_dime, custom_color_light)
  self:dispose()
  self:_init_by_toggles(toggle_list, callback, default_select, use_text_color, init_callback, custom_color_dime, custom_color_light)
end

function M:init_by_parent(toggle_obj, callback, default_select, use_text_color, init_callback)
  self:dispose()
  self.v_toggle_obj = toggle_obj
  self.v_use_text_color = false
  local toggle_list = toggle_obj.gameObject:GetComponentsInChildren(typeof(UnityEngine.UI.Toggle))
  self:_init_by_toggles(toggle_list, callback, default_select, use_text_color, init_callback)
end

function M:init_by_toggle_objs(toggle_objs, callback, default_select, use_text_color, init_callback)
  self:dispose()
  local toggle_list = {}
  for _, obj in ipairs(toggle_objs) do
    table.insert(toggle_list, obj:GetComponent(UnityEngine.UI.Toggle))
  end
  self:init_by_toggles(toggle_list, callback, default_select, use_text_color, init_callback)
end

function M:set_toggle_by_index(index, ...)
  self:_on_toggle(index, ...)
end

function M:get_toggle_by_index(index)
  return self.v_toggles and self.v_toggles[index]
end

function M:dispose()
  if self.v_page_toggles then
    for _, toggle in pairs(self.v_page_toggles) do
      toggle.onValueChanged:RemoveAllListeners()
    end
  end
  self.v_toggle_obj = nil
  self.v_page_toggles = nil
  self.v_callback = nil
  self.v_page_toggle_texts = nil
end

function M:_init_by_toggles(toggle_list, callback, default_select, use_text_color, init_callback, custom_color_dime, custom_color_light)
  if nil == use_text_color then
    self.v_use_text_color = true
  else
    self.v_use_text_color = use_text_color
  end
  COLOR_DIME = tonumber("6A779E", 16)
  COLOR_LIGHT = tonumber("FFFFFF", 16)
  if custom_color_dime then
    COLOR_DIME = custom_color_dime
  end
  if custom_color_light then
    COLOR_LIGHT = custom_color_light
  end
  self.v_toggles = toggle_list
  self.v_page_count = #self.v_toggles
  self.v_callback = callback
  default_select = default_select or 1
  self.v_cur_select = default_select
  self.v_pre_select = -1
  self.v_page_toggles = {}
  self.v_page_toggle_texts = {}
  for i = 1, self.v_page_count do
    self.v_page_toggles[i] = self:_set_toggle(self.v_toggles[i], function(is_on)
      if is_on then
        self:_on_toggle(i)
      end
    end)
    if self.v_use_text_color then
      local parent = self.v_page_toggles[i].gameObject
      local child = parent:FindChild(NAME_TOGGLE_TEXT)
      local text
      if child then
        text = child:GetComponent(TypeUnityUIText)
      end
      if nil == text then
        self.v_use_text_color = false
      else
        self.v_page_toggle_texts[i] = text
      end
    end
  end
  if self.v_use_text_color then
    self.v_toggle_on_color = Util.get_unity_color_by_hex(COLOR_LIGHT)
    self.v_toggle_off_color = Util.get_unity_color_by_hex(COLOR_DIME)
  end
  for i = 1, self.v_page_count do
    local toggle = self.v_page_toggles[i]
    local text = self.v_page_toggle_texts[i]
    if i == default_select then
      toggle.isOn = true
      toggle.interactable = false
      if self.v_use_text_color and text then
        text.color = self.v_toggle_on_color
      end
      if self.v_callback and init_callback then
        self.v_callback(self.v_cur_select)
      end
    else
      toggle.isOn = false
      toggle.interactable = true
      if self.v_use_text_color and text then
        text.color = self.v_toggle_off_color
      end
    end
  end
end

function M:set_color(light, dime, light_alpha, dime_alpha)
  if light then
    self.v_toggle_on_color = Util.get_unity_color_by_hex(tonumber(light, 16))
    if light_alpha then
      self.v_toggle_on_color.a = light_alpha
    end
  end
  if dime then
    self.v_toggle_off_color = Util.get_unity_color_by_hex(tonumber(dime, 16))
    if dime_alpha then
      self.v_toggle_off_color.a = dime_alpha
    end
  end
  for i = 1, self.v_page_count do
    local toggle = self.v_page_toggles[i]
    local text = self.v_page_toggle_texts[i]
    if i == self.v_cur_select then
      toggle.isOn = true
      toggle.interactable = false
      if self.v_use_text_color and text then
        text.color = self.v_toggle_on_color
      end
    else
      toggle.isOn = false
      toggle.interactable = true
      if self.v_use_text_color and text then
        text.color = self.v_toggle_off_color
      end
    end
  end
end

function M:_on_toggle(cur_index, ...)
  if -1 == cur_index then
    for _, toggle in pairs(self.v_page_toggles) do
      toggle.isOn = false
      toggle.interactable = true
    end
    self.v_cur_select = -1
    self.v_pre_select = -1
    return
  end
  if cur_index == self.v_cur_select then
    return
  end
  for index, toggle in pairs(self.v_page_toggles) do
    toggle.isOn = cur_index == index
    toggle.interactable = cur_index ~= index
  end
  self.v_pre_select = self.v_cur_select
  self.v_cur_select = cur_index
  if self.v_use_text_color then
    if self.v_page_toggle_texts[self.v_pre_select] then
      self.v_page_toggle_texts[self.v_pre_select].color = self.v_toggle_off_color
    end
    if self.v_page_toggle_texts[self.v_cur_select] then
      self.v_page_toggle_texts[self.v_cur_select].color = self.v_toggle_on_color
    end
  end
  if self.v_callback then
    local cur_toggle = self.v_page_toggles[self.v_cur_select]
    local pre_toggle = self.v_page_toggles[self.v_pre_select]
    self.v_callback(self.v_cur_select, self.v_pre_select, cur_toggle, pre_toggle, ...)
  end
end

function M:_set_toggle(toggle, callback)
  Global.listener_mgr:add_listener(self, toggle.onValueChanged, callback)
  return toggle
end

function M:get_select_idx()
  return self.v_cur_select
end

return M
