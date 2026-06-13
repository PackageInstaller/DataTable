local Vec3 = require("base.vec3")
local FightHudMgr = require("uimodule.fight.fight_hud_mgr")
local FightDefine = require("cs_share.fight_define")
local LuaBehaviorConst = require("common.lua_behavior_const")
local MISSILE_EVT_TYPE = LuaBehaviorConst.MISSILE_EVT_TYPE
local MAGIC_EVT_TYPE = LuaBehaviorConst.MAGIC_EVT_TYPE
local BUTTON_EVT_TYPE = LuaBehaviorConst.BUTTON_EVT_TYPE
local ATTR_TYPE = FightDefine.ATTR_TYPE
local STATE_NAME = Global.config.STATE_NAME
local CAMPS = Global.config.CAMPS
local RELATIONSHIP = Global.config.RELATIONSHIP
local Deg2Rad = require("base.mathx").Deg2Rad
local mathx = require("base.mathx")
local _normalize2 = mathx.normalize2
local _tremove = table.remove
local UTIL_FUN = require("utils.util_fun")
local CICLE_FUN_TYPE = UTIL_FUN.CICLE_FUN_TYPE
local Layer = require("utils.layer")
local _tinsert = table.insert
local _huge = math.huge
local _sin = math.sin
local _cos = math.cos
local M = {}
local JOYSTICK_POS = Vec3.New(0, 0, 0)
local NO_NPC_JOYSTICK_POS = Vec3.New(0, 0, 0)
local CHANGE_STATE_TYPE = {CUR_SKILL = 1, LIBRARY = 2}
local fight_ui_objs = {}

local function check_npc(npc)
  return npc and not npc:is_destroy()
end

local function get_behavior_scope_table(table_name)
  BehaviorMgr.SCOPE_GLOBAL[table_name] = BehaviorMgr.SCOPE_GLOBAL[table_name] or {}
  return BehaviorMgr.SCOPE_GLOBAL[table_name]
end

function M.check_npc_status(npc, status)
  if not check_npc(npc) then
    return false
  end
  return npc:is_in_state(status)
end

function M.get_npc_status(npc)
  if not check_npc(npc) then
    return
  end
  return npc:get_status()
end

function M.check_npc_die(npc)
  if not check_npc(npc) then
    return true
  end
  return npc:is_die()
end

function M.search_joystick_npc(npc, target_type, distance, angel, keycode)
  if not check_npc(npc) then
    return
  end
  local obj = SceneMgr:search_target(npc, target_type, distance, angel, nil, nil, nil, nil, nil, keycode)
  if not obj then
    return
  end
  return obj
end

function M.is_npc_loaded(npc)
  return npc.transform ~= nil
end

local TARGET_MAGIC_MAP = "TARGET_MAGIC_MAP"
local TARGET_NPC_MAP = "TARGET_NPC_MAP"
local TARGET_KIND_MAP = "TARGET_KIND_MAP"

function M.set_search_npc_limit(kind, npc_id, magic_id)
  if Util.is_more_than_zero(kind) then
    local map = get_behavior_scope_table(TARGET_KIND_MAP)
    map[kind] = true
  end
  if Util.is_more_than_zero(npc_id) then
    local map = get_behavior_scope_table(TARGET_NPC_MAP)
    map[npc_id] = true
  end
  if Util.is_more_than_zero(magic_id) then
    local map = get_behavior_scope_table(TARGET_MAGIC_MAP)
    map[magic_id] = true
  end
end

function M.search_npc(npc, target_type, distance, magic_id, is_tmp_list, search_list, target_npc_id, target_npc_kind)
  if not check_npc(npc) then
    return
  end
  M.set_search_npc_limit(target_npc_kind, target_npc_id, magic_id)
  local result, count = SceneMgr:search_target(npc, target_type, distance, nil, BehaviorMgr.SCOPE_GLOBAL[TARGET_MAGIC_MAP], search_list, BehaviorMgr.SCOPE_GLOBAL[TARGET_NPC_MAP], BehaviorMgr.SCOPE_GLOBAL[TARGET_KIND_MAP], is_tmp_list)
  if BehaviorMgr.SCOPE_GLOBAL[TARGET_MAGIC_MAP] then
    UtilTable.clear_map(BehaviorMgr.SCOPE_GLOBAL[TARGET_MAGIC_MAP])
  end
  if BehaviorMgr.SCOPE_GLOBAL[TARGET_NPC_MAP] then
    UtilTable.clear_map(BehaviorMgr.SCOPE_GLOBAL[TARGET_NPC_MAP])
  end
  if BehaviorMgr.SCOPE_GLOBAL[TARGET_KIND_MAP] then
    UtilTable.clear_map(BehaviorMgr.SCOPE_GLOBAL[TARGET_KIND_MAP])
  end
  return result, count
end

function M.search_npc_magic_count(npc, target_type, distance, magic_id, hero_cast_magic)
  if not check_npc(npc) then
    return
  end
  local target_list = SceneMgr:search_target(npc, target_type, distance, nil, magic_id, true)
  local magic_count = 0
  for i = #target_list, 1, -1 do
    local target = target_list[i]
    local count = target.magic_mgr:get_magic_num(magic_id, hero_cast_magic)
    if count > 0 then
      magic_count = magic_count + count
    else
      _tremove(target_list, i)
    end
  end
  return #target_list, magic_count
end

function M.get_grabed_obj(npc, attach_point)
  if not check_npc(npc) then
    return
  end
  return npc:get_grabed_obj(attach_point)
end

function M.check_npc_distance(npc, target, distance, include_body)
  if not check_npc(npc) then
    return
  end
  if not check_npc(target) then
    return
  end
  local posa = npc:get_pos_vec3()
  local posb = target:get_pos_vec3()
  local dt = mathx.distance2(posa.x, posa.z, posb.x, posb.z)
  if include_body then
    return distance > dt + npc:get_real_radius() + target:get_real_radius()
  else
    return distance > dt
  end
end

function M.check_npc_distance_to_pos(npc, posx, posz, distance, include_body)
  if not check_npc(npc) then
    return
  end
  local posa = npc:get_pos_vec3()
  local dt = mathx.distance2(posa.x, posa.z, posx, posz)
  if include_body then
    return distance > dt + npc:get_real_radius()
  else
    return distance > dt
  end
end

function M.get_npc_distance(npc, type, param1, param2, param3)
  if not check_npc(npc) then
    return _huge
  end
  return SceneMgr:get_npc_distance(npc, type, param1, param2, param3) or _huge
end

function M.get_target_angel(npc, target, is_negative)
  if not check_npc(npc) or not check_npc(target) then
    return 0
  end
  local angel = npc:get_diff_dir(target, is_negative)
  if angel > 180 then
    angel = angel - 360
  end
  return angel
end

function M.get_target_pos_angle(npc, x, z, is_negative)
  if not check_npc(npc) then
    return 0
  end
  local angel = npc:get_diff_pos_dir(x, z, is_negative)
  if angel > 180 then
    angel = angel - 360
  end
  return angel
end

function M.get_npc_pos(npc, attach_name)
  if not check_npc(npc) then
    return
  end
  local x, y, z = npc:get_pos()
  if attach_name then
    local attach_point = npc:get_setting_point(attach_name)
    if attach_point then
      x, y, z = attach_point:GetPositionA()
    end
  end
  local position = Vec3.New(x, y, z)
  return position
end

function M.get_click_input(npc, input_code)
  return InputMgr.has_input(input_code)
end

function M.get_time()
  return GlobalTimeMgr:get_time()
end

function M.get_npc_time(npc)
  if not check_npc(npc) then
    return 0
  end
  return npc.time_mgr:get_time()
end

function M.change_char_special_ui(hero, data)
  local ui_fight = UIMgr:try_get_loaded_ui(UIMgr.FIGHT_UI_NAME)
  if not ui_fight then
    return
  end
  ui_fight:change_char_special_ui(hero, data)
end

function M.get_joystick_target_pos(npc)
  if not check_npc(npc) then
    JOYSTICK_POS.x = 0
    JOYSTICK_POS.z = 0
    NO_NPC_JOYSTICK_POS.x = 0
    NO_NPC_JOYSTICK_POS.z = 0
  elseif 0 == Global.camera_joystick_x and 0 == Global.camera_joystick_y then
    JOYSTICK_POS.x = 0
    JOYSTICK_POS.z = 0
    NO_NPC_JOYSTICK_POS.x = 0
    NO_NPC_JOYSTICK_POS.z = 0
  else
    local npc_pos = npc:get_pos_vec3()
    JOYSTICK_POS.x = Global.camera_joystick_x * 10 + npc_pos.x
    JOYSTICK_POS.z = Global.camera_joystick_y * 10 + npc_pos.z
    NO_NPC_JOYSTICK_POS.x = Global.camera_joystick_x
    NO_NPC_JOYSTICK_POS.z = Global.camera_joystick_y
  end
  return JOYSTICK_POS, NO_NPC_JOYSTICK_POS
end

function M.cast_skill(npc, target, skill_id, targetx, targetz, skill_action_info, start_frame)
  if UNITY_EDITOR then
    local function callback()
      if not check_npc(npc) then
        return
      end
      npc.skill_mgr:cast_skill(skill_id, target, targetx, nil, targetz, skill_action_info, start_frame)
    end
    
    return Global.util_fun:call_event_fun(CICLE_FUN_TYPE.CAST_SKILL, callback)
  else
    if not check_npc(npc) then
      return
    end
    npc.skill_mgr:cast_skill(skill_id, target, targetx, nil, targetz, skill_action_info, start_frame)
  end
end

function M.cast_missile(npc, target, posx, posz, missile_id, missile_level, lookat_posx, lookat_posz, lookat_posy, posy, born_posx, born_posz, born_posy, skill_action_info)
  local temp_posy = posy
  local temp_born_posy = born_posy
  if not temp_posy then
    local _, height = Util.raycast_by_role(npc, posx or 0, posz or 0)
    temp_posy = height
  end
  if not temp_born_posy then
    local _, height = Util.raycast_by_role(npc, born_posx or 0, born_posz or 0)
    temp_born_posy = height
  end
  local lookat_pos
  if lookat_posx and lookat_posz then
    lookat_posy = lookat_posy or 0
    lookat_pos = Vec3.New(lookat_posx, lookat_posy, lookat_posz)
  end
  local born_pos
  local target_pos = Vec3.New(posx, temp_posy, posz)
  if born_posx and temp_born_posy and born_posz then
    born_pos = Vec3.New(born_posx, temp_born_posy, born_posz)
  else
    born_pos = target_pos
  end
  if UNITY_EDITOR then
    local function callback()
      if not check_npc(npc) then
        return
      end
      return npc.skill_mgr:add_missile_task(missile_id, target, target_pos, missile_level, lookat_pos, born_pos, nil, skill_action_info, true, true)
    end
    
    return Global.util_fun:call_event_fun(CICLE_FUN_TYPE.CAST_MISSILE, callback)
  else
    if not check_npc(npc) then
      return
    end
    return npc.skill_mgr:add_missile_task(missile_id, target, target_pos, missile_level, lookat_pos, born_pos, nil, skill_action_info, true, true)
  end
end

function M.cast_missile2(param)
  local npc, target, posx, posz, missile_id, missile_level, lookat_posx, lookat_posz, lookat_posy, posy, born_posx, born_posz, born_posy, skill_action_info = param.npc, param.target, param.posx, param.posz, param.missile_id, param.missile_level, param.lookat_posx, param.lookat_posz, param.lookat_posy, param.posy, param.born_posx, param.born_posz, param.born_posy, param.skill_action_info
  return M.cast_missile(npc, target, posx, posz, missile_id, missile_level, lookat_posx, lookat_posz, lookat_posy, posy, born_posx, born_posz, born_posy, skill_action_info)
end

function M.cast_missile3(npc, target, posx, posz, missile_id, missile_level, lookat_posx, lookat_posz, lookat_posy, posy, born_posx, born_posz, born_posy, skill_action_info)
  local temp_posy = posy
  local temp_born_posy = born_posy
  if not temp_posy then
    local _, height = Util.raycast_by_role(npc, posx or 0, posz or 0)
    temp_posy = height
  end
  if not temp_born_posy then
    local _, height = Util.raycast_by_role(npc, born_posx or 0, born_posz or 0)
    temp_born_posy = height
  end
  local lookat_pos
  if lookat_posx and lookat_posz then
    lookat_posy = lookat_posy or 0
    lookat_pos = Vec3.New(lookat_posx, lookat_posy, lookat_posz)
  end
  local born_pos
  local target_pos = Vec3.New(posx, temp_posy, posz)
  if born_posx and temp_born_posy and born_posz then
    born_pos = Vec3.New(born_posx, temp_born_posy, born_posz)
  else
    born_pos = target_pos
  end
  if UNITY_EDITOR then
    local function callback()
      if not check_npc(npc) then
        return
      end
      return npc.skill_mgr:add_missile_task(missile_id, target, target_pos, missile_level, lookat_pos, born_pos, true, skill_action_info, true)
    end
    
    return Global.util_fun:call_event_fun(CICLE_FUN_TYPE.CAST_MISSILE, callback)
  else
    if not check_npc(npc) then
      return
    end
    return npc.skill_mgr:add_missile_task(missile_id, target, target_pos, missile_level, lookat_pos, born_pos, true, skill_action_info, true)
  end
end

function M.cast_missile_new(npc, target, posx, posz, missile_id, missile_level, lookat_posx, lookat_posz, lookat_posy, posy, born_posx, born_posz, born_posy, skill_action_info)
  local temp_posy = posy
  local temp_born_posy = born_posy
  if not temp_posy then
    local _, height = Util.raycast_by_role(npc, posx or 0, posz or 0)
    temp_posy = height
  end
  if not temp_born_posy then
    local _, height = Util.raycast_by_role(npc, born_posx or 0, born_posz or 0)
    temp_born_posy = height
  end
  local lookat_pos
  if lookat_posx and lookat_posz then
    lookat_posy = lookat_posy or 0
    lookat_pos = Vec3.New(lookat_posx, lookat_posy, lookat_posz)
  end
  local born_pos
  local target_pos = Vec3.New(posx, temp_posy, posz)
  if born_posx and temp_born_posy and born_posz then
    born_pos = Vec3.New(born_posx, temp_born_posy, born_posz)
  else
    born_pos = target_pos
  end
  if UNITY_EDITOR then
    local function callback()
      if not check_npc(npc) then
        return
      end
      return npc.skill_mgr:add_missile_task(missile_id, target, target_pos, missile_level, lookat_pos, born_pos, nil, skill_action_info, true)
    end
    
    return Global.util_fun:call_event_fun(CICLE_FUN_TYPE.CAST_MISSILE, callback)
  else
    if not check_npc(npc) then
      return
    end
    return npc.skill_mgr:add_missile_task(missile_id, target, target_pos, missile_level, lookat_pos, born_pos, nil, skill_action_info, true)
  end
end

function M.cast_missile2_new(param)
  local npc, target, posx, posz, missile_id, missile_level, lookat_posx, lookat_posz, lookat_posy, posy, born_posx, born_posz, born_posy, skill_action_info = param.npc, param.target, param.posx, param.posz, param.missile_id, param.missile_level, param.lookat_posx, param.lookat_posz, param.lookat_posy, param.posy, param.born_posx, param.born_posz, param.born_posy, param.skill_action_info
  return M.cast_missile_new(npc, target, posx, posz, missile_id, missile_level, lookat_posx, lookat_posz, lookat_posy, posy, born_posx, born_posz, born_posy, skill_action_info)
end

function M.change_missile_move_params(missile, ...)
  local movement = missile and missile:get_movement()
  if not movement then
    return
  end
  if movement.change_move_params then
    movement:change_move_params(...)
  else
    Log.Error("当前子弹不能运行时修改移动参数 子弹ID:", missile.missile_id, "line_type", movement.__DEBUG_LINE_TYPE, debug.traceback())
  end
end

function M.cast_magic(npc, target, magic_id, level, add_count)
  if not check_npc(npc) or not check_npc(target) then
    return
  end
  if add_count then
    if add_count <= 0 then
      return
    end
    add_count = math.floor(add_count)
  end
  if UNITY_EDITOR then
    local function callback()
      return target.magic_mgr:add_magic(npc, magic_id, nil, nil, level, nil, nil, add_count)
    end
    
    return Global.util_fun:call_event_fun(CICLE_FUN_TYPE.CAST_MAGIC, callback)
  else
    return target.magic_mgr:add_magic(npc, magic_id, nil, nil, level, nil, nil, add_count)
  end
end

function M.debug_all_magic()
  Global.hero.magic_mgr:trace_all_magic()
end

function M.debug_magic(id)
  Global.hero.magic_mgr:trace_magic_id(id)
end

function M.cast_skill_to_position(npc, skill_id, targetx, targetz)
  if not check_npc(npc) then
    return
  end
  npc.skill_mgr:cast_skill(skill_id, nil, targetx, nil, targetz)
end

function M.lookat_npc(npc, target, force)
  if not check_npc(npc) or not check_npc(target) then
    return
  end
  npc:face_to_obj(target, force)
end

function M.lookat_position(npc, posx, posz, force)
  if not check_npc(npc) then
    return
  end
  npc:face_to_pos(posx, posz, force)
end

function M.moveto_npc(npc, target)
  if not check_npc(npc) then
    return
  end
  if not check_npc(target) then
    return
  end
  npc.role_move_ctrl:move_to_target(target)
end

function M.create_part_npc(res_id, owner, attach_name, part_id, camp)
  return SceneMgr:create_part_npc(res_id, owner, attach_name, part_id, camp)
end

function M.get_missile_pos(missile)
  if not missile then
    Log.Error("get_missile_pos 传入子弹为空")
    return
  end
  if not check_npc(missile) then
    Log.Error("get_missile_pos 传入子弹已销毁")
  end
  return missile:get_pos_vec3()
end

function M.became_part(npc, owner, attach_name, part_id)
  if not check_npc(npc) then
    return
  end
  npc:became_part(owner, attach_name, part_id)
end

function M.became_follower(npc, leader)
  if not check_npc(npc) then
    return
  end
  npc:became_follower(leader)
end

function M.move_to_pos(npc, pos)
  if not check_npc(npc) then
    return
  end
  npc.role_move_ctrl:move_to_postion(pos)
end

function M.move_by_dir(npc)
  if not check_npc(npc) then
    return
  end
  local vec_dir = npc:get_dir_vec()
  npc.state_manager:move_by_dir(vec_dir.x, vec_dir.z)
end

function M.check_activate(npc)
  return SceneMgr:npc_in_scene(npc)
end

function M.stop_move(npc)
  if not check_npc(npc) then
    return
  end
  npc.state_manager:stop_move()
end

function M.switch_move_type(npc, move_type)
  if not check_npc(npc) then
    return
  end
  if npc:get_move_type() ~= move_type then
    npc:update_move_type(move_type)
    npc.state_manager:update_move_type()
  end
end

function M.set_sceneobj_visible(path, is_visible)
  SceneMgr:show_gameobject(path, is_visible)
end

function M.set_sceneobj_visible_save_state(path, is_visible, is_timeline_to_last_frame)
  SceneMgr:show_gameobject(path, is_visible)
  SceneMgr:c2gs_call_scene("save_sceneobj_visible", path, is_visible, is_timeline_to_last_frame)
end

function M.set_scene_effect(effect_path, is_visible, is_save_visible)
  if not is_visible then
    SceneMgr:hide_scene_effect_status_obj(effect_path)
  else
    SceneMgr:show_gameobject(effect_path, true)
  end
  if is_save_visible then
    SceneMgr:c2gs_call_scene("save_sceneobj_visible", effect_path, is_visible, false)
  end
end

function M.idle_switch(npc, idle_state)
  if not check_npc(npc) then
    return
  end
  npc.state_manager:switch_idle_state(idle_state)
end

function M.is_cast_skill_time(npc, skill_id, is_exit_time)
  if not check_npc(npc) then
    return
  end
  local state_mgr = npc.state_manager
  local attack_state = state_mgr:get_cur_state(STATE_NAME.attack)
  if not attack_state then
    return false
  end
  local cur_skill_id = npc.skill_mgr:get_cur_skill_id()
  if skill_id and (not cur_skill_id or skill_id ~= cur_skill_id) then
    return false
  end
  return attack_state:is_cast_time(is_exit_time) or not state_mgr:is_skill_end_to_idle()
end

function M.get_skill_cfg(skill_id)
  return ShareRes.create("skill.skill", skill_id)
end

function M.abort_skill(npc, break_abort)
  if not check_npc(npc) then
    return
  end
  local abort_type = Config.SKILL_ABORT_TYPE.BEHAVIOR_ABORT
  if break_abort then
    abort_type = abort_type | Config.SKILL_ABORT_TYPE.BREAK_ABORT
  end
  npc.skill_mgr:abort(abort_type)
end

function M.get_armor_def_level(npc)
  if not check_npc(npc) then
    return
  end
  return npc.skill_mgr:get_armor_def_lv()
end

function M.get_armor_atk_level(npc)
  if not check_npc(npc) then
    return
  end
  return npc.skill_mgr:get_armor_atk_lv()
end

function M.get_hitfly_speed(npc)
  if not check_npc(npc) then
    return
  end
  local role_move_ctrl = npc.role_move_ctrl
  return role_move_ctrl:get_behitfly_hspeed(), role_move_ctrl:get_behitfly_vspeed()
end

function M.get_npc_height(npc)
  if not check_npc(npc) then
    return
  end
  return npc:get_pos_height()
end

function M.get_npc_id(npc)
  if not check_npc(npc) then
    return
  end
  return npc:get_npc_id()
end

function M.play_effect_anim(npc, effect_name, anim_state_name)
  if not check_npc(npc) then
    return
  end
  npc.act_effect_ctrl:effect_play_anim(effect_name, anim_state_name)
end

function M.missile_play_effect_anim(missile, anim_state_name)
  if not check_npc(missile) or not missile:is_missile() then
    return
  end
  missile:effect_play_anim(anim_state_name)
end

function M.set_missile_effect_end_anim_idx(missile, idx)
  if not check_npc(missile) or not missile:is_missile() then
    return
  end
  missile:set_effect_end_anim_idx(idx)
end

function M.set_effect_end_anim_idx(npc, effect_name, idx)
  if not check_npc(npc) then
    return
  end
  npc.act_effect_ctrl:set_effect_end_anim_idx(effect_name, idx)
end

function M.set_npc_turnpos(npc, pos)
  if not check_npc(npc) then
    return
  end
  npc:set_turnpos(pos)
end

function M.remove_npc(npc)
  if not check_npc(npc) then
    return
  end
  SceneMgr:remove_npc2(npc)
end

function M.get_npc_shield(npc)
  if not check_npc(npc) then
    return
  end
  return npc:get_shield_num()
end

function M.get_hero_job_id(hero)
  if not hero:is_hero() then
    return
  end
  return hero.buddy_cfg.Job
end

local function get_camp(self_camp, relationship)
  local npc_camp
  if self_camp == CAMPS.FRIEND and relationship == RELATIONSHIP.SIMILAR or self_camp == CAMPS.ENEMY and relationship == RELATIONSHIP.OPPOSED then
    npc_camp = CAMPS.FRIEND
  elseif self_camp == CAMPS.FRIEND and relationship == RELATIONSHIP.OPPOSED or self_camp == CAMPS.ENEMY and relationship == RELATIONSHIP.SIMILAR then
    npc_camp = CAMPS.ENEMY
  end
  return npc_camp
end

function M.get_npc_group_id(npc)
  if not check_npc(npc) then
    return
  end
  return npc:get_group_id()
end

function M.add_npc(self_camp, res_id, vec3_pos, vec3_target, relationship, level, npc_group)
  local npc_camp = get_camp(self_camp, relationship)
  local ext_args = {npc_group = npc_group}
  return SceneMgr:create_npc(res_id, vec3_pos.x, vec3_pos.y, vec3_pos.z, vec3_target.x, vec3_target.z, npc_camp, level, ext_args)
end

function M.add_npc2(self_camp, res_id, posx, posz, tarx, tarz, relationship, level, npc_group)
  local npc_camp = get_camp(self_camp, relationship)
  local ext_args = {npc_group = npc_group}
  return SceneMgr:create_npc(res_id, posx, nil, posz, tarx, tarz, npc_camp, level, ext_args)
end

function M.add_npc_by_pos_key(self_camp, res_id, pos_key, offset_x, offset_z, tgt_pos_key, tgt_offset_x, tgt_offset_z, camp, level, npc_group)
  local scene_map = SceneMgr:get_scene_map()
  if not scene_map then
    return
  end
  local position = scene_map:get_area_position(pos_key)
  local vec3_pos = Vec3.New(position.X + offset_x, position.Y, position.Z + offset_z)
  local tgt_position = scene_map:get_area_position(tgt_pos_key)
  local vec3_target = Vec3.New(tgt_position.X + tgt_offset_x, tgt_position.Y, tgt_position.Z + tgt_offset_z)
  return M.add_npc(self_camp, res_id, vec3_pos, vec3_target, camp, level, npc_group)
end

function M.get_position_offset_position(base_pos, face_to_pos, deg, length)
  local rad = deg * Deg2Rad * -1
  local face_dir_x = face_to_pos.x - base_pos.x
  local face_dir_z = face_to_pos.z - base_pos.z
  face_dir_x, face_dir_z = _normalize2(face_dir_x, face_dir_z)
  local x, z
  local sin_rad, cos_rad = math.sin(rad), math.cos(rad)
  x = face_dir_x * cos_rad - face_dir_z * sin_rad
  z = face_dir_x * sin_rad + face_dir_z * cos_rad
  x = x * length
  z = z * length
  return Vec3.New(base_pos.x + x, base_pos.y, base_pos.z + z)
end

function M.get_npc_offset_position(npc, face_to_pos, deg, length)
  if not check_npc(npc) then
    return
  end
  local npc_pos = M.get_npc_pos(npc)
  if face_to_pos then
    return M.get_position_offset_position(npc_pos, face_to_pos, deg, length)
  else
    local dir_vec = npc:get_dir_vec()
    local rad = deg * Deg2Rad * -1
    local face_dir_x, face_dir_z = dir_vec.x, dir_vec.z
    face_dir_x, face_dir_z = _normalize2(face_dir_x, face_dir_z)
    local sin_rad, cos_rad = math.sin(rad), math.cos(rad)
    local x = face_dir_x * cos_rad - face_dir_z * sin_rad
    local z = face_dir_x * sin_rad + face_dir_z * cos_rad
    x = x * length
    z = z * length
    return Vec3.New(npc_pos.x + x, npc_pos.y, npc_pos.z + z)
  end
end

function M.get_postion_raycast_obstruct_distance(base_pos, deg)
  local rad = deg * Deg2Rad
  local x = _sin(rad)
  local z = _cos(rad)
  local mask = ~Layer.LayerMask.Character
  local hit = CSHelper.RayCast2(x, 0, z, base_pos.x, base_pos.y, base_pos.z, 25, mask)
  if hit.collider then
    return hit.distance
  end
  return 99
end

function M.get_npc_raycast_obstruct_distance(npc, deg)
  if not check_npc(npc) then
    return 0
  end
  local roation_y = npc:get_dir()
  local npc_pos = M.get_npc_pos(npc)
  deg = deg + roation_y
  return M.get_postion_raycast_obstruct_distance(npc_pos, deg)
end

function M.check_magic(npc, magic_id)
  if not check_npc(npc) then
    return false
  end
  return npc.magic_mgr:check_magic(magic_id)
end

function M.get_weapon_advance_lv(npc)
  if not check_npc(npc) then
    return false
  end
  return npc:get_weapon_advance_lv() or 0
end

function M.get_magic_num(npc, magic_id, hero_cast_magic)
  if not check_npc(npc) then
    return 0
  end
  return npc.magic_mgr:get_magic_num(magic_id, hero_cast_magic)
end

function M.set_skill_end_to_idle(npc, param)
  if not check_npc(npc) then
    return
  end
  npc.state_manager:set_skill_end_to_idle(param)
end

function M.set_action_keep_end(npc)
  if not check_npc(npc) then
    return
  end
  npc.act_ctrl:set_keep_end(0, true)
end

function M.replace_hero_skill(index, skill_id)
  local uifight = UIMgr:try_get_loaded_ui(UIMgr.FIGHT_UI_NAME)
  if not uifight then
    return
  end
  uifight:replace_hero_skill(index, skill_id)
end

function M.get_god_npc()
  local god = SceneMgr:get_god_npc()
  return god
end

function M.set_strength_visible(is_show)
  if not Global.camera then
    return
  end
  Global.camera:set_strength_ui_visible(is_show)
end

function M.set_aimed_move_state(is_move)
  Global.is_aimed_move = is_move
end

function M.replace_tower_skill(skill_index)
  local god = SceneMgr:get_god_npc()
  assert(god, "replace god skill error")
  god:replace_skill_index(skill_index)
  MsgGame:mq_publish2(Const.MSG_CHANGE_SCENE_SKILL)
end

function M.set_skill_ex_enengy(skill_id, ex_energy)
end

function M.set_cam_default_angles(x, y, ease_in_speed, prop)
  Global.camera:set_angle(x, y, ease_in_speed, prop)
end

function M.set_cam_default_dist(dist)
  Global.camera:set_distance(dist)
end

function M.get_enemy_npc_count()
  return SceneMgr:get_enemy_npc_count()
end

function M.get_npc_count_by_res_id(res_id)
  return SceneMgr:get_npc_count_by_res_id(res_id)
end

function M.set_can_searched(npc, is_can_searched)
  if not check_npc(npc) then
    return
  end
  npc:set_can_searched(is_can_searched)
end

function M.get_can_searched(npc)
  if not check_npc(npc) then
    return
  end
  return npc:is_can_searched()
end

function M.get_magic_kind_num(npc, type)
  if not check_npc(npc) then
    return
  end
  return npc.magic_mgr:get_magic_kind_num(type)
end

function M.get_npc_cd_charge(npc, skill_id)
  if not check_npc(npc) then
    return 0
  end
  local skill = npc.skill_mgr:get_skill(skill_id)
  return skill and skill:get_skill_energy()
end

function M.get_npc_exskill_energy(npc)
  return 0
end

function M.get_fight_skill_id_by_index(npc, index)
  return 0
end

function M.get_npc_attr(npc, attr_type)
  if not npc.attr_mgr then
    return 0
  end
  return npc.attr_mgr:get_attr(attr_type)
end

function M.play_ui_fight_button_effect(params)
  local msg = MsgGame:mq_publish2(Const.MSG_UI_FIGHT_BUTTON_EFFECT)
  msg.mm_x = params[1]
  msg.mm_y = params[2]
  msg.mm_obj = params
end

function M.stop_ui_fight_button_effect(params)
  local msg = MsgGame:mq_publish2(Const.MSG_UI_FIGHT_STOP_EFFECT)
  msg.mm_x = params[1]
  msg.mm_y = params[2]
end

function M.abort_magic_by_id(npc, magic_id, num)
  if not check_npc(npc) then
    return
  end
  npc.magic_mgr:remove_magic_by_id(magic_id, num)
end

function M.mark_transparent(npc)
  if not check_npc(npc) then
    return
  end
  npc:mark_transparent()
end

function M.enable_rim(npc, enable)
  if not check_npc(npc) then
    return
  end
  npc:enable_rim(enable)
end

function M.set_ui_object_visible(ui_name, object_name, is_visible, cur_frame_execute)
  if cur_frame_execute then
    local fight = UIMgr:try_get_ui(UIMgr.FIGHT_UI_NAME)
    if fight then
      local msg = {
        mm_x = ui_name,
        mm_y = object_name,
        mm_obj = is_visible
      }
      fight:on_set_uiobject_visible(msg)
    end
  else
    local msg = MsgGame:mq_publish2(Const.MSG_SET_UIOBJECT_VISIBLE)
    msg.mm_x = ui_name
    msg.mm_y = object_name
    msg.mm_obj = is_visible
  end
end

function M.set_team_head_object_visible(head_index, object_name, is_visible)
  local fight = UIMgr:try_get_loaded_ui(UIMgr.FIGHT_UI_NAME)
  if fight then
    fight:set_team_head_object_visible(head_index, object_name, is_visible)
  end
end

function M.set_scene_object_visible(ui_name, object_name, is_visible)
  local msg = MsgGame:mq_publish2(Const.MSG_SCENE_SET_UI_VISIBLE)
  msg.mm_x = ui_name
  msg.mm_y = object_name
  msg.mm_obj = is_visible
end

function M.get_scene_map_pos_postion(pos_key)
  local scene_logic = SceneMgr:get_scene_logic()
  local x, y, z = scene_logic:get_pos_key_position(pos_key)
  return x, z, y
end

function M.set_npc_level(npc, level, is_update_attr)
  if not check_npc(npc) then
    return
  end
  if M._set_npc_level(npc, level, is_update_attr) then
    SceneMgr:c2gs_call_scene("set_npc_level", npc.uuid, level, is_update_attr)
  end
end

function M._set_npc_level(npc, level, is_update_attr)
  if not check_npc(npc) then
    return
  end
  if npc:get_level() ~= level then
    npc:set_level(level)
    if is_update_attr then
      npc.attr_mgr:init_attr()
      local msg = MsgGame:mq_publish2(Const.MSG_HERO_ATTR_CHANGE)
      msg.mm_x = ATTR_TYPE.CHAR_SP
      msg.mm_y = 0
    end
    return true
  end
end

function M.get_tower_floor_info()
  if not TowerMgr then
    return 1, 1
  end
  local tower = TowerMgr:get_tower()
  if not tower then
    return 1, 1
  end
  local room_num = tower:get_room_num()
  local floor_num = tower:get_floor_num()
  return room_num, floor_num
end

function M.create_scene_effect(prefab_name, position, duration, obj_name, face_pos, not_time_scale)
  SceneMgr:create_scene_effect(prefab_name, position, duration, obj_name, nil, nil, nil, face_pos, not_time_scale)
end

function M.remove_scene_effect(obj_name)
  SceneMgr:remove_scene_effect(obj_name)
end

function M.enter_main_scene()
  Global.scene_mgr:on_enter_main_scene()
end

function M.set_npc_dead(npc, dead_action, action_remove, dead_cb)
  if not check_npc(npc) then
    return
  end
  if dead_cb and type(dead_cb) ~= "function" then
    Log.Error("set_npc_dead的第四个参数必须为空或function", debug.traceback())
    return
  end
  npc:set_dead(dead_action, action_remove, dead_cb)
end

function M.on_not_monster_npc_dead(npc)
  if not npc or npc:is_die() then
    return
  end
  ChallengeRingPlusMgr:record_kill_not_monster_count(npc.character_cfg.Kind, npc:get_uuid(), npc:get_npc_id())
end

function M.set_scene_tips(id, is_visible, param)
  local msg = MsgGame:mq_publish2(Const.MSG_UI_FIGHT_SCENE_TIPS)
  msg.mm_x = id
  msg.mm_y = is_visible
  msg.mm_obj = param
end

function M.set_npc_target(npc, target)
  if not check_npc(npc) then
    return
  end
  if npc:is_hero() and target and not target:is_npc() then
    Log.Error("角色:", npc.id, "   set_npc_target所传target不为怪物, target ID:", target.id, " UUID:", target.uuid)
  end
  npc:set_target(target)
end

function M.get_target_hero()
  local npc_list = {}
  local list = Global.hero:get_betargetd_map()
  for uuid, _ in pairs(list) do
    local npc = SceneMgr:get_npc_by_id(uuid)
    if npc then
      _tinsert(npc_list, npc)
    end
  end
  return npc_list
end

function M.enable_shadow(npc, param)
  if not check_npc(npc) or not npc.enable_shadow then
    return
  end
  npc:enable_shadow(param)
end

function M.rgb_split(delay, time, power, inteval, powr, powg, powb)
  local effect_mgr = Global.scene_mgr:get_scene_effect_mgr()
  if not effect_mgr then
    return
  end
  effect_mgr:show_rgb_split(delay, time, power, inteval, powr, powg, powb)
end

local AIM_KEY_CODE = Config.INPUT_CODE.AIM_JOYSTICK

function M.set_left_joystick_inverse(is_inverse)
  Global.joystick_inverse = is_inverse
end

function M.set_indicator_inverse(is_inverse)
  local ui_fight = UIMgr:try_get_loaded_ui(UIMgr.FIGHT_UI_NAME)
  if not ui_fight then
    return
  end
  ui_fight:set_indicator_inverse(is_inverse)
end

function M.update_skill_indicator(key_code, area_cfg, indi_cfg, sensitivity)
  local ui_fight = UIMgr:try_get_loaded_ui(UIMgr.FIGHT_UI_NAME)
  if not ui_fight then
    return
  end
  ui_fight:update_skill_indicator(key_code, area_cfg, indi_cfg, sensitivity)
end

function M.set_indicator_active(keycode, param, lock_tar, extra_pos_x, extra_pos_z, force_red, reset_to_last_drag)
  local ui_fight = UIMgr:try_get_loaded_ui(UIMgr.FIGHT_UI_NAME)
  if not ui_fight then
    return
  end
  ui_fight:set_indicator_active(keycode, param, lock_tar, extra_pos_x, extra_pos_z, force_red, reset_to_last_drag)
end

function M.set_is_force_red(key_code, is_force_red)
  local ui_fight = UIMgr:try_get_loaded_ui(UIMgr.FIGHT_UI_NAME)
  if not ui_fight then
    return
  end
  ui_fight:set_is_force_red(key_code, is_force_red)
end

function M.set_indicator_pos(key_code, x, y)
  assert(x)
  assert(y)
  local ui_fight = UIMgr:try_get_loaded_ui(UIMgr.FIGHT_UI_NAME)
  if not ui_fight then
    return
  end
  ui_fight:set_indicator_pos(key_code, x, y)
end

function M.get_indicator_pos(key_code)
  local ui_fight = UIMgr:try_get_loaded_ui(UIMgr.FIGHT_UI_NAME)
  if not ui_fight then
    return
  end
  return ui_fight:get_indicator_pos(key_code)
end

function M.left_joystick_skill_mode(area_cfg, indicator_cfg, sensitivity, lock_cfg)
  local ui_fight = UIMgr:try_get_loaded_ui(UIMgr.FIGHT_UI_NAME)
  if not ui_fight then
    return
  end
  ui_fight:update_aim_mode_cfg(area_cfg, indicator_cfg, sensitivity, lock_cfg)
end

function M.set_left_joystick_skill_mode_active(param, lock_tar)
end

function M.set_aim_pos(x, y)
  local ui_fight = UIMgr:try_get_loaded_ui(UIMgr.FIGHT_UI_NAME)
  if not ui_fight then
    return
  end
  ui_fight:set_indicator_pos(AIM_KEY_CODE, x, y)
end

function M.get_aim_pos()
  local ui_fight = UIMgr:try_get_loaded_ui(UIMgr.FIGHT_UI_NAME)
  if not ui_fight then
    return
  end
  return ui_fight:get_indicator_pos(AIM_KEY_CODE)
end

function M.clear_aim()
  require("uimodule.fight.skill_indicator").clear_tar(AIM_KEY_CODE)
end

function M.get_aim_tar()
  return require("uimodule.fight.skill_indicator").get_tar(AIM_KEY_CODE)
end

function M.get_indicator_lock_tar(keycode)
  return require("uimodule.fight.skill_indicator").get_tar(keycode)
end

function M.get_scene_hero_by_poskey(key)
  local ui_fight = UIMgr:try_get_loaded_ui(UIMgr.FIGHT_UI_NAME)
  if not ui_fight then
    return
  end
  return ui_fight:get_hero_by_poskey(key)
end

function M.get_force_target()
end

function M.clear_force_target()
end

function M.set_hero_can_showup(npc, param)
  if not check_npc(npc) then
    return
  end
  npc.can_show_up = param
end

function M.is_hero_in_ground(npc)
  if not check_npc(npc) then
    return
  end
  return npc.in_control or npc.in_ground
end

function M.hero_born_finish(skill_id)
  if not SceneMgr:global_hero_is_destroyed() then
    Global.hero.skill_mgr:set_born_skill_id(skill_id)
  end
  local skill_cfg = M.get_skill_cfg(skill_id)
  local cast_time = skill_cfg.CastTime or 0
  local offset_time = 0.5
  cast_time = cast_time + offset_time
  MsgGame:mq_publish2(Const.MSG_ON_HERO_BORN_ANIM_START)
  Timer:add_timer("born_anim_finish", cast_time, function()
    if not Util.is_client_only() then
      MsgGame:mq_publish2(Const.MSG_ON_HERO_BORN_ANIM_END)
      BehaviorMgr:call_event_fun(BehaviorMgr.EVENTS.ON_HERO_BORN_ANIM_END)
      SceneMgr:c2gs_call_scene("on_hero_born_anim_finish")
      BehaviorMgr:call_scene_logic_event_fun("on_hero_born_anim_finish")
    end
  end)
end

function M.show_hero_by_keycode(key_code, ignore_cd)
  local fight = UIMgr:try_get_loaded_ui(UIMgr.FIGHT_UI_NAME)
  if fight then
    fight:force_switch_hero(key_code, ignore_cd)
  end
end

function M.change_missile_config(missile_id, attr_name, new_value, change_mode)
  MissileConfigHookMgr:hook(missile_id, attr_name, new_value, change_mode)
end

function M.rebound_missile(missile, rebound_caster, tar, tarx, tarz, speed, not_change_owner, not_change_movement, need_change_tar)
  missile:be_rebound(rebound_caster, tar, tarx, tarz, speed, not_change_owner, not_change_movement, need_change_tar)
end

function M.enable_part_damage(npc, part_id, enable)
  if not check_npc(npc) then
    return true
  end
  npc:enable_part_damage(part_id, enable)
end

function M.stop_missile(missile)
  if missile and not missile:is_die() then
    missile:stop()
  end
end

function clear_input(keycode, force)
  local msg = MsgGame:mq_publish2(Const.MSG_CLEAR_INPUT_KEY)
  msg.mm_x = keycode
  msg.mm_y = force
end

function on_up_skill_btn(keycode, cancle)
  local msg = MsgGame:mq_publish2(Const.MSG_ON_UP_SKILL)
  msg.mm_x = keycode
  msg.mm_y = cancle
end

function M.time_scale_immune(target, is_immune)
  if target:is_destroy() then
    return
  end
  target:set_close_time_scale(is_immune)
end

function M.change_fight_btn(show_interact)
  local ui_fight = UIMgr:try_get_loaded_ui(UIMgr.FIGHT_UI_NAME)
  if not ui_fight then
    return
  end
  ui_fight:change_button(show_interact)
end

function M.set_lock_velocity(npc, turn_speed)
  if npc:is_destroy() then
    return
  end
  npc:set_turn_speed(turn_speed)
end

function M.set_scene_camera(camera_id)
  Global.camera:set_scene_camera(camera_id)
end

function M.set_camera(camera_id, is_new_config, is_force_switch_cameramode, on_pre_set_camera_cfg)
  Global.camera:set_camera_id(camera_id, is_new_config, false, is_force_switch_cameramode, on_pre_set_camera_cfg)
end

function M.get_cur_camera_id()
  return Global.camera:get_camera_id()
end

function M.back_to_scene_camera(is_reduction)
  Global.camera:back_to_scene_camera(is_reduction)
end

function M.focus_npc(npc, attach_name)
  Global.camera:set_camera_focal(npc, attach_name)
end

function M.change_follow_target(follow_target_type, npc, param)
  Global.camera:change_follow_target(follow_target_type, npc, param)
end

function M.change_follow_target_new(follow_target_type, npc, param)
  Global.camera:change_follow_target_new(follow_target_type, npc, param)
end

function M.set_camera_focal(npc)
  Global.camera:set_camera_focal(npc, "Bip001 Chest", true)
end

function M.set_camera_focal_by_pos(x, y, z)
  Global.camera:set_camera_focal_by_pos(x, y, z)
end

function M.clear_focal()
  Global.camera:clear_focal()
end

function M.set_camera_click_swip_state(is_swip)
  if Global.camera then
    Global.camera:set_click_swip_camera(is_swip)
  end
end

function M.keep_focus_pos_by_clear_target()
  if Global.camera then
    Global.camera:keep_focus_pos_by_clear_target()
  end
end

function M.set_charge(charge_type, time, charge_time)
  if Global.hero then
    Global.hero:update_charge_view(charge_type, time, charge_time)
  end
end

function M.set_charged_active(is_show)
  if Global.hero then
    Global.hero:set_charged_obj_visible(is_show)
  end
end

function M.damage_correct(npc, correct_val)
  npc:set_damage_correct(correct_val)
end

function M.heal_correct(npc, correct_val)
  npc:set_heal_correct(correct_val)
end

function M.is_pass_room(room_id)
  if not TowerMgr then
    return
  end
  local tower = TowerMgr:get_tower()
  if not tower then
    return
  end
  return tower:is_pass_room(room_id)
end

function M.get_part_attr(npc, part_id, attr_type)
  return npc:get_part_attr(part_id, attr_type)
end

function M.set_part_attr(npc, part_id, attr_type, attr_value)
  npc:set_part_attr(part_id, attr_type, attr_value)
end

function M.change_skill_cd(npc, key_val, change_type, magic_id)
  if not check_npc(npc) then
    return false
  end
  local npc_id = npc:get_npc_id()
  local libray_data = ShareRes.create_ex("buddy.buddy_skill_library", npc_id, "LibraryData" .. key_val)
  if not libray_data then
    return
  end
  local skill_mgr = npc.skill_mgr
  local default_id = libray_data[1]
  local magic_mgr = npc.magic_mgr
  Log.Info("change_type = ", change_type, libray_data)
  if change_type == CHANGE_STATE_TYPE.CUR_SKILL then
    skill_mgr:set_change_effect_energy_id(default_id)
    magic_mgr:add_magic(npc, magic_id, nil, nil, 1)
  elseif change_type == CHANGE_STATE_TYPE.LIBRARY then
    for key, id in pairs(libray_data) do
      local magic_cfg = ShareRes.get_magic_cfg(magic_id)
      skill_mgr:set_change_effect_energy_id(id)
      magic_mgr:add_magic(npc, magic_id, nil, nil, 1)
    end
    local add_library_list = skill_mgr:get_library_skill_list(key_val)
    if add_library_list then
      for key, id in pairs(add_library_list) do
        skill_mgr:set_change_effect_energy_id(id)
        magic_mgr:add_magic(npc, magic_id, nil, nil, 1)
      end
    end
  end
end

function M.check_skill_library(npc, key_val, check_skill_id)
  if not check_npc(npc) then
    return false
  end
  local npc_id = npc:get_npc_id()
  local skill_libray_cfg = ShareRes.create("buddy.buddy_skill_library", npc_id)
  local libray_data = skill_libray_cfg["LibraryData" .. key_val]
  local skill_mgr = npc.skill_mgr
  for key, id in pairs(libray_data) do
    if id == check_skill_id then
      return true
    end
  end
  if skill_mgr:check_skill_id_existence(key_val, check_skill_id) then
    return true
  end
  return false
end

function M.add_skill_library_id(npc, key_val, add_skill_id)
  if not check_npc(npc) then
    return false
  end
  local skill_mgr = npc.skill_mgr
  skill_mgr:add_library_skill_id(key_val, add_skill_id)
end

function M.remove_skill_library(npc, key_val, remove_skill_id)
  if not check_npc(npc) then
    return false
  end
  local skill_mgr = npc.skill_mgr
  skill_mgr:remove_skill_library_by_id(key_val, remove_skill_id)
end

function M.get_dir_offset(npc, px, pz)
  if not check_npc(npc) then
    return 0
  end
  return npc:get_pos_dir_offset(px, pz)
end

function M.change_linetype(missile, linetype, lineparams)
  if not check_npc(missile) or not missile:is_missile() then
    return
  end
  missile:change_linetype(linetype, lineparams)
end

function M.remove_missile(missile, need_explosion)
  assert(missile)
  if missile:get_create_frame() == Global.frame_id then
    SceneMgr:safe_remove_missile(missile, nil, need_explosion)
  else
    SceneMgr:remove_missile(missile, nil, need_explosion)
  end
end

function M.mark_limited_missile(missile_id, max_count)
  SceneMgr:mark_limited_missile(missile_id, max_count)
end

function M.set_skill_btn_charging(key_code, charged_type, param_cfg)
  local ui_fight = UIMgr:try_get_loaded_ui(UIMgr.FIGHT_UI_NAME)
  if not ui_fight then
    return
  end
  ui_fight:set_skill_btn_charging(key_code, charged_type, param_cfg)
end

function M.set_skill_btn_icon(key_code, skill_icon)
  local ui_fight = UIMgr:try_get_loaded_ui(UIMgr.FIGHT_UI_NAME)
  if not ui_fight then
    return
  end
  ui_fight:api_set_icon(key_code, skill_icon)
end

function M.clear_skill_btn_charging(key_code)
  local ui_fight = UIMgr:try_get_loaded_ui(UIMgr.FIGHT_UI_NAME)
  if not ui_fight then
    return
  end
  ui_fight:behavior_clear_charing(key_code)
end

function M.get_come_on_hero()
  return Global.hero
end

function M.set_npc_hp_visible(npc, is_visible)
  if not check_npc(npc) then
    return
  end
  npc:set_hp_visible(is_visible)
  FightDataMgr:set_hp_visible_state(npc.uuid, is_visible, is_visible, is_visible, nil)
end

function M.show_magic_num(key_code, value)
  local ui_fight = UIMgr:try_get_loaded_ui(UIMgr.FIGHT_UI_NAME)
  if not ui_fight then
    return
  end
  ui_fight:show_magic_num(key_code, value)
end

function M.enter_guide(guide_id)
  if GuideMgr then
    GuideMgr:enter_guide(guide_id)
  end
end

function M.get_npc_temp_blue(npc)
  if not check_npc(npc) then
    return
  end
  return npc:get_temp_blue_val() or 0
end

function M.get_battle_setting_camera_type()
  if not Util.is_client_only() then
    return BattleSettingMgr:get_custom_camera_view()
  end
end

function M.get_auto_trigger_qte_on_role_out()
  return BattleSettingMgr:get_auto_trigger_qte_on_role_out()
end

function M.stop_skill_joystick_move(npc)
  if not check_npc(npc) then
    return
  end
  npc.role_move_ctrl:stop_skill_joystick()
end

function M.forced_reduce_skill_joystick_speed(npc)
  if not check_npc(npc) then
    return
  end
  npc.role_move_ctrl:forced_reduce_skill_joystick_speed()
end

function M.set_camera_animed_state(is_open)
  if not Global.camera then
    return
  end
  if is_open then
    Global.camera:open_camera_aimed()
  else
    Global.camera:close_camera_aimed()
  end
end

function M.open_hero_head_follow(npc, is_open)
  if not check_npc(npc) then
    return
  end
  if not npc:is_hero() then
    return
  end
  npc:open_hero_head_follow(is_open)
end

function M.get_aimed_camera_angle()
  if not Global.camera then
    return
  end
  local euler = Global.camera:get_aimed_camera_angle()
  return euler
end

function M.lookat_by_npc_attach(npc, attach_name, target_pos, max_x, min_x, max_z, min_z)
  if not check_npc(npc) then
    return
  end
  if not npc:is_npc() then
    return
  end
  npc:lookat_by_npc_attach(npc, attach_name, target_pos, max_x, min_x, max_z, min_z)
end

function M.update_lookat_pos(npc, target_pos)
  if not check_npc(npc) then
    return
  end
  if not npc:is_npc() then
    return
  end
  npc:update_lookat_pos(target_pos)
end

function M.close_npc_attach_lookat(npc)
  if not check_npc(npc) then
    return
  end
  npc:close_npc_attach_lookat()
end

function M.play_DBM_ani(text_id)
  local msg = MsgGame:mq_publish2(Const.MSG_ON_SHOW_DBM)
  msg.mm_x = text_id
end

function M.disable_DBM(text_id, close_type)
  local msg = MsgGame:mq_publish2(Const.MSG_ON_CLOSE_DBM)
  msg.mm_x = text_id
  msg.mm_y = close_type
end

function M.get_camera_view_type()
  if not Global.camera then
    return Config.CAMERA_VIEW_TYPE.DEPRESSION
  end
  return Global.camera:get_view_type()
end

function M.joystick_end()
  Joystick.on_joystick("end")
end

function M.get_active_char_element(npc)
  npc = npc or Global.hero
  return npc:get_element_id()
end

function M.set_sync_var(k, v)
  BehaviorShareMgr:set_sync_var(k, v)
end

function M.get_sync_var(k)
  return BehaviorShareMgr:get_sync_var(k)
end

function M.switch_fight_bgm(bgm_name, volume, fadeout_time)
  if not Global.sound_mgr then
    return
  end
  Global.sound_mgr:switch_fight_bgm(bgm_name, volume, fadeout_time)
end

function M.start_play_bgm(change_time)
  if not Global.sound_mgr then
    return
  end
  Global.sound_mgr:start_play_bgm(change_time)
end

function M.switch_play_bgm(bgm_name)
  if not Global.sound_mgr then
    return
  end
  Global.sound_mgr:switch_play_bgm(bgm_name)
end

function M.stop_play_bgm(change_time)
  if not Global.sound_mgr then
    return
  end
  Global.sound_mgr:stop_play_bgm(change_time)
end

function M.set_source_volume(source_type, lerp_time, target_volume)
  if not Global.sound_mgr then
    return
  end
  Global.sound_mgr:set_source_volume(source_type, lerp_time, target_volume)
end

function M.play_common_sound(sound_name)
  if not Global.sound_mgr then
    return
  end
  Global.sound_mgr:play_common_sound(sound_name)
end

function M.set_sound_reverb_state(state)
  if not Global.sound_mgr then
    return
  end
  Global.sound_mgr:set_sound_reverb_state(state)
end

function M.switch_bgm_block(sound_name, block_num)
  if not Global.sound_mgr then
    return
  end
  Global.sound_mgr:switch_block(sound_name, block_num)
end

function M.is_in_challenge()
  local fight_ui = UIMgr:try_get_visible_ui(UIMgr.FIGHT_UI_NAME)
  if fight_ui then
    return fight_ui:get_is_in_challenge()
  end
  return false
end

function M.trigger_fight_story(story_id)
  UIMgr:get_ui("uifight_story"):ui_show(story_id)
end

function M.set_keyframe_enable(char, id, enable, force)
  if not check_npc(char) then
    return
  end
  char.skill_mgr:set_keyframe_enable(id, enable, force)
end

function M.set_keyframe_enable_by_tag(char, skill_id, tag, enable, force)
  if not check_npc(char) then
    return
  end
  char.skill_mgr:set_keyframe_by_tag(skill_id, tag, enable, force)
end

function M.force_finish_cur_guide()
  if GuideMgr then
    GuideMgr:force_finish_cur_guide()
  end
end

function M.stop_touch_swip(is_stop_swip)
  if Global.camera then
    Global.camera:stop_touch_swip(is_stop_swip)
  end
end

function M.pause_cinemachine(is_pause)
  if is_pause then
    Cinemachine:pause()
  else
    Cinemachine:resume()
  end
end

function M.set_cursor_enable(npc, bool)
  if not check_npc(npc) then
    return
  end
  npc:set_cursor_enable(bool)
end

function M.start_texture_guide(group_id)
  if GraphicGuideMgr then
    GraphicGuideMgr:init(group_id)
  end
end

function M.start_stroy(story_id)
  if StoryMgr then
    StoryMgr:on_start(story_id)
  end
end

function M.char_visible(is_hide)
  local cur_hero = Global.hero
  if not cur_hero then
    return
  end
  cur_hero:set_obj_enable(not is_hide)
end

function M.set_hud_config(key_code, res_config, usage, param1, param2)
  FightHudMgr.set_hud_config(key_code, res_config, usage, param1, param2)
end

function M.set_hud_config_world(key_code, res_config, usage, param1, param2)
  FightHudMgr.set_hud_config_world(key_code, res_config, usage, param1, param2)
end

function M.active_hud(npc, key_code, attach_point, is_active, txt)
  if not check_npc(npc) then
    return
  end
  npc.fight_hud_mgr:active_hud(key_code, attach_point, is_active, txt)
end

function M.active_hud_world(npc, key_code, attach_point, is_active)
  if not check_npc(npc) then
    return
  end
  npc.fight_hud_mgr:active_hud_world(key_code, attach_point, is_active)
end

function M.start_skill_teach(skill_id)
  local msg = MsgGame:mq_publish2(Const.MSG_ON_START_HERO_SKILL_TEACH)
  msg.mm_x = skill_id
end

function M.set_skill_state(step_id, success)
  local msg = MsgGame:mq_publish2(Const.MSG_ON_CHANGE_SKILL_STATE)
  msg.mm_x = step_id
  msg.mm_y = success
end

function M.start_long_click_skill()
  MsgGame:mq_publish2(Const.MSG_ON_START_LONG_CLICK_SKILL)
end

function M.restart_skill_teach(skill_id)
  local msg = MsgGame:mq_publish2(Const.MSG_ON_RESTART_HERO_SKILL_TEACH)
  msg.mm_x = skill_id
end

function M.show_skill_teach_tips(tips_id, visible)
  local msg = MsgGame:mq_publish2(Const.MSG_ON_SHOW_SKILL_TIPS)
  msg.mm_x = tips_id
  msg.mm_y = visible
end

function M.show_skill_combo_tips(combo_id_list, visible)
  local msg = MsgGame:mq_publish2(Const.MSG_ON_SHOW_SKILL_TIPS)
  msg.mm_x = combo_id_list
  msg.mm_y = visible
end

function M.set_skill_ban_use(idx, visible)
  local msg = MsgGame:mq_publish2(Const.MSG_ON_BAN_SKILL_USE)
  msg.mm_x = idx
  msg.mm_y = visible
end

function M.check_npc_btn_interact(npc_id)
  if SceneMgr then
    local scene_logic = SceneMgr:get_scene_logic()
    if scene_logic then
      return scene_logic:is_contacting_func_npc(npc_id)
    end
  end
end

function M.listen_missile_evt(evt_type, npc, missile_id, callback, instance)
  if not check_npc(npc) then
    return false
  end
  BehaviorMgr:listen_missile_mq(npc, evt_type, missile_id, callback, instance)
end

function M.unlisten_missile_evt(evt_type, npc, missile_id, instance)
  if not check_npc(npc) then
    return false
  end
  BehaviorMgr:unlisten_missile_mq(npc, evt_type, missile_id, instance)
end

function M.listen_missile_collide_obstacle(npc, missile_id, callback, instance)
  if not check_npc(npc) then
    return false
  end
  local evt_type = MISSILE_EVT_TYPE.COLLIDE_OBSTACLE
  BehaviorMgr:listen_missile_mq(npc, evt_type, missile_id, callback, instance)
end

function M.unlisten_missile_collide_obstacle(npc, missile_id, instance)
  if not check_npc(npc) then
    return false
  end
  local evt_type = MISSILE_EVT_TYPE.COLLIDE_OBSTACLE
  BehaviorMgr:unlisten_missile_mq(npc, evt_type, missile_id, instance)
end

function M.listen_missile_begin_pos(npc, missile_id, callback, instance)
  if not check_npc(npc) then
    return false
  end
  local evt_type = MISSILE_EVT_TYPE.BEGIN_POS
  BehaviorMgr:listen_missile_mq(npc, evt_type, missile_id, callback, instance)
end

function M.unlisten_missile_begin_pos(npc, missile_id, instance)
  if not check_npc(npc) then
    return false
  end
  local evt_type = MISSILE_EVT_TYPE.BEGIN_POS
  BehaviorMgr:unlisten_missile_mq(npc, evt_type, missile_id, instance)
end

function M.listen_missile_end_pos(npc, missile_id, callback, instance)
  if not check_npc(npc) then
    return false
  end
  local evt_type = MISSILE_EVT_TYPE.END_POS
  BehaviorMgr:listen_missile_mq(npc, evt_type, missile_id, callback, instance)
end

function M.unlisten_missile_end_pos(npc, missile_id, instance)
  if not check_npc(npc) then
    return false
  end
  local evt_type = MISSILE_EVT_TYPE.END_POS
  BehaviorMgr:unlisten_missile_mq(npc, evt_type, missile_id, instance)
end

function M.listen_magic_begin(npc, magic_id, callback, instance)
  if not check_npc(npc) then
    return false
  end
  local evt_type = MAGIC_EVT_TYPE.BEGIN
  BehaviorMgr:listen_magic_mq(evt_type, npc, magic_id, callback, instance)
end

function M.unlisten_magic_begin(npc, magic_id, instance)
  if not check_npc(npc) then
    return false
  end
  local evt_type = MAGIC_EVT_TYPE.BEGIN
  BehaviorMgr:unlisten_magic_mq(npc, evt_type, magic_id, instance)
end

function M.listen_magic_end(npc, magic_id, callback, instance)
  if not check_npc(npc) then
    return false
  end
  local evt_type = MAGIC_EVT_TYPE.END
  BehaviorMgr:listen_magic_mq(evt_type, npc, magic_id, callback, instance)
end

function M.unlisten_magic_end(npc, magic_id, instance)
  if not check_npc(npc) then
    return false
  end
  local evt_type = MAGIC_EVT_TYPE.END
  BehaviorMgr:unlisten_magic_mq(npc, evt_type, magic_id, instance)
end

function M.get_weapon_attach_point(npc, attach_name)
  if not check_npc(npc) then
    return
  end
  local weapon_mgr = npc.weapon_mgr
  if not weapon_mgr then
    return
  end
  return weapon_mgr:get_attach_point_obj(attach_name)
end

function M.get_skill_lv(npc, skill_id)
  if not check_npc(npc) then
    return
  end
  local skill_mgr = npc.skill_mgr
  local lv = skill_mgr:get_skill_lv(skill_id)
  return lv
end

function M.check_navigate(npc)
  if not check_npc(npc) then
    return 3
  end
  return npc.navigator_ctrl:get_state()
end

function M.is_path_possible(npc, target)
  if not check_npc(npc) or not check_npc(target) then
    return false
  end
  local map = SceneMgr:get_scene_map()
  if map:has_platforms() then
    local start_pos = npc:get_pos_vec3()
    local end_pos = target:get_pos_vec3()
    local start_region = map:get_region_at_pos(start_pos.x, start_pos.z)
    local end_region = map:get_region_at_pos(end_pos.x, end_pos.z)
    if nil == start_region or nil == end_region then
      return false
    end
    return start_region:get_link_flag() == end_region:get_link_flag()
  else
    return true
  end
end

function M.set_cam_pinch_switch(is_open)
  if Global.camera then
    Global.camera:set_cam_pinch_switch(is_open)
  end
end

function M.change_focus_follow_speed(speed)
  if Global.camera then
    Global.camera:change_focus_follow_speed(speed)
  end
end

function M.get_focus_follow_speed()
  if Global.camera then
    return Global.camera:get_target_follow_speed()
  end
end

function M.get_camera_follow_target()
  if Global.camera then
    return Global.camera:get_camera_follow_target()
  end
end

function M.request_teach_scene_create_monster(monster_group)
  SceneMgr:c2gs_call_scene("teach_scene_create_monster", monster_group)
end

function M.request_end_teach_level(win)
  BehaviorMgr:call_scene_logic_event_fun("on_end_teach_level")
end

function M.set_dynamic_bone_shake_list(npc, bone_type, bone_name_list)
  if not npc then
    return
  end
  npc:set_dynamic_bone_shake_list(bone_type, bone_name_list)
end

function M.clear_dynamic_bone_shake_list(npc)
  if not npc then
    return
  end
  npc:clear_dynamic_bone_shake_list()
end

function M.set_npc_controller(npc, extra_controller_path)
  extra_controller_path = extra_controller_path or 0
  SceneMgr:set_model_animator(npc, extra_controller_path)
end

function M.offset_shadow_api(x, y, z)
  SceneMgr:room_offset_shadow_api(x, y, z)
end

function M.set_npc_joint_active(npc, joint, is_active)
  if not check_npc(npc) then
    return
  end
  npc:set_joint_active(joint, is_active)
end

function M.get_ball_level()
  return Rune2Mgr:get_ball_level()
end

function M.get_ball_level_on_npc(npc)
  if not check_npc(npc) then
    return
  end
  return Rune2Mgr:get_ball_level_on_npc(npc)
end

function M.get_npc_rune2_level_by_color(npc, color)
  if not check_npc(npc) then
    return
  end
  if Util.is_client_only() then
    return 0
  end
  return Rune2Mgr:get_npc_rune2_level_by_color(npc, color)
end

function M.get_npc_rune2_info(npc)
  if not check_npc(npc) then
    return
  end
  if Util.is_client_only() then
    return {color = "none", level = 0}
  end
  return Rune2Mgr:get_npc_rune2_info(npc)
end

function M.set_stun_animation_group_id(npc, group_id)
  if not check_npc(npc) then
    return
  end
  npc:set_stun_animation_group_id(group_id)
end

function M.enter_stun(npc, exist_armor, duration)
  if not (check_npc(npc) and duration) or duration < 0 then
    return
  end
  npc.state_manager:enter_stun(duration, exist_armor)
end

function M.exit_stun(npc)
  if not check_npc(npc) then
    return
  end
  npc.state_manager:exit_stun()
end

function M.is_really_enter_stun(npc)
  if not check_npc(npc) then
    return
  end
  return npc.state_manager:is_really_enter_stun()
end

function M.stun_is_end(npc)
  if not check_npc(npc) then
    return
  end
  return npc.state_manager:stun_is_end()
end

function M.debug_missile_name()
  Global.debug_missile_name = true
end

function M.check_play_born_sound(npc)
  if not check_npc(npc) then
    return
  end
  SceneMgr:check_play_hero_born_sound(npc)
end

function M.play_effect(char, effect_name, attach_point, is_weapon_attach)
  local ctrl = char.act_effect_ctrl
  if not ctrl then
    return
  end
  local effect_data = ctrl.create_effect_param()
  effect_data.prefab_name = effect_name
  effect_data.attach_point = attach_point
  effect_data.is_weapon_attach = is_weapon_attach
  local fx_id = ctrl:play_attach_effect(effect_data, char)
  return fx_id
end

function M.stop_effect(char, fx_id)
  local ctrl = char.act_effect_ctrl
  if not ctrl then
    return
  end
  ctrl:stop_effect(fx_id)
end

function M.flash_to_pos(npc, x, z, y, only_check_boundar, trigger_area_event)
  if not check_npc(npc) then
    return
  end
  npc.role_move_ctrl:flash_to_pos(x, z, y, only_check_boundar, trigger_area_event)
end

function M.set_face_skill_indicator_pos(npc, is_open, dev_val, move_speed, back_speed)
  if not check_npc(npc) then
    return
  end
  if not npc:is_hero() then
    return
  end
  local parms = {
    is_open = is_open,
    dev_val = dev_val,
    move_speed = move_speed,
    back_speed = back_speed
  }
  npc:set_face_pos_skill_indicator(parms)
end

function M.get_char_long_press_skill_id(npc)
  if not check_npc(npc) then
    return
  end
  if not npc:is_hero() then
    return
  end
  local cfg = npc:get_character_cfg()
  return cfg.DefAtkSkillId
end

function M.set_effect_bar_length(npc, length)
  if not check_npc(npc) then
    return
  end
  if npc:is_hero() then
    return
  end
  if npc:is_have_effect_bar() then
    npc:set_effect_bar_length(length)
  else
    local fight = UIMgr:try_get_visible_ui(UIMgr.FIGHT_UI_NAME)
    if fight and fight.v_panels and fight.v_panels.enemy_bar then
      fight.v_panels.enemy_bar:set_effect_bar_length(length)
    end
  end
end

function M.set_effect_bar_show(npc, is_show)
  if not check_npc(npc) then
    return
  end
  if npc:is_hero() then
    return
  end
  if npc:is_have_effect_bar() then
    npc:set_effect_bar_show(is_show)
  else
    local fight = UIMgr:try_get_visible_ui(UIMgr.FIGHT_UI_NAME)
    if fight and fight.v_panels and fight.v_panels.enemy_bar then
      fight.v_panels.enemy_bar:set_effect_bar_show(is_show)
    end
  end
end

function M.set_missile_dt(missile, scale)
  missile:set_missile_time_scale(scale)
end

function M.play_timeline(name, fade_in, fade_out, uuid_list, can_skip, is_active_lua, close_camera_transparent, is_show_ui)
  local data = {
    name = name,
    fade_in = fade_in,
    fade_out = fade_out,
    uuid_list = uuid_list,
    can_skip = can_skip,
    is_active_lua = is_active_lua,
    close_camera_transparent = close_camera_transparent,
    is_show_ui = is_show_ui
  }
  TimeLineSeqPlayer.play_time_line_seq(data)
end

function M.stop_timeline(name)
  TimeLineSeqPlayer.stop()
end

function M.get_god_skill_level()
  if not TowerMgr then
    return 0
  end
  local skill_data = TowerMgr:get_scene_skill_data()
  if not skill_data then
    return 0
  end
  return skill_data.lv
end

function M.init_special_fight_ui(type, max_num, active_list)
  if 2 == type and (not max_num or not active_list) then
    Log.Error("type为", type, "时，第二、三参数均不可为空")
    return
  end
  local fight = UIMgr:try_get_visible_ui(UIMgr.FIGHT_UI_NAME)
  if fight then
    local hero_bar = fight:get_panel("hero_bar")
    if not hero_bar then
      return
    end
    if type then
      hero_bar:set_bar_style(type)
    end
    if max_num then
      hero_bar:set_point_count(max_num)
    end
    if active_list then
      hero_bar:set_point_state(active_list)
    end
  end
end

function M.update_point_fight_ui(max_num, active_list)
  local fight = UIMgr:try_get_visible_ui(UIMgr.FIGHT_UI_NAME)
  if fight then
    local hero_bar = fight:get_panel("hero_bar")
    if not hero_bar then
      return
    end
    if max_num then
      hero_bar:set_point_count(max_num)
    end
    if active_list then
      hero_bar:set_point_state(active_list)
    end
  end
end

function M.get_team_rune_count_by_type(rune_type)
  return Rune2Mgr:get_team_rune_count_by_type(rune_type)
end

function M.play_video(video_name, is_skip, alpha_enter, alpha_out, sound_name)
  if not VideoMgr then
    return
  end
  local video_data = {
    video_name = video_name,
    is_skip = is_skip,
    alpha_enter = alpha_enter,
    alpha_out = alpha_out,
    sound_name = sound_name
  }
  VideoMgr:on_play_video(video_data)
end

function M.set_npc_pos(npc, pos_key)
  local scene_logic = SceneMgr:get_scene_logic()
  local x, y, z = scene_logic:get_pos_key_position(pos_key)
  if npc then
    npc:set_pos(x, y, z)
  end
end

function M.switch_ui_image(ui_name, obj_name, img_path)
  local ui_obj = UIMgr:try_get_visible_ui(ui_name)
  if not ui_obj then
    return
  end
  ui_obj:switch_ui_image(obj_name, img_path)
end

function M.get_cur_card_cfg_info()
  local card_cfg = ChallengeRingPlusMgr:get_cur_card_cfg_info()
  if card_cfg then
    return card_cfg.Id, card_cfg.Type
  end
end

function M.get_nearest_walkable_pos(src_pos, tar_pos, reduce_dist, check_ground_dist, only_check_boundary)
  if check_ground_dist and check_ground_dist > 20 then
    Log.Error("get_nearest_walkable_pos 检测地面距离不可超过 20", debug.traceback())
    return
  end
  local check_layer
  if only_check_boundary then
    check_layer = Layer.LayerMask.BoundaryBlock
  end
  return SceneMgr:get_nearest_walkable_pos(src_pos, tar_pos, reduce_dist, check_ground_dist, check_layer)
end

function M.remove_missile_by_id(missile_id, char, need_explosion)
  SceneMgr:remove_missile_by_id(missile_id, char, nil, need_explosion)
end

function M.check_betargetd()
  if not Global.hero then
    return false
  end
  local betargets_map = Global.hero:get_betargetd_map()
  for uuid, _ in pairs(betargets_map) do
    local target = SceneMgr:get_npc_by_id(uuid)
    if target and not target:is_destroy() then
      return true
    end
  end
  return false
end

function M.set_special_tag(npc, tag, is_remove)
  if is_remove then
    npc:remove_special_tag()
  else
    npc:special_tag(tag)
  end
end

function M.get_config_id(npc)
  return npc:get_config_id()
end

function M.get_role_kind(npc)
  return npc:get_role_kind()
end

function M.get_button_cur_state(keycode)
  local fight = UIMgr:try_get_visible_ui(UIMgr.FIGHT_UI_NAME)
  if fight then
    return fight:get_button_cur_state(keycode)
  end
end

function M.record_time_invert(npc, time_limit)
  if not check_npc(npc) then
    return
  end
  local keeper = SceneMgr:get_time_keeper_mgr()
  keeper:record_time_invert(npc, time_limit)
end

function M.play_time_invert(sec, speed, cb)
  local keeper = SceneMgr:get_time_keeper_mgr()
  keeper:play_time_invert(sec, speed, cb)
end

function M.set_show_hit_effect_state(npc, is_show_hit_effect)
  if not check_npc(npc) then
    return
  end
  npc:set_show_hit_effect_state(is_show_hit_effect)
end

function M.update_plat_movement(name, is_move, anim)
  if SceneMgr then
    SceneMgr:get_plat_mgr():update_plat_movement(name, is_move, anim)
  end
end

function M.remove_area(key, tag)
  if not SceneMgr then
    return
  end
  local scene_logic = SceneMgr:get_scene_logic()
  if scene_logic then
    scene_logic:remove_area(key, tag)
  else
    Log.Error("remove_area with no scene logic：", Account:get_account())
  end
end

function M.enable_god_skill(is_enable)
  TowerMgr:enable_god_skill(is_enable)
end

function M.set_weapon_attach_point(npc, attach_name, active)
  local point_obj = M.get_weapon_attach_point(npc, attach_name)
  if point_obj and not point_obj:IsNull() then
    point_obj.gameObject:SetActive(active)
  end
  local rep = "%s_lod%d"
  for i = 0, 2 do
    local point_obj2 = M.get_weapon_attach_point(npc, string.format(rep, attach_name, i))
    if point_obj2 and not point_obj2:IsNull() then
      point_obj2.gameObject:SetActive(active)
    end
  end
end

function M.set_npc_target_dir(npc, dir, force)
  if not check_npc(npc) then
    return
  end
  npc:set_target_dir(dir, force)
end

function M.set_root_trans(pos_x, pos_y, pos_z, rot_x, rot_y, rot_z)
  if not SceneMgr then
    return
  end
  SceneMgr:set_root_trans(pos_x, pos_y, pos_z, rot_x, rot_y, rot_z)
end

function M.get_cur_room_id()
  if not TowerMgr then
    return
  end
  local tower = TowerMgr:get_tower()
  if not tower then
    return
  end
  local room = tower:get_room()
  if not room then
    return
  end
  return room:get_room_id()
end

function M.get_npc_cur_tough_down_lv(npc)
  if not check_npc(npc) or not npc:is_have_tough() then
    return
  end
  return npc:get_cur_tough_down_lv()
end

function M.set_npc_floating_text_hud_visible(npc, is_show)
  if not check_npc(npc) then
    return
  end
  return npc:set_floating_text_hud_visible(is_show)
end

function M.get_missile_uuid(missile)
  local uuid = missile.id
  return uuid
end

function M.set_btn_charging_type(skill_id, charge_type, is_on, cur_cd, max_cd, cd_recove_per_second, attr_id)
  local fight = UIMgr:try_get_ui(UIMgr.FIGHT_UI_NAME)
  if fight then
    fight:set_btn_charging_type(skill_id, charge_type, is_on, cur_cd, max_cd, cd_recove_per_second, attr_id)
  end
end

function M.get_common_value(key)
  return ShareRes.get_comm_value(key)
end

function M.get_area_pos(pos_key)
  local scene_map = SceneMgr:get_scene_map()
  if not scene_map then
    return
  end
  local pos = scene_map:get_area_position(pos_key)
  return pos.X, pos.Y, pos.Z
end

function M.npc_is_destroy(npc)
  return nil == npc or npc:is_destroy()
end

function M.set_dead_ball_count(npc, count)
  if not npc then
    return
  end
  npc:set_dead_ball_count(count)
end

function M.check_element_ab_state(npc, element_type)
  if not (check_npc(npc) and npc:is_npc()) or not npc.attr_mgr then
    return false
  end
  if element_type and not FightDefine.ELEMENT_TO_AB_ATTR[element_type] then
    return false
  end
  return npc.element_abnormal_mgr:check_abnormal_on_timer(element_type)
end

function M.switch_behavior_file(file, char)
  if not file then
    return
  end
  if not char then
    return
  end
  BehaviorMgr:switch_char_behavior(file, char)
end

function M.copy_attr_to_npc(from_npc, target_npc, type_arg)
  if not (check_npc(from_npc) and check_npc(target_npc)) or not SceneMgr then
    return
  end
  SceneMgr:copy_attr_to_npc(from_npc, target_npc, type_arg)
end

function M.change_npc_prefab(npc, prefab_index, save_vfx)
  if not check_npc(npc) then
    return
  end
  npc:change_gameobj(prefab_index, save_vfx)
end

function M.set_enable_transparent(npc, is_enable)
  if not npc then
    return
  end
  npc:set_enable_transparent(is_enable)
end

function M.auto_forward_move(npc, is_open)
  if not check_npc(npc) then
    return
  end
  npc.state_manager:set_auto_forward_move_mode(is_open)
end

function M.set_npc_speed_correct_param(npc, param1, param2, param3, param4)
  if not check_npc(npc) then
    return
  end
  npc:set_speed_correct_param(param1, param2, param3, param4)
end

function M.change_root_pos_and_rota(pos_x, pos_y, pos_z, rota_x, rota_y, rota_z)
  if not SceneMgr then
    return
  end
  SceneMgr:change_root_pos_and_rota(pos_x, pos_y, pos_z, rota_x, rota_y, rota_z)
end

function M.get_unit_physical_button_cfg(char_id, btn_name)
  return ShareRes.get_unit_physical_button_cfg(char_id, btn_name)
end

function M.get_unit_logic_button_cfg(char_id, icon_name)
  return ShareRes.get_unit_logic_button_cfg(char_id, icon_name)
end

function M.get_unit_skill_action_cfg(char_id, skact_name)
  return ShareRes.get_unit_skill_action_cfg(char_id, skact_name)
end

function M.add_task_progress(id, value)
  if not SceneMgr or not BattleTaskMgr then
    return
  end
  BattleTaskMgr:request_add_task_progress(id, value)
end

function M.set_scene_npc_status(scene_npc, status)
  if not scene_npc or not scene_npc.set_scene_npc_status then
    return
  end
  scene_npc:set_scene_npc_status(status)
end

function M.get_scene_npc_status(scene_npc)
  if not scene_npc or not scene_npc.get_scene_npc_status then
    return
  end
  return scene_npc:get_scene_npc_status()
end

function M.get_ability_level(ability_id)
  if not ability_id or ability_id < 1 then
    return
  end
  if not GenresMgr then
    Log.Error("单机不存在能力管理器，目标能力等级将返回1")
    return 1
  end
  return GenresMgr:get_ability_grade(ability_id)
end

function M.get_ui_object_self_active(ui_name, object_name)
  local ui = UIMgr:try_get_visible_ui(ui_name)
  if ui then
    local obj = ui:get_uiobject(object_name)
    if not obj then
      for _, child_obj in pairs(ui.v_panels) do
        obj = child_obj:get_uiobject(object_name)
        if obj then
          break
        end
      end
    end
    if obj then
      return obj.gameObject.activeInHierarchy
    else
      Log.Error("ui：", ui_name, "中，不存在：", object_name, "object", debug.traceback())
      return false
    end
  else
    return false
  end
end

function M.get_develop_level(npc, level_type, param)
  if not check_npc(npc) then
    return 0
  end
  local buddy_data = npc:get_buddy_data()
  if not buddy_data then
    return 0
  end
  if 1 == level_type then
    return buddy_data.break_lv or 0
  elseif 2 == level_type then
    return buddy_data.advance or 0
  elseif 3 == level_type then
    return buddy_data.equip_data and buddy_data.equip_data.advance_lv or 0
  elseif 4 == level_type then
    if not buddy_data.equip_data then
      return 0
    end
    local equip_data = buddy_data.equip_data
    local magic_id = ShareRes.get_weapon_magic(equip_data.id, equip_data.advance_lv)
    return magic_id
  elseif 5 == level_type then
    return buddy_data.talent_lv or 0
  elseif 6 == level_type and param then
    local puzzle_graph = buddy_data.puzzle_graph
    if not puzzle_graph or not puzzle_graph.puzzle_place_infos then
      return 0
    end
    local quality = 2
    for _, puzzle_place_info in ipairs(puzzle_graph.puzzle_place_infos) do
      local puzzle_id = puzzle_place_info.id
      local puzzle_cfg = ShareRes.get_buddy_puzzle_cfg(puzzle_id)
      if puzzle_cfg.EntryId then
        local entry_cfg = ShareRes.get_buddy_puzzle_entry_cfg(puzzle_cfg.EntryId, puzzle_place_info.quality)
        if entry_cfg.MagicId == param and quality < puzzle_place_info.quality then
          quality = puzzle_place_info.quality
        end
      end
    end
    return quality - 2
  end
end

function M.set_scene_plat_speed(plat_name, speed, anim_name, is_move)
  if Util.is_empty(plat_name) then
    return
  end
  local plat_mgr = SceneMgr:get_plat_mgr()
  if not plat_mgr then
    return
  end
  plat_mgr:set_plat_time_scale(plat_name, speed)
  if anim_name then
    M.update_plat_movement(plat_name, is_move, anim_name)
  end
end

function M.set_scene_timeline_speed(timeline_obj_path, speed)
  if Util.is_empty(timeline_obj_path) then
    return
  end
  local scene_logic = SceneMgr:get_scene_logic()
  if not scene_logic then
    return
  end
  scene_logic:set_scene_time_line_speed(timeline_obj_path, speed)
end

function M.replace_team_pos_data(pos, is_go_out)
  if not pos then
    return
  end
  if Util.is_client_only() then
    Log.Error("单机无法使用replace_team_pos_data")
    return
  end
  SceneMgr:c2gs_call_scene("replace_team_pos_data", pos, is_go_out)
end

function M.set_ult_skill_enabled(npc, enabled)
  if not check_npc(npc) then
    return
  end
  local fight = UIMgr:try_get_visible_ui(UIMgr.FIGHT_UI_NAME)
  if fight then
    fight:set_ult_skill_enabled(npc.uuid, enabled)
  end
end

function M.get_ui_obj_list(ui_name)
  if not ui_name then
    return fight_ui_objs
  end
  if not fight_ui_objs[ui_name] then
    return {}
  end
  return fight_ui_objs[ui_name]
end

function M.add_fight_ui_to_table(ui_name, obj_name)
  if not fight_ui_objs[ui_name] then
    fight_ui_objs[ui_name] = {}
  end
  fight_ui_objs[ui_name][obj_name] = true
end

function M.remove_fight_ui_to_table(ui_name, obj_name)
  if not fight_ui_objs[ui_name] then
    return
  end
  fight_ui_objs[ui_name][obj_name] = nil
end

function M.clear_fight_ui_objs()
  fight_ui_objs = {}
end

function M.get_group_ai_cfg(id)
  return ShareRes.get_group_ai_cfg(id)
end

function M.get_npc_group_ai(npc)
  if not check_npc(npc) then
    return
  end
  return npc:get_ai_group_id(), npc:get_ai_group()
end

function M.play_simple_timeline(name, is_play)
  if is_play then
    SceneRoomPrefabLoader:load_prefab(name)
  else
    SceneRoomPrefabLoader:release_prefab(name)
  end
end

function M.cancel_born_skill()
  if TowerMgr then
    return TowerMgr:need_cancle_born_skill()
  else
    return false
  end
end

function M.set_npc_phase_number(npc, phase_num)
  if not check_npc(npc) then
    return
  end
  FightDataMgr:set_npc_phase_data(npc.uuid, phase_num)
end

function M.change_npc_phase_state(npc, phase_num, phase_state)
  if not check_npc(npc) or type(phase_state) ~= "boolean" then
    return
  end
  FightDataMgr:change_npc_phase_state(npc.uuid, phase_num, phase_state)
end

function M.set_move_offsets_multi_map(npc, offsets_multi_map)
  if not check_npc(npc) or not npc.act_ctrl then
    return
  end
  npc.act_ctrl:set_move_offsets_multi_map(offsets_multi_map)
end

function M.set_move_offsets_multiplier(npc, multiplier)
  if not check_npc(npc) or not npc.act_ctrl then
    return
  end
  npc.act_ctrl:set_move_offsets_multiplier(multiplier)
end

function M.set_joystick_alpha_visible(visible)
  local fight = UIMgr:try_get_loaded_ui(UIMgr.FIGHT_UI_NAME)
  if fight then
    local alpha = visible and 1 or 0
    fight:set_joystick_alpha(alpha)
  end
end

function M.set_npc_ignore_sync_area(npc, ignore_sync)
  if not check_npc(npc) then
    return
  end
  npc:set_ignore_sync(ignore_sync)
end

function M.get_npc_missile_distance(npc, missile)
  if not check_npc(npc) then
    Log.Error("get_npc_missile_distance error, target npc", npc.id, " has destroyed, return 0", debug.traceback())
    return 0
  end
  if not check_npc(missile) then
    Log.Error("get_npc_missile_distance error, target missile", missile.missile_id, " has destroyed, return 0", debug.traceback())
    return 0
  end
  return Vec3.Distance(missile:get_pos_vec3(), npc:get_pos_vec3())
end

function M.get_missile_skill_action_info(missile)
  if not check_npc(missile) then
    return
  end
  return missile:get_skill_action_info()
end

function M.get_npc_to_camera_offset_position(npc, length, deg)
  if not check_npc(npc) or not Global.camera then
    return
  end
  deg = deg or 0
  local npc_pos = M.get_npc_pos(npc)
  local camera_position = Global.camera:get_camera_position()
  return M.get_position_offset_position(npc_pos, camera_position, deg, length)
end

function M.get_pos_to_camera_offset_position(target_pos, length, deg)
  if not Global.camera then
    return
  end
  deg = deg or 0
  local camera_position = Global.camera:get_camera_position()
  return M.get_position_offset_position(target_pos, camera_position, deg, length)
end

function M.listen_button_mq(event_type, npc, callback, instance)
  BehaviorMgr:listen_button_mq(event_type, npc, callback, instance)
end

function M.unlisten_button_mq(event_type, npc, instance)
  BehaviorMgr:unlisten_button_mq(event_type, npc, instance)
end

function M.listen_custom_event_mq(event_name, npc, callback, instance)
  return BehaviorMgr:listen_custom_event_mq(event_name, npc, callback, instance)
end

function M.unlisten_custom_event_mq(event_type, npc, instance)
  BehaviorMgr:unlisten_custom_event_mq(event_type, npc, instance)
end

function M.call_custom_event_mq(event_name, ...)
  BehaviorMgr:call_custom_event_mq(event_name, ...)
end

function M.listen_attr_change_mq(npc, attr_type, callback, instance)
  if not check_npc(npc) or not instance then
    return
  end
  BehaviorMgr:listen_attr_change_mq(npc, attr_type, callback, instance)
end

function M.unlisten_attr_change_mq(npc, attr_type, instance)
  if not instance then
    return
  end
  BehaviorMgr:unlisten_attr_change_mq(npc, attr_type, instance)
end

function M.get_button_drag_state(index)
  local fight = UIMgr:try_get_loaded_ui(UIMgr.FIGHT_UI_NAME)
  if fight then
    return fight:get_button_drag_state(index)
  else
    return false
  end
end

function M.change_hero_state(hero, new_state, keycode, pos, state_type)
  local current_state = hero:get_current_state()
  if pos then
    if new_state ~= Config.HERO_STATE.IN_BACKGROUND then
      hero:set_latest_pos(pos:Get())
    end
  elseif current_state == Config.HERO_STATE.IN_GROUND and new_state == Config.HERO_STATE.IN_CONTROL then
    hero:set_use_pos_type(Config.HERO_POS_CHANGE_TYPE.ORIGIN)
  else
    hero:set_use_pos_type(Config.HERO_POS_CHANGE_TYPE.GLOBAL_POS)
  end
  SceneMgr:change_hero_state(hero, new_state, keycode, nil, state_type)
end

function M.hero_stop_move(hero)
  hero.state_manager:stop_move()
  hero.role_move_ctrl:set_joystick_dir(0, 0)
end

function M.set_attach_target_enable(enable)
  local fight = UIMgr:try_get_loaded_ui(UIMgr.FIGHT_UI_NAME)
  if fight then
    fight:set_attach_target_enable(enable)
  end
end

function M.open_progress_display(init_value, curr_room__final_value, all_room_final_value, up_speed, is_need_anim, up_interval)
  if not Global.ui_dynamic_canvas then
    return
  end
  Global.ui_dynamic_canvas:on_progress_display_open(init_value, curr_room__final_value, all_room_final_value, up_speed, is_need_anim, up_interval)
end

function M.close_progress_display(is_need_anim)
  if not Global.ui_dynamic_canvas then
    return
  end
  Global.ui_dynamic_canvas:on_progress_display_close(is_need_anim)
end

function M.update_progress_display(up_value)
  if not Global.ui_dynamic_canvas then
    return
  end
  Global.ui_dynamic_canvas:on_progress_display_update(up_value)
end

function M.set_record_damage_trigger(is_open)
  FightDataMgr:set_record_damage_trigger(is_open)
  FightDataMgr:clear_skill_link_damage()
end

function M.clear_record_damage()
  FightDataMgr:clear_skill_link_damage()
end

function M.on_level_counter_add(key, add_type)
  if not SceneMgr then
    return
  end
  local scene_logic_runner = SceneMgr and SceneMgr:get_scene_logic_runner()
  if not scene_logic_runner or not scene_logic_runner.on_level_counter_add then
    return
  end
  scene_logic_runner:on_level_counter_add(key, add_type)
end

function M.on_level_counter_clear(key)
  if not SceneMgr then
    return
  end
  local scene_logic_runner = SceneMgr and SceneMgr:get_scene_logic_runner()
  if not scene_logic_runner or not scene_logic_runner.on_level_counter_clear then
    return
  end
  scene_logic_runner:on_level_counter_clear(key)
end

function M.on_scene_object_list_play(key_names)
  if not SceneMgr then
    return
  end
  SceneMgr:on_scene_object_list_play(key_names)
end

function M.on_scene_object_list_pause(key_names, is_pause)
  if not SceneMgr then
    return
  end
  SceneMgr:on_scene_object_list_pause(key_names, is_pause)
end

function M.get_monster_npc_name(npc)
  if not npc then
    return nil
  end
  return npc:get_local_name()
end

function M.get_monster_search_config(npc)
  if not npc then
    return nil
  end
  return npc:get_monster_search_config()
end

function M.set_skill_link_ui_state(stage, charge_stage)
  local fight = UIMgr:try_get_loaded_ui(UIMgr.FIGHT_UI_NAME)
  if fight then
    local ult_skill_view = fight:get_panel("ult_skill_view")
    if ult_skill_view then
      ult_skill_view:set_skill_link_ui_state(stage, charge_stage)
    end
  end
end

function M.set_link_timer_type(timer_type)
  local fight = UIMgr:try_get_loaded_ui(UIMgr.FIGHT_UI_NAME)
  if fight then
    local ult_skill_view = fight:get_panel("ult_skill_view")
    if ult_skill_view then
      ult_skill_view:set_link_timer_type(timer_type)
    end
  end
end

function M.set_link_stage_state(stage)
  local fight = UIMgr:try_get_loaded_ui(UIMgr.FIGHT_UI_NAME)
  if fight then
    local ult_skill_view = fight:get_panel("ult_skill_view")
    ult_skill_view:set_link_stage_state(stage)
  end
end

function M.change_skill_link_duration(stage, delta)
  FightDataMgr:change_skill_link_duration(stage, delta)
end

function M.change_ult_effect(npc, state)
  if check_npc(npc) then
    local fight = UIMgr:try_get_loaded_ui(UIMgr.FIGHT_UI_NAME)
    if fight then
      fight:change_ult_effect(npc.uuid, state)
    end
  end
end

function M.is_in_region(pos)
  return SceneMgr:is_in_region(pos.x, pos.z, pos.y)
end

function M.log_on_npc(npc, str, visible)
  if check_npc(npc) and Global.ui_dynamic_canvas then
    if visible then
      local ui_item = Global.ui_dynamic_canvas:get_follow_debug_info(npc)
      if ui_item then
        ui_item:set_text(str)
      end
    else
      Global.ui_dynamic_canvas:destroy_follow_debug_info(npc)
    end
  end
end

function M.set_npc_status(npc, status, status_enable)
  if not check_npc(npc) then
    return
  end
  if status == Config.NPC_STATUS_KIND.IS_GHOST then
    npc:set_is_ghost(status_enable)
  elseif status == Config.NPC_STATUS_KIND.IS_AIR then
    npc:set_is_air(status_enable)
  elseif status == Config.NPC_STATUS_KIND.GODMODE then
    npc:set_godmode(status_enable, "api")
  elseif status == Config.NPC_STATUS_KIND.IS_SUPER_GHOST then
    npc:set_is_super_ghost(status_enable)
  end
end

function M.set_tough_bar_protect_state(npc, state)
  if not check_npc(npc) then
    return
  end
  local uuid = npc.uuid
  local fight = UIMgr:try_get_loaded_ui(UIMgr.FIGHT_UI_NAME)
  if fight then
    local enemy = fight:get_panel("enemy_bar")
    enemy:set_tough_bar_protect_state(uuid, state)
  end
end

function M.set_npc_hp_bar_type(npc, bar_type)
  if not check_npc(npc) then
    return
  end
  npc:set_hp_bar_type(bar_type)
end

function M.set_all_npc_hp_visible(visible, show_hero_bar)
  if visible then
    SceneMgr:show_npc_hp_obj()
  else
    SceneMgr:hide_npc_hp_obj(nil, nil, show_hero_bar)
  end
end

function M.create_navigator_effect(name, is_open, is_continue)
  if not SceneMgr then
    return
  end
  local logic = SceneMgr:get_scene_logic()
  if not logic then
    return
  end
  if is_open then
    logic:create_navigator_effect(name, is_continue)
  else
    logic:clear_navigator_effect()
  end
end

function M.get_ability_count(genres_id)
  if not Util.is_more_than_zero(genres_id) then
    return
  end
  GenresMgr:get_ability_count(genres_id)
end

function M.recover_head_max_energy()
  local fight = UIMgr:try_get_loaded_ui(UIMgr.FIGHT_UI_NAME)
  if fight then
    local hero_head_view = fight:get_panel("hero_head_view")
    hero_head_view:recover_head_max_energy()
  end
end

function M.set_skill_ignore_expend_detect(npc, skill_id, is_ignore)
  if not check_npc(npc) then
    return
  end
  local skill = npc.skill_mgr:get_skill(skill_id)
  if skill then
    skill:set_ignore_consume_detect(is_ignore)
  end
end

function M.set_qte_effect_active(npc, effect_name, enable, priority)
  if not (check_npc(npc) and npc:is_hero()) or npc:is_die() then
    return
  end
  priority = priority or 1
  local fight = UIMgr:try_get_loaded_ui(UIMgr.FIGHT_UI_NAME)
  if fight then
    local hero_head_view = fight:get_panel("hero_head_view")
    local uuid = npc.uuid
    hero_head_view:set_qte_effect_active(uuid, priority, enable, effect_name)
  end
end

function M.get_fate_book_coin_count()
  if not BagMgr then
    return 0
  end
  return BagMgr:get_item_num(Config.CURSE_GOLD)
end

function M.change_attach_point_parent(npc, attach_point, parent_attach_point, reset_time)
  if not check_npc(npc) or not npc:is_npc() then
    return
  end
  npc:change_attach_point_parent(attach_point, parent_attach_point, reset_time)
end

function M.set_fight_ui_object_visible(object_name, visible)
  local fight = UIMgr:try_get_loaded_ui(UIMgr.FIGHT_UI_NAME)
  if fight then
    fight:set_object_visible(object_name, visible)
  end
end

function M.get_fight_ui_object_visible(object_name)
  local fight = UIMgr:try_get_loaded_ui(UIMgr.FIGHT_UI_NAME)
  if fight then
    return fight:get_object_visible(object_name)
  end
  return false
end

function M.set_npc_pretend_visible(npc, visible, x, y, z)
  if not check_npc(npc) then
    return
  end
  if visible then
    npc:set_pos(x, y, z)
  else
    npc:set_pos_by_delta(0, 1000, 0)
  end
end

function M.add_treasure_chest(id, pos_key, rotation, is_play_effect_and_audio, is_can_open, custom_event_name)
  local body = {
    id = id,
    pos_key = pos_key,
    rotation = rotation,
    is_play_effect_and_audio = is_play_effect_and_audio,
    is_can_open = is_can_open,
    custom_event_name = custom_event_name
  }
  SceneMgr:c2gs_call_scene("add_battle_episode_box", body)
end

function M.get_equation_branch_info(equation_id)
  local data = FateBookMgr and FateBookMgr:get_equation_data(equation_id)
  if data then
    local branch_id = data.branch_id
    local level = data.level
    return branch_id, level
  end
end

function M.set_show_betargeted_arrow(hero, show)
  if not check_npc(hero) or not hero:is_hero() then
    return
  end
  hero:set_show_betargeted_arrow(show)
end

function M.set_timer_pause(is_pause, ignore_notice_show)
  FightDataMgr:set_timer_pause(is_pause, ignore_notice_show)
end

function M.to_turn_over_state(npc)
  if Util.is_destroy(npc) then
    return
  end
  local behitfly = npc.state_manager:get_behitfly_state()
  if not behitfly or not behitfly:check_can_turn_over() then
    Log.Error("进入受身状态失败", npc.id, debug.traceback())
    return
  end
  npc.state_manager:to_turn_over_state()
end

function M.create_behavior_manager(file)
  if TowerMgr and not TowerMgr:get_tower() then
    return
  end
  BehaviorMgr:load_manager(file)
end

function M.get_tower_id()
  local tower = TowerMgr and TowerMgr:get_tower()
  return tower and tower:get_tower_id()
end

function M.add_sub_magic(magic_id, sub_magic_id, effect_time)
  FightDataMgr:add_sub_magic(magic_id, sub_magic_id, effect_time)
end

function M.remove_sub_magic(magic_id, sub_magic_id)
  FightDataMgr:remove_sub_magic(magic_id, sub_magic_id)
end

function M.create_nav_fight_hud()
  if not Global.ui_dynamic_canvas then
    return
  end
  return Global.ui_dynamic_canvas:get_navigation_fight_hud_item()
end

function M.release_nav_fight_hud(item)
  if not Global.ui_dynamic_canvas then
    return
  end
  Global.ui_dynamic_canvas:release_navigation_fight_hud_item(item)
end

function M.replace_ragdoll_power_profile(npc, index)
  if not check_npc(npc) then
    return
  end
  npc:replace_ragdoll_power_profile(index)
end

function M.set_localrotation_component(npc, attach_name, x, y, z, speed, no_lerp)
  local trans = npc:get_setting_point(attach_name)
  speed = speed or 1
  no_lerp = no_lerp or false
  CSHelper.SetLocalRotationComponent(trans, x, y, z, speed, no_lerp)
end

local TEMP_DIFFICULTY_MAP = "TEMP_DIFFICULTY_MAP"

function M.get_npc_difficulty_tag(npc)
  if not check_npc(npc) then
    return
  end
  local tag = npc:get_difficulty_tag()
  local map = get_behavior_scope_table(TEMP_DIFFICULTY_MAP)
  UtilTable.clear_map(map)
  if not tag then
    map[1] = 1
    return map
  end
  if 0 == tag then
    return map
  end
  for i = 0, 31 do
    local bit_mask = 1 << i
    if 0 ~= tag & bit_mask then
      map[bit_mask] = bit_mask
    end
    if tag < bit_mask then
      break
    end
  end
  return map
end

function M.transfer_missile_effect(missile, new_missile_owner)
  if not check_npc(missile) or not check_npc(new_missile_owner) then
    return
  end
  local effect_id = missile:get_missile_effect()
  if not effect_id then
    return
  end
  if new_missile_owner:get_missile_effect() then
    return
  end
  missile:set_effect_id(nil)
  new_missile_owner:set_effect_id(effect_id)
  local effect_ctl = missile:get_act_effct_ctrl()
  if not effect_ctl then
    return
  end
  local effect_info = effect_ctl:effect_break_away_old_owner(effect_id)
  if not effect_info then
    return
  end
  local new_owner_effect_ctl = new_missile_owner:get_act_effct_ctrl()
  if not new_owner_effect_ctl then
    return
  end
  local effect_trans = new_missile_owner:get_effect_trans()
  new_owner_effect_ctl:become_effect_new_owner(effect_id, effect_info, effect_trans)
end

function M.change_abnormal_flag_count(npc, element_id, change_count)
  if not check_npc(npc) or not npc:is_npc() then
    return
  end
  if not element_id or element_id <= 0 then
    return
  end
  if not change_count or 0 == change_count then
    return
  end
  npc.element_abnormal_mgr:change_abnormal_flag_count(element_id, change_count)
end

function M.get_missile_target(missile)
  if not check_npc(missile) then
    return
  end
  return missile:get_target()
end

function M.call_scene_logic_custom_event(event_name)
  BehaviorMgr:call_scene_logic_event_fun("RunFuncModule", event_name)
end

function M.func_npc_try_call_behavior_fun(npc_id, func_name, ...)
  if not M[func_name] then
    Log.Error("方法", func_name, "不存在", debug.traceback())
    return
  end
  local scene_logic = SceneMgr:get_scene_logic()
  if not scene_logic then
    return
  end
  local func_npc = scene_logic:get_func_npc(npc_id)
  if not func_npc then
    Log.Error("功能性Npc", npc_id, "不存在", debug.traceback())
    return
  end
  return M[func_name](func_npc, ...)
end

function M.play_front_qte_btn_effect()
  UIMgr:try_call_ui_func(UIMgr.FIGHT_UI_NAME, "play_button_2_down_skill_effect")
end

function M.can_change_hero_state()
  return not SceneMgr:get_change_hero_state_lock()
end

function M.get_missile_kill_role_count(npc, missile)
  if not check_npc(npc) or not check_npc(missile) then
    return 0
  end
  return missile:get_kill_role_count(npc.uuid)
end

function M.set_effect_pos_control_bind(npc, monster)
  if nil == monster or not check_npc(npc) then
    CSHelper.EffectScreenPosControlBind(nil, nil)
  else
    CSHelper.EffectScreenPosControlBind(npc.gameobj.gameObject, monster.gameobj.gameObject)
  end
end

function M.add_missile_atk_cd(missile, npc, cd)
  if not check_npc(npc) or not check_npc(missile) then
    return
  end
  missile:behavior_add_atk_cd(npc, cd)
end

function M.get_role_weapon_fashion_id(role)
  if not check_npc(role) or not role:is_role() then
    return
  end
  return role:get_weapon_fashion()
end

function M.get_role_fashion_id(role)
  if not check_npc(role) or not role:is_role() then
    return
  end
  return role:get_fashion_id()
end

function M.is_judg_missile(missile)
  if not check_npc(missile) or not missile:is_missile() then
    return false
  end
  return missile.missile_type == Config.MISSILE_TYPE.JUDG
end

function M.is_dodge_missile(missile)
  if not check_npc(missile) or not missile:is_missile() then
    return false
  end
  return missile.missile_type == Config.MISSILE_TYPE.Dodge
end

function M.set_ban_skill_to_move(role, is_ban)
  if not check_npc(role) or not role:is_role() then
    return
  end
  return role.state_manager:set_skill_to_move_enable(not is_ban)
end

function M.missile_has_hurt_magic(missile)
  if not check_npc(missile) or not missile:is_missile() then
    return false
  end
  for _, magic_id in pairs(missile.missile_cfg.magic) do
    local magic_cfg = ShareRes.get_magic_cfg(magic_id)
    local magic_type = magic_cfg and magic_cfg.logic and magic_cfg.logic.type
    if magic_type == Config.MagicDefine.MAGIC_TYPE.HurtDamage or magic_type == Config.MagicDefine.MAGIC_TYPE.SPECAIL_DMG then
      return true
    end
  end
  return false
end

function M.is_missile_target_camp(target, missile)
  if not check_npc(target) or not check_npc(missile) then
    return
  end
  return Util.is_target_camp(missile:get_owner(), target, missile.missile_cfg.TargetType)
end

function M.get_npc_time_scale(npc)
  if not check_npc(npc) or not npc:is_role() then
    return
  end
  return npc.time_mgr:get_time_scale()
end

function M.clear_hit_stop(npc)
  if not check_npc(npc) or not npc:is_role() then
    return
  end
  return npc:clear_hit_stop()
end

function M.disable_stun_anim(npc)
  if not check_npc(npc) or not npc:is_role() then
    return
  end
  return npc.state_manager:add_blocked_stun_handle()
end

function M.enable_stun_anim(npc, handler)
  if not check_npc(npc) or not npc:is_role() then
    return
  end
  return npc.state_manager:remove_blocked_stun_handle(handler)
end

function M.get_tough_record_state(npc)
  if not check_npc(npc) or not npc:is_npc() then
    return
  end
  return npc:get_tough_record_state()
end

function M.set_skill_target(npc, skill_id, target, target_pos)
  if not check_npc(npc) then
    return
  end
  if not check_npc(target) then
    target = nil
  end
  npc.skill_mgr:set_skill_target(skill_id, target, target_pos)
end

function M.get_part_npc_kind(npc)
  if not check_npc(npc) or not npc:is_npc() then
    return
  end
  return npc:get_part_type()
end

function M.get_part_npc(npc, part_id)
  if not check_npc(npc) or not npc:is_npc() then
    return
  end
  if part_id then
    local part_info = npc:get_part_info_by_id(part_id)
    if part_info.part_uuid then
      return SceneMgr:pick_by_uuid(part_info.part_uuid)
    end
  else
    local npc_list
    local all_part_info = npc:get_all_part_info()
    for _, part_info in pairs(all_part_info) do
      if part_info.part_uuid then
        npc_list = npc_list or {}
        npc_list[#npc_list + 1] = SceneMgr:pick_by_uuid(part_info.part_uuid)
      end
    end
    return npc_list
  end
end

function M.get_main_part_npc(npc)
  if not check_npc(npc) or not npc:is_npc() then
    return
  end
  local main_part_uuid = npc:get_main_part()
  if main_part_uuid then
    return SceneMgr:pick_by_uuid(main_part_uuid)
  end
end

function M.get_effect_gameobject(npc, effect_name)
  if not check_npc(npc) then
    return
  end
  return npc.act_effect_ctrl:get_effect_gameobject_by_name(effect_name)
end

function M.get_missile_owner(missile)
  if not check_npc(missile) or not missile:is_missile() then
    return
  end
  local owner = missile:get_owner()
  return not Util.is_destroy(owner) and owner or nil
end

function M.get_role_job(role)
  if not check_npc(role) or not role:is_role() then
    return
  end
  return role:get_role_job()
end

function M.decrease_closeup_camera_priority()
  if Cinemachine then
    Cinemachine:decrease_closeup_camera_priority()
  end
end

return M
