local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local BIND_TYPE = Config.BIND_TYPE
local ToggleTab = require("ui.widget.widget_toggle_tab")
local LoopListClass = require("ui.widget.infinite_loop_list")
local ACHIEVEMENT_TASK_CLASS = require("uimodule.achievement.achievement_task")
local TASK_CONFIG = require("gamelogic.task.task_config")
local GETSTATETYPE_ORDER = TASK_CONFIG.GETSTATETYPE_ORDER
local TASK_STATE = TASK_CONFIG.TASK_STATE
local BG_PREFIX = "UICommon/"
local _tinsert = table.insert
local _tsort = table.sort
local SaticSv = require("ui.widget.static_scroll_view")
local AwardItemKey = "ACHIEVEMENT_AWARD_TIP_KEY"
local MODEL = {
  v_achievement_name = {
    "AchievementName",
    BIND_TYPE.TEXT
  },
  v_title_obj = {
    "TitleObj",
    BIND_TYPE.OBJECT
  },
  v_title_member = {
    "MemberTitle",
    BIND_TYPE.OBJECT
  },
  v_title_course = {
    "CourseTitle",
    BIND_TYPE.OBJECT
  },
  v_bg_member = {
    "MemberTitle",
    BIND_TYPE.IMAGE
  },
  v_bg_course = {
    "CourseTitle",
    BIND_TYPE.IMAGE
  },
  v_lock_member = {
    "MemberLock",
    BIND_TYPE.OBJECT
  },
  v_lock_course = {
    "CourseLock",
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
  v_name_member = {
    "MemberName",
    BIND_TYPE.TEXT
  },
  v_name_course = {
    "CourseName",
    BIND_TYPE.TEXT
  },
  v_hero_icon = {
    "HeroIcon",
    BIND_TYPE.IMAGE
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
  v_need = {
    "Need",
    BIND_TYPE.TEXT
  },
  v_now = {
    "Now",
    BIND_TYPE.TEXT
  },
  v_progress_bar_fill = {
    "ProgressBarFill",
    BIND_TYPE.IMAGE
  },
  v_no_achievement_desc = {
    "NoAchievementDesc",
    BIND_TYPE.OBJECT
  },
  v_btn_all_get = {
    "BtnAllGet",
    BIND_TYPE.BUTTON
  },
  v_progress = {
    "Progress",
    BIND_TYPE.OBJECT
  },
  v_task_tem = {
    "TaskTem",
    BIND_TYPE.OBJECT
  },
  v_all = {
    "All",
    BIND_TYPE.TOGGLE
  },
  v_complete = {
    "Complete",
    BIND_TYPE.TOGGLE
  },
  v_un_complete = {
    "UnComplete",
    BIND_TYPE.TOGGLE
  },
  v_task_scrollview = {
    "TaskList",
    BIND_TYPE.OBJECT
  },
  v_achievement_icon = {
    "AchievementIcon",
    BIND_TYPE.IMAGE
  },
  v_btn_recive = {
    "BtnRecive",
    BIND_TYPE.OBJECT
  },
  v_check = {
    "Check",
    BIND_TYPE.OBJECT
  },
  v_ani_vx_btnrecive_loop = {
    "Ani_VX_BtnRecive_loop",
    BIND_TYPE.OBJECT
  },
  v_ani_vx_task_in = {
    "Ani_VX_Task_IN",
    BIND_TYPE.OBJECT
  },
  v_fx_box = {
    "FX_UI_BtnRecive",
    BIND_TYPE.OBJECT
  }
}
local PAGE_IDX = {MEMBER = 1, COURSE = 2}
local ITEM_TYPE = {TITLE = 19}
local TASK_PAGE_IDX = {
  ALL = 1,
  COMPLETE = 2,
  UNCOMPLETE = 3
}

function ui:ui_finish_load()
  self:init_model(MODEL)
  self:set_button("BtnAllGet", function()
    self:_on_click_btn_all_get()
  end)
  self:set_button("BtnRecive", function()
    self:show_preview_award_ui()
  end)
  self:set_button("BtnRet1", function()
    self:ui_hide()
  end)
  self:set_button("Check", function()
    self:show_preview_award_ui()
  end)
  local pages = {}
  _tinsert(pages, self.v_all)
  _tinsert(pages, self.v_complete)
  _tinsert(pages, self.v_un_complete)
  self.v_page_toggle_tab = ToggleTab:new(self)
  self.v_page_toggle_tab:init_by_toggles(pages, function(idx)
    self:_on_click_page(idx)
    self.v_ani_vx_task_in:SetActive(false)
    self.v_ani_vx_task_in:SetActive(true)
  end, 0, false)
  self.v_task_loop_list = LoopListClass:new(self, self.v_task_scrollview, ACHIEVEMENT_TASK_CLASS)
  self.v_select_idx = 1
end

function ui:register_event()
  self:bind_auto_mq(Const.MSG_ON_GET_ACHIEVEMENT_AWARD, self.refresh_ui_event, self)
  self:bind_auto_mq(Const.MSG_ON_GET_ACHIEVEMENT_GROUP_AWARD, self.refresh_ui_event, self)
  self:bind_auto_mq(Const.MSG_ON_GET_NEW_ACHIEVEMENT_GROUP, self.refresh_ui_event, self)
end

function ui:ui_on_show(data, is_form_out)
  if is_form_out then
    self.v_select_idx = 1
  end
  self:register_event()
  self.v_achievement_group_id = data.group_id
  self.v_all_achievements = PlayerMgr:get_achievements_dict(data.group_id) or {}
  self.v_achievement_group_cfg = ShareRes.get_achievement_group_cfg(self.v_achievement_group_id)
  self.v_suffix = 1 == self.v_achievement_group_cfg.Classify and "_member" or "_course"
  self.v_achievement_name.text = Util.get_i18n(self.v_achievement_group_cfg.Name)
  if self.v_achievement_group_cfg.Classify == PAGE_IDX.MEMBER then
    self.v_hero_icon.gameObject:SetActive(true)
    self.v_achievement_icon.gameObject:SetActive(false)
    ResMgr:load_set_icon(self.v_hero_icon, self.v_achievement_group_cfg.DetaillPhoto, nil, true)
  elseif self.v_achievement_group_cfg.Classify == PAGE_IDX.COURSE then
    self.v_hero_icon.gameObject:SetActive(false)
    self.v_achievement_icon.gameObject:SetActive(true)
    ResMgr:load_set_icon(self.v_achievement_icon, self.v_achievement_group_cfg.DetaillPhoto, nil, true)
  end
  self:refresh_ui_event()
end

function ui:refresh_ui_event()
  self:classify_achievements()
  self:refresh_task_list(self.v_select_idx)
  self.v_page_toggle_tab:set_toggle_by_index(self.v_select_idx)
  self:refresh_all_ui()
end

function ui:_on_click_page(idx)
  if self.v_select_idx == idx then
    return
  end
  self.v_select_idx = idx
  self.v_task_loop_list:stop_scroll()
  self:refresh_task_list(idx)
end

function ui:_on_click_btn_all_get()
  local send_data = {}
  for i = 1, #self.v_now_achievement_receive do
    _tinsert(send_data, self.v_now_achievement_receive[i].TaskId)
  end
  TaskMgr:submit_task_list(send_data, function()
    PlayerMgr:refresh_achievement_red_point()
    MsgGame:mq_publish2(Const.MSG_ON_GET_ACHIEVEMENT_AWARD)
  end)
end

function ui:refresh_all_ui()
  if next(self.v_now_achievement_receive) then
    Util.enable_btn(self.v_btn_all_get)
  else
    Util.disable_btn(self.v_btn_all_get, true)
  end
  self.v_achievement_group_info = PlayerMgr:get_achievement_list(self.v_achievement_group_id)
  local progress = self.v_achievement_group_info or {}
  local cur_stage = 1
  for i = 1, #progress do
    if 2 == progress[i].state then
      cur_stage = cur_stage + 1
    end
  end
  if cur_stage > #progress then
    cur_stage = #progress
    self.v_check:SetActive(true)
    self.v_btn_recive:SetActive(false)
  else
    self.v_check:SetActive(false)
    self.v_btn_recive:SetActive(true)
  end
  self.v_title = nil
  self.v_title_complete = nil
  self.v_finish_time = nil
  local award_type = ShareRes.create("item.award_type", ITEM_TYPE.TITLE)
  local id_begine = award_type.IdBegin
  local id_end = award_type.IdEnd
  local now = 0
  for i = 1, #progress do
    if 0 ~= progress[i].id then
      local item = ShareRes.get_achievement_award(progress[i].id)
      local item_id = item[1][1]
      if id_begine <= item_id and id_end >= item_id then
        if self.v_title == nil then
          self.v_title = item_id
        end
        if 2 == progress[i].state then
          self.v_title = item_id
          self.v_title_complete = true
          self.v_finish_time = progress[i].finish_time
        end
      end
      now = progress[i].progress.progress
    end
  end
  self.v_title_member:SetActive(false)
  self.v_title_course:SetActive(false)
  if self.v_title then
    self["v_title" .. self.v_suffix]:SetActive(true)
    if self.v_title_complete then
      self["v_lock" .. self.v_suffix]:SetActive(false)
      self["v_quality_bg" .. self.v_suffix]:SetActive(true)
    else
      self["v_lock" .. self.v_suffix]:SetActive(true)
      self["v_quality_bg" .. self.v_suffix]:SetActive(false)
    end
    local title_cfg = ShareRes.get_title(self.v_title)
    local title_quality_path_cfg = ShareRes.get_title_quality_path(title_cfg.Quality)
    self["v_lv" .. self.v_suffix].text = title_cfg.Level
    self["v_lv" .. self.v_suffix].gameObject:SetActive(1 == title_cfg.ShowLevel)
    self["v_name" .. self.v_suffix].text = Util.get_i18n(title_cfg.Name)
    ResMgr:load_set_icon(self["v_icon" .. self.v_suffix], title_cfg.BaseMapPreview)
    ResMgr:load_set_icon(self["v_bg" .. self.v_suffix], title_cfg.BaseMap)
    ResMgr:load_set_icon(self["v_quality_bg" .. self.v_suffix], title_quality_path_cfg.Qualitybox)
  end
  self.v_award_item = ShareRes.get_achievement_award(progress[cur_stage].id)
  local condition_id = ShareRes.get_achievement_progress_condition(progress[cur_stage].id)
  local condition_cfg = ShareRes.create("condition.condition", condition_id)
  local need = condition_cfg.Value
  self.v_now.text = now
  self.v_need.text = need
  self.v_progress_bar_fill.fillAmount = now / need
  local arrive_end = false
  if cur_stage == #progress and 2 == progress[cur_stage].state then
    arrive_end = true
  end
  if 1 ~= progress[cur_stage].state then
    self.v_ani_vx_btnrecive_loop:SetActive(false)
    self.v_fx_box:SetActive(false)
    self:set_button("BtnRecive", function()
      self:show_preview_award_ui()
    end)
  elseif 1 == progress[cur_stage].state then
    self.v_ani_vx_btnrecive_loop:SetActive(true)
    self:set_button("BtnRecive", function()
      PlayerMgr:achievement_get_award(progress[cur_stage].id)
    end)
  end
end

function ui:refresh_task_list(idx)
  local data = {}
  if idx == TASK_PAGE_IDX.ALL then
    data = self.v_now_achievement_all
  elseif idx == TASK_PAGE_IDX.COMPLETE then
    data = self.v_now_achievement_complete
  elseif idx == TASK_PAGE_IDX.UNCOMPLETE then
    data = self.v_now_achievement_uncomplete
  end
  self.v_task_loop_list:refresh_data(data)
  if next(data) then
    self.v_no_achievement_desc:SetActive(false)
  else
    self.v_no_achievement_desc:SetActive(true)
  end
end

function ui:classify_achievements()
  local group_id = self.v_achievement_group_id
  self.v_now_achievement_all = {}
  self.v_now_achievement_receive = {}
  self.v_now_achievement_received = {}
  self.v_now_achievement_complete = {}
  self.v_now_achievement_uncomplete = {}
  self.exist_complete_task = false
  local now_all_achievements = self.v_all_achievements
  for _, achievement in pairs(now_all_achievements) do
    local task_data = TaskMgr:get_task_by_id(achievement.TaskId)
    if task_data then
      _tinsert(self.v_now_achievement_all, achievement)
      local order = GETSTATETYPE_ORDER[task_data.state]
      if order == GETSTATETYPE_ORDER[TASK_STATE.receive] then
        achievement.sort_index = 1
        _tinsert(self.v_now_achievement_receive, achievement)
        self.exist_complete_task = true
      elseif order == GETSTATETYPE_ORDER[TASK_STATE.received] then
        achievement.sort_index = 3
        _tinsert(self.v_now_achievement_received, achievement)
      else
        achievement.sort_index = 2
        _tinsert(self.v_now_achievement_uncomplete, achievement)
      end
    end
  end
  
  local function sort_func(a, b)
    if a.sort_index == b.sort_index and a.Priority == b.Priority then
      return a.Id < b.Id
    elseif a.sort_index == b.sort_index then
      return b.Priority < a.Priority
    else
      return a.sort_index < b.sort_index
    end
  end
  
  _tsort(self.v_now_achievement_all, sort_func)
  _tsort(self.v_now_achievement_receive, sort_func)
  _tsort(self.v_now_achievement_received, sort_func)
  for i = 1, #self.v_now_achievement_receive do
    _tinsert(self.v_now_achievement_complete, self.v_now_achievement_receive[i])
  end
  for i = 1, #self.v_now_achievement_received do
    _tinsert(self.v_now_achievement_complete, self.v_now_achievement_received[i])
  end
end

function ui:ui_on_hide()
  if self.v_task_loop_list then
    self.v_task_loop_list:ui_on_hide()
  end
end

function ui:ui_on_destroy()
  if self.v_task_loop_list then
    self.v_task_loop_list:ui_on_destroy()
  end
end

function ui:show_preview_award_ui()
  if self.v_achievement_group_info then
    UIMgr:get_ui("achiev_pre_award_tip"):ui_show(self.v_achievement_group_info)
  end
end

return ui
