local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local StaicSv = require("ui.widget.static_scroll_view")
local SvItem = require("uimodule.notice.notice_login_item")
local template_key = "notice_login_main_key"
local Notice_Cfg = require("uimodule.notice.notice_cfg")
local ToggleTabClass = require("ui.widget.widget_toggle_tab")
local CommonDefind = require("cs_share.common_define")
local item_color = {
  select = {color_str = "484243", alpha = 0.8},
  un_select = {color_str = "F5EDE2", alpha = 0.6}
}
local NOTICE_TYPE = CommonDefind.NOTICE_TYPE
local TSI_NOTICE_CHANNEL_LIMIT_TYPE = CommonDefind.TSI_NOTICE_CHANNEL_LIMIT_TYPE

function ui:ui_finish_load()
  self:set_button("BtnReturn", function()
    self:ui_hide()
  end)
  self:set_button("BgReturn", function()
    self:ui_hide()
  end)
  self:init_toggle()
  self.v_content_rect = self:get_rect_transform("Viewport/Content", self.v_uiobjects.ContentScroll)
  self.notice_list = StaicSv:new(self, self.v_uiobjects.NoticeList, SvItem, template_key)
  self.v_remote_sprite_list = {}
end

function ui:ui_on_show(data)
  data = data or Global.notice_data
  self:hide_title()
  self.notice_data = data
  Global.notice_data = data
  self.v_toggle_idx = Notice_Cfg.TOGGLE_TAB.ACTIVITY
  table.sort(data, function(a, b)
    return (a.sort_id or 1) < (b.sort_id or 1)
  end)
  if SDKType == Config.SDK_TYPE.HIVE_SDK then
    self.v_toggle_idx = self:get_hive_notice_default_idx()
    self.v_toggle_tab:set_toggle_by_index(self.v_toggle_idx)
    self:refresh_notice_list(self.v_toggle_idx)
  else
    self:refresh_notice_list()
  end
  self:register_listener()
end

function ui:get_hive_notice_default_idx()
  local have_act_page = false
  local have_sys_page = false
  for _, content in pairs(self.notice_data) do
    if content.paging == Notice_Cfg.TOGGLE_TAB.ACTIVITY then
      have_act_page = true
    elseif content.paging == Notice_Cfg.TOGGLE_TAB.SYSTEM then
      have_sys_page = true
    end
  end
  self.v_uiobjects.Activity:SetActive(have_act_page)
  self.v_uiobjects.System:SetActive(have_sys_page)
  if have_act_page then
    return Notice_Cfg.TOGGLE_TAB.ACTIVITY
  end
  return Notice_Cfg.TOGGLE_TAB.SYSTEM
end

function ui:ui_on_hide()
  self.curr_select_item = nil
  self.notice_list:clear()
end

function ui:ui_on_destroy()
  self.notice_list = nil
  self.v_remote_sprite_list = nil
end

function ui:register_listener()
  self:bind_auto_mq(Const.MSG_ON_SELECTED_NOTICE_LOGIN_ITEM, self.on_item_click, self)
end

function ui:init_toggle()
  self.v_toggle_tab_toggles = {
    self.v_uicompents.Activity_tog,
    self.v_uicompents.System_tog
  }
  self.v_toggle_tab = ToggleTabClass:new(self)
  self.v_toggle_tab:init_by_toggles(self.v_toggle_tab_toggles, function(cur_select, pre_select, cur_toggle, pre_toggle)
    self:select_title_toggle(cur_select, pre_select, cur_toggle, pre_toggle)
  end, Notice_Cfg.TOGGLE_TAB.ACTIVITY)
end

function ui:select_title_toggle(cur_select, pre_select, cur_toggle, pre_toggle)
  self.v_toggle_idx = cur_select
  self:refresh_notice_list(self.v_toggle_idx)
end

function ui:refresh_notice_list(page)
  local result_data = {}
  if not page then
    for i, v in pairs(self.notice_data) do
      if v.is_show_game and 2 == v.is_show_game or v.game_paging and v.game_paging == NOTICE_TYPE.LOGIN_MODE_NOTICE and (v.limit_platform == TSI_NOTICE_CHANNEL_LIMIT_TYPE.ALL_CHANNEL or SDKManager:check_sdk_notice_is_show(v.channel_list)) then
        table.insert(result_data, v)
      end
    end
  else
    for i, v in pairs(self.notice_data) do
      if not v.paging or v.paging == page then
        table.insert(result_data, v)
      end
    end
  end
  self.curr_select_item = nil
  self.notice_list:update_list(result_data)
  self:set_selected(self.notice_list:get_item_by_idx(1))
end

function ui:set_selected(notice_item)
  if self.v_content_rect then
    self.v_content_rect:SetAnchoredPositionA(0, 0, 0)
  end
  if self.curr_select_item then
    self.curr_select_item:set_selected(false)
  end
  self.curr_select_item = notice_item
  self.curr_select_item:set_selected(true)
  self:refresh_language_info(self.curr_select_item.item_data)
end

function ui:on_item_click(msg)
  local notice_item = msg.mm_obj
  self:set_selected(notice_item)
end

function ui:refresh_content(item_data)
  self:refresh_title_content(item_data.title, item_data.content)
  if item_data.picture and item_data.picture ~= "" then
    local picture_path = Path.get_texture_path(item_data.picture)
    local is_file_exist = true
    if Game_AssetBundle then
      if not Global.res_mgr:is_res_exist(picture_path) then
        is_file_exist = false
      end
    elseif not CSHelper.IsFileExist(picture_path) then
      is_file_exist = false
    end
    if is_file_exist then
      ResMgr:load_set_icon(self.v_uicompents.NoticeBanner_img, item_data.picture, nil, true)
    else
      Log.Error("未找到路径", picture_path)
    end
  end
end

function ui:refresh_language_info(item_data)
  if not item_data.is_abroad then
    self:refresh_content(item_data)
    return
  end
  local language_data
  if item_data.other_language and #item_data.other_language > 0 then
    for i, v in pairs(item_data.other_language) do
      if v.language_type == Global.curr_text_language then
        language_data = v
        break
      end
    end
  end
  if not language_data then
    language_data = {}
    language_data.title = item_data.title
    language_data.content = item_data.content
    language_data.picture = item_data.picture
  end
  self:refresh_title_content(language_data.title, language_data.content)
  if self.v_remote_sprite_list[language_data.picture] then
    self.v_uicompents.NoticeBanner_img.sprite = self.v_remote_sprite_list[language_data.picture]
  else
    local url = SDKManager:get_notice_url(language_data.picture)
    CSHelper.RequestSprite(url, function(sp)
      self.v_remote_sprite_list[language_data.picture] = sp
      self.v_uicompents.NoticeBanner_img.sprite = sp
    end)
  end
end

function ui:refresh_title_content(title_value, content_value)
  local content = string.gsub(content_value, "\\r", " ")
  self.v_uicompents.Title_txt.text = title_value
  self.v_uiobjects.NoticeContent:SetActive(false)
  self.v_uiobjects.NoticeLinkContent:SetActive(true)
  self:set_ui_camera()
  local tmp_text = self.v_uiobjects.NoticeLinkContent:GetComponent(typeof(CS.TMPro.TMP_Text))
  tmp_text.text = content
end

function ui:set_ui_camera()
  local link_opener = self.v_uiobjects.NoticeLinkContent:GetComponent(typeof(CS.LinkOpener))
  link_opener:SetCamera(UIMgr.root_camera)
  link_opener:SetCallBack(function(url)
    SDKManager:open_web_view(url)
  end)
end

function ui:hide_title()
  self.v_uiobjects.Activity:SetActive(SDKType == Config.SDK_TYPE.HIVE_SDK)
  self.v_uiobjects.System:SetActive(SDKType == Config.SDK_TYPE.HIVE_SDK)
  self.v_uiobjects.ActivityRedPoint:SetActive(false)
  self.v_uiobjects.SystemRedPoint:SetActive(false)
  self.v_uiobjects.NoNotice:SetActive(false)
  self.v_uiobjects.IfJump:SetActive(false)
end

return ui
