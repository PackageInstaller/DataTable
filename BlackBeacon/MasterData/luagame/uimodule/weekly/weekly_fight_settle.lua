local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local dotween = CS.DG.Tweening.DOTweenAnimation
local MAX_CHAR_ITEM_COUNT = Config.MAX_CHAR_ITEM_COUNT
local Char_Helper = require("uimodule.character.char_helper")
local SPINE_RT_VIEW = require("ui.model_rt_view.spine_rt_view")
local SpineHelper = require("ui.model_rt_view.spine_helper")

local function sort(a, b)
  if a.pos ~= b.pos then
    return a.pos < b.pos
  else
    return false
  end
end

local _tinsert = table.insert
local player_icon_path_prefix = "Icon/Profile/%s"
local CommonDef = require("cs_share.common_define")

function ui:ui_finish_load()
  self:set_button("BtnConfirm", function()
    self:click_confirm_btn()
  end)
  self:set_button("SpineBtn", function()
    if self.v_anim_data.record_data.play_start then
      if self.v_anim_data.record_data.play_interrupt then
        SpineHelper.init_anim_info(self.v_spine_id, self.v_anim_data, SpineHelper.ANIM_TYPE.CLICK)
      end
    else
      SpineHelper.init_anim_info(self.v_spine_id, self.v_anim_data, SpineHelper.ANIM_TYPE.CLICK)
    end
  end)
  local x, y, _ = self.v_uicompents.SpineRaw_rect:GetLocalPositionA3()
  local scale, _, _ = self.v_uicompents.SpineRaw_rect:GetLocalScaleA3()
  self.v_default_raw_img_offset = {
    x,
    y,
    scale
  }
  x, y, _ = self.v_uicompents.Char_rect:GetLocalPositionA3()
  scale, _, _ = self.v_uicompents.Char_rect:GetLocalScaleA3()
  self.v_default_img_offset = {
    x,
    y,
    scale
  }
end

function ui:click_confirm_btn()
  local function callback()
    Global.scene_mgr:on_enter_main_scene()
    
    UIMgr:revert_cache_ui()
  end
  
  if SceneMgr:check_main_scene() then
    self:ui_hide()
  end
  TowerMgr:get_fight_reward(callback)
end

function ui:ui_on_update()
  if not self.v_spine_id then
    return
  end
  if Global.real_time - self.v_low_update < SpineHelper.UPDATE_TIME then
    return
  end
  self.v_low_update = Global.real_time
  if self.v_anim_data.record_data.play_end then
    self.v_start_time = self.v_start_time or Global.real_time
    if self.v_anim_interval and Global.real_time - self.v_start_time > self.v_anim_interval then
      SpineHelper.init_anim_info(self.v_spine_id, self.v_anim_data, SpineHelper.ANIM_TYPE.INTERVAL)
    elseif self.v_single_anim_delay and Global.real_time - self.v_start_time > self.v_single_anim_delay then
      SpineHelper.init_anim_info(self.v_spine_id, self.v_anim_data, SpineHelper.ANIM_TYPE.SINGLE)
      self.v_single_anim_delay = nil
    end
  else
    self.v_start_time = Global.real_time
  end
  SpineHelper.check_play_anim(self.v_spine_rt, self.v_anim_data)
end

function ui:ui_on_show()
  WeeklyMgr:request_weekly_prepare_score()
  self.v_low_update = Global.real_time
  self.v_anim_data = SpineHelper.get_init_anim_info()
  local fight_progress = TowerMgr:get_tower_progress()
  self.v_fight_progress = fight_progress
  self.v_is_pvp = false
  local change_type = fight_progress.challenge_type
  if change_type == CommonDef.CHALLENGE_TYPE.WEEK_ACTY_PVP_EPI then
    self.v_is_pvp = true
  end
  self.v_tween_map = {}
  self.v_tween_map_1 = {}
  self:init_tween_map()
  self:update_def_hurdle_view()
  self:update_score_view()
  self:update_buddy_view()
  AssistMgr:check_show_add_assist_friend_tips()
end

function ui:init_tween_map()
  local point_all_tween = self.v_uiobjects.PointAll:GetComponent(typeof(dotween))
  _tinsert(self.v_tween_map, point_all_tween)
  _tinsert(self.v_tween_map_1, self.v_uiobjects.PointAll)
  local point_tween = self.v_uiobjects.Point:GetComponent(typeof(dotween))
  _tinsert(self.v_tween_map, point_tween)
  _tinsert(self.v_tween_map_1, self.v_uiobjects.Point)
  local btn_confirm_tween = self.v_uiobjects.BtnConfirm:GetComponent(typeof(dotween))
  _tinsert(self.v_tween_map, btn_confirm_tween)
  _tinsert(self.v_tween_map_1, self.v_uiobjects.BtnConfirm)
  for index, obj in ipairs(self.v_tween_map_1) do
    obj:SetActive(true)
  end
end

function ui:ui_on_hide()
  for _, tween in pairs(self.v_tween_map) do
    tween:DOKill()
  end
  self.v_tween_map = {}
  for index, obj in ipairs(self.v_tween_map_1) do
    obj:SetActive(false)
  end
  AssistMgr:try_hide_add_assist_friend_tips()
  self:clear_spine_rt()
end

function ui:update_def_hurdle_view()
  local progress = self.v_fight_progress
  local hurdle_id = progress.episode_id
  local cfg = ShareRes.get_weekly_hundle_cfg(hurdle_id)
  if self.v_is_pvp then
    cfg = ShareRes.get_weekly_pvp_epi_cfg(hurdle_id)
  end
  self.v_uicompents.StageName_txt.text = cfg.EpiName
  local fight_wave_num = WeeklyMgr:get_weekly_fight_wave_num()
  self.v_uicompents.Round_txt.text = fight_wave_num
  local avatar_cfg = ShareRes.create("player.player_avatar")
  local avatar_id = PlayerMgr:get_player_head_id()
  local icon_name = nil == avatar_cfg[avatar_id] and avatar_cfg[700051].Icon or avatar_cfg[avatar_id].Icon
  local avatar_icon_path = string.format(player_icon_path_prefix, icon_name)
  ResMgr:load_set_icon(self.v_uicompents.PlayerIcon_img, avatar_icon_path)
  local char_name = PlayerMgr:get_player_name()
  self.v_uicompents.PlayerName_txt.text = char_name
  local char_id = PlayerMgr:get_player_uid()
  self.v_uicompents.PlayerID_txt.text = char_id
end

function ui:update_score_view()
  local progress = self.v_fight_progress
  local hurdle_id = progress.episode_id
  local weekly_acty_info = WeeklyMgr:get_weekly_fraction_data()
  weekly_acty_info = weekly_acty_info or {
    monster_wave_fraction = 0,
    damage_fraction = 0,
    buddy_hp_ratio_fraction = 0,
    second_fraction = 0
  }
  Util.assert(weekly_acty_info, "缺少结算分数数据", debug.traceback())
  local wave_score = weekly_acty_info.monster_wave_fraction
  local damage_score = weekly_acty_info.damage_fraction
  self.v_uicompents.KillNum_txt.text = damage_score + wave_score
  local life_score = weekly_acty_info.buddy_hp_ratio_fraction
  self.v_uicompents.SurvivalNum_txt.text = life_score
  local time_score = weekly_acty_info.second_fraction or 0
  self.v_uicompents.TimeNum_txt.text = time_score
  local all_score = wave_score + damage_score + life_score + time_score
  if UNITY_EDITOR then
    Log.Info("波次得分 = ", wave_score)
    Log.Info("伤害得分 = ", damage_score)
    Log.Info("轮次得分 = 波次得分 + 伤害得分 = ", damage_score + wave_score)
    Log.Info("生存得分 = ", life_score)
    Log.Info("时间得分 = ", time_score)
  end
  self.v_uicompents.PointAllNum_txt.text = all_score
  local history_score = WeeklyMgr:get_hurdle_history_score(hurdle_id)
  if self.v_is_pvp then
    history_score = WeeklyMgr:get_pvp_history_score(hurdle_id)
  end
  self.v_uiobjects.NewRecord:SetActive(all_score > history_score)
  if all_score > history_score then
    history_score = all_score
  end
  self.v_uicompents.PointMax_txt.text = history_score
  self.v_uiobjects.PointTem2:SetActive(0 ~= damage_score + wave_score)
  self.v_uiobjects.PointTem3:SetActive(0 ~= life_score)
  self.v_uiobjects.PointTem5:SetActive(0 ~= time_score)
  self.v_uiobjects.LoseText:SetActive(0 == all_score)
end

function ui:update_buddy_view()
  local progress = TowerMgr:get_tower_progress()
  local hero_list = progress and progress.battle_buddy_data
  local buddy_id, fashion_id = self:refresh_hero_item(hero_list)
  if not hero_list or #hero_list <= 0 then
    return
  end
  if not buddy_id then
    buddy_id = hero_list[1].buddy_id
    fashion_id = hero_list[1].fashion
  end
  local spine_id, is_spine, offset = UtilUI.get_hero_settle_spine(buddy_id, fashion_id)
  self.v_uiobjects.SpineRaw:SetActive(is_spine)
  self.v_uiobjects.Hero:SetActive(not is_spine)
  if is_spine then
    self:clear_spine_rt()
    self.v_spine_id = spine_id
    self.v_anim_interval = SpineHelper.get_anim_interval(self.v_spine_id)
    self.v_single_anim_delay = SpineHelper.get_single_anim_delay(self.v_spine_id)
    self.v_spine_rt = self.v_spine_rt or SPINE_RT_VIEW:new(self, self.v_uiobjects.SpineRaw)
    SpineHelper.load_char_spine_res(self.v_spine_rt, self.v_spine_id, self.v_uiobjects.SpineRaw)
    offset = offset or self.v_default_raw_img_offset
    self.v_uicompents.SpineRaw_rect:SetLocalPositionA(offset[1], offset[2], 0)
    self.v_uicompents.SpineRaw_rect:SetLocalScaleA(offset[3], offset[3], offset[3])
  else
    self.v_spine_id = nil
    local icon_path = spine_id
    ResMgr:load_set_icon(self.v_uicompents.Hero_img, icon_path, nil, true, self)
    offset = offset or self.v_default_img_offset
    self.v_uicompents.Char_rect:SetLocalPositionA(offset[1], offset[2], 0)
    self.v_uicompents.Char_rect:SetLocalScaleA(offset[3], offset[3], offset[3])
  end
end

function ui:clear_spine_rt()
  if self.v_spine_rt then
    self.v_spine_rt:on_destroy()
    self.v_spine_rt = nil
  end
end

function ui:refresh_hero_item(hero_list)
  if not hero_list then
    for index = 1, MAX_CHAR_ITEM_COUNT do
      self.v_uiobjects["Char" .. index]:SetActive(false)
    end
    return
  end
  local main_pos, main_role, main_role_fashion_id
  if not SceneMgr:check_main_scene() and not SceneMgr:global_hero_is_destroyed() then
    main_pos = Global.hero:get_team_pos()
  end
  table.sort(hero_list, sort)
  local role_cfg, role_id, fashion_id, icon_path, qual_val, data, power
  for index = 1, MAX_CHAR_ITEM_COUNT do
    data = hero_list[index]
    if data then
      if main_pos and main_pos == data.pos or data.is_main then
        main_role = data.buddy_id
        main_role_fashion_id = data.fashion
      end
      self.v_uiobjects["Char" .. index]:SetActive(true)
      role_id = data.buddy_id
      fashion_id = data.fashion
      role_cfg = ShareRes.create("buddy.buddy", role_id)
      power = CharacterMgr:get_buddy_combat_effectiveness(role_id, false, false)
      icon_path = UtilUI.get_hero_images(role_id, 2, fashion_id)
      ResMgr:load_set_icon(self.v_uicompents["CharIcon" .. index .. "_img"], icon_path)
      self.v_uicompents["ZhanliNum" .. index .. "_txt"].text = power
      icon_path = Char_Helper.get_char_select_quality_icon(role_id)
      ResMgr:load_set_icon(self.v_uicompents["QualityBg" .. index .. "_img"], icon_path)
      qual_val = role_cfg.Quality
      icon_path = Char_Helper.get_char_line_quality_icon(qual_val)
      ResMgr:load_set_icon(self.v_uicompents["QualityLine" .. index .. "_img"], icon_path)
    else
      self.v_uiobjects["Char" .. index]:SetActive(false)
    end
  end
  return main_role, main_role_fashion_id
end

return ui
