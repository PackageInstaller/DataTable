local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local player_icon_path_prefix = "Icon/Profile/%s"
local player_card_path_prefix = "CardBG/%s"
local CharcterConfig = require("uimodule.character.character_config")
local PLAY_SET_TITLE = require("uimodule.player.player_set_title")
local LAST_SELECT_BUDDY_IDX_TYPE = CharcterConfig.LAST_SELECT_BUDDY_IDX_TYPE
local GuiUtil = UnityEngine.GUIUtility
local Char_Helper = require("uimodule.character.char_helper")
local TASK_CONFIG = require("gamelogic.task.task_config")
local GETSTATETYPE_ORDER = TASK_CONFIG.GETSTATETYPE_ORDER
local TASK_STATE = TASK_CONFIG.TASK_STATE
local ACHIEVEMENT_SYS_ID = 41

function ui:ui_finish_load()
  self:set_button("BtnReturn", function()
    self:ui_hide()
  end)
  self:set_button("ChangeAvatar", function()
    local select_page = 1
    UIMgr:get_ui("player_avatar_choose"):ui_show(select_page, self.v_player_name)
  end)
  self:set_button("BtnSetCard", function()
    UIMgr:get_ui("player_char_set"):ui_show()
  end)
  self:set_button("BtnLogout", function()
    PlayerMgr:logout()
  end)
  self:set_button("OverWrite", function()
    UIMgr:get_ui("player_change_name"):ui_show(PlayerMgr:on_get_rename_card())
  end)
  self:set_button("InsertIn", function()
    UIMgr:get_ui("player_change_born"):ui_show()
  end)
  self:set_button("Copy", function()
    CS.GoogleDeviceUtilities.CopyToClipboard(self.v_player_data_list.info_list.Id)
    Util.show_message_tip(2193)
  end)
  self:set_button("AssistDetail", function()
    UIMgr:get_ui("assist_info"):ui_show()
  end)
  self.quatation_input_field = self:get_inputfield(nil, self.v_uiobjects.QuotationField)
  self.pre_text_content = self.quatation_input_field.text
  self:set_inputfield_listener(self.quatation_input_field, function()
    self:_quatation_listener()
  end, function()
    if self.pre_text_content == self.quatation_input_field.text then
      return
    else
      self.pre_text_content = self.quatation_input_field.text
    end
    self:_quatation_end_edit_listener()
  end)
end

function ui:ui_on_show()
  self.v_player_data_list = PlayerMgr:on_get_player_info_list()
  self:refresh_view()
  self:register_event()
  self:refresh_aid()
  if PlayerMgr:whether_get_all_titles() then
    self:set_title()
  else
    PlayerMgr:get_all_titles_form_server()
  end
  self:get_panel("titles"):set_enable(false)
  self:wear_visiting_card()
end

function ui:ui_on_hide()
  self.v_player_data_list = nil
  self:remove_feedback_timer()
end

function ui:refresh_view()
  local avatar_cfg = ShareRes.create("player.player_avatar")
  local ucom = self.v_uicompents
  local uobj = self.v_uiobjects
  local player_base_info = self.v_player_data_list.base_info
  local player_info_list = self.v_player_data_list.info_list
  local avatar_id = player_info_list.avatar_id
  local icon_name = nil == avatar_cfg[avatar_id] and avatar_cfg[700051].Icon or avatar_cfg[avatar_id].Icon
  local level = PlayerMgr:get_role_lv()
  local avatar_icon_path = string.format(player_icon_path_prefix, icon_name)
  local name = player_base_info.name
  local birth_month = player_info_list.birth_month
  local birth_day = player_info_list.birth_day
  local player_id = player_info_list.Id
  local quotation = player_info_list.quotation
  local now_exp = player_base_info.exp
  self.v_player_name = name
  ucom.PlayerName_txt.text = name
  if 0 == birth_month then
    ucom.BornDay_txt.text = Util.format_str("未录入")
    ucom.InsertIn_btn.interactable = true
    uobj.BornIcon:SetActive(true)
  else
    ucom.BornDay_txt.text = Util.format_str("{1}月{2}日", birth_month, birth_day)
    ucom.InsertIn_btn.interactable = false
    uobj.BornIcon:SetActive(false)
  end
  ucom.PlayerId_txt.text = player_id
  self.quatation_input_field.text = quotation
  ucom.PlayerLevel_txt.text = level
  ResMgr:load_set_icon(ucom.Profile_img, avatar_icon_path)
  if PlayerMgr:player_lv_is_max() then
    uobj.PlayerLVMax:SetActive(true)
    ucom.ExpNeed_txt.text = "--"
    ucom.ExpNow_txt.text = "--"
    ucom.ExpImage_img.fillAmount = 1
  else
    uobj.PlayerLVMax:SetActive(false)
    local need_exp = PlayerMgr:player_lv_need_exp()
    ucom.ExpNeed_txt.text = need_exp
    ucom.ExpNow_txt.text = now_exp
    ucom.ExpImage_img.fillAmount = now_exp / need_exp
  end
end

function ui:change_birthday(msg)
  if nil == msg or nil == msg.mm_obj then
    return
  end
  local month = msg.mm_obj.month
  local day = msg.mm_obj.day
  local birthday = Util.format_str("{1}月{2}日", month, day)
  self.v_uicompents.BornDay_txt.text = birthday
  self.v_uicompents.InsertIn_btn.interactable = false
  self.v_uiobjects.BornIcon:SetActive(false)
end

function ui:change_player_name(msg)
  if nil == msg or nil == msg.mm_obj then
    return
  end
  local name = msg.mm_obj
  self.v_uicompents.PlayerName_txt.text = name
  self.v_player_name = name
end

function ui:change_player_avatar(msg)
  if nil == msg or nil == msg.mm_obj then
    return
  end
  local avatar_icon_path = string.format(player_icon_path_prefix, msg.mm_obj.Icon)
  ResMgr:load_set_icon(self.v_uicompents.Profile_img, avatar_icon_path)
end

function ui:_quatation_listener()
  local len = Util.get_string_len(self.quatation_input_field.text)
  if len > 15 then
    Util.show_message_tip(2215)
    local old_str = self.quatation_input_field.text
    local new_str = Util.get_sub_string_utf8(old_str, 15)
    self.quatation_input_field.text = new_str
  end
end

function ui:_quatation_end_edit_listener()
  Word_Censor.check_has_sensitive(self:ui_get_name(), self.quatation_input_field.text, function(ok, lab)
    if ok then
      PlayerMgr:upgrade_quotation(self.quatation_input_field.text, function(ok)
        if not ok then
          self.quatation_input_field.text = ""
        end
      end)
    else
      self.quatation_input_field.text = ""
    end
  end, "player_set_quotation")
end

function ui:refresh_aid()
  self.v_uicompents.AssistNow_txt.text = AssistMgr:get_stranger_help_cnt()
  self.v_uicompents.AssistMax_txt.text = AssistMgr:get_max_assist_cnt()
  local aid_list = CharacterMgr:get_aid_hero()
  for pos, buddy_id in ipairs(aid_list) do
    local aid_item = self.v_uiobjects["Assist" .. pos]
    local btn = Util.get_button(nil, aid_item)
    local no_char_item = Util.get_child_gameobj("NoCharObj_", aid_item)
    local char_item = Util.get_child_gameobj("CharObj_", aid_item)
    no_char_item:SetActive(0 == buddy_id)
    char_item:SetActive(0 ~= buddy_id)
    if 0 ~= buddy_id then
      local data = CharacterMgr:get_buddy_by_id(buddy_id)
      self:set_player_aid_char_info(char_item, data)
    end
    if btn then
      self:set_button_listener(btn, function()
        self:on_click_aid_item(pos, buddy_id)
      end)
    end
  end
end

function ui:set_player_aid_char_info(item, data)
  local quality_bg = Util.get_image("QualityBg_", item)
  local char_icon = Util.get_image("Hero/HeroIcon_", item)
  local element_icon = Util.get_image("EleIcon_", item)
  local quality_icon = Util.get_image("Quality_", item)
  local char_lv = Util.get_text("LvNum_", item)
  local potential = Util.get_image("Advance_", item)
  local job = Util.get_image("Job_", item)
  local fashion_id = FashionMgr:get_fashion_wearing_id(data.id)
  local path = UtilUI.get_hero_images(data.id, Config.HERO_ICON_LV.HALF_IMG, fashion_id)
  ResMgr:load_set_icon(char_icon, path, nil, true, self)
  path = Char_Helper.get_char_element_icon(data.id)
  ResMgr:load_set_icon(element_icon, path)
  local quality = ShareRes.get_buddy_cfg(data.id).Quality
  for index = 1, 5 do
    local star_obj = Util.get_child_gameobj("QualityStarLayout_/QualityStar" .. index, item)
    if star_obj then
      star_obj:SetActive(index <= quality)
    end
  end
  path = Char_Helper.get_char_icon_quality(data.id, Config.CHAR_QUALITY_TYPE.LONG)
  ResMgr:load_set_icon(quality_bg, path)
  char_lv.text = string.format("%.2d", data.lv)
  local potential_icon = Char_Helper.get_char_potential_icon_by_advance(data.advance)
  ResMgr:load_set_icon(potential, potential_icon, nil, true)
  local job_path = Char_Helper.get_char_job_icon(data.id, false)
  ResMgr:load_set_icon(job, job_path)
end

function ui:on_click_aid_item(pos, buddy_id)
  local list = CharacterMgr:get_aid_hero()
  local aid_data = {
    select_pos = pos,
    select_buddy_id = buddy_id,
    select_list = list
  }
  CharacterMgr:set_aid_data(aid_data)
  UIMgr:get_ui("character_enter"):ui_show(nil, nil, LAST_SELECT_BUDDY_IDX_TYPE.AID)
end

function ui:register_event()
  self:bind_auto_mq(Const.MSG_ON_CHANGE_BIRTHDAY_SUCCESS, self.change_birthday, self)
  self:bind_auto_mq(Const.MSG_ON_CHANGE_NAME_SUCCESS, self.change_player_name, self)
  self:bind_auto_mq(Const.MSG_ON_CHANGE_AVATAR_SUCCESS, self.change_player_avatar, self)
  self:bind_auto_mq(Const.MSG_ON_GET_ALL_TITLES, self.set_title, self)
  self:bind_auto_mq(Const.MSG_ON_WEAR_TITLE, self.set_title, self)
  self:bind_auto_mq(Const.MSG_TITLE_UI_GET_NEW, self.set_title, self)
  self:bind_auto_mq(Const.MSG_ON_VISITING_CARD_WARE, self.wear_visiting_card, self)
end

function ui:cache_ui()
  return true
end

function ui:remove_feedback_timer()
  if self.v_feedback_timer then
    Timer:remove_timer(self.v_feedback_timer)
    self.v_feedback_timer = nil
  end
end

function ui:_add_feeback_timer()
  self:remove_feedback_timer()
  SDKManager:get_help_center_unread(function(success, data)
    self:_get_help_center_unread(success, data)
  end)
  self.v_feedback_timer = Timer:add_timer("player_feedback_timer", 5, function()
    SDKManager:get_help_center_unread(function(success, data)
      self:_get_help_center_unread(success, data)
    end)
    return true
  end, nil, nil, 5)
end

function ui:_get_help_center_unread(success, data)
  local red_point = self:get_child_gameobj("RedPoint", self.v_uiobjects.BtnFeedback)
  if success and data.unread == "1" then
    red_point:SetActiveEx(data.scene == "3")
  else
    red_point:SetActiveEx(false)
  end
end

function ui:set_title()
  local have_wear_title = PlayerMgr:whether_wear_title()
  if self.v_set_title_obj then
    self.v_set_title_obj:ui_hide()
    self.v_set_title_obj:ui_destroy()
  end
  self.v_set_title_obj = PLAY_SET_TITLE:ui_wrap_ex(self, self.v_uiobjects.TitleObj, true)
  self.v_set_title_obj:set_btn(function()
    self:get_panel("titles"):set_enable(true)
  end)
  if have_wear_title then
    self.v_set_title_obj:set_data(PlayerMgr:get_wear_title().id)
  else
    self.v_set_title_obj:set_data(0)
  end
end

function ui:open_achievement_sys()
  self.v_uicompents.BtnAchievement_btn.enabled = true
  self:refresh_achievement_red_point()
end

function ui:refresh_achievement_red_point()
  local red = Util.get_child_gameobj("redPoint", self.v_uiobjects.BtnAchievement)
  local all_achievements = ShareRes.get_achievements()
  local has_reward = false
  for k, v in pairs(all_achievements) do
    local task_data = TaskMgr:get_task_by_id(v.TaskId)
    if task_data and task_data.state == TASK_STATE.receive then
      has_reward = true
    end
  end
  for k1, v1 in pairs(PlayerMgr:get_achievement_list()) do
    for k2, v2 in pairs(v1) do
      if 1 == v2.state then
        has_reward = true
      end
    end
  end
  red:SetActive(has_reward)
end

function ui:wear_visiting_card()
  local card_id = PlayerMgr:get_wear_visiting_card()
  if card_id then
    self.v_uiobjects.CardIcon:SetActive(true)
    self.v_uiobjects.NoCardIcon:SetActive(false)
    local cfg = ShareRes.get_visiting_card_cfg(card_id)
    local icon_path = string.format(player_card_path_prefix, cfg.Icon)
    ResMgr:load_set_icon(self.v_uicompents.CardIcon_img, icon_path, nil, true)
  else
    self.v_uiobjects.CardIcon:SetActive(false)
    self.v_uiobjects.NoCardIcon:SetActive(true)
  end
end

return ui
