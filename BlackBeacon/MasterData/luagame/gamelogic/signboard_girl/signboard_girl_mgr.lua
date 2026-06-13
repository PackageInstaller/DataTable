local Base = require("gamelogic.base_system")
local M = Util.create_child_mt(Base)
local Timer = Global.timer
local CONDITION_ACTION = Config.CONDITION_ACTION
local ACT_DEFINE = Config.ACT_DEFINE
local DO_STAND_BY_SIGNBOARD_PARAM = Config.DO_STAND_BY_SIGNBOARD_PARAM
local KEEP_ACT_SIGNBOARD_PARAM = Config.KEEP_ACT_SIGNBOARD_PARAM
local VoiceFadeOutTime_MainScene = ShareRes.get_comm_value("VoiceFadeOutTime_MainScene") or 1
local SPECIAL_ACTION_TYPE = {CONTINUED = 200}
local _insert = table.insert
local DEFAULT_STAND_TIME = 1800

function M:init_sys()
  Base.init_sys(self)
  self.v_first_trigger = true
  self.first_trigger = true
  self.v_update_camera = true
  self.v_is_playing = false
  self.v_cooldown_action = {}
  self.v_next_stand_time = DEFAULT_STAND_TIME
  self.v_stand_by_time = 0
  self.v_stand_by_action = nil
  self.v_is_check_stand_by = false
  self.v_is_update = true
  self.v_cur_view_stand_by_act = nil
  self.v_is_clock_update = true
end

local function draw_random_action(action_list)
  if not action_list then
    return
  end
  local length = #action_list
  if length < 1 then
    return
  end
  local sum = 0
  for _, data in ipairs(action_list) do
    local weight = data.Weights
    sum = sum + weight
  end
  local compare_weight = math.random(1, sum)
  local count_weight = 0
  for idx, data in ipairs(action_list) do
    local weight = data.Weights
    count_weight = count_weight + weight
    if compare_weight <= count_weight then
      return action_list[idx]
    end
  end
  return action_list[1]
end

function M:get_board_random_action(action_list)
  return draw_random_action(action_list)
end

function M:add_action_cooldown(id, duration)
  self.v_cooldown_action[id] = duration
end

function M:is_cooldown(id)
  return self.v_cooldown_action[id]
end

function M:enable_use_action_list(action_list)
  local use_action_list = {}
  for _, data in pairs(action_list) do
    local id = data.Id
    if not self:is_cooldown(id) then
      _insert(use_action_list, data)
    end
  end
  return use_action_list
end

function M:enable_use_action_list_ex(action_list)
  local use_action_list = {}
  if not action_list then
    return use_action_list
  end
  for _, data in pairs(action_list) do
    local unlock_condition = data.UnlockConditionId or 0
    if (0 == unlock_condition or Condition:check_condition(unlock_condition)) and not self:is_cooldown(data.Id) then
      _insert(use_action_list, data)
    end
  end
  return use_action_list
end

function M:check_journey_action_to_use(use_action)
  local have_new_journey = PlayerJourneyMgr:get_journey_red()
  if not have_new_journey then
    return
  end
  local react_type = CONDITION_ACTION.HAVE_NEW_JOURNEY
  local buddy_id = PlayerMgr:get_signboard_girl_id()
  local fashion_id = FashionMgr:get_fashion_wearing_id(buddy_id)
  local reaction_cfgs = ShareRes.get_signboard_girl_reaction_cfg(react_type, buddy_id, fashion_id)
  if reaction_cfgs then
    local temp_list = self:enable_use_action_list_ex(reaction_cfgs)
    for _, data in pairs(temp_list) do
      _insert(use_action, data)
    end
  end
end

function M:update(delta_time)
  for id, rest_time in pairs(self.v_cooldown_action) do
    self.v_cooldown_action[id] = rest_time - delta_time
    if self.v_cooldown_action[id] < 0 then
      self.v_cooldown_action[id] = nil
    end
  end
  self:check_stand_by(delta_time)
end

function M:check_stand_by(delta_time)
  if self.v_is_check_stand_by then
    self.v_stand_by_time = self.v_stand_by_time + delta_time
    if self.v_stand_by_time > self.v_next_stand_time and self.v_stand_by_action then
      self:send_signboard_action(self.v_stand_by_action)
      self:reset_stand_by_time()
    end
  end
end

function M:get_useable_action_list(react_type, include_journey_action, buddy_id)
  buddy_id = buddy_id or PlayerMgr:get_signboard_girl_id()
  local fashion_id = FashionMgr:get_fashion_wearing_id(buddy_id)
  local reaction_cfgs = ShareRes.get_signboard_girl_reaction_cfg(react_type, buddy_id, fashion_id, true)
  local useable_action_list = self:enable_use_action_list_ex(reaction_cfgs)
  if include_journey_action then
    local have_new_journey = PlayerJourneyMgr:get_journey_red()
    if have_new_journey then
      local jo_action_list = ShareRes.get_signboard_girl_reaction_cfg(CONDITION_ACTION.HAVE_NEW_JOURNEY, buddy_id, fashion_id)
      if jo_action_list then
        local temp_list = self:enable_use_action_list_ex(jo_action_list)
        for _, data in pairs(temp_list) do
          _insert(useable_action_list, data)
        end
      end
    end
  end
  return useable_action_list
end

function M:get_action_by_param(buddy_id, condition_type, match_arg1, check_fashion)
  buddy_id = buddy_id or PlayerMgr:get_signboard_girl_id()
  local fashion_id = check_fashion and FashionMgr:get_fashion_wearing_id(buddy_id)
  local reaction_cfgs = ShareRes.get_signboard_girl_reaction_cfg(condition_type, buddy_id, fashion_id, true)
  if not reaction_cfgs then
    return
  end
  for _, v in pairs(reaction_cfgs) do
    if v.ConArg[1] == match_arg1 then
      return v
    end
  end
  return
end

function M:play_login_action()
  if not self.v_first_trigger then
    return
  end
  self:refresh_stand_action()
  self:refresh_cur_view_stand_by_act()
  local useable_action_list = self:get_useable_action_list(CONDITION_ACTION.LOGIN_WEILCOME, true)
  if useable_action_list then
    local draw_action = draw_random_action(useable_action_list)
    if draw_action then
      self:send_signboard_action(draw_action)
      self.v_first_trigger = false
    end
  end
end

function M:change_signboard_girl()
  local useable_action_list = self:get_useable_action_list(CONDITION_ACTION.CHANGE_GIRL, false)
  if useable_action_list then
    local draw_action = draw_random_action(useable_action_list)
    if draw_action then
      self:send_signboard_action(draw_action)
    end
  end
end

function M:play_favor_exp_up_action(buddy_id)
  local useable_action_list = self:get_useable_action_list(CONDITION_ACTION.FAVOR_EXP_UP, false, buddy_id)
  if useable_action_list then
    local draw_action = draw_random_action(useable_action_list)
    if draw_action then
      self:send_signboard_action(draw_action)
    end
  end
end

function M:play_favor_lv_up_action(buddy_id, match_lv)
  local draw_action = self:get_action_by_param(buddy_id, CONDITION_ACTION.FAVOR_LV_UP, match_lv, true)
  if draw_action then
    self:send_signboard_action(draw_action)
  end
end

function M:record_signboard_param_type(param_type)
  local do_stand_by = nil ~= param_type and true == DO_STAND_BY_SIGNBOARD_PARAM[param_type]
  self:enable_check_stand_by(do_stand_by, param_type)
  self.v_cur_signboard_param_type = param_type
  self:refresh_cur_view_stand_by_act()
end

function M:refresh_cur_view_stand_by_act()
  local buddy_id = PlayerMgr:get_signboard_girl_id()
  local cur_type = self.v_cur_signboard_param_type or 1
  local fashion_id = FashionMgr:get_fashion_wearing_id(buddy_id)
  local buddy_param_cfg = ShareRes.get_signboard_girl_param(cur_type, buddy_id, fashion_id)
  local act_name = buddy_param_cfg.Action
  if not act_name or "" == act_name then
    self.v_cur_view_stand_by_act = nil
  else
    self.v_cur_view_stand_by_act = act_name
  end
end

function M:get_cur_view_stand_by_act()
  return self.v_cur_view_stand_by_act or ACT_DEFINE.Idle
end

function M:refresh_stand_action()
  local useable_action_list = self:get_useable_action_list(CONDITION_ACTION.PLAY_LONG_TIEM, true)
  if useable_action_list then
    local draw_action = draw_random_action(useable_action_list)
    if draw_action then
      local stand_by_time = draw_action.ConArg[1] or DEFAULT_STAND_TIME
      self:_set_stand_by_data(stand_by_time, draw_action)
    end
  end
end

function M:_set_stand_by_data(time, draw_action)
  self.v_next_stand_time = time
  self.v_stand_by_action = draw_action
end

function M:click_signboard_girl()
  local buddy_id = PlayerMgr:get_signboard_girl_id()
  local fashion_id = FashionMgr:get_fashion_wearing_id(buddy_id)
  local char_active_action = ShareRes.get_signboard_girl_reaction_cfg("ActiveAction", buddy_id, fashion_id, true)
  if char_active_action then
    local use_action_list = self:enable_use_action_list_ex(char_active_action)
    local draw_action = draw_random_action(use_action_list)
    if draw_action then
      self:send_signboard_action(draw_action)
    end
  end
end

function M:continued_click_girl()
  local buddy_id = PlayerMgr:get_signboard_girl_id()
  local fashion_id = FashionMgr:get_fashion_wearing_id(buddy_id)
  local special_cfg = ShareRes.get_signboard_girl_reaction_cfg("SpecialAction", buddy_id, fashion_id, true)
  local condition_id = SPECIAL_ACTION_TYPE.CONTINUED
  if special_cfg and special_cfg[condition_id] then
    self:send_signboard_action(special_cfg[condition_id])
  else
    self:click_signboard_girl()
  end
end

function M:reset_stand_by_time()
  self.v_stand_by_time = 0
end

function M:on_set_signboard_girl_id(buddy_id)
  Network:call("c2gs_set_board_id", {id = buddy_id}, function(ok)
    if ok then
      Util.show_message_tip(2092)
    end
  end)
end

function M:on_set_board_background_id(backgroun_id)
  Network:call("c2gs_set_board_background", {id = backgroun_id}, function(ok)
    if ok then
      Util.show_message_tip(2092)
    end
  end)
end

function M:gm_send_signboard_action(draw_action)
  self.v_is_playing = true
  self.v_cur_action_cfg = draw_action
  local msg = MsgGame:mq_publish2(Const.MSG_ON_SIGNBOARD_ACTIVE_ACTION)
  msg.mm_obj = draw_action
  local cooldown = draw_action.CoolDown
  local id = draw_action.Id
  self:add_action_cooldown(id, cooldown)
  self.v_first_trigger = false
  self:clear_timer()
  local duration = self:get_act_duraction(draw_action)
  self.v_sound_timer = Timer:add_timer("sign_board_sound_timer", duration, function()
    MsgGame:mq_publish2(Const.MSG_ON_SIGNBOARD_SOUND_FINISH)
    self.v_cur_action_cfg = nil
    self.v_is_playing = false
  end)
  self:reset_stand_by_time()
end

function M:send_signboard_action(draw_action)
  local unlock_condition = draw_action.UnlockConditionId or 0
  if 0 ~= unlock_condition and not Condition:check_condition(unlock_condition) then
    return
  end
  self.v_is_playing = true
  self.v_cur_action_cfg = draw_action
  local msg = MsgGame:mq_publish2(Const.MSG_ON_SIGNBOARD_ACTIVE_ACTION)
  msg.mm_obj = draw_action
  local cooldown = draw_action.CoolDown
  local id = draw_action.Id
  self:add_action_cooldown(id, cooldown)
  self.v_first_trigger = false
  self:clear_timer()
  local duration = self:get_act_duraction(draw_action)
  self.v_sound_timer = Timer:add_timer("sign_board_sound_timer", duration, function()
    MsgGame:mq_publish2(Const.MSG_ON_SIGNBOARD_SOUND_FINISH)
    self.v_cur_action_cfg = nil
    self.v_is_playing = false
  end)
  self:reset_stand_by_time()
end

function M:play_action_sound(draw_action)
  if UIMgr:try_get_visible_ui("ui_guide") then
    return
  end
  self:stop_signboard_model_sound()
  self:clear_timer()
  local duration = self:get_act_duraction(draw_action)
  self.v_sound_timer = Timer:add_timer("sign_board_sound_timer", duration, function()
    MsgGame:mq_publish2(Const.MSG_ON_SIGNBOARD_SOUND_FINISH)
    self.v_cur_action_cfg = nil
    self.v_is_playing = false
  end)
end

function M:get_act_duraction(act_cfg)
  local language = CharacterMgr:get_buddy_cv_language(act_cfg.BuddyId)
  return act_cfg[language] or act_cfg.Duration
end

function M:stop_signboard_model_sound()
  local ui_main = UIMgr:try_get_visible_ui("uimain")
  if ui_main then
    ui_main:stop_signboard_model_sound_uimain()
  end
end

function M:get_signboard_model_sound_source()
  local ui_main = UIMgr:try_get_visible_ui("uimain")
  if ui_main then
    return ui_main:get_signboard_model_sound_source_uimain()
  end
end

function M:is_camera_can_update()
  return self.v_update_camera
end

function M:enable_check_stand_by(do_stand_by, param_type)
  self.v_is_check_stand_by = do_stand_by
  if param_type and KEEP_ACT_SIGNBOARD_PARAM[param_type] or do_stand_by then
  else
    SignBoardGirlMgr:try_clear_sound_immediately()
  end
end

function M:try_clear_sound_immediately(flag)
  if flag then
    self:stop_signboard_model_sound()
    self:clear_timer()
    MsgGame:mq_publish2(Const.MSG_ON_SIGNBOARD_SOUND_FINISH)
    self.v_cur_action_cfg = nil
    self.v_is_playing = false
    return
  end
  local source = self:get_signboard_model_sound_source()
  if source then
    source:Stop()
    self:clear_timer()
    MsgGame:mq_publish2(Const.MSG_ON_SIGNBOARD_SOUND_FINISH)
    self.v_cur_action_cfg = nil
    self.v_is_playing = false
  end
end

function M:try_clear_sound_gradually()
  local source = self:get_signboard_model_sound_source()
  if source then
    Global.sound_mgr:insert_fade_data(source, 1, source.volume, 0, function()
      self:clear_timer()
      MsgGame:mq_publish2(Const.MSG_ON_SIGNBOARD_SOUND_FINISH)
      self.v_cur_action_cfg = nil
      self.v_is_playing = false
    end)
  end
end

function M:set_camera_update()
  self.v_update_camera = not self.v_update_camera
end

function M:set_signboard_buddy_id(id)
  local board_id = PlayerMgr:get_signboard_girl_id()
  if id == board_id then
    return
  end
  self:on_set_signboard_girl_id(id)
  PlayerMgr:set_signboard_girl_id(id)
  self:refresh_stand_action()
  self:refresh_cur_view_stand_by_act()
  local msg = MsgGame:mq_publish2(Const.MSG_ON_BROWSE_SIGNBOARD_GIRL)
  msg.mm_x = id
  self:change_signboard_girl()
end

function M:set_update(is_on)
  self.v_is_update = is_on
end

function M:is_can_update()
  return self.v_is_update
end

function M:set_clock_update(is_on)
  self.v_is_clock_update = is_on
end

function M:is_clock_can_update()
  return self.v_is_clock_update
end

function M:clear_timer()
  if self.v_sound_timer then
    Timer:remove_timer(self.v_sound_timer)
    self.v_sound_timer = nil
  end
end

function M:on_destroy()
  self:clear_timer()
end

function M:set_npc_loading(val)
  self.v_npc_loading = val
end

function M:get_npc_loading()
  return self.v_npc_loading
end

function M:is_playing()
  return self.v_is_playing
end

function M:get_cur_playing_action_cfg()
  return self.v_cur_action_cfg
end

function M:get_cur_cv_sound_id()
  return self.v_cur_cv_sound_id
end

function M:set_cloth_buddy_cache(id)
  self.v_cloth_buddy_cache = id
end

function M:get_cloth_buddy_cache()
  return self.v_cloth_buddy_cache
end

function M:send_change_model_view_param(param_id, is_fast, ignore_same_act, just_return_param)
  if false ~= ignore_same_act then
    ignore_same_act = true
  end
  self.v_signboard_model_view_param_id = param_id
  if just_return_param then
    local msg = {}
    msg.mm_x = param_id
    msg.mm_y = is_fast
    msg.mm_obj = ignore_same_act
    return msg
  end
  local msg = MsgGame:mq_publish2(Const.MSG_CHANGE_MODEL_VIEW_PARAM)
  msg.mm_x = param_id
  msg.mm_y = is_fast
  msg.mm_obj = ignore_same_act
end

return M
