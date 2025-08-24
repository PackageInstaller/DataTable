local Base = require("ui.uiobject")
local ui = Util.create_child_mt(Base)
local ICON_PREFIX = "Icon/Item/%s"
local BG_ICON_PREFIX = "UICharacter/%s"
local _sformat = string.format
local Char_Helper = require("uimodule.character.char_helper")

function ui:set_data(go, data_list, index)
  local use_data = data_list[index]
  local uicom = self.v_uicompents
  ResMgr:load_set_icon(uicom.Bg1_img, use_data.weapon_quality_bg1)
  ResMgr:load_set_icon(uicom.Bg2_img, use_data.weapon_quality_bg2)
  ResMgr:load_set_icon(uicom.EquipIcon_img, _sformat(ICON_PREFIX, use_data.weapon_icon))
  Char_Helper.set_buddy_quality_star(self.v_uiobjects, use_data.weapon_quality)
  uicom.Name_txt.text = use_data.weapon_name
  self.v_uiobjects.RedPoint:SetActive(use_data.weapon_isred)
  self.v_uiobjects.NoGet:SetActive(not use_data.weapon_isunlock)
  local btn = Util.get_button(nil, self.v_object)
  self:set_button_listener(btn, function()
    self.v_parent_ui:click_item(use_data.weapon_id, use_data.weapon_isunlock and use_data.weapon_isred)
  end)
end

function ui:play_in_eff()
  self.v_object:SetActive(true)
end

function ui:eff_init()
  self.v_object:SetActive(false)
end

function ui:is_visible_item()
  return self.v_visible
end

function ui:set_linked_parent(parent_ui)
  self.v_parent_ui = parent_ui
end

return ui
