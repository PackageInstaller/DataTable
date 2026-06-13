local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local StaicSv = require("uimodule.notice.local_widgets.sv_list")
local SvItem = require("uimodule.notice.local_widgets.notice_item")
local ToggleTabClass = require("ui.widget.widget_toggle_tab")
local Notice_Cfg = require("uimodule.notice.notice_cfg")
local CommonDefind = require("cs_share.common_define")
local NOTICE_TYPE = CommonDefind.NOTICE_TYPE
local JumpCfg = ShareRes.create("sysopen.sys_jump")
local ActivityCfg = require("gamelogic.activity.activity_config")
local BIND_TYPE = Config.BIND_TYPE
local _tinsert = table.insert
local _tsort = table.sort
local util_get_color = Util.get_unity_color_by_hex
local toggle_select_color = util_get_color(tonumber("F5EDE2", 16))
local toggle_unselect_color = util_get_color(tonumber("484243", 16))
local MODEL = {
  v_item_content = {
    "NoticeList",
    BIND_TYPE.OBJECT
  },
  v_toggle_activity = {
    "Activity",
    BIND_TYPE.TOGGLE
  },
  v_toggle_system = {
    "System",
    BIND_TYPE.TOGGLE
  }
}

local function activity_sort(a, b)
  if a.priority == b.priority then
    if a.start_time == b.start_time then
      if a.id == b.id then
        return a.cdn_index > b.cdn_index
      end
      return a.id > b.id
    else
      return a.start_time > b.start_time
    end
  else
    return a.priority > b.priority
  end
end

local function system_sort(a, b)
  if a.priority == b.priority then
    if a.start_time == b.start_time then
      return a.id > b.id
    else
      return a.start_time > b.start_time
    end
  else
    return a.priority > b.priority
  end
end

function ui:ui_finish_load()
  self:init_model(MODEL)
  self:init_toggle()
  self:set_button("BtnReturn", function()
    local offline_list = self.v_offline_notice_data_list
    self:ui_hide()
    if nil == offline_list then
      UIMgr:get_ui("uimain"):ui_show()
    end
  end)
  self:set_button("BgReturn", function()
    local offline_list = self.v_offline_notice_data_list
    self:ui_hide()
    if nil == offline_list then
      UIMgr:get_ui("uimain"):ui_show()
    end
  end)
  self:set_button("IfJump", function()
    local jump_id = self.jump_id
    local offline_list = self.v_offline_notice_data_list
    if nil == offline_list then
      if nil ~= JumpCfg[jump_id] then
        local jump_cfg = JumpCfg[jump_id]
        if SysOpenMgr:get_sys_is_open(jump_cfg.sys_id) then
          local activity_id = ActivityCfg.SYSID_TO_ACTY_TYPE[jump_cfg.sys_id]
          if nil ~= activity_id and ActivityMgr:get_activity_is_open(activity_id) then
            self:ui_hide()
          end
        end
      end
      local suc = SysOpenMgr:jump_to_sys(jump_id, true)
      if suc then
        self:ui_hide()
      end
    end
  end)
  self.v_child_list = StaicSv:new(self, self.v_item_content, SvItem, "NOTICE_ITEM")
end

function ui:ui_on_show(data)
  NoticeMgr:set_ignore_notice_main_red()
  if nil ~= data then
    self.v_offline_notice_data_list = self:_get_offline_notice_data(data)
    self.v_toggle_idx = Notice_Cfg.TOGGLE_TAB.SYSTEM
    self.v_uiobjects.SystemRedPoint:SetActive(false)
    self.v_uiobjects.Activity:SetActive(false)
    self.v_uiobjects.NoticeBanner:SetActive(false)
    self:_set_toggle_mask(true)
    self:refresh_view(self.v_toggle_idx)
  else
    self.v_activity_notice_data_list = NoticeMgr:get_notice_data_list(NOTICE_TYPE.ACTIVITY)
    self.v_system_notice_data_list = NoticeMgr:get_notice_data_list(NOTICE_TYPE.SYSTEM)
    self.v_activity_notice_data_list_cdn = NoticeMgr:get_notice_data_list_cdn(NOTICE_TYPE.ACTIVITY)
    self.v_system_notice_data_list_cdn = NoticeMgr:get_notice_data_list_cdn(NOTICE_TYPE.SYSTEM)
    local sys_notice_empty = not next(self.v_system_notice_data_list) and not next(self.v_system_notice_data_list_cdn)
    local act_notice_empty = not next(self.v_activity_notice_data_list) and not next(self.v_activity_notice_data_list_cdn)
    self.v_uiobjects.Activity:SetActive(not sys_notice_empty)
    self.v_uiobjects.System:SetActive(not act_notice_empty)
    self.v_toggle_idx = sys_notice_empty and Notice_Cfg.TOGGLE_TAB.ACTIVITY or Notice_Cfg.TOGGLE_TAB.SYSTEM
    self:_set_toggle_mask(false)
    self:refresh_view(self.v_toggle_idx)
  end
  self:register_listener()
  self.v_uiobjects.NoNotice:SetActive(NoticeMgr:get_is_no_notice())
end

function ui:ui_on_hide()
  if self.v_offline_notice_data_list == nil then
    NoticeMgr:save_local_read_data()
  end
  self.v_child_list:clear()
  self.v_toggle_idx = nil
  self.v_activity_notice_data_list = nil
  self.v_system_notice_data_list = nil
  self.v_offline_notice_data_list = nil
  self.jump_id = nil
end

function ui:ui_on_destroy()
  self.v_child_list = nil
  self.v_toggle_tab = nil
  self.v_toggle_tab_toggles = nil
end

function ui:init_toggle()
  self.v_toggle_tab_toggles = {
    self.v_toggle_activity,
    self.v_toggle_system
  }
  self.v_toggle_tab = ToggleTabClass:new(self)
  self.v_toggle_tab:init_by_toggles(self.v_toggle_tab_toggles, function(cur_select, pre_select, cur_toggle, pre_toggle)
    self:select_title_toggle(cur_select, pre_select, cur_toggle, pre_toggle)
  end, Notice_Cfg.TOGGLE_TAB.ACTIVITY)
end

function ui:refresh_view(type)
  self.v_toggle_tab:set_toggle_by_index(type)
  self:refresh_notice_item()
end

function ui:refresh_notice_item()
  if self.v_offline_notice_data_list == nil then
    self:on_show_toggle_red()
  end
  self:_update_display_tb()
  self:_location_unread_notice_pos()
end

function ui:refresh_item_context(data)
  local uobj = self.v_uiobjects
  local ucom = self.v_uicompents
  local content_scrollrect = Util.get_scrollrect(nil, uobj.ContentScroll)
  content_scrollrect.verticalNormalizedPosition = 1
  if data.cdn_index then
    ucom.Title_txt.text = data.title
    self:set_link_content(data.content)
    self.jump_id = nil
    uobj.IfJump:SetActive(false)
  else
    ucom.Title_txt.text = ShareRes.get_notice_txt_by_id(data.title)
    self:set_link_content(ShareRes.get_notice_txt_by_id(data.content))
    self.jump_id = data.jump_id
    uobj.IfJump:SetActive(data.jump_id and 0 ~= data.jump_id)
  end
  self:safe_set_picture(data.jump_image)
end

function ui:set_link_content(content)
  content = string.gsub(content, "\\r", " ")
  self.v_uiobjects.NoticeContent:SetActive(false)
  self.v_uiobjects.NoticeLinkContent:SetActive(true)
  self:set_ui_camera()
  local tmp_text = self.v_uiobjects.NoticeLinkContent:GetComponent(typeof(CS.TMPro.TMP_Text))
  tmp_text.text = content
end

function ui:safe_set_picture(picture)
  if picture and "" ~= picture then
    local picture_path = Path.get_texture_path(picture)
    local is_file_exist = true
    if Game_AssetBundle then
      if not Global.res_mgr:is_res_exist(picture_path) then
        is_file_exist = false
      end
    elseif not CSHelper.IsFileExist(picture_path) then
      is_file_exist = false
    end
    if is_file_exist then
      ResMgr:load_set_icon(self.v_uicompents.NoticeBanner_img, picture, nil, true)
    else
      Log.Error("未找到路径", picture_path)
      self.v_uiobjects.NoticeBanner:SetActive(false)
    end
  else
    self.v_uiobjects.NoticeBanner:SetActive(false)
  end
end

function ui:set_ui_camera()
  local link_opener = self.v_uiobjects.NoticeLinkContent:GetComponent(typeof(CS.LinkOpener))
  link_opener:SetCamera(UIMgr.root_camera)
  link_opener:SetCallBack(function(url)
    SDKManager:open_web_view(url)
  end)
end

function ui:register_listener()
  self:bind_auto_mq(Const.MSG_ON_SELECTED_NOTICE_ITEM, self.on_item_selected, self)
  self:bind_auto_mq(Const.MSG_ON_NOTICE_UPDATE_READ, self.on_show_toggle_red, self)
end

function ui:on_show_toggle_red()
  if NoticeMgr:have_not_read_activity_notice() then
    self.v_uiobjects.ActivityRedPoint:SetActive(true)
  else
    self.v_uiobjects.ActivityRedPoint:SetActive(false)
  end
  if NoticeMgr:have_not_read_system_notice() then
    self.v_uiobjects.SystemRedPoint:SetActive(true)
  else
    self.v_uiobjects.SystemRedPoint:SetActive(false)
  end
end

function ui:on_item_selected(msg)
  local data = msg.mm_obj
  local select_idx = data.idx
  local select_item = self.v_child_list:get_item_by_idx(select_idx)
  self.v_child_list:on_select_change(select_item)
  self:refresh_item_context(data)
end

function ui:select_title_toggle(cur_select, pre_select, cur_toggle, pre_toggle)
  self.v_toggle_idx = cur_select
  self:_set_toggle_mask(false)
  self:refresh_notice_item()
end

function ui:_get_offline_notice_data(data)
  local temp_tb = {}
  for index, notice_data in pairs(data) do
    if notice_data.type == NOTICE_TYPE.SYSTEM then
      local start_time = notice_data.start_time
      local tb = {
        type = notice_data.type,
        title = notice_data.title,
        content = notice_data.content,
        month = tonumber(os.date("!%m", start_time)),
        day = tonumber(os.date("!%d", start_time)),
        start_time = notice_data.start_time,
        end_time = notice_data.end_time
      }
      _tinsert(temp_tb, tb)
    end
  end
  return temp_tb
end

function ui:_update_display_tb()
  self.display_tb = {}
  if self.v_toggle_idx == NOTICE_TYPE.ACTIVITY then
    for _, notice_data in pairs(self.v_activity_notice_data_list) do
      if Date.server_time() >= notice_data.start_time and Date.server_time() <= notice_data.end_time then
        _tinsert(self.display_tb, notice_data)
      end
    end
    for _, cdn_notice in ipairs(self.v_activity_notice_data_list_cdn) do
      _tinsert(self.display_tb, cdn_notice)
    end
    _tsort(self.display_tb, activity_sort)
  elseif self.v_toggle_idx == NOTICE_TYPE.SYSTEM then
    local list
    if self.v_offline_notice_data_list ~= nil then
      list = self.v_offline_notice_data_list
      for _, notice_data in pairs(list) do
        if Date.server_time() >= notice_data.start_time and Date.server_time() <= notice_data.end_time then
          _tinsert(self.display_tb, notice_data)
        end
      end
    else
      list = self.v_system_notice_data_list
      for _, notice_data in pairs(list) do
        if not notice_data.is_delete and Date.server_time() >= notice_data.start_time and Date.server_time() <= notice_data.end_time then
          _tinsert(self.display_tb, notice_data)
        end
      end
    end
    for _, cdn_notice in ipairs(self.v_system_notice_data_list_cdn) do
      _tinsert(self.display_tb, cdn_notice)
    end
    _tsort(self.display_tb, system_sort)
  end
  self.v_child_list:update_list(self.display_tb)
end

function ui:_location_unread_notice_pos()
  local uobj = self.v_uiobjects
  local content_obj = uobj.Content
  local notice_view_obj = uobj.NoticeView
  local next_num = next(self.display_tb)
  if nil ~= next_num then
    local msg = {}
    local is_all_read = true
    local select_index = next_num
    if nil == self.v_offline_notice_data_list then
      for index, notice_data in pairs(self.display_tb) do
        if self.v_toggle_idx == NOTICE_TYPE.ACTIVITY then
          if 0 == notice_data.is_read then
            msg.mm_obj = notice_data
            is_all_read = false
            select_index = index
            break
          end
        elseif self.v_toggle_idx == NOTICE_TYPE.SYSTEM and not notice_data.is_read then
          msg.mm_obj = notice_data
          is_all_read = false
          select_index = index
          break
        end
      end
    end
    local notice_scrollrect = Util.get_scrollrect(nil, uobj.NoticeView)
    local length = #self.display_tb
    if select_index <= 5 then
      notice_scrollrect.verticalNormalizedPosition = 1
    elseif length - select_index <= 5 then
      notice_scrollrect.verticalNormalizedPosition = 0
    else
      notice_scrollrect.verticalNormalizedPosition = 1 - select_index / length
    end
    if is_all_read then
      msg.mm_obj = self.display_tb[select_index]
    end
    self:on_item_selected(msg)
    content_obj:SetActive(true)
    notice_view_obj:SetActive(true)
  else
    content_obj:SetActive(false)
    notice_view_obj:SetActive(false)
  end
end

function ui:_set_toggle_mask(is_offline_notice)
  if is_offline_notice then
    Util.get_text("Label", self.v_uiobjects.System).color = toggle_select_color
  else
    Util.get_text("Label", self.v_uiobjects.Activity).color = self.v_toggle_idx == Notice_Cfg.TOGGLE_TAB.ACTIVITY and toggle_select_color or toggle_unselect_color
    Util.get_text("Label", self.v_uiobjects.System).color = self.v_toggle_idx == Notice_Cfg.TOGGLE_TAB.SYSTEM and toggle_select_color or toggle_unselect_color
  end
end

return ui
