local Base = require("ui.uiobject")
local ui = Util.create_child_mt(Base)
local Char_Helper = require("uimodule.character.char_helper")

function ui:on_click_btn()
  if self.v_is_ban then
    return
  end
  if not self.v_char_id then
    self.v_parent_ui:try_select_first_can_use_char(self.v_slot_index)
    return
  end
  self.v_parent_ui:on_click_char_item(self.v_char_id, self.v_char_uuid)
end

function ui:ui_finish_load()
end

function ui:ui_on_show()
end

function ui:ui_on_hide()
end

function ui:ui_on_destroy()
end

function ui:set_data(data, index)
  local is_empty = not data.is_select
  local is_ban = data.is_ban
  local fixed_char_id = data.fixed_char_id
  local is_must_select = nil ~= fixed_char_id
  self.v_char_uuid = data.char_uuid
  self.v_char_id = data.char_id
  self.v_is_ban = is_ban
  self.v_uiobjects.Add:SetActive(is_empty and not is_ban)
  self.v_uiobjects.Ban:SetActive(is_ban)
  self.v_slot_index = index
  local show_char_id = self.v_char_id or fixed_char_id
  if show_char_id then
    self.v_uiobjects.CharIcon:SetActive(true)
    local head_icon = UtilUI.get_hero_images(show_char_id, 1)
    ResMgr:load_set_icon(self.v_uicompents.CharIcon_img, head_icon)
    local color_str
    if is_must_select and nil == self.v_char_id then
      color_str = "606060"
      self.v_uiobjects.EleIcon:SetActive(false)
    else
      color_str = "ffffff"
      self.v_uiobjects.EleIcon:SetActive(true)
      local element_icon = Char_Helper.get_char_element_icon(show_char_id)
      ResMgr:load_set_icon(self.v_uicompents.EleIcon_img, element_icon)
    end
    Util.set_color(self.v_uicompents.CharIcon_img, color_str)
  else
    self.v_uiobjects.CharIcon:SetActive(false)
  end
  self.v_uiobjects.MustTag:SetActive(is_must_select)
  self.v_uiobjects.AssistTag:SetActive(nil ~= self.v_char_uuid)
  self:set_button_listener(self:get_button(), function()
    self:on_click_btn()
  end)
end

return ui
