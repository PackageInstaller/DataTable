local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local BIND_TYPE = Config.BIND_TYPE
local SIGNBOARD_PARAM = Config.SIGNBOARD_PARAM
local SIGNBOARD_BUDDY_KEY = "signboard_buddy_key"
local SIGNBOARD_BUDDY_FILTER_KEY = "signboard_buddy_filter_key"
local SIGNBOARD_BUDDY_FILTER_LIST_KEY = "signboard_buddy_filter_list_key"
local Char_Helper = require("uimodule.character.char_helper")
local CharacterConfig = require("uimodule.character.character_config")
local SORT_RULE = CharacterConfig.SORT_RULE
local MODEL = {
  v_buddy_list = {
    "Content",
    BIND_TYPE.OBJECT
  },
  v_buddy_template = {
    "Template",
    BIND_TYPE.OBJECT
  },
  v_filter_content = {
    "FilterContent",
    BIND_TYPE.OBJECT
  },
  v_filter_template = {
    "FilterSelect",
    BIND_TYPE.OBJECT
  },
  v_filter_list = {
    "Filter_List",
    BIND_TYPE.OBJECT
  },
  v_filter_list_template = {
    "Template_Filter",
    BIND_TYPE.OBJECT
  },
  v_left_main_clear_btn = {
    "Button_clear",
    BIND_TYPE.BUTTON
  },
  v_filter_list_clear_btn = {
    "Button_Filter_clear",
    BIND_TYPE.BUTTON
  },
  v_sort_btn = {
    "BtnSortType",
    BIND_TYPE.BUTTON
  },
  v_buddy_sort_type = {
    "BuddySort",
    BIND_TYPE.OBJECT
  },
  v_sort_type_btn1 = {
    "BuddySortType1",
    BIND_TYPE.BUTTON
  },
  v_sort_type_btn2 = {
    "BuddySortType2",
    BIND_TYPE.BUTTON
  },
  v_sort_type_btn3 = {
    "BuddySortType3",
    BIND_TYPE.BUTTON
  }
}

function ui:ui_finish_load()
  self:init_model(MODEL)
  self:set_button("BtnConfirm", function()
    if SignBoardGirlMgr:get_npc_loading() then
      return
    end
    if not self.v_buddy_idx then
      Util.show_message_tip(2232)
      return
    end
    local id = self:get_select_buddy_id()
    local signboard_id = PlayerMgr:get_signboard_girl_id()
    if id == signboard_id then
      Util.show_message_tip(2233)
      return
    end
    SignBoardGirlMgr:set_signboard_buddy_id(id)
    self:do_hide(true)
  end)
  self:set_button("BtnFilter", function()
    self:show_filter_info()
  end)
  self:set_button("BtnRet", function()
    self:do_hide(true)
  end)
  self:set_button("BtnOrderType", function()
    self:click_order_btn()
  end)
  self.v_sort_name_text = Util.get_text("Text", self.v_sort_btn.transform)
  self.v_out_ani = Util.get_child_gameobj("Animation/Ani_UISignBoard_Girl_Change_Out", self.v_object)
  self:register_exist_auto_template(SIGNBOARD_BUDDY_KEY, self.v_buddy_template, self.v_buddy_list)
  self:register_exist_auto_template(SIGNBOARD_BUDDY_FILTER_KEY, self.v_filter_template, self.v_filter_content)
  self:register_exist_auto_template(SIGNBOARD_BUDDY_FILTER_LIST_KEY, self.v_filter_list_template, self.v_filter_list)
  self.v_buddy_idx = nil
end

function ui:do_hide(do_tween)
  self.v_cache_buddy_list = nil
  self.v_order_type = nil
  CharacterMgr:set_screen_condtion(1)
  MsgGame:mq_publish2(Const.MSG_ON_SIGNBOARD_GIRL_CHANGE_UI_HIDE)
  self:clear_exit_seq()
  if do_tween then
    self.v_out_ani:SetActive(true)
    self.v_exit_seq = Util.create_sequence()
    self.v_exit_seq:AppendInterval(0.3)
    self.v_exit_seq:OnComplete(function()
      self:ui_hide()
    end)
  else
    self:ui_hide()
  end
end

function ui:click_order_btn()
  self.sort_by_dec = not self.sort_by_dec
  self:refresh_order_btn()
  local now_id = self:remove_select_and_get_model_id()
  local new_buddy_list = UtilTable.table_reverse(self.v_buddy_data_list)
  self:refresh_buddy_list(new_buddy_list, now_id, true)
end

function ui:refresh_order_btn()
  local order_btn_obj = self.v_uiobjects.BtnOrderType
  local up_active_obj = Util.get_child_gameobj("IconUpActive", order_btn_obj)
  local down_active_obj = Util.get_child_gameobj("IconDownActive", order_btn_obj)
  up_active_obj:SetActive(not self.sort_by_dec)
  down_active_obj:SetActive(self.sort_by_dec)
end

function ui:ui_on_show(hide_Confirm_btn)
  self.v_is_open_fashion = false
  self.v_buddy_sort_type.gameObject:SetActive(false)
  self:init_order_btn_ui()
  self:resgister_event()
  self.v_left_main_clear_btn.gameObject:SetActive(false)
  self:_init_buddy_list()
  self.v_out_ani:SetActive(false)
  self.v_uiobjects.BtnConfirm:SetActive(not hide_Confirm_btn)
  self.v_is_quick_select = hide_Confirm_btn
end

function ui:ui_on_hide()
  self.v_buddy_idx = nil
  self.v_buddy_data_list = nil
  self:clear_all_seq()
  self.v_uiobjects.BlackScreen:SetActive(false)
end

function ui:ui_on_destroy()
end

function ui:resgister_event()
  self:bind_auto_mq(Const.MSG_ON_BUDDY_CHANGE, self.refresh_char_select_list, self)
end

function ui:refresh_char_select_list()
  self.sort_by_dec = false
  self:refresh_order_btn()
  local tag_list = CharacterMgr.v_tag_screen_list
  local element_list = CharacterMgr.v_attr_screen_list
  local job_list = CharacterMgr.v_job_screen_list
  local buddy_list = {}
  local buddy_config = ShareRes.create("buddy.buddy")
  local own_list = UtilTable.copy_table(CharacterMgr:get_buddy_map())
  for _, info in pairs(own_list) do
    local cfg = buddy_config[info.id]
    if 1 ~= cfg.IsShow and CharacterMgr:check_buddy_release(info.id) then
      local tag_cond = not (not UtilTable.is_empty(tag_list) and cfg.Tag) or UtilTable.contains(tag_list, cfg.Tag[1]) or UtilTable.contains(tag_list, cfg.Tag[2])
      local element_cond = not element_list or 0 == #element_list or UtilTable.contains(element_list, cfg.Element)
      local job_cond = not job_list or 0 == #job_list or UtilTable.contains(job_list, cfg.Job)
      if element_cond and job_cond and tag_cond then
        table.insert(buddy_list, info)
      end
    end
  end
  self.v_order_type = CharacterMgr.v_screen_type or 1
  local now_id = self:remove_select_and_get_model_id()
  self:refresh_buddy_list(buddy_list, now_id)
end

function ui:refresh_buddy_list(buddy_list, buddy_id, not_sort)
  if not self.v_visible then
    return
  end
  self:refresh_buddy_data_list(buddy_list, buddy_id, nil, not_sort)
  if not self.v_buddy_idx then
    self.v_buddy_idx = 1
  end
  self:refresh_choose_view()
end

function ui:init_order_btn_ui()
  self.sort_by_dec = false
  self:refresh_order_btn()
end

function ui:_init_buddy_list()
  if not self.v_visible then
    return
  end
  local signboard_id = SignBoardGirlMgr:get_cloth_buddy_cache() or PlayerMgr:get_signboard_girl_id()
  if self.v_cache_buddy_list then
    self:refresh_buddy_data_list(self.v_cache_buddy_list, nil, signboard_id, true)
    self.v_cache_buddy_list = nil
  else
    local buddy_list = self.v_cache_buddy_list or UtilTable.copy_table(CharacterMgr:get_buddy_list_show())
    self:refresh_buddy_data_list(buddy_list, nil, signboard_id)
  end
  if not self.v_buddy_idx then
    self.v_buddy_idx = 1
  end
  self:refresh_choose_view()
end

function ui:refresh_buddy_data_list(buddy_list, buddy_id, signboard_id, not_sort)
  self:give_back_auto_cache(SIGNBOARD_BUDDY_KEY)
  self.v_buddy_data_list = {}
  local buddy_config = ShareRes.create("buddy.buddy")
  for _, buddy in ipairs(buddy_list) do
    local now_id = buddy.id
    buddy.power = CharacterMgr:get_buddy_combat_effectiveness(now_id)
    buddy.element = buddy_config[now_id].Element
    buddy.favor_lv = buddy.favor_lv
  end
  if not not_sort then
    self:sort_type(self.v_order_type, buddy_list)
  end
  for buddy_idx, buddy in ipairs(buddy_list) do
    local now_id = buddy.id
    if signboard_id == now_id and not self.v_buddy_idx then
      self.v_buddy_idx = buddy_idx
    elseif now_id == buddy_id then
      self.v_buddy_idx = buddy_idx
    end
    local buddy_obj = self:get_auto_cache(SIGNBOARD_BUDDY_KEY)
    self:refresh_buddy_icon_info(buddy_obj, buddy)
    self.v_buddy_data_list[buddy_idx] = buddy
    self.v_buddy_data_list[buddy_idx].buddy_obj = buddy_obj
    local choose_img = Util.get_image("Choose", buddy_obj.transform)
    choose_img.gameObject:SetActive(false)
    self:set_button_listener(Util.get_button(nil, buddy_obj), function()
      self:click_char_item(buddy_idx)
      if self.v_is_quick_select then
        self:do_hide(true)
      end
    end)
  end
end

function ui:refresh_choose_view()
  local now_id
  local buddy_info = self.v_buddy_data_list[self.v_buddy_idx]
  if buddy_info then
    now_id = buddy_info.id
  else
    Log.Error("buddy is not exist, buddy idx = ", self.v_buddy_idx)
    return
  end
  local msg = MsgGame:mq_publish2(Const.MSG_ON_BROWSE_SIGNBOARD_GIRL)
  msg.mm_x = now_id
  msg.mm_y = SIGNBOARD_PARAM.CHOOSE_ROLE
  msg.mm_obj = true
  SignBoardGirlMgr:set_cloth_buddy_cache(now_id)
  for index, buddy_data in pairs(self.v_buddy_data_list) do
    local choose_img = Util.get_image("Choose", buddy_data.buddy_obj.transform)
    choose_img.gameObject:SetActive(false)
    if index == self.v_buddy_idx then
      choose_img.gameObject:SetActive(true)
    end
  end
end

function ui:refresh_buddy_icon_info(buddy_obj, buddy_data)
  local id = buddy_data.id
  local signboard_id = PlayerMgr:get_signboard_girl_id()
  local icon_path = UtilUI.get_hero_images(id, Config.CHAR_QUALITY_TYPE.SMALL)
  local buddy_icon = Util.get_image("Head", buddy_obj)
  self:set_buddy_icon_by_id(buddy_icon, icon_path)
  local buddy_quality_path = Char_Helper.get_char_icon_quality(id, Config.CHAR_QUALITY_TYPE.SMALL)
  local buddy_quality = Util.get_image("Pz", buddy_obj)
  self:set_buddy_icon_by_id(buddy_quality, buddy_quality_path)
  local path = CharacterMgr:get_buddy_element_icon_path(id)
  local buddy_element = Util.get_image("Type/Icon", buddy_obj)
  self:set_buddy_icon_by_id(buddy_element, path)
  local now_image = Util.get_image("Now", buddy_obj)
  now_image:SetActive(signboard_id == id)
  local lv_go = Util.get_child_gameobj("Favorability/LV", buddy_obj)
  local favor_lv_txt = Util.get_text("Favorability/Num", buddy_obj)
  local max_lv_go = Util.get_child_gameobj("Favorability/MAX", buddy_obj)
  local favor_lv = buddy_data.favor_lv
  local max_lv = ShareRes.get_max_favor_lv()
  local is_max = favor_lv >= max_lv
  lv_go:SetActive(not is_max)
  favor_lv_txt:SetActive(not is_max)
  max_lv_go:SetActive(is_max)
  if not is_max then
    favor_lv_txt.text = favor_lv
  end
end

function ui:show_filter_info()
  UIMgr:get_ui("screen_buddy_tips"):ui_show(true)
end

function ui:set_buddy_icon_by_id(icon, path)
  ResMgr:load_set_icon(icon, path)
end

function ui:cache_ui()
  return true
end

function ui:get_cache_data()
end

function ui:get_select_buddy_id()
  return self.v_buddy_data_list[self.v_buddy_idx].id
end

function ui:clear_all_seq()
  self:clear_enter_seq()
  self:clear_exit_seq()
  self:clear_black_fade_close_seq()
end

function ui:clear_enter_seq()
  if self.v_enter_seq then
    self.v_enter_seq:Kill(false)
    self.v_enter_seq = nil
  end
end

function ui:clear_black_fade_close_seq()
  if self.v_black_fade_close_seq then
    self.v_black_fade_close_seq:Kill(false)
    self.v_black_fade_close_seq = nil
  end
end

function ui:clear_black_fade_open_seq()
  if self.v_black_fade_open_seq then
    self.v_black_fade_open_seq:Kill(false)
    self.v_black_fade_open_seq = nil
  end
end

function ui:clear_exit_seq()
  if self.v_exit_seq then
    self.v_exit_seq:Kill(false)
    self.v_exit_seq = nil
  end
end

function ui:click_char_item(buddy_idx)
  SignBoardGirlMgr:try_clear_sound_immediately()
  self.v_buddy_idx = buddy_idx
  self:refresh_choose_view()
end

function ui:sort_type(order_type, buddy_list)
  local sort_rule = SORT_RULE[order_type or 1]
  table.sort(buddy_list, function(a, b)
    for _, type in ipairs(sort_rule) do
      if a[type] ~= b[type] then
        return a[type] > b[type]
      end
    end
    if a.element ~= b.element then
      return a.element > b.element
    end
    return a.id > b.id
  end)
end

function ui:remove_select_and_get_model_id()
  local buddy_data = self.v_buddy_data_list[self.v_buddy_idx]
  local buddy_id = buddy_data.id
  self.v_buddy_idx = nil
  return buddy_id
end

return ui
