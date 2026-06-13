local Base = require("gamelogic.base_system")
local Behavior = require("manager.fight.behavior")
local M = Util.create_child_mt(Base)
local CSLuaService = CS.Game.LuaService
local CommonDefine = require("cs_share.common_define")
local STORY_CONFIG = require("uimodule.story.story_config")
local _tinsert = table.insert

function M:init_sys()
  Base.init_sys(self)
  self.v_story_id = 0
  self.v_is_full_screen_story_playing = false
  self.v_story_end_cb_tb = {}
  self.v_story_real_start_cb_tb = {}
  self.v_is_delay_destroy_ids = {}
  self.v_is_settle_story = {}
  self.v_settle_story_id = {}
  self.story_speed_idx = 1
  self.story_is_auto = false
end

function M:cache_tower_play_story(story_id, room_id)
  local cache_data = self.v_cache_story_data
  if cache_data then
    local cache_id = cache_data.story_id
    if cache_id == story_id then
      return
    elseif cache_id and 0 ~= cache_id then
      Log.Error("当前已有一个剧情等待播放,新剧情id为 = ", story_id, debug.traceback())
    end
  end
  self.v_cache_story_data = {story_id = story_id, room_id = room_id}
end

function M:get_cache_story_data()
  return self.v_cache_story_data
end

function M:check_play_tower_story()
  return self.v_cache_story_data ~= nil
end

function M:play_tower_story(cb)
  if not self.v_cache_story_data then
    return
  end
  local story_id = self.v_cache_story_data.story_id
  local room_id = self.v_cache_story_data.room_id
  if cb then
    self:set_story_end_cb(story_id, cb)
  end
  self:on_start(story_id)
  if TowerMgr then
    local fight_type = TowerMgr:get_fight_type()
    if fight_type ~= CommonDefine.CHALLENGE_TYPE.NEWBIE_TOWER then
      TowerMgr:add_story_record(room_id, story_id)
    end
  end
  self.v_cache_story_data = nil
  return true
end

function M:clear_cache_data()
  self.v_cache_story_data = nil
end

function M:is_delay_destroy(id)
  return self.v_is_delay_destroy_ids[id]
end

function M:is_settle_story(id)
  return self.v_is_settle_story[id]
end

function M:on_start(story_id, next_no_anim, is_delay_destroy, can_be_zero, no_skip_story, finish_cb, is_settle_story)
  self:check_track(story_id)
  self.v_is_check_newbie = false
  self.v_is_delay_destroy_ids[story_id] = is_delay_destroy
  self.v_is_settle_story[story_id] = is_settle_story
  if not self:check_start_story(story_id, can_be_zero) then
    self:check_newbie_tower(story_id)
    self:on_end()
    return
  end
  if story_id == self.v_story_id and self.v_is_story_playing then
    Log.Error("重复播放同一个剧情，剧情id = ", story_id, debug.traceback())
    return
  end
  local story_ui = UIMgr:get_ui("uistory")
  if story_ui:visible() then
    local path = "story." .. story_id
    local story_cfg = ShareRes.create(path)
    if story_cfg.HideGlobalHero == true then
      Global.hero:set_obj_enable(false)
    end
    story_ui:play_next(story_id, true, no_skip_story)
    if finish_cb then
      story_ui:set_finish_cb(finish_cb)
    end
  else
    self.v_cur_step_id = 0
    if TowerMgr then
      local tower = TowerMgr:get_tower()
      if tower and Global.hero then
        local path = "story." .. story_id
        local story_cfg = ShareRes.create(path)
        local steps = story_cfg.Steps
        local step_index = 1
        if not (steps and steps[step_index] and steps[step_index].Talking) or 3 ~= steps[step_index].Talking.Type then
          Global.hero:clear_navigator_effect()
        end
        if story_cfg.HideGlobalHero == true then
          Global.hero:set_obj_enable(false)
        end
      end
    end
    story_ui:ui_show(story_id, nil, nil, nil, nil, no_skip_story, finish_cb)
    self:deal_with_ui()
  end
  self.v_is_story_playing = true
  MsgGame:mq_publish2(Const.MSG_ON_STORY_START)
  if not self:check_cur_step_captions_talk() then
    local uifight = UIMgr:try_get_visible_ui("fight")
    if uifight then
      uifight:on_up_all_code(true, true)
    end
  end
end

function M:check_track(story_id)
  if 5000101 == story_id then
    SDKManager:track_adjust_event("12_prologue_dialogue2_tower")
  end
  if 1000003 == story_id and TowerMgr and TowerMgr:get_tower() and TowerMgr:get_fight_type() == CommonDefine.CHALLENGE_TYPE.NEWBIE_TOWER then
    SDKManager:track_adjust_event("14_prologue_combat1_end")
  end
  if 1000004 == story_id and TowerMgr and TowerMgr:get_tower() and TowerMgr:get_fight_type() == CommonDefine.CHALLENGE_TYPE.NEWBIE_TOWER then
    SDKManager:track_adjust_event("15_prologue_dialogue3_ereshan")
  end
  if 1000005 == story_id and TowerMgr and TowerMgr:get_tower() and TowerMgr:get_fight_type() == CommonDefine.CHALLENGE_TYPE.NEWBIE_TOWER then
    SDKManager:track_adjust_event("17_prologue_combat2_end")
  end
  if 1000010 == story_id and TowerMgr and TowerMgr:get_tower() and TowerMgr:get_fight_type() == CommonDefine.CHALLENGE_TYPE.NEWBIE_TOWER then
    SDKManager:track_adjust_event("18_prologue_dialogue4_ereshan2")
  end
end

function M:on_story_ui_before_show(story_id)
  if self.v_story_real_start_cb_tb[story_id] then
    self.v_story_real_start_cb_tb[story_id]()
    self.v_story_real_start_cb_tb[story_id] = nil
  end
  local room = not TowerMgr or TowerMgr:get_cur_room() or TowerMgr:get_story_room()
  if room and room:is_on_enter_room() then
    room:on_pre_fight_play(1)
    if self:check_story_has_tiem_line(story_id) then
      SceneMgr:set_curtain_show(false)
    end
  end
end

function M:on_story_ui_destroy(story_id)
  local room = not TowerMgr or TowerMgr:get_cur_room() or TowerMgr:get_story_room()
  if room and room:is_on_enter_room() then
    if self:check_story_has_tiem_line(story_id) then
      SceneMgr:set_curtain_show(true)
    end
    self.v_story_id = 0
    room:on_pre_fight_play(2)
  else
    self.v_story_id = 0
  end
end

function M:check_story_has_tiem_line(story_id)
  local path = "story." .. story_id
  local story_cfg = Util.is_more_than_zero(story_id) and ShareRes.create(path) or nil
  return nil ~= story_cfg and nil ~= story_cfg.TimelineRes
end

function M:set_cur_story_id(story_id)
  self.v_story_id = story_id
  if UNITY_EDITOR then
    Log.Info("story sys is playing story_id: ", story_id)
  end
  if 100001 == story_id then
    SDKManager:track_adjust_event("19_prologue_dialogue_lobby")
  end
end

function M:deal_with_ui()
  local drop_item_ui = UIMgr:try_get_visible_ui("ui_battle_item")
  if drop_item_ui then
    drop_item_ui:ui_hide()
  end
end

function M:check_start_story(story_id, can_be_zero)
  local file = "story." .. story_id
  local exist = ShareRes.is_exist_config(file)
  if not exist then
    self:set_cur_story_id(story_id)
    if not can_be_zero then
      Log.Error("缺少剧情配置，让策划检查下，剧情id = ", story_id)
    end
    return
  end
  return true
end

function M:check_newbie_tower(story_id)
  local newbie_story_id = ShareRes.get_comm_value("CreateAccountStory")
  if story_id == newbie_story_id and not self.v_is_check_newbie then
    self:on_end()
    NewbieTowerMgr:on_enter_newbie_tower()
    self.v_is_check_newbie = true
  end
end

function M:on_reconnect()
end

function M:set_story_cur_step_id(step_id, branch_id)
  self.v_cur_step_id = step_id
  branch_id = branch_id or 0
  if TowerMgr then
    local tower = TowerMgr:get_tower()
    if tower then
      SceneMgr:c2gs_call_scene("on_story_begin", self.v_story_id, self.v_cur_step_id, branch_id)
      BehaviorMgr:call_event_fun("on_story_begin", self.v_story_id, self.v_cur_step_id, branch_id)
      BehaviorMgr:call_scene_logic_event_fun("on_story_begin", self.v_story_id, self.v_cur_step_id)
    end
  end
end

function M:on_end(not_reset_bgm)
  self.v_is_story_playing = false
  self.v_is_full_screen_story_playing = false
  self:clear_settle_story_tab(self.v_story_id)
  self.v_is_delay_destroy_ids[self.v_story_id] = nil
  if TowerMgr then
    local tower = TowerMgr:get_tower()
    if tower then
      if 0 ~= self.v_story_id then
        SceneMgr:c2gs_call_scene("on_story_end", self.v_story_id, self.v_cur_step_id)
        local path = "story." .. self.v_story_id
        local story_cfg = ShareRes.create(path)
        if story_cfg.HideGlobalHero == true then
          Global.hero:set_obj_enable(true)
        end
      end
      if NewbieTowerMgr:check_enter_newbie_tower() and NewbieTowerMgr:need_read_story() then
        NewbieTowerMgr:update_newbie_read_story()
      end
    end
  end
  Behavior.set_ui_object_visible("fight", "Main", true)
  if self:check_story_has_tiem_line(self.v_story_id) and TowerMgr:is_on_enter_room() then
    SceneMgr:set_curtain_show(true)
  end
  if self.v_story_end_cb_tb and self.v_story_end_cb_tb[self.v_story_id] then
    self.v_story_end_cb_tb[self.v_story_id]()
    self.v_story_end_cb_tb[self.v_story_id] = nil
  end
  if UtilTable.is_empty(self.v_story_end_cb_tb) and not not_reset_bgm then
    SceneMgr:play_tower_sound()
  end
  if TowerMgr and not GuideMgr:get_cur_guider() and not UIMgr:is_current_ui_can_pause_game() and Global.scene_mgr.v_pause_update then
    SceneMgr:set_game_pause(false)
  end
  BehaviorMgr:call_event_fun(BehaviorMgr.EVENTS.ON_STORY_FINISH, self.v_story_id)
  local msg = MsgGame:mq_publish2(Const.MSG_ON_STORY_END)
  msg.mm_x = self.v_story_id
end

function M:is_playing_story()
  return self.v_is_story_playing
end

function M:is_playing_full_screen_story()
  return self.v_is_full_screen_story_playing
end

function M:set_playing_story(is_playing)
  self.v_is_story_playing = is_playing
end

function M:set_playing_full_screen_story(is_playing)
  self.v_is_full_screen_story_playing = is_playing
end

function M:set_story_end_cb(story_id, callback)
  self.v_story_end_cb_tb[story_id] = callback
end

function M:remove_story_end_cb(story_id)
  self.v_story_end_cb_tb[story_id] = nil
end

function M:stop_story()
  local ui = UIMgr:try_get_visible_ui("uistory")
  if ui then
    ui:stop_story()
  end
  self.v_story_end_cb_tb = {}
  self.v_is_story_playing = false
end

function M:get_cur_play_story_id()
  return self.v_story_id
end

function M:get_cur_play_story_step_id()
  return self.v_cur_step_id
end

function M:close_story()
  local uistory = UIMgr:try_get_visible_ui("uistory")
  if uistory then
    uistory:ui_destroy()
  end
  self:on_end()
end

function M:check_cur_step_captions_talk()
  local uistory = UIMgr:try_get_visible_ui("uistory")
  if not uistory then
    return
  end
  return uistory:is_captions_talk_data()
end

function M:pause_captions_talk(pause)
  local uistory = UIMgr:try_get_visible_ui("uistory")
  if not uistory then
    return
  end
  uistory:pause_captions_talk(pause)
end

function M:check_cur_stroy_is_full()
  if not Util.is_more_than_zero(self.v_story_id) then
    return false
  end
  local path = "story." .. self.v_story_id
  local story_cfg = ShareRes.create(path)
  if not story_cfg then
    return false
  end
  local steps = story_cfg.Steps
  local is_full = true
  for step_key, _ in pairs(steps) do
    if STORY_CONFIG.STEP_LUA_PATH[step_key] and STORY_CONFIG.SHOW_FIGHT_UI[step_key] then
      is_full = false
    end
  end
  return is_full
end

function M:add_trace_step_record(branch_id)
  if not self.v_branch_record_data then
    self.v_branch_record_data = {}
  end
  _tinsert(self.v_branch_record_data, branch_id)
end

function M:trace_story(story_start_time, is_skip_end)
  if not SDKTrack then
    return
  end
  local play_time = Global.real_time - story_start_time
  self.v_branch_record_data = self.v_branch_record_data or {}
  local trace_data = {
    plot_id = self.v_story_id,
    is_skip_plot = is_skip_end and true or false,
    duration_plot = play_time
  }
  local trace_arr_data = {
    choose_result = self.v_branch_record_data
  }
  if UNITY_EDITOR then
    Log.Info("-------------------------------trace_data  -- trace_arr_data", trace_data, trace_arr_data)
  end
  SDKTrack:trace_story(trace_data, trace_arr_data)
  self.v_branch_record_data = {}
end

function M:after_uistory_init_data()
  self:insert_wait_play_story()
end

function M:insert_wait_play_story()
  if not self.v_story_id_queue or not self.v_node_id_to_story_id_dict then
    return
  end
  local uistory = UIMgr:get_ui("uistory")
  for index, story_id in ipairs(self.v_story_id_queue) do
    uistory:insert_wait_play_story(story_id)
  end
end

function M:set_story_stop_arg_params(arg_params)
  self.stop_arg_params = arg_params
end

function M:get_story_stop_arg_params()
  return self.stop_arg_params
end

function M:get_main_scene_story_param()
  local param = {}
  local str_list = ShareRes.get_comm_string_value("MainSceneStoryStopParams")
  param.stop_fade_in_time = str_list[1] or 0
  param.stop_stay_time = str_list[2] or 0
  param.stop_fade_out_time = str_list[3] or 0
  return param
end

function M:reset_story_stop_arg_params()
  self.stop_arg_params = nil
end

function M:set_settle_story(story_id)
  self.v_settle_story_id[story_id] = true
end

function M:check_story_is_settle_story(story_id)
  return story_id and self.v_settle_story_id[story_id] or false
end

function M:clear_settle_story_tab(story_id)
  self.v_settle_story_id[story_id] = nil
end

function M:force_stop_captions_talk()
  local uistory = UIMgr:try_get_visible_ui("uistory")
  if not uistory then
    return
  end
  uistory:force_stop_captions_talk()
end

function M:set_story_real_start_cb(story_id, cb)
  self.v_story_real_start_cb_tb[story_id] = cb
end

function M:clear_story_real_start_cb(story_id)
  self.v_story_real_start_cb_tb[story_id] = nil
end

function M:play_barrage(story_id, play_type, alpha, speed)
  if not story_id then
    return
  end
  local path = "story." .. story_id
  local story_cfg = ShareRes.create(path)
  local steps = story_cfg.Steps
  if not steps or 0 == #steps then
    return
  end
  local talking = steps[1].Talking
  if not talking then
    return
  end
  local content = LanguageMgr:get_story_text(talking.Content)
  if not content or "" == content then
    return
  end
  local barrages = Util.split_str(content, "\n")
  if not barrages or 0 == #barrages then
    return
  end
  self:show_barrage(story_id, barrages, play_type, alpha, speed)
end

function M:show_barrage(story_id, barrages, play_type, alpha, speed)
  local ui = UIMgr:try_get_visible_ui("ui_barrage")
  if not ui then
    UIMgr:get_ui("ui_barrage"):ui_show(story_id, barrages, play_type, alpha, speed)
  else
    ui:refresh_data(story_id, barrages, play_type, alpha, speed)
  end
end

function M:stop_barrage()
  local barrage_ui = UIMgr:try_get_visible_ui("ui_barrage")
  if barrage_ui then
    barrage_ui:ui_hide()
  end
end

function M:update_curr_step_is_showing_skip(is_showing_skip)
  self.curr_step_is_showing_skip = is_showing_skip
end

function M:get_curr_step_is_showing_skip()
  return self.curr_step_is_showing_skip
end

return M
