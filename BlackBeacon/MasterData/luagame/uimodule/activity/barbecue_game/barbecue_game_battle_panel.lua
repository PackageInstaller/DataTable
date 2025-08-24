local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local BBQ_GAME_FOOD_ITEM_TEMP_KEY = "BBQ_GAME_FOOD_ITEM_TEMP_KEY"
local MUSIC_GAME_NODE_BASE_ITEM_TEMP_KEY = "MUSIC_GAME_NODE_BASE_ITEM_TEMP_KEY"
local FoodNodeItem = require("uimodule.activity.music_game.music_game_node_item")
local PosCfg = ShareRes.create("activity.music_mini_game_node_pos")
local ComboCfg = ShareRes.create("activity.music_mini_game_combo")
local _ceil = math.ceil

function ui:on_click_return()
  self:stop_ct()
  self.v_uiobjects.Pause:SetActive(true)
end

function ui:on_click_exit()
  self:ui_hide()
end

function ui:on_click_restart()
  self.v_uiobjects.Pause:SetActive(false)
  self:init_score()
  self:reset_active_nodes()
  self:start_count_down()
end

function ui:on_click_continue()
  self.v_uiobjects.Pause:SetActive(false)
  self:continue_ct()
end

function ui:ui_finish_load()
  self:set_button("BtnRet1", function()
    self:on_click_return()
  end)
  self:set_button("BtnExit", function()
    self:on_click_exit()
  end)
  self:set_button("BtnReStart", function()
    self:on_click_restart()
  end)
  self:set_button("BtnContinue", function()
    self:on_click_continue()
  end)
  self.v_star_content_width = self.v_uicompents.StarContent_rect.sizeDelta.x
  self:register_exist_auto_template(BBQ_GAME_FOOD_ITEM_TEMP_KEY, self.v_uiobjects.FoodObj, self.v_uiobjects.TableContent)
  self:register_exist_auto_template(MUSIC_GAME_NODE_BASE_ITEM_TEMP_KEY, self.v_uiobjects.NodeBaseTem, self.v_uiobjects.NodeBaseContent)
end

function ui:ui_on_show(chapter_id, stage_id)
  self.v_bgm_id_cache = Global.sound_mgr:get_cur_bgm_id()
  self:clear_bgm()
  self.v_chapter_id = chapter_id
  self.v_stage_id = stage_id
  self.v_stage_cfg = ShareRes.get_puzzle_game_stage_cfg(stage_id)
  self.v_time_axis_cfg = ShareRes.create("activity.music_mini_game_nodes")[self.v_stage_id]
  self.v_time_axis_length = #self.v_time_axis_cfg
  self.v_end_time = self.v_stage_cfg.Duration
  self.v_uiobjects.Pause:SetActive(false)
  self:init_score()
  self:show_base_node()
  self:init_node_pool()
  self:start_count_down()
end

function ui:ui_on_hide()
  self:stop_ct()
  self:reset_bgm()
  self:clear_wrap_items()
end

function ui:ui_on_update(delta_time)
  if self.v_count_down_sec then
    self.v_count_down_sec = self.v_count_down_sec - delta_time
    self:refresh_count_down_txt()
    return
  end
  if self.v_is_running then
    self:do_ct(delta_time)
    self:pass_ct_to_node(delta_time)
  end
end

function ui:init_score()
  self.v_cur_star = 0
  self.v_cur_score = 0
  self.v_cur_combo = 0
  self.v_max_combo = 0
  self.v_max_combo_record = 0
  self.v_uicompents.ScoreNum_txt.text = 0
  self.v_uicompents.ScoreBarFill_img.fillAmount = 0
  self.v_uiobjects.MutiScore:SetActiveEx(false)
  self.v_uiobjects.Combo:SetActiveEx(false)
  self.v_star_score_cfg = self.v_stage_cfg.StarScore
  self.v_max_score = self.v_stage_cfg.MaxScore
  for i = 1, 4 do
    self.v_uicompents["Star" .. i .. "_rect"]:SetAnchoredPositionA(self.v_star_content_width * self.v_star_score_cfg[i] / self.v_max_score, 0, 0)
    self.v_uiobjects["StarLight" .. i]:SetActiveEx(false)
  end
end

function ui:show_base_node()
  self:give_back_auto_cache(MUSIC_GAME_NODE_BASE_ITEM_TEMP_KEY)
  if not self.v_stage_cfg.PosIdList then
    return
  end
  for _, id in ipairs(self.v_stage_cfg.PosIdList) do
    local obj = self:get_auto_cache(MUSIC_GAME_NODE_BASE_ITEM_TEMP_KEY)
    local pos = PosCfg[id].Pos
    obj.transform:SetLocalPositionA(pos[1], pos[2], 0)
  end
end

function ui:init_node_pool()
  self:give_back_auto_cache(BBQ_GAME_FOOD_ITEM_TEMP_KEY)
  self.v_free_node = {}
  self.v_node_pool = {}
  for i = 1, 5 do
    local obj = self:get_auto_cache(BBQ_GAME_FOOD_ITEM_TEMP_KEY)
    local item = FoodNodeItem:ui_wrap_ex(self, obj, false)
    item:set_idx(i)
    self.v_node_pool[i] = item
    self.v_free_node[i] = true
  end
end

function ui:get_free_node_idx()
  local free_node_idx = next(self.v_free_node)
  if not free_node_idx then
    free_node_idx = #self.v_node_pool + 1
    local obj = self:get_auto_cache(BBQ_GAME_FOOD_ITEM_TEMP_KEY)
    local item = FoodNodeItem:ui_wrap_ex(self, obj, false)
    item:set_idx(free_node_idx)
    self.v_node_pool[free_node_idx] = item
  end
  self.v_free_node[free_node_idx] = nil
  return free_node_idx
end

function ui:release_node(node_idx)
  self.v_free_node[node_idx] = true
end

function ui:reset_active_nodes()
  if self.v_node_pool then
    for _, node in ipairs(self.v_node_pool) do
      if node:get_enable() then
        node:do_end()
      end
    end
  end
end

function ui:pass_ct_to_node(delta_time)
  if self.v_node_pool then
    for _, node in ipairs(self.v_node_pool) do
      if node:get_enable() then
        node:do_ct(delta_time)
      end
    end
  end
end

function ui:clear_wrap_items()
  if self.v_node_pool then
    for idx = #self.v_node_pool, 1, -1 do
      local item = self.v_node_pool[idx]
      item:ui_destroy()
      self.v_node_pool[idx] = nil
    end
    self.v_node_pool = nil
  end
end

function ui:start_count_down()
  self.v_count_down_sec = 3
  self.v_cur_count_down_sec = 3
  self.v_uicompents.CountDownText_txt.text = 3
  self.v_uiobjects.CountDown:SetActive(true)
  Global.sound_mgr:play_ui_sound(Config.UI_SOUND_CFG.music_game_count_down_UI_SOUND)
end

function ui:refresh_count_down_txt()
  if self.v_count_down_sec < -1 then
    self.v_count_down_sec = nil
    self.v_uiobjects.CountDown:SetActive(false)
    self:start_ct()
    return
  end
  local sec = _ceil(self.v_count_down_sec)
  if self.v_cur_count_down_sec ~= sec then
    self.v_cur_count_down_sec = sec
    if 0 == sec then
      sec = "开始！"
    end
    self.v_uiobjects.CountDownText:SetActiveEx(false)
    self.v_uiobjects.CountDownText:SetActive(true)
    self.v_uicompents.CountDownText_txt.text = sec
  end
end

function ui:start_ct()
  self.v_is_running = true
  self.v_ct_time = 0
  self.v_start_flag = 1
  self:clear_bgm()
  self:play_bgm(true)
end

function ui:stop_ct()
  self.v_is_running = false
  self:play_bgm(false)
  self:pause_nodes(true)
end

function ui:continue_ct()
  self.v_is_running = true
  self:play_bgm(true)
  self:pause_nodes(false)
end

function ui:play_bgm(is_play)
  if self.v_stage_cfg.BGM then
    Global.sound_mgr:pause_sound_by_id(self.v_stage_cfg.BGM, not is_play)
  end
end

function ui:clear_bgm()
  Global.sound_mgr:bgm_stop()
end

function ui:reset_bgm()
  if self.v_bgm_id_cache and self.v_bgm_id_cache ~= "" then
    Global.sound_mgr:pause_sound_by_id(self.v_bgm_id_cache)
    Global.sound_mgr:play_sound_by_id(self.v_bgm_id_cache)
  end
end

function ui:do_ct(delta_time)
  self.v_ct_time = self.v_ct_time + delta_time
  if self.v_ct_time >= self.v_end_time then
    self.v_is_running = false
    self:show_result()
    return
  end
  if self.v_start_flag > self.v_time_axis_length then
    return
  end
  for idx = self.v_start_flag, self.v_time_axis_length do
    local cfg = self.v_time_axis_cfg[idx]
    if cfg.Second <= self.v_ct_time then
      self:show_nodes(cfg)
      self.v_start_flag = idx + 1
    else
      return
    end
  end
end

function ui:pause_nodes(is_pause)
  if self.v_node_pool then
    for _, node in ipairs(self.v_node_pool) do
      if node:get_enable() then
        node:do_pause(is_pause)
      end
    end
  end
end

function ui:show_nodes(time_axis_cfg)
  local pos_id_list = time_axis_cfg.PosIdList
  for _, pos_id in ipairs(pos_id_list) do
    local free_node_idx = self:get_free_node_idx()
    local node_item = self.v_node_pool[free_node_idx]
    node_item:show_node(pos_id, time_axis_cfg.NodeType, self.v_ct_time)
  end
end

function ui:miss_node()
  self.v_uiobjects.MutiScore:SetActiveEx(false)
  self.v_uiobjects.Combo:SetActiveEx(false)
  self.v_cur_combo = 0
  self.v_uiobjects.MutiScore:SetActiveEx(false)
  self.v_uiobjects.Combo:SetActiveEx(false)
end

function ui:hit_node()
  self.v_uiobjects.MutiScore:SetActiveEx(true)
  self.v_uiobjects.Combo:SetActiveEx(true)
  self:add_combo()
  self:refresh_ratio()
  self:refresh_star()
end

function ui:add_combo()
  self.v_cur_combo = self.v_cur_combo + 1
  if not self.v_max_combo or self.v_max_combo < self.v_cur_combo then
    self.v_max_combo = self.v_cur_combo
  end
  self.v_uicompents.ComboNum_txt.text = self.v_cur_combo
  if self.v_cur_combo > self.v_max_combo_record then
    self.v_max_combo_record = self.v_cur_combo
  end
end

function ui:refresh_ratio()
  local add_score, ratio = 0, 0
  for _, cfg in ipairs(ComboCfg) do
    if self.v_cur_combo >= cfg.Count then
      add_score = cfg.Score
      ratio = cfg.RatioTxt
    else
      break
    end
  end
  self.v_cur_score = self.v_cur_score + add_score
  self.v_uicompents.ScoreNum_txt.text = self.v_cur_score
  self.v_uicompents.ScoreBarFill_img.fillAmount = self.v_cur_score / self.v_max_score
  self.v_uicompents.MutiScoreNum_txt.text = ratio
  self.v_uiobjects.Fx_Jf:SetActive(false)
  self.v_uiobjects.Fx_Jf:SetActive(true)
  self.v_uiobjects.Ani_ComboNum_In:SetActive(false)
  self.v_uiobjects.Ani_ComboNum_In:SetActive(true)
end

function ui:refresh_star()
  if 4 == self.v_cur_star then
    return
  end
  for i = self.v_cur_star + 1, 4 do
    if self.v_cur_score >= self.v_star_score_cfg[i] then
      self.v_cur_star = i
      self.v_uiobjects["StarLight" .. i]:SetActiveEx(true)
    else
      break
    end
  end
end

function ui:show_result()
  if self.v_cur_star > 0 then
    MusicGameMgr:report_score(self.v_chapter_id, self.v_stage_id, self.v_cur_score, self.v_max_combo_record, function()
      UIMgr:get_ui("music_game_result_tips"):ui_show(self.v_stage_id, self.v_cur_score, self.v_cur_star, self.v_max_combo)
    end)
  else
    UIMgr:get_ui("music_game_result_tips"):ui_show(self.v_stage_id, self.v_cur_score, self.v_cur_star, self.v_max_combo)
  end
  self:reset_active_nodes()
  self:clear_bgm()
end

return ui
