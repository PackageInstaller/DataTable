local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local GET_ABILITY_AWARD_TEM = "GET_ABILITY_AWARD_TEM"
local GET_ORNAMENT_AWARD_TEM = "GET_ORNAMENT_AWARD_TEM"
local DROP_ABILITY_ITEM_CLASS = require("uimodule.stage_activity.challenge_ring_plus.drop_ability_item")
local ORN_VIEW_ITEM = require("uimodule.battle_bag.orn_view_item")
local curse_com_def = require("uimodule.stage_activity.challenge_ring_plus.curse_common_define")

function ui:ui_finish_load()
  self:set_button("BtnClose", function()
    self:on_click_close_btn()
  end)
  self:register_exist_auto_template(GET_ABILITY_AWARD_TEM, self.v_uiobjects.TalentTem, self.v_uiobjects.DropList)
  self:register_exist_auto_template(GET_ORNAMENT_AWARD_TEM, self.v_uiobjects.OrnTem, self.v_uiobjects.DropList)
  self.v_award_ability_item_list = {}
  self.v_award_ornament_item_list = {}
  self.v_safearea = self:get_canvas_group("SafeArea").component
  self.v_drop_list_layout = self:get_component(nil, self.v_uiobjects.DropList, typeof(UnityEngine.UI.HorizontalLayoutGroup))
  self.v_tween = nil
  self.v_scroll_drop_list = self:get_scrollrect(nil, self.v_uiobjects.ScrollDropList)
end

function ui:ui_on_show(award_type, data)
  SceneMgr:set_game_pause(true)
  self:refresh(award_type, data)
end

function ui:ui_on_hide()
  self.v_award_type = nil
  self:clear_tween()
  self:remove_all_item()
  self:invoke_next_type_refresh_callback()
  local cur_show_ui = UIMgr:get_cur_show_ui()
  if cur_show_ui and cur_show_ui:ui_get_name() == "fate_book_event_card" then
    cur_show_ui:after_confirm_select_option()
  end
end

function ui:ui_on_destroy()
end

function ui:refresh(award_type, data)
  data = data or ChallengeRingPlusMgr:dequeue_update_data()
  if not data then
    self:ui_hide()
    return
  end
  award_type = data.award_type
  self.v_drop_list_layout.childAlignment = UnityEngine.TextAnchor.MiddleCenter
  self.v_scroll_drop_list.enabled = false
  self.v_uicompents.ScrollDropList_img.enabled = false
  self:clear_tween()
  self.v_safearea.alpha = 0
  self.v_tween = self.v_safearea:DOFade(1, 0.8)
  self.v_tween:OnComplete(function()
    self:clear_tween()
  end)
  self.v_award_type = award_type
  self:remove_all_item()
  Global.sound_mgr:play_common_sound("Sound_getskill_fresh")
  if award_type == curse_com_def.CURSE_GET_AWARD_TIP_TYPE.GET_ORNAMENT then
    self:refresh_award_ornament(data)
    self.v_uicompents.Title_txt.text = curse_com_def.CURSE_GET_AWARD_TIP[award_type]
  elseif award_type == curse_com_def.CURSE_GET_AWARD_TIP_TYPE.GET_ABILITY_LIST then
    self:refresh_award_ability_list(data)
  elseif award_type == curse_com_def.CURSE_GET_AWARD_TIP_TYPE.GET_ABILITY or award_type == curse_com_def.CURSE_GET_AWARD_TIP_TYPE.ABILITY_UPGRADE then
    self:refresh_award_ability(data)
  elseif award_type == curse_com_def.CURSE_GET_AWARD_TIP_TYPE.GET_ORNAMENT_LIST or award_type == curse_com_def.CURSE_GET_AWARD_TIP_TYPE.REMOVE_ORNAMENT_LIST then
    self:refresh_award_ornament_list(data)
  elseif award_type == curse_com_def.CURSE_GET_AWARD_TIP_TYPE.RESTORE_ORNAMENT_LIST then
    self:refresh_restore_ornament_list(data)
  end
  local count = math.max(UtilTable.hash_lenth(self.v_award_ornament_item_list), UtilTable.hash_lenth(self.v_award_ability_item_list))
  local TextAnchor = UnityEngine.TextAnchor
  local more_then_four = count > 4
  self.v_drop_list_layout.childAlignment = more_then_four and TextAnchor.MiddleLeft or TextAnchor.MiddleCenter
  self.v_scroll_drop_list.enabled = more_then_four
  if not more_then_four then
    self.v_uicompents.ScrollDropList_rect:ResetContentPosition()
  end
  self.v_uicompents.ScrollDropList_img.enabled = more_then_four
  if self.v_skip_award_type and self.v_skip_award_type ~= award_type then
    self:invoke_next_type_refresh_callback()
  end
end

function ui:refresh_award_ability_list(data)
  for key, ability_data in pairs(data.ability_drop) do
    local obj = self:get_auto_cache(GET_ABILITY_AWARD_TEM)
    local ability_id = ability_data.id
    local ability_grade = ability_data.grade
    local award_type = data.award_type
    self.v_uicompents.Title_txt.text = curse_com_def.CURSE_GET_AWARD_TIP[award_type]
    self.v_award_ability_item_list[ability_id] = DROP_ABILITY_ITEM_CLASS:ui_wrap(self, obj, true)
    self.v_award_ability_item_list[ability_id]:set_data(ability_id, nil, true, true, ability_grade)
  end
  if self.v_award_type == curse_com_def.CURSE_GET_AWARD_TIP_TYPE.GET_ABILITY_LIST then
    GenresMgr:select_drop_ability()
    ChallengeRingPlusMgr:update_card_ability_drop()
  end
end

function ui:refresh_award_ability(data)
  local obj = self:get_auto_cache(GET_ABILITY_AWARD_TEM)
  local ability_data = data.ability_data
  local ability_id = ability_data.ability_id
  local ability_grade = ability_data.ability_grade
  local award_type = data.award_type
  self.v_uicompents.Title_txt.text = curse_com_def.CURSE_GET_AWARD_TIP[award_type]
  self.v_award_ability_item_list[ability_id] = DROP_ABILITY_ITEM_CLASS:ui_wrap(self, obj, true)
  self.v_award_ability_item_list[ability_id]:set_data(ability_id, nil, true, true, ability_grade)
end

function ui:refresh_award_ornament(data)
  local ornaments_data = data.ornaments_data
  local ornament_id = ornaments_data.item_id
  local obj = self:get_auto_cache(GET_ORNAMENT_AWARD_TEM)
  local item = ORN_VIEW_ITEM:ui_wrap(self, obj, true)
  item:set_data(ornament_id, true)
  self.v_award_ornament_item_list[ornament_id] = item
end

function ui:refresh_award_ornament_list(data)
  local data_list = data.data_list
  local ornament_id
  local default_source = -1
  local source = data.source
  local title_str
  if default_source ~= source then
    local str_list = Util.split_str(source, "-", false)
    if str_list[3] then
      local ornament_cfg = ShareRes.get_ornaments(str_list[3])
      title_str = ornament_cfg and Util.format_str("奇珍[{1}]生效，获得以下奇珍", ornament_cfg.Name)
    end
  end
  title_str = title_str or curse_com_def.CURSE_GET_AWARD_TIP[data.award_type]
  self.v_uicompents.Title_txt.text = title_str
  local ornament_count = 0
  for _, ornaments_data in ipairs(data_list) do
    ornament_id = ornaments_data.item_id
    local obj = self:get_auto_cache(GET_ORNAMENT_AWARD_TEM)
    local item = ORN_VIEW_ITEM:ui_wrap(self, obj, true)
    item:set_data(ornament_id, true)
    self.v_award_ornament_item_list[ornament_id] = item
    ornament_count = ornament_count + 1
  end
end

function ui:refresh_restore_ornament_list(data)
  local data_list = data.data_list
  local ornament_id
  self.v_uicompents.Title_txt.text = curse_com_def.CURSE_GET_AWARD_TIP[data.award_type]
  local ornament_count = 0
  for _, ornaments_data in ipairs(data_list) do
    ornament_id = ornaments_data.ornament_id
    local obj = self:get_auto_cache(GET_ORNAMENT_AWARD_TEM)
    local item = ORN_VIEW_ITEM:ui_wrap(self, obj, true)
    item:set_data(ornament_id, true)
    self.v_award_ornament_item_list[ornament_id] = item
    ornament_count = ornament_count + 1
  end
end

function ui:remove_all_item()
  self:give_back_auto_cache(GET_ABILITY_AWARD_TEM)
  self:give_back_auto_cache(GET_ORNAMENT_AWARD_TEM)
  for key, item in pairs(self.v_award_ability_item_list) do
    item:ui_hide()
    item:ui_destroy()
    self.v_award_ability_item_list[key] = nil
  end
  for key, item in pairs(self.v_award_ornament_item_list) do
    item:ui_hide()
    item:ui_destroy()
    self.v_award_ornament_item_list[key] = nil
  end
end

function ui:on_click_close_btn()
  if self.v_tween then
    return
  end
  self.v_safearea.alpha = 1
  self.v_tween = self.v_safearea:DOFade(0, 0.5)
  self.v_tween:OnComplete(function()
    self:clear_tween()
    if self.v_award_type == curse_com_def.CURSE_GET_AWARD_TIP_TYPE.GET_ABILITY_LIST then
      self:ui_hide()
      return
    end
    self:refresh()
  end)
end

function ui:is_show_ornament_award()
  return curse_com_def.is_ability_type(self.v_award_type)
end

function ui:is_show_ability_list()
  return curse_com_def.is_ornament_type(self.v_award_type)
end

function ui:set_next_refresh_callback(cb, skip_award_type)
  self.v_next_type_refresh_callback = cb
  self.v_skip_award_type = skip_award_type
end

function ui:invoke_next_type_refresh_callback()
  if self.v_next_type_refresh_callback then
    self.v_next_type_refresh_callback()
    self.v_next_type_refresh_callback = nil
    self.v_show_award_type = nil
  else
    local recuper_room = UIMgr:try_get_visible_ui("curse_recuperation_room")
    if recuper_room then
      recuper_room:check_play_mask_effect()
    end
  end
end

function ui:clear_tween()
  if self.v_tween then
    self.v_tween:Kill(false)
    self.v_tween = nil
  end
end

return ui
