local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local ENDLESS_POINT_TEM = "ENDLESS_POINT_TEM"
local ENDLESS_AWARD_TEM = "ENDLESS_AWARD_TEM"
local ENDLESS_POINT_ITEM = require("uimodule.chapter.endless.endless_point_item")
local ITEM_OBJ_COM = require("uimodule.item.item_obj_com")
local CHAPTER_CONFIG = require("uimodule.chapter.chapter_config")
local INFINITE_EPISODE_TYPE = Config.CommonDefine.INFINITE_EPISODE_TYPE
local AWARD_STATE = {
  NO_COMPLATE = 1,
  COMPLATE = 2,
  COMPLATED = 3
}
local AWARD_COLOR = {
  [AWARD_STATE.NO_COMPLATE] = "909090",
  [AWARD_STATE.COMPLATE] = "FFFFFF",
  [AWARD_STATE.COMPLATED] = "AE9577"
}

local function sort_func(a, b)
  if a.Priority ~= b.Priority then
    return a.Priority < b.Priority
  else
    return false
  end
end

local function sort_func2(a_cfg, b_cfg)
  if a_cfg.Id ~= b_cfg.Id then
    return a_cfg.Id < b_cfg.Id
  else
    return false
  end
end

local function sort_func3(a, b)
  local a_score = ChapterEndlessMgr:get_endless_score(a.Id)
  local b_score = ChapterEndlessMgr:get_endless_score(b.Id)
  if a_score > 0 and b_score <= 0 then
    return false
  elseif a_score <= 0 and b_score > 0 then
    return true
  elseif a.Priority ~= b.Priority then
    return a.Priority < b.Priority
  else
    return false
  end
end

function ui:init_infinite_list()
  self.v_infinite_list = {}
  for key, point_type in pairs(INFINITE_EPISODE_TYPE) do
    self.v_infinite_list[point_type] = {}
  end
  local all_infinite_cfg = ShareRes.get_inf_chapter_cfg()
  local type_list
  for key, cfg in pairs(all_infinite_cfg) do
    type_list = self.v_infinite_list[cfg.Type]
    if type_list then
      type_list[#type_list + 1] = cfg
    end
  end
  for key, list in pairs(self.v_infinite_list) do
    table.sort(list, sort_func)
  end
end

function ui:ui_finish_load()
  self:set_button("BtnAward", function()
    self:on_click_award_btn()
  end)
  self:set_button("BtnCloseAward", function()
    self:on_click_close_award_btn()
  end)
  self:set_button("BtnFight", function()
    self:on_click_fight_btn()
  end)
  self:set_button("BtnQuickFight", function()
    self:on_click_quick_fight_btn()
  end)
  self:set_button("BtnRank", function()
    self:on_click_rank_btn()
  end)
  self:set_button("BtnRet1", function()
    self:on_click_return_btn()
  end)
  self:set_button("BtnTask", function()
    self:on_click_task_btn()
  end)
  self:set_button("BtnRecive", function()
    self:on_click_recive_btn()
  end)
  self:set_button("BtnChangeMode", function()
    self:on_click_change_mode_btn()
  end)
  self.v_endless_point_map = {}
  self.v_award_item_list = {}
  self.v_can_click_change_mode = true
  self:init_infinite_list()
  self.v_uiobjects.BtnChangeMode:SetActive(false)
  self.v_point_type = ChapterEndlessMgr:is_week_infinite_open() and INFINITE_EPISODE_TYPE.WEEK or INFINITE_EPISODE_TYPE.ALWAYS
  self:register_exist_auto_template(ENDLESS_POINT_TEM, self.v_uiobjects.StageTem, self.v_uiobjects.StageContent)
  self:register_exist_auto_template(ENDLESS_AWARD_TEM, self.v_uiobjects.AwardTem, self.v_uiobjects.AwardContent, 20)
end

function ui:on_click_award_btn()
  self:open_award_info()
  self.v_uiobjects.BtnCloseAward:SetActive(true)
end

function ui:on_click_close_award_btn()
  self:close_award_panel()
  self.v_uiobjects.BtnCloseAward:SetActive(false)
end

function ui:on_click_fight_btn()
  if TowerMgr:check_fight_progress() then
    return
  end
  local infinite_cfg = ShareRes.get_inf_chapter_cfg(self.v_infinite_id)
  if infinite_cfg and infinite_cfg.Id == 1005 and not Util.get_res_is_integrity() then
    return
  end
  ChapterEndlessMgr:set_last_select_infinite_id(self.v_infinite_id)
  UIMgr:get_ui("endless_prewar"):ui_show(self.v_infinite_id)
end

function ui:on_click_quick_fight_btn()
  if not self:check_can_quick_fight(true) then
    return
  end
  
  local function sure_callback()
    local infinite_id = self.v_infinite_id
    
    local function cb(resp)
      local param = {
        score = resp.score,
        reward_list = resp.reward_list,
        infinite_id = infinite_id,
        progress_data = resp.progress_data
      }
      UIMgr:get_ui("endless_settle"):ui_show(CHAPTER_CONFIG.POINTSTATE.complete, param)
      if self:visible() then
        self:refresh_all_score()
      end
    end
    
    ChapterEndlessMgr:infinite_sweep_episode(self.v_infinite_id, cb)
  end
  
  local srt = "是否使用历史最高分的%d%%（%d分）作为本次挑战结果？"
  local disc = ShareRes.get_endless_sweep_discount() or 0
  local data = ChapterMgr:get_inf_chapter_data(self.v_infinite_id)
  local max_score = data.history_max_score or 0
  local score = math.ceil(max_score * disc / 10000)
  srt = string.format(srt, disc / 100, score)
  UIMgr:get_ui("uinotice_tips"):ui_show(sure_callback, nil, srt)
end

function ui:on_click_return_btn()
  self.v_infinite_id = nil
  self.v_point_id = nil
  self:ui_hide()
end

function ui:on_click_task_btn()
  local task_group_id = ShareRes.get_endless_progress_task_group()
  if task_group_id then
    UIMgr:get_ui("chapter_task"):ui_show(nil, task_group_id)
  else
    Log.Error("获取无尽进度任务组失败")
  end
end

function ui:on_click_recive_btn()
  if not self:check_can_get_award() then
    return
  end
  
  local function cb()
    if self.v_uiobjects.AwardObj.activeInHierarchy then
      self:clear_award_item()
      self:refresh_award_info()
      self:refresh_score_award_redpoint()
    end
  end
  
  BagMgr:request_infinite_gain_score_reward(cb)
end

function ui:on_click_change_mode_btn()
  if not self.v_can_click_change_mode then
    return
  end
  self.v_can_click_change_mode = false
  self.v_point_type = self.v_point_type == INFINITE_EPISODE_TYPE.ALWAYS and INFINITE_EPISODE_TYPE.WEEK or INFINITE_EPISODE_TYPE.ALWAYS
  self.v_infinite_id = nil
  self:refresh_point_list()
  self:refresh_mode()
end

function ui:after_select_point(is_first)
  self.v_can_click_change_mode = true
  local cfg = ShareRes.get_inf_chapter_cfg(self.v_infinite_id)
  if not Util.is_empty(cfg.BgName) then
    self:change_bg(cfg.BgName)
  end
  self:open_point_info()
end

function ui:on_select_point(infinite_id, point_id, force, is_first)
  if self.v_infinite_id == infinite_id and not force then
    return
  end
  for key, item in pairs(self.v_endless_point_map) do
    item:on_select_point(infinite_id, is_first)
  end
  self.v_infinite_id = infinite_id
  self.v_point_id = point_id
  self:clear_select_timer()
  self:after_select_point()
end

function ui:on_click_rank_btn()
  local infinite_cfg = ShareRes.get_inf_chapter_cfg(self.v_infinite_id)
  local show_count = infinite_cfg.ShowRankPlayer
  local total_count = infinite_cfg.RankPlayer
  RankMgr:request_rank_list(Config.CommonDefine.RANK_NAME.NEW_INFINITE_SCORE, infinite_cfg.Id, 1, show_count, total_count, true)
end

function ui:on_open_rank(msg)
  local curr_rank_info
  local rank_info_list = {}
  for i, cfg in pairs(self.v_infinite_list[self.v_point_type]) do
    if cfg.IsOpenRank then
      local info = RankMgr:get_new_rank_title(cfg.Id, cfg.Name, cfg.ShowRankPlayer, cfg.RankPlayer, cfg.RankRefreshType)
      if cfg.Id == self.v_infinite_id then
        curr_rank_info = info
      end
      table.insert(rank_info_list, info)
    end
  end
  UIMgr:get_ui("endless_rank"):ui_show(Config.CommonDefine.RANK_NAME.NEW_INFINITE_SCORE, curr_rank_info, rank_info_list)
end

function ui:create_blur()
  Global.ui_mgr:set_backgroud_blur(self.v_cfg.name, self._set_blur_img, self)
end

function ui:ui_on_show()
  self.v_first_show = true
  self:load_last_select_info()
  self:bind_auto_mq(Const.MSG_ON_TASK_UPDATE, self.refresh_task_redpoint, self)
  self:bind_auto_mq(Const.MSG_ON_RANK_UPDATE, self.on_open_rank, self)
  self:refresh_point_list()
  self:refresh_redpoint()
  self:refresh_time()
  self.v_uiobjects.BtnCloseAward:SetActive(false)
  self.v_uiobjects.StageInfo:SetActive(false)
  self.v_uiobjects.AwardObj:SetActive(false)
  self:refresh_select()
  self:refresh_mode()
  self:create_blur()
  self.v_first_show = false
  if self.v_infinite_id then
    local infinite_cfg = ShareRes.get_inf_chapter_cfg(self.v_infinite_id)
    self:refresh_btn_rank_visible(infinite_cfg.IsOpenRank)
  end
end

function ui:ui_on_hide()
  self:clear_point_item()
  self:clear_award_item()
  self:release_blur_texture()
  if self.v_sequence then
    self.v_sequence:Kill(false)
    self.v_sequence = nil
  end
  self.v_can_click_change_mode = true
  self.v_point_type = ChapterEndlessMgr:is_week_infinite_open() and INFINITE_EPISODE_TYPE.WEEK or INFINITE_EPISODE_TYPE.ALWAYS
end

function ui:ui_on_destroy()
end

function ui:refresh_time()
  local seconds = ChapterEndlessMgr:get_endless_end_time()
  local tb = os.date("!*t", seconds)
  local date = Date.get_time_formate_3(seconds)
  local time = string.format("%02d:%02d:%02d", tb.hour, tb.min, tb.sec)
  self.v_uicompents.TimeDate_txt.text = date
  self.v_uicompents.Time_txt.text = time
end

function ui:refresh_select()
  if self.v_infinite_id and self.v_point_id then
    self:on_select_point(self.v_infinite_id, self.v_point_id, true, true)
  end
end

function ui:refresh_point_list()
  local infinite_id
  local map = ChapterMgr:get_inf_chapter_map()
  if not map or not self.v_infinite_list[self.v_point_type] then
    Log.Error("获取无尽章节数据失败")
    return
  end
  self:clear_point_item()
  self.v_total_score = 0
  local temp_list = {}
  local temp_count = 0
  local score, is_unlock
  for key, cfg in ipairs(self.v_infinite_list[self.v_point_type]) do
    infinite_id = cfg.Id
    local obj = self:get_auto_cache(ENDLESS_POINT_TEM)
    local item = ENDLESS_POINT_ITEM:ui_wrap_ex(self, obj, true)
    item:set_data(cfg)
    self.v_endless_point_map[infinite_id] = item
    if cfg.Type == Config.CommonDefine.INFINITE_EPISODE_TYPE.WEEK then
      score = ChapterEndlessMgr:get_endless_score(infinite_id)
      self.v_total_score = self.v_total_score + (score or 0)
    end
    is_unlock = nil ~= map[infinite_id]
    if is_unlock then
      temp_count = temp_count + 1
      temp_list[#temp_list + 1] = cfg
    end
  end
  local item
  if self.v_infinite_id then
    item = self.v_endless_point_map[self.v_infinite_id]
  elseif temp_list[1] then
    table.sort(temp_list, sort_func3)
    item = self.v_endless_point_map[temp_list[1].Id]
    item:on_click_btn(self.v_first_show)
  end
  if not item then
    self.v_can_click_change_mode = true
    self:close_point_info()
  elseif temp_count > 3 then
    local tf = item:get_rect_transform()
    UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.v_uicompents.StageContent_rect)
    Util.move_to_target_point_pos(tf, self.v_uicompents.ScrollView_rect, self.v_uicompents.StageContent_rect, false, nil, nil, true)
  else
    local pos = self.v_uicompents.StageContent_rect.anchoredPosition
    self.v_uicompents.StageContent_rect:SetAnchoredPositionA(pos.x, 0, pos.z)
  end
  self.v_uicompents.AllScoreNum_txt.text = self.v_total_score
end

function ui:open_point_info()
  self:refresh_point_info()
  self.v_uiobjects.StageInfo:SetActive(true)
end

function ui:refresh_point_info()
  local infinite_cfg = ShareRes.get_inf_chapter_cfg(self.v_infinite_id)
  local point_cfg = ShareRes.get_chapter_point_cfg(self.v_point_id)
  self.v_uicompents.StageName_txt.text = point_cfg.PointName
  self.v_uicompents.StageDesc_txt.text = point_cfg.PointDesc
  self.v_uicompents.ZhanliNeed_txt.text = point_cfg.RecomFightVal
  self.v_uiobjects.BtnQuickFight:SetActive(infinite_cfg.CanSweep)
  if infinite_cfg.CanSweep then
    local can_quick_fight = self:check_can_quick_fight(false)
    Util.apply_grey_ex(self.v_uiobjects.BtnQuickFight, not can_quick_fight)
    self.v_uiobjects.BtnQuickFightLock:SetActive(not can_quick_fight)
    self.v_uiobjects.BtnQuickFightArrow:SetActive(can_quick_fight)
  end
  local data = ChapterMgr:get_inf_chapter_data(self.v_infinite_id)
  self.v_uicompents.HistoryScoreNum_txt.text = data and data.history_max_score or 0
end

function ui:refresh_task_redpoint()
  local task_group_id = ShareRes.get_endless_progress_task_group()
  local task_red = TaskMgr:get_task_group_red(task_group_id)
  local red_point = self:get_child_gameobj("RedPoint", self.v_uiobjects.BtnTask)
  red_point:SetActive(task_red)
  MsgGame:mq_publish2(Const.MSG_ON_WEEKLY_ENDLESS_RED_REFRESH)
end

function ui:refresh_score_award_redpoint()
  local can_get = self:check_can_get_award()
  local redpoint = self:get_child_gameobj("RedPoint", self.v_uiobjects.BtnAward)
  redpoint:SetActive(can_get)
  MsgGame:mq_publish2(Const.MSG_ON_WEEKLY_ENDLESS_RED_REFRESH)
end

function ui:refresh_redpoint()
  self:refresh_task_redpoint()
  self:refresh_score_award_redpoint()
end

function ui:close_point_info()
  self.v_uiobjects.StageInfo:SetActive(false)
end

function ui:open_award_info()
  self:refresh_award_info()
  self.v_uiobjects.AwardObj:SetActive(true)
end

function ui:refresh_award_info()
  local award_bit = ChapterEndlessMgr:get_endless_award_bit()
  local all_cfg = ShareRes.get_infinite_score_award()
  local temp_list = {}
  for key, cfg in pairs(all_cfg) do
    temp_list[#temp_list + 1] = cfg
  end
  table.sort(temp_list, sort_func2)
  local has_get, has_comp, has_recive, slider, comp, need, all_get, red_point, icon
  local total_score = self.v_total_score
  local first_uncomp_index, last_comp_obj, state
  for index, cfg in ipairs(temp_list) do
    has_comp = total_score >= cfg.Score
    has_get = 1 == (award_bit >> cfg.Id - 1) % 2
    if has_comp and not has_get then
      state = AWARD_STATE.COMPLATE
    elseif has_comp and has_get then
      state = AWARD_STATE.COMPLATED
    else
      state = AWARD_STATE.NO_COMPLATE
    end
    local obj = self:get_auto_cache(ENDLESS_AWARD_TEM)
    slider = self:get_slider("Score/ScoreSlider_", obj)
    if not first_uncomp_index then
      local next_score
      local cur_score = cfg.Score
      local dif_value
      local next_index = index + 1
      if next_index <= #temp_list then
        next_score = temp_list[next_index].Score
      else
        next_score = cfg.Score
      end
      if has_comp and total_score >= next_score then
        slider.value = 1
      else
        dif_value = next_score - cur_score
        slider.value = (total_score - cur_score) / dif_value
      end
      if has_comp then
        last_comp_obj = obj
      else
        first_uncomp_index = index
      end
    else
      slider.value = 0
    end
    comp = self:get_child_gameobj("Score/Complete_", obj)
    comp:SetActive(state == AWARD_STATE.COMPLATE)
    need = self:get_text("Score/ScoreNeed_", obj)
    need.text = cfg.Score
    Util.set_color(need, AWARD_COLOR[state])
    icon = self:get_image("Score/Icon", obj)
    Util.set_color(icon, AWARD_COLOR[state])
    red_point = self:get_child_gameobj("Score/ScoreNeed_/RedPoint_", obj)
    red_point:SetActive(state == AWARD_STATE.COMPLATE)
    all_get = self:get_child_gameobj("AwardContent/AwardGot_", obj)
    all_get:SetActive(state == AWARD_STATE.COMPLATED)
    self:refresh_award_group(cfg.RewardGroupId, obj)
    has_recive = has_recive or has_comp and not has_get
  end
  local seconds = ChapterEndlessMgr:get_endless_end_time()
  local time = Date.get_time_formate_2(seconds - Date.server_time())
  self.v_uicompents.AwardTime_txt.text = time .. "后重置"
  self.v_uiobjects.BtnRecive:SetActive(has_recive)
  if last_comp_obj then
    UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.v_uicompents.AwardContent_rect)
    local rect = self:get_rect_transform(nil, last_comp_obj)
    Util.move_to_target_point_pos(rect, self.v_uicompents.AwardScrollView_rect, self.v_uicompents.AwardContent_rect, false, nil, nil, true)
  end
end

function ui:refresh_award_group(award_group, obj)
  local award
  local awards = ShareRes.get_awards(award_group)
  local item_com, item, data
  for index = 1, 4 do
    award = self:get_child_gameobj("AwardContent/Award" .. index, obj)
    item_com = self:get_child_gameobj("ItemObjCom", award)
    if nil ~= awards[index] then
      item_com:SetActive(true)
      item = ITEM_OBJ_COM:ui_wrap_ex(self, item_com, true)
      data = {
        cb = function()
          UIMgr:get_ui("itemTip"):ui_show({
            item_id = awards[index].ItemId,
            is_hide_get_way = true
          })
        end,
        ItemId = awards[index].ItemId,
        Num = awards[index].Num
      }
      item:set_data(data)
      self.v_award_item_list[#self.v_award_item_list + 1] = item
    else
      item_com:SetActive(false)
    end
  end
end

function ui:refresh_all_score()
  self.v_total_score = 0
  for infinite_id, item in pairs(self.v_endless_point_map) do
    item:refresh_score()
    self.v_total_score = self.v_total_score + (ChapterEndlessMgr:get_endless_score(infinite_id) or 0)
  end
  self.v_uicompents.AllScoreNum_txt.text = self.v_total_score
end

function ui:close_award_panel()
  self:clear_award_item()
  self.v_uiobjects.AwardObj:SetActive(false)
end

function ui:check_can_quick_fight(show_tips)
  local data = ChapterMgr:get_inf_chapter_data(self.v_infinite_id)
  if not data or data.history_max_score <= 0 then
    if show_tips then
      Util.show_message_tip(2255)
    end
    return false
  end
  return true
end

function ui:check_can_get_award()
  local all_cfg = ShareRes.get_infinite_score_award()
  local total_score = self.v_total_score or 0
  local award_bit = ChapterEndlessMgr:get_endless_award_bit()
  local has_comp, has_get = false, false
  for key, cfg in pairs(all_cfg) do
    has_comp = total_score >= cfg.Score
    has_get = 1 == (award_bit >> cfg.Id - 1) % 2
    if has_comp and not has_get then
      return true
    end
  end
  return false
end

function ui:clear_point_item()
  self:give_back_auto_cache(ENDLESS_POINT_TEM)
  for key, item in pairs(self.v_endless_point_map) do
    item:ui_hide()
    item:ui_destroy()
    self.v_endless_point_map[key] = nil
  end
end

function ui:clear_award_item()
  self:give_back_auto_cache(ENDLESS_AWARD_TEM)
  for key, item in pairs(self.v_award_item_list) do
    item:ui_hide()
    item:ui_destroy()
    self.v_award_item_list[key] = nil
  end
end

function ui:cache_ui()
  return true
end

function ui:clear_select_timer()
  if self.v_select_pd_timer then
    Timer:remove_timer(self.v_select_pd_timer)
    self.v_select_pd_timer = nil
  end
end

function ui:refresh_mode()
  local is_always = self.v_point_type == INFINITE_EPISODE_TYPE.ALWAYS
  local is_week = self.v_point_type == INFINITE_EPISODE_TYPE.WEEK
  local mode_text = is_always and Util.format_str("常规") or Util.format_str("周期")
  self.v_uicompents.ModeName_txt.text = mode_text
  self.v_uiobjects.BtnTask:SetActive(is_always)
  self.v_uiobjects.BtnAward:SetActive(is_week)
  self.v_uiobjects.AllScoreNum:SetActive(is_week)
  self.v_uiobjects.TimeObj:SetActive(is_week)
end

function ui:refresh_btn_rank_visible(visible)
  self.v_uiobjects.BtnRank:SetActive(visible)
end

function ui:load_last_select_info()
  local last_select_infinite_id = ChapterEndlessMgr:get_last_select_infinite_id()
  if last_select_infinite_id then
    local cfg = ShareRes.get_inf_chapter_cfg(last_select_infinite_id)
    self.v_point_type = cfg.Type
    self.v_infinite_id = last_select_infinite_id
    self.v_point_id = cfg.EpisodeId
    ChapterEndlessMgr:set_last_select_infinite_id()
  end
end

function ui:change_bg(path)
  if self.v_cur_bg_path ~= path then
    self.v_cur_bg_path = path
    if self.v_cur_bg_path then
      if self.v_sequence then
        self.v_sequence:Kill(false)
        self.v_sequence = nil
      end
      self.v_sequence = Util.create_sequence()
      
      local function set_bg_cb1()
        Util.change_component_alpha2(self.v_uicompents.FullBg_img, 1)
        if self.v_hide_tween then
          self.v_hide_tween:Kill(false)
          self.v_hide_tween = nil
        end
        self.v_sequence:Join(self.v_uicompents.FullBg_img:DOFade(0, 0.25))
        self.v_sequence:Join(self.v_uicompents.AfterBg_img:DOFade(1, 0.25))
        self.v_sequence:OnComplete(function()
          local function set_bg_cb2()
            Util.change_component_alpha2(self.v_uicompents.FullBg_img, 1)
            
            Util.change_component_alpha2(self.v_uicompents.AfterBg_img, 0)
          end
          
          ResMgr:load_set_icon(self.v_uicompents.FullBg_img, self.v_cur_bg_path, set_bg_cb2, true, self)
          if self.v_sequence then
            self.v_sequence:Kill(false)
            self.v_sequence = nil
          end
        end)
      end
      
      Util.change_component_alpha2(self.v_uicompents.AfterBg_img, 0)
      ResMgr:load_set_icon(self.v_uicompents.AfterBg_img, self.v_cur_bg_path, set_bg_cb1, true, self)
    else
      ResMgr:load_set_icon(self.v_uicompents.FullBg_img, self.v_cur_bg_path, nil, true, self)
      Util.change_component_alpha2(self.v_uicompents.AfterBg_img, 0)
    end
  end
end

return ui
