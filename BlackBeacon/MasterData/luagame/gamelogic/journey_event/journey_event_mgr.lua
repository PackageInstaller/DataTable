local Base = require("gamelogic.base_system")
local M = Util.create_child_mt(Base)
local CommonDefine = require("cs_share.common_define")
local Layer = require("utils.layer")
local TypeSpeedSceneTimeline = typeof(CS.Game.SpeedSceneTimeline)
local CSInput = UnityEngine.Input
local TouchPhase = UnityEngine.TouchPhase
local UnityVector2 = _ENV.UnityVector2
local CSHelper = _ENV.CSHelper
local UnityFind = _ENV.UnityFind
local _abs = math.abs
local _floor = math.floor
local Vec2 = require("base.vec2")
local Math = require("base.mathx")
local EFF_AUDIO_ID_LIST = Config.EFF_AUDIO_ID_LIST
local action_id_enum = {change_main_scene_obj_visible = 16, change_bgm = 17}
local SETTLE_BTN_STATE = {
  NONE = 0,
  SHOW_NEXT_AND_FORCE_SETTLE_TO_MAIN = 1,
  HIDE_NEXT_AND_FORCE_SETTLE_TO_MAIN = 2
}
M.curr_event_info = nil
M.curr_event_cfg = nil
M.buddy_data = {}
M.all_step_cfg = {}
M.curr_step_index = 0
M.curr_event_all_step_cfg = {}
M.curr_step_cfg = nil
M.curr_step_need_run_action_count = 0
M.curr_step_run_finish_action_count = 0
M.curr_model_index = 0
M.curr_npc_id = 0
M.is_need_run_force_journey_event = false
M.is_listener_npc_click = false
M.need_play_bgm = nil
M.need_refresh_main_obj_list = {}
M.effect_parent = nil
M.born_effect = nil
M.idle_effect = nil
M.interact_effect = nil
M.model_trans = nil
M.curr_fix_play_audio_name = nil
M.curr_fix_close_audio_name = nil
M.delay_change_space_timer = nil

function M:init_sys()
  Base.init_sys(self)
  self:sys_mq_bind(Const.MSG_ON_HIDE_UI, self.on_ui_hide_event, self)
  self:sys_mq_bind(Const.MSG_ON_SHOW_UI, self.on_ui_show_event, self)
end

function M:on_scene_journey_event_list_init(data)
  local model_view = self:try_get_model_view()
  if model_view and self.curr_model_index > 0 then
    model_view:remove_npc_by_index(self.curr_model_index)
  end
  self:reset()
  if not self.event_list then
    self.event_list = {}
  end
  for i, v in pairs(data.scene_journey_events) do
    self.event_list[v.id] = v
  end
  local all_cfg = ShareRes.create("scene_journey.scene_journey_event_step")
  self.all_step_cfg = {}
  for step_id, cfg in pairs(all_cfg) do
    if not cfg.EventId or 0 == cfg.EventId then
      Log.Error("步骤配置中的EventId为空或者为0请检查配置")
      return
    end
    if not self.all_step_cfg[cfg.EventId] then
      self.all_step_cfg[cfg.EventId] = {}
    end
    if not self.all_step_cfg[cfg.EventId][cfg.Step] then
      self.all_step_cfg[cfg.EventId][cfg.Step] = {}
    end
    table.insert(self.all_step_cfg[cfg.EventId][cfg.Step], cfg)
  end
  self:refresh_curr_event()
end

function M:on_scene_journey_event_update(data)
  if not self.event_list then
    self.event_list = {}
  end
  local info = data.scene_journey_event
  self.event_list[info.id] = info
  if self.curr_event_info and self.curr_event_info.id ~= info.id then
    if 1 == self.curr_event_cfg.Compulsory then
      return
    end
    local cfg = ShareRes.create("scene_journey.scene_journey_event", info.id)
    if 1 == cfg.Compulsory or self.curr_event_cfg.Weight and cfg.Weight and self.curr_event_cfg.Weight < cfg.Weight then
      self:remove_model()
      local curr_ui = UIMgr:get_cur_show_ui_name()
      if "uimain" == curr_ui then
        self:refresh_journey_event_model()
      end
    end
    return
  end
  if info.state == CommonDefine.SCENE_JOURNEY_EVENT_STATE.COMPLETE then
    self:reset()
    self:change_space_time_logic(0, 0, true, true)
    self.stop_change_space_time = true
  end
  local curr_show_ui = UIMgr:get_cur_show_ui_name()
  if "uimain" == curr_show_ui then
    self:refresh_journey_event_model()
  else
    self:refresh_curr_event()
  end
end

function M:on_other_journey_event_update(event_id, is_finish)
  local is_need_run_event = self:remove_model()
  local data = {
    id = event_id,
    state = is_finish and CommonDefine.SCENE_JOURNEY_EVENT_STATE.COMPLETE or CommonDefine.SCENE_JOURNEY_EVENT_STATE.UNDER_WAY
  }
  self:on_scene_journey_event_update({scene_journey_event = data})
  local curr_ui = UIMgr:get_cur_show_ui_name()
  if is_need_run_event and "uimain" == curr_ui then
    self:refresh_journey_event_model()
  end
end

function M:refresh_curr_event()
  if not self.event_list then
    return
  end
  if self.curr_event_cfg then
    if self:check_event_is_finish(true) then
      self:send_msg()
    end
    return
  end
  local sort_list = self:get_sorted_event_list()
  for idx, info in ipairs(sort_list) do
    if info.state == CommonDefine.SCENE_JOURNEY_EVENT_STATE.UNDER_WAY then
      self.curr_event_info = info
      break
    end
  end
  if not self.curr_event_info then
    return
  end
  self.curr_event_cfg = ShareRes.create("scene_journey.scene_journey_event", self.curr_event_info.id)
  if self:check_event_is_finish(true) then
    self:send_msg()
    return
  end
  self.curr_event_all_step_cfg = self.all_step_cfg[self.curr_event_info.id]
  if (not self.curr_event_cfg.FinishCondition or 0 == self.curr_event_cfg.FinishCondition) and self.curr_event_all_step_cfg and #self.curr_event_all_step_cfg > 0 then
    self.is_need_run_force_journey_event = true
    UIMainBubbleMgr:release_all_bubble_obj_state()
  end
  self:refresh_bgm_and_obj()
end

function M:refresh_bgm_and_obj()
  for step, step_cfg in ipairs(self.curr_event_all_step_cfg) do
    for _, cfg in ipairs(step_cfg) do
      if cfg.ActionId ~= action_id_enum.change_main_scene_obj_visible and cfg.ActionId ~= action_id_enum.change_bgm then
      else
        local params = cfg.Params
        if cfg.ActionId == action_id_enum.change_main_scene_obj_visible then
          if "1" ~= params[3] then
          else
            self.need_refresh_main_obj_list[params[1]] = "1" == params[2] and 1 or 2
          end
        elseif "1" ~= params[2] then
        elseif self.need_play_bgm == nil then
          self.need_play_bgm = params[1]
        end
      end
    end
  end
end

function M:get_is_need_run_force_journey_event()
  return self.is_need_run_force_journey_event
end

function M:get_is_need_force_settle()
  if not self.curr_event_cfg then
    return false
  end
  return self.curr_event_cfg.SettleBtnState > 0
end

function M:get_is_need_hide_next_btn()
  if not self.curr_event_cfg then
    return false
  end
  return self.curr_event_cfg.SettleBtnState == SETTLE_BTN_STATE.HIDE_NEXT_AND_FORCE_SETTLE_TO_MAIN
end

function M:get_is_need_ignore_signboard_sound()
  if not self.curr_event_cfg then
    return false
  end
  if self.curr_event_cfg.IgnoreSignboardSoundStepId then
    return self.curr_step_index < self.curr_event_cfg.IgnoreSignboardSoundStepId
  end
  return false
end

function M:get_npc_id_and_index()
  return self.curr_npc_id, self.curr_model_index
end

function M:get_sorted_event_list()
  local sorted_list = {}
  for i, info in pairs(self.event_list) do
    table.insert(sorted_list, info)
  end
  table.sort(sorted_list, function(a, b)
    local config_a = ShareRes.create("scene_journey.scene_journey_event", a.id)
    local config_b = ShareRes.create("scene_journey.scene_journey_event", b.id)
    return config_a.Sort < config_b.Sort
  end)
  return sorted_list
end

function M:refresh_journey_event_model()
  local model_view = self:try_get_model_view()
  if not model_view then
    Log.Error("refresh_journey_event_model: model_view is nil")
    return
  end
  if self.curr_model_index ~= nil and self.curr_model_index > 0 then
    local obj = model_view:get_model_with_index(self.curr_model_index)
    local is_finish = self:check_event_is_finish(true)
    if obj then
      if not is_finish then
        return
      else
        model_view:remove_npc_by_index(self.curr_model_index)
        self:send_msg()
      end
    elseif is_finish then
      self:send_msg()
    else
      model_view:remove_npc_by_index(self.curr_model_index)
      self:reset()
    end
  end
  self:refresh_curr_event()
  if not self.curr_event_cfg or not self.curr_event_info then
    return
  end
  if 0 == self.curr_step_index then
    self:go_to_next_step()
  end
end

function M:remove_model()
  if self.curr_event_cfg and 1 == self.curr_event_cfg.Compulsory then
    return false
  end
  local model_view = self:try_get_model_view()
  if not model_view then
    return true
  end
  if self.curr_model_index ~= nil and self.curr_model_index > 0 then
    UIMainBubbleMgr:release_bubble_obj_state(self.curr_npc_id)
    model_view:remove_npc_by_index(self.curr_model_index)
  end
  self:reset()
  return true
end

function M:get_buddy_data()
  if not self.is_listener_npc_click then
    return nil
  end
  return self.buddy_data
end

function M:update(elapsed)
  self:check_change_space_time(elapsed)
  self:on_clock_pointer_listener(elapsed)
  self:refresh_interactive_pd_progress_with_update(elapsed)
  self:check_hold_timeline(elapsed)
  if not self.curr_event_cfg or not self.curr_step_cfg then
    return
  end
  if 0 == self.curr_step_need_run_action_count then
    return
  end
  if not SceneMgr:check_main_scene() or not self:get_is_need_run_force_journey_event() and GuideMgr:get_cur_guider() then
    return
  end
  if self.curr_step_need_run_action_count == self.curr_step_run_finish_action_count then
    self:go_to_next_step()
  end
end

function M:check_change_space_time(elapsed)
  if self.stop_change_space_time then
    return
  end
  if UIMgr:get_cur_show_ui_name() ~= "uimain" or not SceneMgr:check_main_scene() then
    self.stop_change_space_time = true
    self.curr_change_space_time_time = 0
    self:reset()
    return
  end
  if self.curr_change_space_time_interval == nil or self.curr_change_space_time_interval <= 0 then
    return
  end
  if self.curr_change_space_time_time >= self.curr_change_space_time_interval then
    local index = self.curr_change_space_time_index + 1
    if index > 1 then
      index = 0
    end
    self.curr_change_space_time_index = index
    self.curr_change_space_time_time = 0
    self:change_space_time_logic(self.curr_change_space_time_index, self.curr_change_space_time_delay)
    return
  end
  self.curr_change_space_time_time = self.curr_change_space_time_time + elapsed
end

M.action_handler = {
  [1] = {
    func_name = "check_is_in_main_ui"
  },
  [2] = {
    func_name = "hide_main_ui_function"
  },
  [3] = {
    func_name = "hide_board_npc"
  },
  [4] = {func_name = "hide_clock"},
  [5] = {func_name = "create_npc"},
  [6] = {func_name = "play_story"},
  [7] = {
    func_name = "create_npc_and_play_story",
    func_count = 2
  },
  [8] = {
    func_name = "listener_npc_click"
  },
  [9] = {func_name = "remove_npc"},
  [10] = {func_name = "show_clock"},
  [11] = {
    func_name = "show_board_npc"
  },
  [12] = {
    func_name = "show_main_ui_function"
  },
  [13] = {
    func_name = "show_ui_black_fade"
  },
  [14] = {
    func_name = "play_timeline"
  },
  [15] = {
    func_name = "change_main_ui_lens"
  },
  [16] = {
    func_name = "change_main_scene_obj_visible"
  },
  [17] = {func_name = "change_bgm"},
  [18] = {
    func_name = "hide_main_scene_system",
    func_count = 3
  },
  [19] = {
    func_name = "open_main_scene_system",
    func_count = 3
  },
  [20] = {
    func_name = "play_timeline_on_long_press"
  },
  [21] = {
    func_name = "set_main_photo_frame_pd_enabled"
  },
  [22] = {
    func_name = "change_space_time"
  },
  [23] = {
    func_name = "refresh_change_space_time_state"
  },
  [24] = {
    func_name = "refresh_scene_po_sui_state"
  },
  [25] = {
    func_name = "change_to_default_lens"
  },
  [26] = {
    func_name = "active_timeline_not_play"
  },
  [27] = {
    func_name = "play_performance_timeline"
  },
  [28] = {
    func_name = "set_main_chapter_texture"
  },
  [29] = {func_name = "play_video"},
  [30] = {
    func_name = "refresh_main_clock_pointer_state"
  },
  [31] = {
    func_name = "refresh_main_clock_video_state"
  },
  [32] = {
    func_name = "listener_clock_pointer_rotate"
  },
  [33] = {
    func_name = "show_ui_white_fade"
  },
  [34] = {
    func_name = "change_rain_state"
  },
  [35] = {
    func_name = "play_performance_timeline_with_path"
  },
  [36] = {
    func_name = "set_main_clock_time_to_zero"
  },
  [37] = {
    func_name = "play_main_bgm"
  },
  [38] = {func_name = "open_ui"},
  [39] = {func_name = "close_ui"}
}

function M:run_next_step()
  self.curr_step_need_run_action_count = 0
  self.curr_step_run_finish_action_count = 0
  for i, cfg in pairs(self.curr_step_cfg) do
    local action_id_list = cfg.ActionIdList
    if action_id_list and #action_id_list > 0 then
      for _, action_id in pairs(action_id_list) do
        self:run_action(action_id, cfg)
      end
    end
    if cfg.ActionId and cfg.ActionId > 0 then
      self:run_action(cfg.ActionId, cfg)
    end
  end
end

function M:run_action(action_id, cfg)
  local func_name = self.action_handler[action_id].func_name
  local func_count = self.action_handler[action_id].func_count
  self:add_curr_step_need_run_action_count(func_count)
  local handler = M[func_name]
  if cfg.DelayTime then
    local delay_time = tonumber(cfg.DelayTime)
    local key = "run_journey_event_delay_time" .. tostring(action_id)
    Timer:add_timer(key, delay_time, function()
      handler(self, cfg.ActionId, cfg.Params)
    end)
  else
    handler(self, cfg.ActionId, cfg.Params)
  end
end

function M:go_to_next_step()
  self.curr_step_index = self.curr_step_index + 1
  if self.curr_step_index > #self.curr_event_all_step_cfg then
    self:on_event_finish()
    return
  end
  self.curr_step_cfg = self.curr_event_all_step_cfg[self.curr_step_index]
  self:run_next_step()
end

function M:add_curr_step_need_run_action_count(count)
  count = count or 1
  self.curr_step_need_run_action_count = self.curr_step_need_run_action_count + count
end

function M:on_action_run_finish()
  self.curr_step_run_finish_action_count = self.curr_step_run_finish_action_count + 1
end

function M:check_is_in_main_ui()
  local curr_ui_name = UIMgr:get_cur_show_ui_name()
  if "uimain" == curr_ui_name then
    self:on_action_run_finish()
  end
end

function M:hide_main_ui_function()
  self:set_main_ui_function_state(false)
end

function M:hide_board_npc()
  self:set_board_npc_visible(false)
end

function M:hide_clock()
  self:set_clock_visible(false)
end

function M:create_npc(action_id, params, cb)
  local model_view = self:try_get_model_view()
  if not model_view then
    Log.Error("create_npc: model_view is nil")
    return
  end
  local board_id = params[1]
  local is_need_effect = "1" == params[2]
  if not board_id then
    Log.Error(Util.format_str("函数{1}中的第一个参数为空", action_id))
    return
  end
  board_id = tonumber(board_id)
  local total_buddy_param_cfg = ShareRes.create("signboard_girl.signboard_girl_param")
  local buddy_param_cfg = total_buddy_param_cfg[board_id]
  local npc_id = buddy_param_cfg.BuddyId
  self.curr_npc_id = npc_id
  self.curr_model_index = TaskMgr:load_npc(model_view, npc_id, board_id, true, function(model_index)
    self.model_trans = model_view:get_model_with_index(model_index).transform
    if self.is_need_run_force_journey_event then
      model_view:hide_other_model(npc_id)
    end
    if is_need_effect then
      self:refresh_effect(board_id)
    end
  end, function()
    if cb then
      cb()
    end
    self:on_action_run_finish()
    if not Util.is_nil(self.idle_effect) then
      self:set_effect_visible(self.born_effect, false)
      self:set_effect_visible(self.idle_effect, true)
    end
  end)
  self.buddy_data.npc_id = npc_id
  self.buddy_data.bubble_state = 2
  self.buddy_data.model_index = self.curr_model_index
end

function M:refresh_effect(board_id)
  local ui_main = UIMgr:try_get_visible_ui("uimain")
  if not ui_main then
    return
  end
  if 1001001201 ~= board_id then
    return
  end
  self.effect_parent, self.born_effect, self.idle_effect, self.interact_effect = ui_main:get_scene_journey_effect()
  self.born_effect.transform:SetParent(self.model_trans)
  self.idle_effect.transform:SetParent(self.model_trans:Find("Bip001"))
  self.interact_effect.transform:SetParent(self.model_trans)
  self:refresh_mat_processor_obj(self.born_effect)
  self:refresh_mat_processor_obj(self.idle_effect)
  self:refresh_mat_processor_obj(self.interact_effect)
  self:set_effect_visible(self.born_effect, true)
end

function M:refresh_mat_processor_obj(obj)
  local mat_processor_obj = obj:GetComponentInChildren(typeof(CS.MaterialProcessor))
  if not Util.is_nil(mat_processor_obj) then
    mat_processor_obj.AttachedGameobj = self.model_trans.gameObject
  end
end

function M:set_effect_visible(obj, visible, parent)
  if not Util.is_nil(parent) then
    obj.transform:SetParent(parent)
  end
  if visible then
    obj.transform:ResetAttr()
  end
  obj:SetActive(visible)
end

function M:reset_effect()
  if Util.is_nil(self.born_effect) then
    return
  end
  self:set_effect_visible(self.born_effect, false, self.effect_parent.transform)
  self:set_effect_visible(self.idle_effect, false, self.effect_parent.transform)
  self:set_effect_visible(self.interact_effect, false, self.effect_parent.transform)
  self.born_effect = nil
  self.idle_effect = nil
  self.interact_effect = nil
  self.effect_parent = nil
  self.model_trans = nil
end

function M:play_story(action_id, params, cb)
  local model_view = self:try_get_model_view()
  if not model_view then
    Log.Error("play_story: model_view is nil")
    return
  end
  local story_id = params[1]
  if not story_id then
    Log.Error(Util.format_str("函数{1}中的第一个参数为空", action_id))
    return
  end
  story_id = tonumber(story_id)
  StoryMgr:on_start(story_id, nil, nil, nil, nil, function()
    if cb then
      cb()
    end
    self:on_action_run_finish()
  end)
end

function M:create_npc_and_play_story(action_id, params)
  local board_id = params[1]
  local story_id = params[2]
  local is_need_effect = params[3]
  if not board_id or "" == board_id then
    Log.Error(Util.format_str("函数{1}中的第一个参数为空", action_id))
    return
  end
  if not story_id or "" == story_id then
    Log.Error(Util.format_str("函数{1}中的第二个参数为空", action_id))
    return
  end
  local tempParams = {
    [1] = board_id,
    [2] = is_need_effect
  }
  self:create_npc(action_id, tempParams, function()
    self:play_story(action_id, {story_id})
  end)
end

function M:listener_npc_click(action_id, params)
  Timer:add_timer("journey_event_delay_npc_click", 1, function()
    self.is_listener_npc_click = true
  end)
end

function M:on_npc_click()
  if not self.is_listener_npc_click then
    return
  end
  if not self.curr_step_cfg then
    Log.Error("当前步骤配置为空", self.curr_step_index)
    return
  end
  for i, cfg in pairs(self.curr_step_cfg) do
    local action_id = cfg.InteractionActionId
    if action_id and action_id > 0 then
      local func_name = self.action_handler[action_id].func_name
      local handler = M[func_name]
      handler(self, action_id, cfg.Params)
    end
  end
  UIMainBubbleMgr:release_bubble_obj_state(self.curr_npc_id)
  self.is_listener_npc_click = false
end

function M:remove_npc()
  local model_view = self:try_get_model_view()
  if not model_view then
    Log.Error("remove_npc: model_view is nil")
    return
  end
  if not Util.is_nil(self.idle_effect) then
    self:set_effect_visible(self.idle_effect, false)
  end
  if not Util.is_nil(self.interact_effect) then
    self:set_effect_visible(self.interact_effect, true)
  end
  TaskMgr:play_buddy_event_delivery_anim(self.curr_npc_id, model_view, self.curr_model_index, function()
    self:reset_effect()
    model_view:remove_npc_by_index(self.curr_model_index)
    self:on_action_run_finish()
  end)
end

function M:show_clock()
  self:set_clock_visible(true)
end

function M:show_board_npc()
  self:set_board_npc_visible(true)
end

function M:show_main_ui_function()
  self:set_main_ui_function_state(true)
end

function M:show_ui_black_fade(action_id, params)
  local black_fade_in = params[1] and tonumber(params[1]) or 0.5
  local black_hold = params[2] and tonumber(params[2]) or 0.5
  local black_fade_out = params[3] and tonumber(params[3]) or 0.5
  local is_fade_in_cb = false
  if not params[4] or "1" == params[4] then
    is_fade_in_cb = true
  end
  local model_view = self:try_get_model_view()
  if not model_view then
    Log.Error("show_ui_black_fade: model_view is nil")
    return
  end
  if model_view then
    model_view:refresh_camera_root_visible(false)
  end
  Timer:add_timer("delay_show_ui_black_fade", 0.3, function()
    if model_view then
      model_view:refresh_camera_root_visible(true)
    end
    local ui_main = UIMgr:try_get_ui("uimain")
    if ui_main then
      ui_main:stop_change_space_time_effect()
    end
  end)
  UIMgr:get_ui("ui_blackfade"):ui_show(black_fade_in, black_hold, black_fade_out, function()
    self:on_action_run_finish()
  end, is_fade_in_cb)
end

function M:play_timeline(action_id, params)
  if not params[1] then
    Log.Error(Util.format_str("函数{1}中的第一个参数为空", action_id))
    return
  end
  local path = params[1]
  local object = UnityFind(path)
  if Util.is_nil(object) then
    Log.Error(Util.format_str("函数{1}中配置的参数路径未找到:{2}", action_id, path))
    return
  end
  object:SetActive(true)
  local pd = object:GetComponentInChildren(TypePlayableDirector)
  local scene_timeline = object.gameObject:TryAddComponent(TypeSpeedSceneTimeline)
  local time = pd.time
  local speed = params[2] and tonumber(params[2]) or 1
  scene_timeline:SetSpeed(speed, time)
  scene_timeline:PlaySceneTimeline(function()
    self:on_action_run_finish()
  end)
end

function M:active_timeline_not_play(action_id, params)
  if not params[1] then
    Log.Error(Util.format_str("函数{1}中的第一个参数为空", action_id))
    return
  end
  local path = params[1]
  local object = UnityFind(path)
  if Util.is_nil(object) then
    Log.Error(Util.format_str("函数{1}中配置的参数路径未找到:{2}", action_id, path))
    return
  end
  object:SetActive(true)
  local pd = object:GetComponentInChildren(TypePlayableDirector)
  pd.time = 0
  pd:Evaluate()
  self:on_action_run_finish()
end

function M:play_performance_timeline(action_id, params)
  local timeline_name = params[1]
  if not timeline_name or "" == timeline_name then
    Log.Error(Util.format_str("函数{1}中的第一个参数为空", action_id))
    return
  end
  self.v_camera_track_obj = nil
  ResPoolMgr:get_model_async(timeline_name, function(go)
    local ui_main = UIMgr:try_get_visible_ui("uimain")
    if not ui_main then
      return
    end
    self.v_camera_track_obj = ui_main:get_camera_track_obj()
    local model_view = self:try_get_model_view()
    if not model_view then
      Log.Error("play_performance_timeline: model_view is nil")
      return
    end
    local trans = model_view:get_content_root_trans()
    go.transform:SetParent(trans)
    go:ResetAttr()
    self.v_camera_track_obj:SetActive(false)
    model_view:set_vcamera_brain_enabled(true)
    model_view:set_model_visible_with_index(self.curr_model_index, false)
    go.transform:PlayTimeLineSeq(function()
      go:SetActive(false)
      self.v_camera_track_obj:SetActive(true)
      model_view:set_vcamera_brain_enabled(false)
      ui_main:change_model_view_param_to_normal(true, true)
      model_view:set_model_visible_with_index(self.curr_model_index, true)
      self:on_action_run_finish()
      ResMgr:destroy_gameobj(go)
      ResPoolMgr:on_destroy_gameobj(go)
      model_view:play_anim(Config.ACT_DEFINE.UIMainIdle, self.curr_model_index, nil, true)
    end)
  end)
end

function M:change_main_ui_lens(action_id, params)
  if not params[1] then
    Log.Error(Util.format_str("函数{1}中的第一个参数为空", action_id))
    return
  end
  local board_id = tonumber(params[1])
  local ui_main = UIMgr:try_get_visible_ui("uimain")
  if not ui_main then
    return
  end
  local speed = params[2]
  if speed and "" ~= params[2] then
    speed = tonumber(speed)
  end
  ui_main:change_center_event_model_view_param(board_id, false, speed)
  self:on_action_run_finish()
end

function M:change_main_scene_obj_visible(action_id, params)
  local ui_main = UIMgr:try_get_visible_ui("uimain")
  if not ui_main then
    return
  end
  local path = params[1]
  local visible = false
  if not params[2] or "1" == params[2] then
    visible = true
  end
  if self:set_obj_visible(path, visible) then
    self:on_action_run_finish()
  end
end

function M:set_obj_visible(path, visible)
  local obj = UnityFind(path)
  if Util.is_nil(obj) then
    Log.Error(Util.format_str("找不到路径{1}", path))
    return
  end
  obj:SetActive(visible)
  return true
end

function M:change_bgm(action_id, params)
  if not params[1] then
    Log.Error(Util.format_str("函数{1}中的第一个参数为空", action_id))
    return
  end
  Global.sound_mgr:play_sound_by_id(params[1])
end

function M:hide_main_scene_system()
  self:set_main_ui_function_state(false)
  self:set_board_npc_visible(false)
  self:set_clock_visible(false)
end

function M:open_main_scene_system()
  self:set_main_ui_function_state(true)
  self:set_board_npc_visible(true)
  self:set_clock_visible(true)
end

function M:play_timeline_on_long_press(action_id, params)
  local ui_main = UIMgr:try_get_visible_ui("uimain")
  if not ui_main then
    return
  end
  local btn = ui_main:get_long_press_btn()
  if not btn then
    Log.Error("主界面找不到长按按钮")
    return
  end
  ui_main:set_long_press_tips_visible(true)
  btn.gameObject:SetActive(true)
  local path = params[1]
  local object = UnityFind(path)
  if Util.is_nil(object) then
    Log.Error("未找到路径", path)
  end
  object:SetActive(true)
  local ui_root = ui_main:get_lua_object()
  local pd = object:GetComponentInChildren(TypePlayableDirector)
  local scene_timeline = object.gameObject:TryAddComponent(TypeSpeedSceneTimeline)
  local is_play_forward = false
  pd.time = 0
  pd:Evaluate()
  local speed = 1
  if params[3] and "" ~= params[3] then
    speed = tonumber(params[3])
  end
  self.curr_fix_play_audio_name = nil
  self.curr_fix_close_audio_name = nil
  if params[4] and "" ~= params[4] then
    self.curr_fix_play_audio_name = params[4]
  end
  if params[5] and "" ~= params[5] then
    self.curr_fix_close_audio_name = params[5]
  end
  Util.remove_longpress(nil, btn.gameObject, ui_root)
  Util.remove_point_up(nil, btn.gameObject, ui_root)
  Util.set_point_up(nil, btn.gameObject, ui_root, function()
    if self.curr_fix_play_audio_name then
      Global.sound_mgr:stop_sound_by_id(self.curr_fix_play_audio_name)
    end
    if self.curr_fix_close_audio_name then
      Global.sound_mgr:play_sound_by_id(self.curr_fix_close_audio_name)
    end
    if not is_play_forward then
      return
    end
    local time = pd.time
    scene_timeline:SetSpeed(-1 * speed, time)
    scene_timeline:PlaySceneTimeline(nil)
    is_play_forward = false
  end)
  local obj_path = params[2]
  if obj_path and "" ~= obj_path then
    local photo_frame_obj = UnityFind(obj_path)
    if not Util.is_nil(photo_frame_obj) then
      ui_main:refresh_long_press_btn_pos(photo_frame_obj)
    end
  end
  Util.set_longpress(nil, btn.gameObject, ui_root, function()
    if self.curr_fix_close_audio_name then
      Global.sound_mgr:stop_sound_by_id(self.curr_fix_close_audio_name)
    end
    if self.curr_fix_play_audio_name then
      Global.sound_mgr:play_sound_by_id(self.curr_fix_play_audio_name)
    end
    is_play_forward = true
    local time = pd.time
    scene_timeline:SetSpeed(speed, time)
    scene_timeline:PlaySceneTimeline(function()
      ui_main:set_long_press_tips_visible(false)
      btn.gameObject:SetActive(false)
      self:on_action_run_finish()
      Global.sound_mgr:play_sound_by_id("Sound_Sc03_fix_finish")
    end)
  end)
end

function M:set_main_photo_frame_pd_enabled(action_id, params)
  local ui_main = UIMgr:try_get_visible_ui("uimain")
  if not ui_main then
    return
  end
  local pd = ui_main:get_photo_frame_pd()
  if Util.is_nil(pd) then
    self:on_action_run_finish()
    return
  end
  pd.time = 0
  pd:Evaluate()
  pd.enabled = "1" == params[1]
  self:on_action_run_finish()
end

function M:change_space_time(action_id, params)
  local index = params[1]
  if not index or "" == index then
    index = 0
  else
    index = tonumber(index)
  end
  local delay = params[2]
  if not delay or "" == delay then
    delay = 0.5
  else
    delay = tonumber(delay)
  end
  local interval = params[3]
  if not interval or "" == interval then
    interval = 0
  else
    interval = tonumber(interval)
  end
  if not self.curr_change_space_time_index then
    self.curr_change_space_time_index = index
  end
  self.curr_change_space_time_delay = delay
  self.curr_change_space_time_interval = interval
  self.curr_change_space_time_time = 0
  self.stop_change_space_time = false
  self:change_space_time_logic(self.curr_change_space_time_index, 0, true)
  Timer:add_timer("delay_change_space_time_finish", 1, function()
    self:on_action_run_finish()
  end)
end

function M:change_space_time_logic(next_index, delay, ignore_effect, ignore_sound)
  local scene_effect_obj = UnityFind("SceneEffect")
  if not scene_effect_obj then
    return
  end
  local scene_illumination = scene_effect_obj:GetComponent(typeof(CS.SceneIllumination))
  if not ignore_effect then
    Global.sound_mgr:play_sound_by_id("Sound_Sc03_switch")
    local ui_main = UIMgr:try_get_visible_ui("uimain")
    if ui_main then
      ui_main:play_change_space_time_effect()
      self:refresh_space_time_change_effect_timer(ui_main)
    end
  end
  if delay > 0 then
    self.delay_change_space_timer = Timer:add_timer("delay_change_space_time", delay, function()
      self:set_scene_light_data(scene_illumination, next_index, ignore_sound)
    end)
  else
    self:set_scene_light_data(scene_illumination, next_index, ignore_sound)
  end
end

function M:refresh_space_time_change_effect_timer(ui_main)
  self:clear_space_time_change_effect_timer()
  self.v_change_space_time_effect_timer = Timer:add_timer("change_space_time_effect_timer", 2.1, function()
    ui_main:stop_change_space_time_effect()
    self:clear_space_time_change_effect_timer()
  end)
end

function M:clear_space_time_change_effect_timer()
  if self.v_change_space_time_effect_timer then
    Timer:remove_timer(self.v_change_space_time_effect_timer)
    self.v_change_space_time_effect_timer = nil
  end
end

function M:set_scene_light_data(scene_illumination, next_index, ignore_sound)
  if not ignore_sound then
    self:refresh_space_time_change_sound(1 == next_index)
  end
  local fashion_index = next_index
  if 0 == fashion_index and self.curr_event_cfg and 1 ~= self.curr_event_cfg.IgnoreFashion then
    fashion_index = FashionMgr:get_use_main_scene_fashion_index()
  end
  scene_illumination.curLightDataIndex = fashion_index
  scene_illumination:ApplySceneEffect()
  self:change_main_scene_clock_material(next_index)
  Global.scene_mgr:_init_diff_light(fashion_index)
  FashionMgr:set_scene_illumination_index(fashion_index)
end

function M:refresh_change_space_time_state(action_id, params)
  self.stop_change_space_time = "1" ~= params[1]
  if self.stop_change_space_time then
    self:clear_change_space_timer()
    self.curr_change_space_time_time = 0
  end
  self:on_action_run_finish()
end

function M:refresh_scene_po_sui_state(action_id, params)
  local index = params[1]
  if not index or "" == index then
    index = 1
  else
    index = tonumber(index)
  end
  self:change_space_time_logic(index, 0, true)
  self:on_action_run_finish()
end

function M:change_to_default_lens(action_id, params)
  local ui_main = UIMgr:try_get_visible_ui("uimain")
  if ui_main then
    ui_main:change_model_view_param_to_normal(false, true)
  end
  self:on_action_run_finish()
end

function M:set_main_chapter_texture(action_id, params)
  local index = params[1]
  local ui_main = UIMgr:try_get_visible_ui("uimain")
  if ui_main then
    if index and "" ~= index then
      index = tonumber(index)
      ui_main:set_main_scene_chapter_mat_tex(index)
    else
      ui_main:main_scene_set_tex()
    end
  end
  self:on_action_run_finish()
end

function M:change_main_scene_clock_material(state)
  local ui_main = UIMgr:try_get_visible_ui("uimain")
  if not ui_main then
    return
  end
  local clock = ui_main:get_clock()
  if not clock then
    Log.Error("主界面找不到时钟")
    return
  end
  local mat = self:get_material(state)
  local mesh_render = clock:GetComponent(typeof(UnityEngine.MeshRenderer))
  mesh_render.material = mat
end

function M:get_material(state)
  local obj
  if 0 == state then
    obj = UnityFind("Root/FX/Fx_clock_zhengchang/GameObject01")
  else
    obj = UnityFind("Root/FX/Fx_clock_posun/GameObject")
  end
  local mat_obj = obj:GetComponent(typeof(CS.MaterialProcessor))
  local mat = mat_obj.MaterialInfos[0].Materials[0]
  return mat
end

function M:set_main_ui_function_state(visible)
  local ui_main = UIMgr:try_get_visible_ui("uimain")
  if not ui_main then
    return
  end
  ui_main:refresh_ui_function_visible(visible)
  self:on_action_run_finish()
end

function M:set_board_npc_visible(visible)
  local model_view = self:try_get_model_view()
  if not model_view then
    Log.Error("set_board_npc_visible: model_view is nil")
    return
  end
  model_view:set_model_visible(visible)
  self:on_action_run_finish()
end

function M:set_clock_visible(visible)
  local ui_main = UIMgr:try_get_visible_ui("uimain")
  if not ui_main then
    return
  end
  ui_main:set_clock_state(visible)
  self:on_action_run_finish()
end

function M:play_video(action_id, params)
  local video_name = params[1]
  
  local function end_cb()
    self:on_action_run_finish()
  end
  
  local aspect_ratio
  if params[2] then
    aspect_ratio = tonumber(params[2])
  end
  local video_info = {
    video_name = video_name,
    is_skip = false,
    end_cb = end_cb,
    aspect_ratio = aspect_ratio
  }
  self:stop_performance_timeline_sound()
  VideoMgr:on_play_video(video_info)
end

function M:refresh_main_clock_pointer_state(action_id, params)
  local state = params[1]
  SignBoardGirlMgr:set_clock_update("1" == state)
  self:on_action_run_finish()
  local model_view = TaskMgr:get_ui_main_model_view()
  if model_view then
    model_view:update_clock()
  end
end

function M:refresh_main_clock_video_state(action_id, params)
  local is_open = "1" == params[1]
  local ui_main = UIMgr:try_get_visible_ui("uimain")
  if not ui_main then
    return
  end
  if not is_open then
    ui_main:play_journey_event_video()
    self:on_action_run_finish()
    return
  end
  local video_name = params[2]
  local cfg = {VedioName = video_name, EntryStyle = 1}
  ui_main:play_journey_event_video(cfg, function()
    self:on_action_run_finish()
  end)
end

function M:listener_clock_pointer_rotate(action_id, params)
  local ui_main = self:try_get_ui_main()
  if not ui_main then
    return
  end
  SignBoardGirlMgr:set_clock_update(false)
  local path = params[1]
  local object = UnityFind(path)
  object:SetActive(true)
  self.v_interactive_pd = object:GetComponentInChildren(TypePlayableDirector)
  self.v_interactive_pd.time = 0
  self.v_interactive_pd:Evaluate()
  self.v_interactive_pd:Stop()
  self.v_auto_play_pd_time = 3
  if params[2] then
    local time = tonumber(params[2])
    if time and time > 0 then
      self.v_auto_play_pd_time = time
    end
  end
  self.v_is_rotate_forward = "1" == params[3]
  self.v_hour_hand, self.v_minute_hand = ui_main:get_hour_minute_hand()
  self.v_listener_clock_pointer_rotate = true
  self.v_touch_pos = Vec2.New()
  self.v_angle_count = 0
  self.v_max_speed = 6
  self.v_max_angle = 360
  self:play_performance_timeline_with_path(action_id, {path, "0"})
  UIMgr:get_ui("ui_main_clock_guide"):ui_show()
end

function M:on_clock_pointer_listener()
  if not self.v_listener_clock_pointer_rotate then
    return
  end
  if UNITY_EDITOR or UNITY_STANDALONE_WIN then
    if CSInput.GetMouseButtonDown(0) then
      self:check_touch_obj(CSInput.mousePosition)
    elseif CSInput.GetMouseButton(0) then
      self:check_move_obj(CSInput.mousePosition)
    elseif CSInput.GetMouseButtonUp(0) then
      self:check_move_end()
    end
  elseif CSInput.touchCount > 0 then
    local touch_1 = CSInput.GetTouch(0)
    if touch_1.phase == TouchPhase.Began then
      self:check_touch_obj(touch_1.position)
    elseif touch_1.phase == TouchPhase.Moved then
      self:check_move_obj(touch_1.position)
    elseif touch_1.phase == TouchPhase.Ended or touch_1.phase == TouchPhase.Canceled then
      self:check_move_end()
    end
  end
end

function M:check_touch_obj(position)
  position = UtilUI.convert_to_resolution_pos(position)
  self.v_touch_pos.x = position.x
  self.v_touch_pos.y = position.y
  local ui_main = self:try_get_ui_main()
  if not ui_main then
    Log.Error("check_touch_obj: ui_main is nil")
    return
  end
  local ray = ui_main:screen_point_to_ray(self.v_touch_pos)
  if not ray then
    return
  end
  local dir = ray.direction
  local org = ray.origin
  local max_ray_len = 100
  local layer = Layer.LayerMask.SceneCollider
  local is_hit, obj = CSHelper.RayCastGameObject(org.x, org.y, org.z, dir.x, dir.y, dir.z, max_ray_len, layer)
  if is_hit and nil ~= obj and obj.name == "MinuteHand_" then
    self.v_is_need_update_clock_video_duration = true
    ui_main:set_video_player_state(true)
    local x, y, z = self.v_minute_hand:GetPositionA()
    local screen_pos_x, screen_pos_y = ui_main:world_to_screen_pos(x, y, z, true)
    self.v_center_pos = Vec2.New(screen_pos_x, screen_pos_y)
    self.v_is_dragging = true
    local _, _, hour_angle_z = self.v_hour_hand:GetLocalEulerAnglesA3()
    self.v_hour_start_angle = hour_angle_z
    self.v_last_angle = nil
    UIMgr:try_hide_ui("ui_main_clock_guide")
    Global.sound_mgr:play_sound_by_id("Sound_LC_Chapter_05_pluck")
  end
end

function M:check_move_obj(position)
  if self.v_is_dragging then
    if self.v_is_refresh_progress_with_update then
      return
    end
    position = UtilUI.convert_to_resolution_pos(position)
    self.v_touch_pos.x = position.x
    self.v_touch_pos.y = position.y
    self.vec2_pos = self.v_touch_pos - self.v_center_pos
    local angle = -UnityVector2.SignedAngle(UnityVector2.up, self.vec2_pos)
    if angle < 0 then
      angle = angle + 360
    end
    if not self.v_angle_offset then
      local _, _, angle_z = self.v_minute_hand:GetEulerAnglesA3()
      self.v_angle_offset = angle_z - angle
    end
    if not self.v_last_angle then
      self.v_last_angle = angle
      return
    end
    if angle == self.v_last_angle then
      return
    end
    if angle > self.v_last_angle then
      if angle - self.v_last_angle > 180 then
        if self.v_is_rotate_forward then
          self.v_last_angle = angle
          return
        end
        self.v_angle_count = self.v_angle_count + angle - self.v_last_angle - 360
      else
        if not self.v_is_rotate_forward then
          self.v_last_angle = angle
          return
        end
        self.v_angle_count = self.v_angle_count + angle - self.v_last_angle
      end
    elseif self.v_last_angle - angle < 180 then
      if self.v_is_rotate_forward then
        self.v_last_angle = angle
        return
      end
      self.v_angle_count = self.v_angle_count + angle - self.v_last_angle
    else
      if not self.v_is_rotate_forward then
        self.v_last_angle = angle
        return
      end
      self.v_angle_count = self.v_angle_count + angle - self.v_last_angle + 360
    end
    self.v_minute_hand:SetEuler(0, 0, angle + self.v_angle_offset)
    self.v_last_angle = angle
    self.v_hour_angle = self.v_hour_start_angle + self.v_angle_count / 12
    self.v_hour_hand:SetEuler(0, 0, self.v_hour_angle)
    self:refresh_interactive_pd_progress_with_rotate()
  end
end

function M:change_effect_speed(angle_count)
  local ratio = angle_count / self.v_max_angle
  local lv = 1
  for i, t in ipairs(EFF_AUDIO_ID_LIST) do
    if ratio >= (i - 1) / 3 then
      lv = i
    end
  end
  if self.v_audio_level ~= lv then
    if self.v_audio_level then
      Global.sound_mgr:stop_sound_by_id_ex("")
    end
    Global.sound_mgr:play_sound_by_id(EFF_AUDIO_ID_LIST[lv][1])
    Global.sound_mgr:play_sound_by_id(EFF_AUDIO_ID_LIST[lv][2])
    self.v_audio_level = lv
  end
end

function M:check_move_end()
  if self.v_is_dragging then
    self.v_is_need_update_clock_video_duration = false
    if self.v_interactive_pd.time < self.v_auto_play_pd_time then
      local ui_main = self:try_get_ui_main()
      if ui_main then
        ui_main:set_video_player_state(false)
      else
        Log.Error("check_move_end: ui_main is nil")
      end
    end
    self.v_is_dragging = false
    self.v_touch_protect = true
    Global.sound_mgr:stop_sound_by_id("Sound_LC_Chapter_05_pluck")
  end
  self:clear_listener_clock_rotate()
end

function M:clear_listener_clock_rotate()
  self.v_touch_pos = Vec2.New()
  self.v_angle_count = 0
  self.v_center_pos = nil
  self.v_is_dragging = nil
  self.v_hour_start_angle = nil
  self.v_last_angle = nil
  self.vec2_pos = nil
  self.v_angle_offset = nil
  self.v_hour_angle = nil
  self.v_audio_level = nil
  self.v_touch_protect = nil
end

function M:refresh_interactive_pd_progress_with_rotate()
  if not self.v_interactive_pd then
    return
  end
  self.v_interactive_pd.time = self.v_interactive_pd.time + 0.03
  self.v_interactive_pd:Evaluate()
  if self.v_interactive_pd.time >= self.v_auto_play_pd_time then
    self.v_is_refresh_progress_with_update = true
    local ui_main = self:try_get_ui_main()
    if ui_main then
      ui_main:set_video_player_state(true)
    else
      Log.Error("refresh_interactive_pd_progress_with_rotate: ui_main is nil")
    end
    Global.sound_mgr:stop_sound_by_id("Sound_LC_Chapter_05_pluck")
    Global.sound_mgr:play_sound_by_id("Sound_LC_Chapter_05_end")
  end
  if self.v_interactive_pd.time >= self.v_interactive_pd.duration then
    self:clear_listener_clock_rotate()
    self.v_listener_clock_pointer_rotate = nil
    self.v_is_refresh_progress_with_update = nil
    self.v_performance_timeline_cb()
    self.v_performance_timeline_cb = nil
  end
end

function M:refresh_clock_video_duration()
  if not self.v_is_need_update_clock_video_duration or not self.v_interactive_pd then
    return
  end
end

function M:refresh_interactive_pd_progress_with_update()
  if not self.v_interactive_pd then
    return
  end
  if not self.v_listener_clock_pointer_rotate then
    return
  end
  if not self.v_is_refresh_progress_with_update then
    return
  end
  self.v_interactive_pd.time = self.v_interactive_pd.time + 0.03
  self.v_interactive_pd:Evaluate()
  if self.v_interactive_pd.time >= self.v_interactive_pd.duration then
    self:clear_listener_clock_rotate()
    self.v_listener_clock_pointer_rotate = nil
    self.v_is_refresh_progress_with_update = nil
    self.v_performance_timeline_cb()
    self.v_performance_timeline_cb = nil
  end
end

function M:play_performance_timeline_with_path(action_id, params)
  if self.v_hold_timeline and self.v_performance_timeline_cb then
    self.v_performance_timeline_cb(true)
    self.v_performance_timeline_cb = nil
    self.v_hold_timeline = nil
  end
  local timeline_path = params[1]
  local ui_main = UIMgr:try_get_visible_ui("uimain")
  if not ui_main then
    return
  end
  if "1" == params[3] then
    VideoMgr:stop()
  end
  self.v_camera_track_obj = nil
  local performance_timeline_obj = UnityFind(timeline_path)
  self.v_performance_timeline_parent = performance_timeline_obj.transform.parent
  self.v_camera_track_obj = ui_main:get_camera_track_obj()
  local model_view = TaskMgr:get_ui_main_model_view()
  local trans = model_view:get_content_root_trans()
  performance_timeline_obj:SetActive(true)
  performance_timeline_obj.transform:SetParent(trans)
  performance_timeline_obj:ResetAttr()
  self.v_camera_track_obj:SetActive(false)
  model_view:set_vcamera_brain_enabled(true)
  model_view:set_model_visible_with_index(self.curr_model_index, false)
  local is_auto_play = "1" == params[2] or nil == params[2]
  local hold_timeline = performance_timeline_obj:GetComponent(TypePlayableDirector)
  self.v_is_need_check_hold_timeline_play_finished = false
  if "1" == params[4] then
    self.v_hold_timeline = hold_timeline
    self.v_is_need_check_hold_timeline_play_finished = true
    self.v_hold_timeline.extrapolationMode = UnityEngine.Playables.DirectorWrapMode.Hold
  end
  if params[5] then
    local sound_info_list = Util.split_str(params[5], "|")
    if not self.v_performance_timeline_loop_sound then
      self.v_performance_timeline_loop_sound = {}
    end
    for _, sound_info in pairs(sound_info_list) do
      local sound_arr = Util.split_str(sound_info, ",")
      if 2 == #sound_arr then
        if "2" == sound_arr[2] then
          table.insert(self.v_performance_timeline_loop_sound, sound_arr[1])
        end
        Global.sound_mgr:play_sound_by_id(sound_arr[1])
      end
    end
  end
  
  local function reset_cb()
    model_view:play_anim(Config.ACT_DEFINE.UIMainIdle, self.curr_model_index, nil, true)
    performance_timeline_obj.transform:SetParent(self.v_performance_timeline_parent)
    performance_timeline_obj:ResetAttr()
    performance_timeline_obj:SetActive(false)
  end
  
  function self.v_performance_timeline_cb(ignore_action_finish)
    self.v_camera_track_obj:SetActive(true)
    model_view:set_vcamera_brain_enabled(false)
    ui_main:change_model_view_param_to_normal(true, true)
    model_view:set_model_visible_with_index(self.curr_model_index, true)
    if not ignore_action_finish then
      self:on_action_run_finish()
    end
    reset_cb()
  end
  
  if is_auto_play then
    performance_timeline_obj.transform:PlayTimeLineSeq(function()
      if self.v_hold_timeline then
        self:on_action_run_finish()
      else
        self.v_performance_timeline_cb()
      end
    end)
  end
end

function M:check_hold_timeline()
  if not self.v_is_need_check_hold_timeline_play_finished then
    return
  end
  if self.v_hold_timeline.time >= self.v_hold_timeline.duration then
    self:on_action_run_finish()
    self.v_is_need_check_hold_timeline_play_finished = false
  end
end

function M:stop_performance_timeline_sound()
  if self.v_performance_timeline_loop_sound then
    for _, sound in pairs(self.v_performance_timeline_loop_sound) do
      Global.sound_mgr:stop_sound_by_id(sound)
    end
    self.v_performance_timeline_loop_sound = nil
  end
end

function M:show_ui_white_fade(action_id, params)
  local black_fade_in = params[1] and tonumber(params[1]) or 0.5
  local black_hold = params[2] and tonumber(params[2]) or 0.5
  local black_fade_out = params[3] and tonumber(params[3]) or 0.5
  local is_fade_in_cb = false
  if not params[4] or "1" == params[4] then
    is_fade_in_cb = true
  end
  UIMgr:get_ui("ui_blackfade"):ui_show(black_fade_in, black_hold, black_fade_out, function()
    self:on_action_run_finish()
  end, is_fade_in_cb, true)
end

function M:change_rain_state(action_id, params)
  local scene_effect_obj = UnityFind("SceneEffect")
  if not scene_effect_obj then
    return
  end
  local scene_illumination = scene_effect_obj:GetComponent(typeof(CS.SceneIllumination))
  local default_index = 0
  if self.curr_event_cfg and 1 ~= self.curr_event_cfg.IgnoreFashion then
    default_index = FashionMgr:get_use_main_scene_fashion_index()
  end
  local light_date_index = "1" == params[1] and 2 or default_index
  scene_illumination.curLightDataIndex = light_date_index
  scene_illumination:ApplySceneEffect()
  Global.scene_mgr:_init_diff_light(light_date_index)
  FashionMgr:set_scene_illumination_index(light_date_index)
  self:on_action_run_finish()
end

function M:set_main_clock_time_to_zero(action_id, params)
  local ui_main = self:try_get_ui_main()
  if not ui_main then
    Log.Error("set_main_clock_time_to_zero: ui_main is nil")
    return
  end
  self.v_hour_hand, self.v_minute_hand = ui_main:get_hour_minute_hand()
  self.v_minute_hand:SetEuler(0, 0, 0)
  self.v_hour_hand:SetEuler(0, 0, 0)
  self:on_action_run_finish()
end

function M:play_main_bgm(action_id, params)
  local is_play = "1" == params[1]
  if is_play then
    Global.sound_mgr:play_main_bgm()
    Global.sound_mgr:start_play_bgm()
  else
    Global.sound_mgr:bgm_stop()
  end
  self:on_action_run_finish()
end

function M:open_ui(action_id, params)
  local ui_name = params[1]
  UIMgr:get_ui(ui_name):ui_show()
  self:on_action_run_finish()
end

function M:close_ui(action_id, params)
  local ui_name = params[1]
  self.v_listener_close_ui = ui_name
end

function M:on_ui_hide_event(msg)
  if not self.v_listener_close_ui then
    return
  end
  if msg.mm_obj == self.v_listener_close_ui then
    self:on_action_run_finish()
    self.v_listener_close_ui = nil
  end
end

function M:on_ui_show_event(msg)
  if not self.curr_event_cfg then
    return
  end
  if 6 ~= self.curr_event_cfg.Id then
    return
  end
  local is_main_scene = SceneMgr:check_main_scene()
  if not is_main_scene then
    self:reset()
    return
  end
  if msg.mm_obj == "ui_click_effect" or msg.mm_obj == "ui_debug_info" then
    return
  end
  if msg.mm_obj ~= "uimain" then
    Global.sound_mgr:set_space_time_aisac_control(1, 0)
    Global.sound_mgr:pause_sound_by_id("Sound_Sc03_ambience_broken_loop", true)
  else
    Global.sound_mgr:set_space_time_aisac_control(0.25, 0)
    Global.sound_mgr:pause_sound_by_id("Sound_Sc03_ambience_broken_loop", false)
  end
end

function M:on_event_finish()
  local is_finish = self:check_event_is_finish()
  if not is_finish and 1 == self.curr_event_cfg.SpaceTimeChangeState then
    return
  end
  self:send_msg()
  local ui_main = UIMgr:try_get_visible_ui("uimain")
  if not ui_main then
    return
  end
  ui_main:ui_show()
  self:refresh_next_journey_event()
end

function M:refresh_next_journey_event()
  Timer:add_timer("refresh_next_journey_event", 2, function()
    self:refresh_journey_event_model()
  end)
end

function M:send_msg()
  self:call_server_event_finish(self.curr_event_info.id)
  self.event_list[self.curr_event_info.id].state = CommonDefine.SCENE_JOURNEY_EVENT_STATE.COMPLETE
  self.stop_change_space_time = true
  self:change_space_time_logic(0, 0, true, true)
  self:reset()
end

function M:check_event_is_finish(check_force_event)
  if self.curr_event_info and self.curr_event_cfg then
    local finish_condition = self.curr_event_cfg.FinishCondition
    if finish_condition and 0 ~= finish_condition and not Condition:check_condition(finish_condition) then
      return false
    end
    if check_force_event and 1 == self.curr_event_cfg.Compulsory then
      return false
    end
  end
  return true
end

function M:reset()
  self.curr_event_info = nil
  self.curr_event_cfg = nil
  self.buddy_data = {}
  self.curr_step_index = 0
  self.curr_event_all_step_cfg = {}
  self.curr_step_cfg = nil
  self.curr_step_need_run_action_count = 0
  self.curr_step_run_finish_action_count = 0
  self.curr_model_index = 0
  self.curr_npc_id = 0
  self.is_need_run_force_journey_event = false
  self.is_listener_npc_click = false
  self.need_play_bgm = nil
  self.need_refresh_main_obj_list = {}
  self.effect_parent = nil
  self.born_effect = nil
  self.idle_effect = nil
  self.interact_effect = nil
  self.model_trans = nil
  self.curr_fix_play_audio_name = nil
  self.curr_fix_close_audio_name = nil
  self:refresh_space_time_change_sound(false, -1)
  self:clear_change_space_timer()
  CS.SceneIlluminationInfo.ProcessingProfileInstantiate()
  self:clear_space_time_change_effect_timer()
  CSHelper.SetSceneGaussianBlur(-1, 0, 0)
end

function M:clear_change_space_timer()
  if self.delay_change_space_timer then
    Timer:remove_timer(self.delay_change_space_timer)
    self.delay_change_space_timer = nil
  end
end

function M:refresh_space_time_change_sound(is_open, duration)
  if -1 == duration then
    duration = nil
  else
    duration = 0.3
  end
  if is_open then
    Global.sound_mgr:set_space_time_aisac_control(0.25, 0)
    Global.sound_mgr:pause_sound_by_id("Sound_Sc03_ambience_broken_loop", false)
  else
    Global.sound_mgr:set_space_time_aisac_control(1, 0)
    Global.sound_mgr:pause_sound_by_id("Sound_Sc03_ambience_broken_loop", true)
  end
end

function M:get_event_is_finish(event_id)
  if not self.event_list then
    return false
  end
  for idx, info in pairs(self.event_list) do
    if info.id == event_id and info.state == CommonDefine.SCENE_JOURNEY_EVENT_STATE.COMPLETE then
      return true
    end
  end
  return false
end

function M:call_server_event_finish(event_id, callback)
  if self.curr_event_cfg.IgnoreEvent and 1 == self.curr_event_cfg.IgnoreEvent then
    self:call_server_ignore_journey_event(event_id, callback)
  else
    self:call_server_journey_event(event_id, callback)
  end
end

function M:call_server_journey_event(event_id, callback)
  local body = {scene_journey_event_id = event_id}
  Network:call("c2gs_scene_journey_event_finish", body, function(ok, resp)
    if ok then
      if self.curr_event_cfg and 1 == self.curr_event_cfg.IgnoreFashion then
        FashionMgr:reset_main_scene_fashion()
      end
      if callback then
        callback(resp)
      end
    end
  end)
end

function M:call_server_ignore_journey_event(event_id, callback)
  if event_id == CommonDefine.JOURNEY_EVENT_ID.BIRTHDAY_TIPS and callback then
    callback()
  end
end

function M:try_get_ui_main()
  return UIMgr:try_get_visible_ui("uimain")
end

function M:try_get_model_view()
  return TaskMgr:get_ui_main_model_view()
end

return M
