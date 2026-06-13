local _tinsert = table.insert
local M = {}

function M.Cast(skill, params)
  local missile_id = params[3]
  skill:play_cast(missile_id)
end

function M.Effect(skill, param)
  skill:play_effect(param)
end

function M.Magic(skill, param)
  local magic_id = param[3]
  local magic_level = param[4]
  local stop_type = param[5]
  skill:play_magic(magic_id, magic_level, stop_type)
end

function M.ShakeCamera(skill, params)
  local char = skill.v_char
  if char:is_hero() and not skill.v_char:check_in_control() then
    return
  end
  Global.camera:shake(params[3], params[4], params[5], params[6], params[7], params[8])
end

function M.Shift(skill, params)
  local start_speed = params[3]
  local duration = params[4]
  local acc = params[5] or 0
  local deg = params[6] or 0
  local break_config = params[7]
  local turn_type = params[8]
  local notify_type = params[9]
  Util.assert(duration, skill.skill_id)
  skill:play_skill_shift(start_speed, duration, acc, deg, break_config, turn_type, notify_type)
end

function M.FixedTimeShift(skill, params)
  local start_speed = params[3]
  local acc_time = params[4]
  local redu_time = params[5]
  Util.assert(start_speed, skill.skill_id)
  Util.assert(acc_time, skill.skill_id)
  Util.assert(redu_time, skill.skill_id)
  skill:play_skill_fixed_time_shift(start_speed, acc_time, redu_time)
end

function M.SkillTurnDir(skill, params)
  local deg = params[3]
  local time = params[4]
  local turn_type = params[5]
  local acc = params[6]
  local stop_type = params[7]
  skill:start_turn_dir(deg, time, turn_type, acc, stop_type)
end

function M.JoystickMove(skill, params)
  local max_speed = params[3]
  local fade_in_time = params[4] or 0
  local fade_out_time = params[5] or 0
  local duration = params[6] or 0
  skill:skill_move_by_joystick(max_speed, fade_in_time, fade_out_time, duration)
end

function M.Sound(skill, params)
  local sound_id = params[3]
  local owner = skill.v_char
  if owner:is_role() then
    sound_id = ShareRes.get_sound_map_by_fashion_id(sound_id, owner:get_fashion_id())
  end
  local abort_type = params[4]
  local fade_out_time = params[5] or 0
  local binding_time = params[6] or 0
  skill:skill_play_sound(sound_id, abort_type, fade_out_time, binding_time)
end

function M.UltimateSkillMagic(skill, params)
  local skill_link_mgr = SceneMgr:get_skill_link_mgr()
  if not skill_link_mgr then
    return
  end
  local magic_list = params[3]
  local abort_magic_list = params[4]
  local abort_time = params[5]
  local start_abort_time = params[6]
  local left_time_offset = params[7] or 0
  local abort_duration = 0
  local magic_duration = 0
  local owner = skill.v_char
  local magic_id, magic_cfg
  for index = 1, #magic_list do
    magic_id = magic_list[index]
    magic_cfg = ShareRes.get_magic_cfg(magic_id)
    if not magic_cfg then
      Log.Error("获取magic配置失败, magicID:", magic_id, "技能id: ", skill.skill_id, debug.traceback())
    elseif magic_duration <= magic_cfg.logic.Duration then
      magic_duration = magic_cfg.logic.Duration
    end
  end
  for index = 1, #abort_magic_list do
    magic_id = abort_magic_list[index]
    magic_cfg = ShareRes.get_magic_cfg(magic_id)
    if not magic_cfg then
      Log.Error("获取magic配置失败, magicID:", magic_id, "技能id: ", skill.skill_id, debug.traceback())
    elseif abort_duration <= magic_cfg.logic.Duration then
      abort_duration = magic_cfg.logic.Duration
    end
  end
  skill_link_mgr:add_skill_effect(owner, magic_list, abort_magic_list, abort_time, start_abort_time, abort_duration, magic_duration, left_time_offset)
end

function M.BezierMove(skill, params)
  local path = params[3]
  local align_curve = params[4]
  skill:play_bezier_move(path, align_curve)
end

function M.CallBehavior(skill, params)
  local skill_id = params[0]
  local tag1 = params[3]
  local tag2 = params[4]
  BehaviorMgr:call_behavior_fun(skill.v_char, BehaviorMgr.EVENTS.ON_KEYFRAME_ACTION, skill_id, tag1, tag2)
end

return M
