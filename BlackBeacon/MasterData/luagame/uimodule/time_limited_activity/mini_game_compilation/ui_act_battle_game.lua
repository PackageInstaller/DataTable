local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local ToggleTab = require("ui.widget.widget_toggle_tab")
local TagA = "ACT_BATTLE_GAME_TAG_A"
local TagB = "ACT_BATTLE_GAME_TAG_B"
local AchievementTem = "ACT_BATTLE_GAME_ACHIEVEMENTTem"
local StarTem = "ACT_BATTLE_GAME_STARTTEM"
local LocalStorage = require("utils.localstorage")
local _tinsert = table.insert
local TASK_STATE = Config.TASK_STATE
local minigame_type_cfg = ShareRes.create("activity.activity_mini_game_type")
local minigame_cfg = ShareRes.create("activity.activity_mini_game")
local UPDATE_INTERVAL = 1

function ui:ui_finish_load()
  self:set_button("BtnRet1", function()
    self:ui_hide()
  end)
  self:set_button("BtnMain", function()
    if SceneMgr:check_main_scene() then
      UIMgr:go_to_main()
    end
  end)
  self:set_button("BtnTask", function()
    UIMgr:get_ui("ui_act_battle_game_award"):ui_show(self.v_activity_id)
  end)
  self:set_button("BtnStart", function()
    if TowerMgr:check_fight_progress() then
      return
    end
    local episode_cfg = self.v_tag_b_cfg_list[self.v_tag_b_index]
    local chapter_id = episode_cfg.Id
    local episode_id = episode_cfg.EpisodeId
    if episode_id then
      UIMgr:get_ui("team"):ui_show(chapter_id, episode_id, nil, nil, nil, nil, {
        self.v_activity_id
      })
    end
  end)
  self:register_exist_auto_template(TagA, self.v_uiobjects.PageTem1, self.v_uiobjects.PageTemContent1)
  self:register_exist_auto_template(TagB, self.v_uiobjects.PageTem2, self.v_uiobjects.PageTemContent2)
  self:register_exist_auto_template(AchievementTem, self.v_uiobjects.StarTem, self.v_uiobjects.StarContent)
  self:register_exist_auto_template(StarTem, self.v_uiobjects.Star, self.v_uiobjects.StarLayout)
  RedPointMgr:bind_redpoint(self, self.v_uiobjects.TaskRed, RedEnum.MINIGAME_COMPILATION_AWARD_UI, RedEnum.MINIGAME_COMPILATION)
end

function ui:ui_on_show(activity_id, default_tag_a, default_tag_b)
  self:check_close(activity_id)
  self:bind_auto_mq(Const.MSG_ON_NOVICE_ACTIVITY_OPEN, self.check_close, self)
  self:bind_auto_mq(Const.MSG_ON_ACTIVITY_MINIGAME_UPDATE, self.on_activity_minigame_update, self)
  local cur_minigame_info = TimeLimitedActMgr:get_mini_game_info()[activity_id]
  local t = TimeLimitedActMgr:get_store_state(TimeLimitedActMgr.MINIGAME_ACTIVITY_KEY) or {}
  local m = t and t[activity_id] or {}
  for k, v in pairs(cur_minigame_info) do
    if v.time_open then
      m[k] = 1
    end
  end
  t[activity_id] = m
  TimeLimitedActMgr:set_store_state(TimeLimitedActMgr.MINIGAME_ACTIVITY_KEY, t)
  TimeLimitedActMgr:minigame_award_redpoint_update(activity_id)
  self.v_last_update_timestap = -1
  self.v_activity_id = activity_id
  self.v_tag_a_index = default_tag_a or 1
  self.v_tag_b_index = default_tag_b or 1
  self.v_activity_minigame_cfg = ShareRes.get_minigame_list_by_acid(self.v_activity_id)
  self.v_tag_a_cfg_list = {}
  local temp = {}
  for _, cfg in ipairs(self.v_activity_minigame_cfg) do
    if not temp[cfg.MiniGameTypeId] then
      temp[cfg.MiniGameTypeId] = true
      _tinsert(self.v_tag_a_cfg_list, cfg.MiniGameTypeId)
    end
  end
  table.sort(self.v_tag_a_cfg_list, function(a, b)
    return a < b
  end)
  self:refresh()
end

function ui:ui_on_update(elapsed)
  self:refresh_update(elapsed)
end

function ui:cache_ui()
  return true
end

function ui:ui_on_hide()
  UIMgr:try_hide_ui("ui_act_battle_game_award")
end

function ui:get_cache_data()
  return self.v_activity_id, self.v_tag_a_index, self.v_tag_b_index
end

function ui:refresh()
  self:refresh_tag_a()
  local index_b = self:get_last_level_index()
  self:refresh_tag_b(index_b)
  self:refresh_main()
end

function ui:refresh_update(elapsed, force)
  if force then
    self.v_last_update_timestap = -1
  end
  if self.v_last_update_timestap < 0 then
    self.v_last_update_timestap = UPDATE_INTERVAL
    local uicom = self.v_uicompents
    local activity_cfg = ShareRes.get_activity_cfg(self.v_activity_id)
    local time_length = NoviceMgr:get_time_remaining(activity_cfg.TimeType, activity_cfg.StopTime, activity_cfg.OpenTime, activity_cfg.SustainTime)
    if time_length then
      uicom.Time_txt.text = Date.get_time_format_7(time_length)
    end
    local open_time = Date.get_time_stamp_by_scheme_id(self.v_tag_b_cfg_list[self.v_tag_b_index].OpenTime)
    time_length = open_time - Date.server_time()
    if time_length > 0 then
      uicom.Text_txt.text = string.format("在%s后解锁关卡", Date.get_time_format_7(time_length))
    elseif self.v_minigame_locked then
      uicom.Text_txt.text = "通关前置关卡后解锁"
    end
  else
    self.v_last_update_timestap = self.v_last_update_timestap - elapsed
  end
end

function ui:refresh_tag_a()
  self:give_back_auto_cache(TagA)
  self.v_tag_a_toggles = {}
  for _, type_id in ipairs(self.v_tag_a_cfg_list) do
    local item = self:get_auto_cache(TagA)
    self:tag_a_set_data(item, type_id)
    local tog = Util.get_toggle(nil, item)
    _tinsert(self.v_tag_a_toggles, tog)
  end
  self.v_minigame_tag_a_toggle = ToggleTab:new(self)
  self.v_minigame_tag_a_toggle:init_by_toggles(self.v_tag_a_toggles, function(index)
    self:on_click_tag_a(index)
  end, self.v_tag_a_index, true)
  self.v_minigame_tag_a_toggle:set_color("ffffff", "fffffe", 1, 0.5)
end

function ui:refresh_tag_b(tag_b_index)
  self:give_back_auto_cache(TagB)
  self.v_tag_b_index = tag_b_index or self.v_tag_b_index
  self.v_tag_b_toggles = {}
  self.v_tag_b_cfg_list = {}
  for _, cfg in ipairs(self.v_activity_minigame_cfg) do
    if cfg.MiniGameTypeId == self.v_tag_a_cfg_list[self.v_tag_a_index] then
      table.insert(self.v_tag_b_cfg_list, cfg)
    end
  end
  table.sort(self.v_tag_b_cfg_list, function(a, b)
    return a.Id < b.Id
  end)
  for _, cfg in ipairs(self.v_tag_b_cfg_list) do
    local item = self:get_auto_cache(TagB)
    self:tag_b_set_data(item, cfg)
    local tog = Util.get_toggle(nil, item)
    _tinsert(self.v_tag_b_toggles, tog)
  end
  self.v_minigame_tag_b_toggle = ToggleTab:new(self)
  self.v_minigame_tag_b_toggle:init_by_toggles(self.v_tag_b_toggles, function(select_idx)
    self:on_click_tag_b(select_idx)
  end, self.v_tag_b_index, true, nil, "f5ede2", "ffffff")
end

function ui:refresh_main()
  local uicom = self.v_uicompents
  local uiobj = self.v_uiobjects
  local all_minigame_info = TimeLimitedActMgr:get_mini_game_info()
  local minigame_episode_cfg = self.v_tag_b_cfg_list[self.v_tag_b_index]
  local cur_minigame_info = all_minigame_info[self.v_activity_id][minigame_episode_cfg.Id]
  if cur_minigame_info and cur_minigame_info.time_open then
    uiobj.Info:SetActiveEx(true)
    uiobj.TimeLock:SetActiveEx(false)
    self.v_minigame_locked = false
  else
    uiobj.Info:SetActiveEx(false)
    uiobj.TimeLock:SetActiveEx(true)
    self.v_minigame_locked = true
    self:refresh_update(0, true)
    return
  end
  local icon_path = minigame_episode_cfg.ImagePath
  ResMgr:load_set_icon(uicom.StageIcon_img, icon_path, nil, false)
  uicom.EpisodTitle_txt.text = minigame_episode_cfg.Name
  uicom.StageDesc_txt.text = minigame_episode_cfg.GameplayBrief
  self:give_back_auto_cache(AchievementTem)
  local cond_list = ShareRes.get_point_star_condition(minigame_episode_cfg.EpisodeId)
  for index, condition_id in ipairs(cond_list) do
    if condition_id > 0 then
      local cfg = ShareRes.get_point_star_condition_cfg(condition_id)
      if cfg then
        local item = self:get_auto_cache(AchievementTem)
        local enable = 1 == cur_minigame_info.star_bit >> index - 1 & 1
        self:achievementtem_set_data(item, cfg, enable)
      end
    end
  end
  self:give_back_auto_cache(StarTem)
  local star_bit = cur_minigame_info.star_bit
  local star_count = 0
  while star_bit > 0 do
    star_bit = star_bit & star_bit - 1
    star_count = star_count + 1
  end
  if star_count > 0 then
    uicom.Label_txt.text = "最高评价:"
    for i = 1, star_count do
      self:get_auto_cache(StarTem)
    end
  else
    uicom.Label_txt.text = "暂无评价"
  end
end

function ui:tag_a_set_data(obj_node, type_id)
  local page_name_txt = Util.get_text("Text", obj_node)
  page_name_txt.text = minigame_type_cfg[type_id].MiniGameTitle
end

function ui:tag_b_set_data(obj_node, cfg)
  local page_num_txt = Util.get_text("Text", obj_node)
  page_num_txt.text = cfg.Name
end

function ui:achievementtem_set_data(obj_node, cfg, enable)
  local desc_txt = Util.get_text("Desc", obj_node)
  local arg = cfg.Arg[1]
  desc_txt.text = Util.format_str(cfg.ConditionDesc, arg)
  local light = Util.get_child_gameobj("Light", obj_node)
  light:SetActiveEx(enable)
end

function ui:get_last_level_index()
  local t = {}
  for _, cfg in ipairs(self.v_activity_minigame_cfg) do
    if cfg.MiniGameTypeId == self.v_tag_a_cfg_list[self.v_tag_a_index] then
      table.insert(t, cfg)
    end
  end
  local minigame_info = TimeLimitedActMgr:get_mini_game_info()[self.v_activity_id]
  local index_b = 1
  for i = #t, 1, -1 do
    local minigame_cfg = minigame_info[t[i].Id]
    if minigame_cfg and minigame_cfg.time_open then
      index_b = i
      break
    end
  end
  return index_b
end

function ui:on_click_tag_a(index)
  self.v_tag_a_index = index
  local index_b = self:get_last_level_index()
  self:refresh_tag_b(index_b)
  self:refresh_main()
end

function ui:on_click_tag_b(index)
  self.v_tag_b_index = index
  self:refresh_main()
end

function ui:on_activity_minigame_update()
  self:refresh()
end

function ui:check_close(activity_id)
  NoviceMgr:check_close_activity_ui(activity_id or self.v_activity_id, self.v_ui_name)
end

return ui
