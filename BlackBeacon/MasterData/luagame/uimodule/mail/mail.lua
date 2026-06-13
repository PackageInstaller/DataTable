local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local BIND_TYPE = Config.BIND_TYPE
local ToggleTab = require("ui.widget.widget_toggle_tab")
local AssetBarView = require("ui.asset_bar.asset_bar")
local MailListItem = require("uimodule.mail.mail_list_item")
local _tinsert = table.insert
local _sformat = string.format
local util_get_color = Util.get_unity_color_by_hex
local set_color = Util.set_color
local Toggle_select_color = util_get_color(tonumber("df7b31", 16))
local Toggle_unselect_color = util_get_color(tonumber("bcb4a5", 16))
local Mail_select_subtitle_color_hex = "000000"
local Mail_unselect_subtitle_color_hex = "ffffff"
local Mail_select_subtitle_color = util_get_color(tonumber("000000", 16))
local Mail_unselect_subtitle_color = util_get_color(tonumber("ffffff", 16))
local Mail_select_subdeadtime_color = util_get_color(tonumber("66645f", 16))
local Mail_unselect_subdeadtime_color = util_get_color(tonumber("b4b4b3", 16))
local Mail_select_subitem_color = util_get_color(tonumber("65625d", 16))
local Mail_unselect_subitem_color = util_get_color(tonumber("797a7d", 16))
local mail_content_layout_normal_height = 399
local mail_content_layout_special_height = 593
local interval_spaceing_height = 46
local mail_content_end_height = 116
local MAIL_ITEM_KEY = "MAIL_ITEM"
local MAIL_ATTACHMENT_ITEM_KEY = "MAIL_ATTACHMENT_ITEM"
local MAIL_ATTACHMENT_AWARD_ITEM_KEY = "MAIL_ATTACHMENT_AWARD_ITEM_KEY"
local huge = require("math").huge
local MAIL_TYPE = {NORMAL = 1, IMPORTANT = 2}
local TIME_UNIT = Config.TIME_UNIT
local TIMEUNIT2STR = {
  [TIME_UNIT.DAY] = "天",
  [TIME_UNIT.HOUR] = "小时",
  [TIME_UNIT.MINUTE] = "分钟"
}
local player_icon_path_prefix = "Icon/Profile/%s"
local player_card_path_prefix = "CardBG/%s"
local QUALITY_IDX = {
  [0] = "UICommon/Common_pzk_01",
  [1] = "UICommon/Common_pzk_01",
  [2] = "UICommon/Common_pzk_02",
  [3] = "UICommon/Common_pzk_02",
  [4] = "UICommon/Common_pzk_03",
  [5] = "UICommon/Common_pzk_04"
}
local ITEM_TYPE = {
  TITLE = 19,
  HEAD_ICON = 11,
  CARD = 22
}
local MODEL = {
  v_normal_toggle = {
    "Normal",
    BIND_TYPE.TOGGLE
  },
  v_important_toggle = {
    "Important",
    BIND_TYPE.TOGGLE
  },
  v_mail_set_important_btn = {
    "Button_SetImportant",
    BIND_TYPE.BUTTON
  },
  v_mail_get_attachment_btn = {
    "Button_GetAttachment",
    BIND_TYPE.BUTTON
  },
  v_mail_get_all_btn = {
    "GetAll",
    BIND_TYPE.BUTTON
  }
}

local function _subtitle_color(mail_item, is_select, is_read)
  local txtTile_txt = Util.get_text("txtTile", mail_item)
  local txtDeadLineTime_txt = Util.get_text("txtDeadLineTime", mail_item)
  local deadLineIcon_img = Util.get_image("txtDeadLineTime/DeadLineIcon", mail_item)
  local not_read_obj = Util.get_child_gameobj("NotRead", mail_item)
  local item_icon = Util.get_image("ItemIcon", mail_item)
  local item_icon_open = Util.get_image("ItemIconOpen", mail_item)
  local done_obj = Util.get_child_gameobj("Done", mail_item)
  local not_read_obj = Util.get_child_gameobj("NotRead", mail_item)
  local choose_obj = Util.get_child_gameobj("Choose", mail_item)
  local red_obj = Util.get_child_gameobj("Red", mail_item)
  if is_select or not is_read then
    set_color(txtTile_txt, Mail_select_subtitle_color_hex, 1)
    set_color(txtDeadLineTime_txt, Mail_select_subtitle_color_hex, 0.8)
    set_color(deadLineIcon_img, Mail_select_subtitle_color_hex, 0.8)
    set_color(item_icon, Mail_select_subtitle_color_hex, 0.6)
    set_color(item_icon_open, Mail_select_subtitle_color_hex, 0.6)
    item_icon.color = Mail_select_subitem_color
    not_read_obj:SetActive(true)
  else
    set_color(txtTile_txt, Mail_unselect_subtitle_color_hex, 0.2)
    set_color(txtDeadLineTime_txt, Mail_unselect_subtitle_color_hex, 0.5)
    set_color(deadLineIcon_img, Mail_unselect_subtitle_color_hex, 0.5)
    set_color(item_icon, Mail_unselect_subtitle_color_hex, 0.3)
    set_color(item_icon_open, Mail_unselect_subtitle_color_hex, 0.3)
    item_icon.color = Mail_unselect_subitem_color
    not_read_obj:SetActive(false)
  end
  item_icon.gameObject:SetActive(not is_read)
  item_icon_open.gameObject:SetActive(is_read)
  choose_obj:SetActive(is_select)
  red_obj:SetActive(not is_read)
end

local function mailCmp(mail_a, mail_b)
  if mail_a.read == mail_b.read then
    if mail_a.create_time ~= mail_b.create_time then
      return mail_a.create_time > mail_b.create_time
    end
  else
    return not mail_a.read
  end
end

function ui:ui_finish_load()
  self:init_model(MODEL)
  self:set_button("BtnReturn", function()
    self:ui_hide()
  end)
  self:set_button_listener(self.v_mail_get_all_btn, function()
    self:get_all_mail_attachment()
  end)
  self:set_button("MailDelete", function()
    self:delete_read_mail()
  end)
  self.v_mail_link_content = self.v_uiobjects.MailLinkContent:GetComponent(typeof(CS.TMPro.TMP_Text))
  self.v_uiobjects.ImportantMailDelete:SetActive(false)
  self:register_exist_auto_template(MAIL_ITEM_KEY, self.v_uiobjects.MailTem, self.v_uiobjects.Mail_content)
  self:register_exist_auto_template(MAIL_ATTACHMENT_ITEM_KEY, self.v_uiobjects.Mail_attachment_template, self.v_uiobjects.Mail_attachment_content)
  self:init_toggle_list()
  self:init_mail_max_count()
  self.v_asset_bar = AssetBarView:new(self, self.v_uiobjects.AssetBar)
end

function ui:ui_on_show()
  self.v_asset_bar:on_create()
  self.v_selected_uuid = -1
  self.tab_is_switch = false
  self.sever_time = Date.server_time()
  self.v_toggle_idx = MAIL_TYPE.NORMAL
  self.v_mail_list_id = {}
  self.v_normal_mail_num = 0
  self.v_important_mail_num = 0
  self.v_display_list = {}
  self.v_toggle_tab:set_toggle_by_index(self.v_toggle_idx)
  self:refresh_view(MAIL_TYPE.NORMAL)
end

function ui:ui_on_hide()
  self.v_display_list = nil
  self.v_mail_list_id = nil
  self.v_selected_uuid = nil
  self.v_toggle_idx = nil
  self.v_normal_mail_num = nil
  self.v_important_mail_num = nil
  self.v_asset_bar:on_hide()
end

function ui:ui_on_destroy()
  self.v_asset_bar:on_destory()
  self.v_toggle_tab = nil
  self.v_tag_toggles = nil
end

function ui:refresh_view(idx)
  self:refresh_mail_view(idx)
  local normal_mail_delete_obj = self.v_uiobjects.MailDelete
  local unfinish_num_obj = self.v_uiobjects.Unfinish_Num
  if idx == MAIL_TYPE.NORMAL then
    self.v_mail_get_all_btn.gameObject:SetActive(true)
    normal_mail_delete_obj:SetActive(true)
    unfinish_num_obj:SetActive(true)
  else
    self.v_mail_get_all_btn.gameObject:SetActive(false)
    normal_mail_delete_obj:SetActive(false)
    unfinish_num_obj:SetActive(false)
  end
end

function ui:refresh_mail_view(idx)
  self.v_display_list = {}
  local total_mail_list = MailMgr:get_mail_list()
  self.v_normal_mail_num = 0
  self.v_important_mail_num = 0
  for _, value in pairs(total_mail_list) do
    if value.important == false and not value.delete then
      self.v_normal_mail_num = self.v_normal_mail_num + 1
      if idx == MAIL_TYPE.NORMAL then
        _tinsert(self.v_display_list, value)
      end
    elseif value.important == true and not value.delete then
      self.v_important_mail_num = self.v_important_mail_num + 1
      if idx == MAIL_TYPE.IMPORTANT then
        _tinsert(self.v_display_list, value)
      end
    end
  end
  table.sort(self.v_display_list, mailCmp)
  self.v_uiobjects.NoMailIcon:SetActive(0 == #self.v_display_list)
  self:refresh_mail_item(self.v_display_list)
  self:refresh_mail_num()
end

function ui:refresh_mail_item(mail_display_list)
  self.v_uiobjects.MailNotExist:SetActive(false)
  if next(mail_display_list) ~= nil and -1 == self.v_selected_uuid then
    self.v_selected_uuid = mail_display_list[1].uuid
  end
  local index = 0
  self:clear_wrap_items()
  self.v_mail_items = {}
  self:give_back_auto_cache(MAIL_ITEM_KEY)
  for _, mail_data in pairs(mail_display_list) do
    index = index + 1
    local obj = self:get_auto_cache(MAIL_ITEM_KEY)
    local item = MailListItem:ui_wrap_ex(self, obj, true)
    item:set_data(mail_data)
    self.v_mail_items[mail_data.uuid] = item
  end
  self:select_mail(self.v_selected_uuid)
  self:refresh_page_red()
end

function ui:refresh_page_red()
  local total_mail_list = MailMgr:get_mail_list()
  local normal_no_read = false
  local important_no_read = false
  for _, value in pairs(total_mail_list) do
    if not value.read and not value.delete then
      if value.important then
        important_no_read = true
      else
        normal_no_read = true
      end
    end
    if important_no_read and normal_no_read then
      break
    end
  end
  self.v_uiobjects.NormalRed:SetActive(normal_no_read)
  self.v_uiobjects.ImportantRed:SetActive(important_no_read)
end

function ui:refresh_mail_context(mail_id)
  local mail_info = MailMgr:get_mail_by_id(mail_id)
  if nil == mail_info then
    self.v_uiobjects.MailNotExist:SetActive(true)
    self.v_uiobjects.MailContext:SetActive(false)
    return
  end
  self.v_uiobjects.MailContext:SetActive(true)
  self.v_uiobjects.MailNotExist:SetActive(false)
  self.v_uicompents.MailTitle_txt.text = mail_info.title
  self:set_ui_camera()
  self.v_mail_link_content.text = mail_info.content
  self.v_uicompents.MailSender_txt.text = mail_info.sender
  self.v_uicompents.MailGreeting_txt.text = mail_info.honorific_name
  self.v_uicompents.MailCreateTime_txt.text = Date.standard_data_m_d(mail_info.create_time)
  local important_on = Util.get_child_gameobj("Important_On", self.v_mail_set_important_btn.gameObject)
  important_on:SetActive(mail_info.important == true)
  if mail_info.important then
    self.v_uicompents.MailImportantText_txt.text = Util.format_str("取消重要")
  else
    self.v_uicompents.MailImportantText_txt.text = Util.format_str("设为重要")
  end
  local remain_time, time_unit = Util.sec2time(mail_info.create_time + mail_info.duration - self.sever_time)
  if 0 == mail_info.duration then
    self.v_uicompents.MailDeadLine_txt.text = Util.format_str("永久")
  elseif remain_time >= 0 then
    if 0 == remain_time and time_unit == TIME_UNIT.MINUTE then
      remain_time = 1
    end
    self.v_uicompents.MailDeadLine_txt.text = Util.format_str("{1}{2}", remain_time, TIMEUNIT2STR[time_unit])
  else
    self.v_uicompents.MailDeadLine_txt.text = Util.format_str("已过期")
  end
  local greet_title_height = self.v_uicompents.MailGreeting_txt.preferredHeight
  local content_height = self.v_mail_link_content.preferredHeight
  local mail_content_scroll_rect = Util.get_scrollrect(nil, self.v_uiobjects.MailContentLayout)
  local mail_content_scrollrect = Util.get_scrollrect(nil, self.v_uiobjects.MailContentLayout)
  local mail_content_height = nil ~= next(mail_info.attachment) and mail_content_layout_normal_height or mail_content_layout_special_height
  mail_content_scroll_rect.vertical = mail_content_height <= greet_title_height + content_height + mail_content_end_height + interval_spaceing_height
  mail_content_scrollrect.verticalNormalizedPosition = 1
  local mail_get_attach_btn = self.v_mail_get_attachment_btn
  local attachment_state = self.v_uiobjects.AttachmentState
  local attachment_state_txt = Util.get_text("Text", attachment_state.transform)
  if nil ~= next(mail_info.attachment) then
    self.v_uiobjects.ItemList:SetActive(true)
    self:release_items_by_template_key(MAIL_ATTACHMENT_AWARD_ITEM_KEY)
    self:give_back_auto_cache(MAIL_ATTACHMENT_ITEM_KEY)
    for i, attach_data in pairs(mail_info.attachment) do
      local attachment_item_obj = self:get_auto_cache(MAIL_ATTACHMENT_ITEM_KEY)
      local replace_obj = self:get_child_gameobj("ItemQuality", attachment_item_obj)
      local quality_img = self:get_image(nil, replace_obj)
      local player_card = self:get_child_gameobj("Bg/PlayerCard_", attachment_item_obj)
      local player_card_icon = self:get_image("Bg/PlayerCard_/PlayerCardIcon_", attachment_item_obj)
      local player_profile = self:get_child_gameobj("Bg/PlayerProfile_", attachment_item_obj)
      local profile_icon = self:get_image("Bg/PlayerProfile_/Bg/ProfileIcon_", attachment_item_obj)
      local item_id = attach_data.id
      local head_icon_type = ShareRes.create("item.award_type", ITEM_TYPE.HEAD_ICON)
      local card_type = ShareRes.create("item.award_type", ITEM_TYPE.CARD)
      self:set_button_listener(Util.get_button(nil, attachment_item_obj), function()
      end)
      player_profile:SetActive(false)
      player_card:SetActive(false)
      if item_id >= head_icon_type.IdBegin and item_id <= head_icon_type.IdEnd then
        player_profile:SetActive(true)
        local cfg = ShareRes.get_player_head_cfg(item_id)
        ResMgr:load_set_icon(profile_icon, _sformat(player_icon_path_prefix, cfg.Icon))
        ResMgr:load_set_icon(quality_img, QUALITY_IDX[cfg.Quality])
      elseif item_id >= card_type.IdBegin and item_id <= card_type.IdEnd then
        player_card:SetActive(true)
        local cfg = ShareRes.get_visiting_card_cfg(item_id)
        ResMgr:load_set_icon(player_card_icon, _sformat(player_card_path_prefix, cfg.Icon), nil, true)
        ResMgr:load_set_icon(quality_img, QUALITY_IDX[cfg.Quality])
      else
        self:create_item_obj(nil, replace_obj, MAIL_ATTACHMENT_AWARD_ITEM_KEY, {
          item_id = attach_data.id,
          click_cb = function()
            UIMgr:get_ui("itemTip"):ui_show({
              item_id = attach_data.id
            })
          end
        })
        self:set_button_listener(Util.get_button(nil, attachment_item_obj), function()
          UIMgr:get_ui("itemTip"):ui_show({
            item_id = attach_data.id
          })
        end)
      end
      local is_get_layout = self:get_child_gameobj("IsGetLayout", attachment_item_obj)
      is_get_layout.gameObject:SetActive(true == mail_info.read)
      Util.get_text("ItemAmount/Bg/ItemNum", attachment_item_obj).text = attach_data.count
    end
    if true == mail_info.read then
      mail_get_attach_btn:SetActive(false)
      attachment_state:SetActive(true)
      attachment_state_txt.text = Util.format_str("已领取")
    else
      mail_get_attach_btn:SetActive(true)
      attachment_state:SetActive(false)
      attachment_state_txt.text = Util.format_str("领取")
    end
    local cont_trans = self.v_uicompents.Mail_attachment_content_rect
    cont_trans:SetLocalPositionA(0, cont_trans.localPosition.y, 0)
  else
    self.v_uiobjects.ItemList:SetActive(false)
    mail_get_attach_btn:SetActive(false)
    attachment_state:SetActive(true)
    attachment_state_txt.text = Util.format_str("无附件")
    self:give_back_auto_cache(MAIL_ATTACHMENT_ITEM_KEY)
  end
  self:set_button_listener(Util.get_button(nil, self.v_mail_set_important_btn), function()
    self:upgrade_mail_important(mail_id)
  end)
  self:set_button_listener(Util.get_button(nil, mail_get_attach_btn), function()
    self:get_mail_attachment(mail_id)
  end)
end

function ui:set_ui_camera()
  local link_opener = self.v_uiobjects.MailLinkContent:GetComponent(typeof(CS.LinkOpener))
  link_opener:SetCamera(UIMgr.root_camera)
  link_opener:SetCallBack(function(url)
    SDKManager:open_web_view(url)
  end)
end

function ui:select_mail(uuid)
  local total_mail_list = MailMgr:get_mail_list()
  local pre_mail_obj = self.v_mail_items[self.v_selected_uuid]
  local cur_mail_obj = self.v_mail_items[uuid]
  local is_same = self.v_selected_uuid == uuid
  self.v_selected_uuid = uuid
  if pre_mail_obj then
    pre_mail_obj:update_selected()
  end
  if cur_mail_obj and not is_same then
    cur_mail_obj:update_selected()
  end
  self:refresh_mail_context(uuid)
  if total_mail_list[uuid] and total_mail_list[uuid].read == false and next(total_mail_list[uuid].attachment) == nil then
    MailMgr:upgrade_mail_read(uuid, function(_uuid)
      self:refresh_mail_num()
      self:refresh_mail_context(_uuid)
      cur_mail_obj:read_mail()
    end)
  end
end

function ui:upgrade_mail_important(mail_id)
  local total_mail_list = MailMgr:get_mail_list()
  local mail_data = total_mail_list[mail_id]
  if total_mail_list[mail_id].attachment ~= nil and total_mail_list[mail_id].read == false then
    Util.show_message_tip(1093)
    return
  end
  if self.v_toggle_idx == MAIL_TYPE.NORMAL then
    if self.v_important_mail_num + 1 > self.max_important_mail_num then
      Util.show_message_tip(1094)
      return
    end
  elseif (mail_data.create_time + mail_data.duration > Date.server_time() or 0 == mail_data.duration) and self.v_normal_mail_num + 1 > self.max_normal_mail_num then
    Util.show_message_tip(2203)
    return
  end
  if mail_data.important then
    if 0 == mail_data.duration then
      Util.show_message_tip(2204)
    elseif mail_data.create_time + mail_data.duration <= Date.server_time() then
      Util.show_message_tip(2205)
    else
      Util.show_message_tip(2204)
    end
  elseif 0 == mail_data.duration then
    Util.show_message_tip(2206)
  elseif mail_data.create_time + mail_data.duration <= Date.server_time() then
    Util.show_message_tip(2207)
    return
  else
    Util.show_message_tip(2206)
  end
  for index, value in pairs(self.v_display_list) do
    if self.v_selected_uuid == value.uuid then
      if self.v_display_list[index + 1] then
        self.v_selected_uuid = self.v_display_list[index + 1].uuid
        break
      end
      if self.v_display_list[index - 1] then
        self.v_selected_uuid = self.v_display_list[index - 1].uuid
        break
      end
      self.v_selected_uuid = -1
      break
    end
  end
  MailMgr:upgrade_mail_important(mail_id, function(uuid, important)
    if self:visible() then
      if nil ~= total_mail_list[uuid] then
        total_mail_list[uuid].important = important
      end
      self:refresh_view(self.v_toggle_idx)
    end
  end)
end

function ui:refresh_mail_num()
  local total_mail_list = MailMgr:get_mail_list()
  local unfinish_num = 0
  for i, mail_data in pairs(total_mail_list) do
    if mail_data.read == false and not mail_data.delete then
      unfinish_num = unfinish_num + 1
    end
  end
  local char_now_num_txt = self.v_uicompents.CharNowNum_txt
  local char_max_num_txt = self.v_uicompents.CharMaxNum_txt
  local char_unfinish_num_txt = self.v_uicompents.CharUnfinishNum_txt
  if self.v_toggle_idx == MAIL_TYPE.NORMAL then
    char_now_num_txt.text = self.v_normal_mail_num
    char_max_num_txt.text = self.max_normal_mail_num
    char_unfinish_num_txt.gameObject:SetActive(true)
    char_unfinish_num_txt.text = unfinish_num
  else
    char_now_num_txt.text = self.v_important_mail_num
    char_max_num_txt.text = self.max_important_mail_num
    char_unfinish_num_txt.gameObject:SetActive(false)
  end
end

function ui:init_toggle_list()
  self.v_tag_toggles = {
    self.v_normal_toggle,
    self.v_important_toggle
  }
  self.v_toggle_tab = ToggleTab:new(self)
  self.v_normal_toggle.interactable = false
  self.v_important_toggle.interactable = true
  self.v_toggle_tab:init_by_toggles(self.v_tag_toggles, function(cur_select, pre_select, cur_toggle, pre_toggle)
    self:select_tag_toggle(cur_select, pre_select, cur_toggle, pre_toggle)
  end, MAIL_TYPE.NORMAL)
end

function ui:select_tag_toggle(cur_select, pre_select, cur_toggle, pre_toggle)
  self.v_toggle_idx = cur_select
  self.v_selected_uuid = -1
  if cur_select ~= pre_select then
    cur_toggle.interactable = false
    pre_toggle.interactable = true
  end
  self.tab_is_switch = true
  self:refresh_view(cur_select)
  self.tab_is_switch = false
end

function ui:delete_read_mail()
  local total_mail_list = MailMgr:get_mail_list()
  local is_mail_has_read = false
  for _, mail_data in pairs(self.v_display_list) do
    if not mail_data.delete and mail_data.read == true and mail_data.important == false then
      is_mail_has_read = true
      break
    end
  end
  if not is_mail_has_read then
    Util.show_message_tip(2208)
  else
    UIMgr:get_ui("uinotice_tips"):ui_show(function()
      MailMgr:delete_all_read_mail(function(uuid_list)
        for _, uuid in pairs(uuid_list) do
          total_mail_list[uuid].delete = true
          if self.v_selected_uuid == uuid then
            self.v_selected_uuid = -1
          end
        end
        self:refresh_view(self.v_toggle_idx)
      end)
    end, nil, "确认删除所有已完成邮件", "确认", "返回")
  end
end

function ui:get_all_mail_attachment()
  local total_mail_list = MailMgr:get_mail_list()
  local mail_list = {}
  for _, mail in pairs(total_mail_list) do
    if not mail.read and mail.attachment and next(mail.attachment) ~= nil then
      mail_list[#mail_list + 1] = mail.uuid
    end
  end
  if #mail_list <= 0 then
    Util.show_message_tip(1682)
    return
  end
  MailMgr:get_mail_costitem_list(mail_list, function(uuid_list)
    for _, uuid in pairs(uuid_list) do
      if self.v_selected_uuid == uuid then
        self.v_selected_uuid = -1
        break
      end
    end
    self:refresh_view(self.v_toggle_idx)
  end)
end

function ui:get_item_count(type, id)
  if type == Config.AWARD_TYPE.ITEM then
    return BagMgr:get_item_num(id)
  elseif type == Config.AWARD_TYPE.EQUIP then
    return #(CharacterMgr:get_equip_list() or {})
  else
    return -huge
  end
end

function ui:get_mail_attachment(mail_id)
  MailMgr:upgrade_mail_read(mail_id, function(uuid)
    self:refresh_view(self.v_toggle_idx)
  end)
end

function ui:init_mail_max_count()
  local single_key_define_cfg = ShareRes.create("single_key_define")
  self.max_normal_mail_num = single_key_define_cfg.MailMaxCnt
  self.max_important_mail_num = single_key_define_cfg.MailImportantCnt
end

function ui:clear_wrap_items()
  if self.v_mail_items then
    for _, item in pairs(self.v_mail_items) do
      item:ui_hide()
      item:ui_destroy()
    end
    self.v_mail_items = nil
  end
end

function ui:get_selected_mail()
  return self.v_selected_uuid
end

return ui
