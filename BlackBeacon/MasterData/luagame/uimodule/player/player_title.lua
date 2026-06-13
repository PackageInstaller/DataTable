local Base = require("ui.uiobject")
local ui = Util.create_child_mt(Base)
local ToggleTab = require("ui.widget.widget_toggle_tab")
local LoopListClass = require("ui.widget.infinite_loop_list")
local _tinsert = table.insert
local _tsort = table.sort
local _max = math.max
local TITLE_TEM_CLASS = require("uimodule.player.player_title_tem")
local PAGE = {
  ALL = 1,
  GET = 2,
  NO_GET = 3
}
local ACHIEVEMENT_SYS_ID = 41
local NO_TITLE_ID = 910000
local BIND_TYPE = Config.BIND_TYPE
local MODEL = {
  v_all = {
    "All",
    BIND_TYPE.TOGGLE
  },
  v_got = {
    "Got",
    BIND_TYPE.TOGGLE
  },
  v_no_get = {
    "NoGet",
    BIND_TYPE.TOGGLE
  },
  v_title_tem = {
    "TitleTem",
    BIND_TYPE.OBJECT
  },
  v_member_title = {
    "MemberTitle",
    BIND_TYPE.OBJECT
  },
  v_course_title = {
    "CourseTitle",
    BIND_TYPE.OBJECT
  },
  v_lv_member = {
    "MemberLv",
    BIND_TYPE.TEXT
  },
  v_lv_course = {
    "CourseLv",
    BIND_TYPE.TEXT
  },
  v_title_desc = {
    "TitleDesc",
    BIND_TYPE.TEXT
  },
  v_name_member = {
    "MemberName",
    BIND_TYPE.TEXT
  },
  v_name_course = {
    "CourseName",
    BIND_TYPE.TEXT
  },
  v_un_lock_way = {
    "UnLockWay",
    BIND_TYPE.TEXT
  },
  v_unLock_txt_obj = {
    "UnLock",
    BIND_TYPE.OBJECT
  },
  v_btn_wear = {
    "BtnWear",
    BIND_TYPE.BUTTON
  },
  v_btn_to_get = {
    "BtnToGet",
    BIND_TYPE.BUTTON
  },
  v_icon_member = {
    "MemberEyes",
    BIND_TYPE.IMAGE
  },
  v_icon_course = {
    "CourseIcon2",
    BIND_TYPE.IMAGE
  },
  v_quality_bg_member = {
    "QualityBg2",
    BIND_TYPE.IMAGE
  },
  v_quality_bg_course = {
    "QualityBg1",
    BIND_TYPE.IMAGE
  },
  v_bg_member = {
    "MemberTitle",
    BIND_TYPE.IMAGE
  },
  v_bg_course = {
    "CourseTitle",
    BIND_TYPE.IMAGE
  },
  v_hold_max = {
    "HoldMax",
    BIND_TYPE.TEXT
  },
  v_hold_now = {
    "HoldNow",
    BIND_TYPE.TEXT
  },
  v_title_info = {
    "TitleInfo",
    BIND_TYPE.OBJECT
  },
  v_title_obj = {
    "TitleObj",
    BIND_TYPE.OBJECT
  },
  v_no_title_desc = {
    "NoTitleDesc",
    BIND_TYPE.OBJECT
  },
  v_title_scroll_view = {
    "Title_ScrollView",
    BIND_TYPE.OBJECT
  },
  v_no_achivev_title = {
    "NoAchivev",
    BIND_TYPE.OBJECT
  },
  v_no_get_btn = {
    "BtnNoGet",
    BIND_TYPE.OBJECT
  }
}

function ui:ui_finish_load()
  self:init_model(MODEL)
  self:set_button("BtnWear", function()
    if next(self.v_cur_show_data) then
      local title = self.v_click_title_data
      local id = title.cfg.Id
      if PlayerMgr:whether_wear_title() and PlayerMgr:get_wear_title().id == id then
        Util.show_message_tip(2337)
        return
      end
      if 1 == title.other_info.is_get or id == NO_TITLE_ID then
        if id == NO_TITLE_ID then
          self.v_btn_wear.enabled = false
          if PlayerMgr:whether_wear_title() then
            PlayerMgr:take_off_title()
          else
            self.v_btn_wear.enabled = true
            Util.show_message_tip(2338)
          end
        else
          PlayerMgr:wear_title(id, function()
            Util.show_message_tip(2337)
          end)
        end
      else
        Util.show_message_tip(2339)
      end
    end
  end)
  self:set_button("CloseBtn", function()
    self:close_ui_title()
  end)
  self:set_button("CloseBtn1", function()
    self:close_ui_title()
  end)
  local pages = {
    self.v_all,
    self.v_got,
    self.v_no_get
  }
  self.v_page_toggle_tab = ToggleTab:new(self)
  self.v_page_toggle_tab:init_by_toggles(pages, function(idx)
    self:_on_click_page(idx)
  end, 0)
  self.v_select_idx = 1
  self.v_title_loop_list = LoopListClass:new(self, self.v_title_scroll_view, TITLE_TEM_CLASS)
end

function ui:close_ui_title()
  if not self.v_exit_pd then
    self:set_enable(false)
  end
  if self.v_on_exiting_pd then
    return
  end
  self.v_on_exiting_pd = true
  local exit_pd = self.v_exit_pd
  self:remove_playable_stopped_action(exit_pd)
  self:set_playable_stopped_action(exit_pd, function()
    if self:is_destroy() or not self:visible() then
      return
    end
    self:set_enable(false)
    self.v_on_exiting_pd = false
    if not Util.is_nil(exit_pd) then
      self:remove_playable_stopped_action(exit_pd)
    end
  end)
  exit_pd:RePlayPD()
end

function ui:register_event()
  self:bind_auto_mq(Const.MSG_ON_GET_ALL_TITLES, self.refresh_title, self)
  self:bind_auto_mq(Const.MSG_ON_GET_ACHIEVEMENT_GROUP, self.to_get_time, self)
  self:bind_auto_mq(Const.MSG_ON_GET_ACHIEVEMENT_COMPLETE_TIME, self.open_to_jump, self)
  self:bind_auto_mq(Const.MSG_ON_WEAR_TITLE, self.open_btn, self)
  self:bind_auto_mq(Const.MSG_ON_WEAR_TITLE, self.refresh_image, self)
end

function ui:ui_on_show()
  self.v_on_exiting_pd = nil
  self:register_event()
  self.v_page_toggle_tab:set_toggle_by_index(1)
  if PlayerMgr:whether_get_all_titles() then
    self:refresh_title()
  else
    PlayerMgr:get_all_titles_form_server()
  end
  if SysOpenMgr:get_sys_is_open(ACHIEVEMENT_SYS_ID) then
    self.v_btn_to_get.enabled = false
    if PlayerMgr:whether_achievement_complete_time() and PlayerMgr:whether_get_achievement_list() then
      self.v_btn_to_get.enabled = true
    else
      PlayerMgr:get_all_achievement_list_form_server()
    end
    self:set_button("BtnToGet", function()
      if PlayerMgr:get_achievement_list(self.v_achievement_group_id) then
        UIMgr:get_ui("achievement_detail"):ui_show({
          group_id = self.v_achievement_group_id
        })
      else
        local condition_id = ShareRes.get_achievement_group_cfg(self.v_achievement_group_id).Condition
        local unlock_desc = ShareRes.get_condition_desc(condition_id)
        if nil == unlock_desc or "" == unlock_desc then
          unlock_desc = "未开放"
        end
        Util.show_message_tip(unlock_desc)
      end
    end)
  else
    self.v_btn_to_get.enabled = true
    self:set_button("BtnToGet", function()
      local condition_id = ShareRes.get_sys_open_cfg(ACHIEVEMENT_SYS_ID).Condition[1]
      local unlock_desc = ShareRes.get_condition_desc(condition_id)
      if nil == unlock_desc or "" == unlock_desc then
        unlock_desc = "未开放"
      end
      Util.show_message_tip(unlock_desc)
    end)
  end
end

function ui:to_get_time()
  PlayerMgr:get_achievement_complete_time_form_server()
end

function ui:open_to_jump()
  self.v_btn_to_get.enabled = true
end

function ui:refresh_title()
  self.v_btn_wear.enabled = true
  self:refresh_title_list()
end

function ui:refresh_image()
  self.v_title_loop_list:reload_data()
end

function ui:open_btn()
  self.v_btn_wear.enabled = true
end

function ui:refresh_title_list()
  self.v_titles_dict = {}
  self.v_group_dict = {}
  self.v_all_titles = {}
  self.v_get_titles = {}
  self.v_no_get_titles = {}
  local max_num = 0
  local hold_num = 0
  for title_id, title_cfg in pairs(ShareRes.get_title()) do
    local buddy_id = title_cfg.BuddyID
    if not buddy_id or ShareRes.get_buddy_is_show(buddy_id) and CharacterMgr:check_buddy_release(buddy_id) then
      self.v_titles_dict[title_id] = {}
      self.v_titles_dict[title_id].cfg = title_cfg
      self.v_titles_dict[title_id].other_info = {is_get = 0, status = 0}
      if self.v_group_dict[title_cfg.GroupId] == nil then
        self.v_group_dict[title_cfg.GroupId] = {max_lv = 1}
      end
      if title_id == NO_TITLE_ID then
        self.v_titles_dict[title_id].other_info.is_get = 1
      end
    end
  end
  for _, title in pairs(PlayerMgr:get_title()) do
    local other_info = {}
    other_info.is_get = 1
    other_info.create_time = title.create_time
    other_info.status = title.status
    if nil ~= self.v_titles_dict[title.id] then
      self.v_titles_dict[title.id].other_info = other_info
      local title_cfg = ShareRes.get_title(title.id)
      self.v_group_dict[title_cfg.GroupId].max_lv = _max(self.v_group_dict[title_cfg.GroupId].max_lv, title_cfg.Level)
    end
  end
  for title_id, title_cfg in pairs(self.v_titles_dict) do
    if title_cfg.cfg.Level == self.v_group_dict[title_cfg.cfg.GroupId].max_lv then
      _tinsert(self.v_all_titles, title_cfg)
      max_num = max_num + 1
      if 1 == title_cfg.other_info.is_get then
        _tinsert(self.v_get_titles, title_cfg)
        hold_num = hold_num + 1
      else
        _tinsert(self.v_no_get_titles, title_cfg)
      end
    end
  end
  
  local function sort_func(a, b)
    if a.other_info.status == b.other_info.status and a.other_info.is_get == b.other_info.is_get then
      if a.cfg.Id == NO_TITLE_ID then
        return false
      elseif b.cfg.Id == NO_TITLE_ID then
        return true
      end
      return a.cfg.Id < b.cfg.Id
    elseif a.other_info.status == b.other_info.status then
      return b.other_info.is_get < a.other_info.is_get
    else
      return b.other_info.status < a.other_info.status
    end
  end
  
  _tsort(self.v_all_titles, sort_func)
  _tsort(self.v_get_titles, sort_func)
  _tsort(self.v_no_get_titles, sort_func)
  self.v_cur_show_data = {}
  if self.v_select_idx == PAGE.ALL then
    self.v_cur_show_data = self.v_all_titles
  elseif self.v_select_idx == PAGE.GET then
    self.v_cur_show_data = self.v_get_titles
  elseif self.v_select_idx == PAGE.NO_GET then
    self.v_cur_show_data = self.v_no_get_titles
  end
  self.v_title_loop_list:refresh_data(self.v_cur_show_data)
  self.v_title_loop_list:select_item(1)
  if next(self.v_cur_show_data) then
    self.v_no_title_desc:SetActive(false)
  else
    self.v_no_title_desc:SetActive(true)
  end
  self.v_hold_max.text = max_num - 1
  self.v_hold_now.text = hold_num - 1
  self.v_title_info:SetActive(nil ~= next(self.v_cur_show_data))
end

function ui:_on_click_page(idx)
  if self.v_select_idx == idx then
    return
  end
  self.v_select_idx = idx
  self.v_btn_wear.gameObject:SetActive(idx ~= PAGE.NO_GET)
  self.v_title_loop_list:stop_scroll()
  self:refresh_title_list()
end

function ui:on_click_title(i)
  local data = self.v_cur_show_data[i]
  self.v_click_title_data = data
  self.v_no_achivev_title:SetActive(3 == data.cfg.Type)
  self.v_member_title:SetActive(1 == data.cfg.Type)
  self.v_course_title:SetActive(2 == data.cfg.Type)
  self.v_lv_member.gameObject:SetActive(1 == data.cfg.ShowLevel)
  self.v_lv_course.gameObject:SetActive(1 == data.cfg.ShowLevel)
  self.v_unLock_txt_obj:SetActive(3 ~= data.cfg.Type)
  self.v_title_desc.gameObject:SetActive(3 ~= data.cfg.Type)
  self.v_un_lock_way.gameObject:SetActive(3 ~= data.cfg.Type)
  self.v_btn_to_get.gameObject:SetActive(false)
  self.v_btn_wear.gameObject:SetActive(false)
  self.v_no_get_btn:SetActive(false)
  local suffix
  local title_cfg = data.cfg
  local title_quality_path_cfg = ShareRes.get_title_quality_path(title_cfg.Quality)
  if 1 == data.cfg.Type then
    suffix = "_member"
  elseif 2 == data.cfg.Type then
    suffix = "_course"
  else
    self.v_btn_wear.gameObject:SetActive(true)
    return
  end
  self.v_title_desc.text = data.cfg.Describe
  self.v_un_lock_way.text = data.cfg.UnlockingMethod
  self["v_lv" .. suffix].text = data.cfg.Level
  self["v_name" .. suffix].text = data.cfg.Name
  ResMgr:load_set_icon(self["v_quality_bg" .. suffix], title_quality_path_cfg.Qualitybox)
  ResMgr:load_set_icon(self["v_icon" .. suffix], title_cfg.BaseMapPreview)
  ResMgr:load_set_icon(self["v_bg" .. suffix], title_cfg.BaseMap)
  self.v_no_get_btn:SetActive(false)
  if 0 == data.other_info.is_get then
    if 0 ~= data.cfg.Jump then
      self.v_btn_to_get.gameObject:SetActive(true)
      self.v_achievement_group_id = data.cfg.GroupId
    else
      self.v_no_get_btn:SetActive(true)
    end
  else
    self.v_btn_wear.gameObject:SetActive(true)
  end
  self.v_title_loop_list:reload_data()
end

function ui:ui_on_hide()
  if self.v_title_loop_list then
    self.v_title_loop_list:ui_on_hide()
  end
end

function ui:ui_on_destroy()
  if self.v_title_loop_list then
    self.v_title_loop_list:ui_on_destroy()
  end
end

return ui
