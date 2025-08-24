local Base = require("ui.uiobject")
local ui = Util.create_child_mt(Base)

function ui:ui_finish_load()
  local btn = Util.get_button(nil, self.v_object)
  self:set_button_listener(btn, function()
    self:on_click()
  end)
  self.v_icon = self:get_image("Icon")
  self.v_txt = self:get_text("PosTxt")
  self.v_select_eff = self:get_child_gameobj("Ani_Select_")
  self.v_txt_obj = self.v_txt.gameObject
end

function ui:bind_node(node)
  self.v_node = node
  self:init_icon()
end

function ui:on_click()
  if not (self.v_node and self.v_node.walkable) or self.v_node.is_exit or self.v_is_cat_stand then
    return
  end
  self:set_block()
end

function ui:init_icon()
  local icon_path = self.v_node.cfg.Icon
  self.v_icon.gameObject:SetActiveEx(nil ~= icon_path)
  if icon_path then
    ResMgr:load_set_icon(self.v_icon, icon_path)
    self.v_icon:SetNativeSize()
  end
  self.v_txt_obj:SetActive(false)
  self.v_select_eff:SetActive(false)
end

function ui:set_cat_stand(bool_val)
  self.v_is_cat_stand = bool_val
end

function ui:set_block()
  if self.v_parent_ui:is_searching_path(true) then
    return
  end
  self.v_node:change_walkable(false)
  ResMgr:load_set_icon(self.v_icon, self:get_block_icon_path())
  self.v_icon.gameObject:SetActive(true)
  self.v_select_eff:SetActive(true)
  Global.sound_mgr:play_ui_sound(Config.UI_SOUND_CFG.catch_cat_click_road_UI_SOUND)
  self.v_parent_ui:switch_left_icon_anim()
  self.v_parent_ui:do_search_path()
end

function ui:get_block_icon_path()
  local stage_cfg = ShareRes.create("activity.kitten_escape")[self.v_node.cfg.ActivityId][self.v_node.cfg.Id]
  return stage_cfg.BlockIcon
end

return ui
