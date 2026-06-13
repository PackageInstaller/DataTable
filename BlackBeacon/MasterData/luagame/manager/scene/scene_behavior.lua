local Behavior = require("manager.fight.behavior")
local CommonDefine = require("cs_share.common_define")
local Account = require("gamelogic.account.account")
local Vec3 = require("base.vec3")
local CAMPS = Global.config.CAMPS
local RELATIONSHIP = Global.config.RELATIONSHIP
local UTIL_FUN = require("utils.util_fun")
local CICLE_FUN_TYPE = UTIL_FUN.CICLE_FUN_TYPE
local M = Util.create_class()

function M:_init()
  self.v_timers = {}
end

function M:release()
  self:remove_all_timer()
end

local function get_key()
  return tostring(Date.server_time)
end

function M:timer_call_out(key, func, sec)
  key = key or get_key()
  local timer = Timer:add_timer(key, sec, func, nil, nil, nil, true)
  self.v_timers[key] = timer
end

function M:timer_call_out_loop(key, func, sec, delaySec)
  key = key or get_key()
  if delaySec then
    self:timer_call_out(key, function()
      self:timer_call_out_loop(key, func, sec)
    end, delaySec)
  else
    local timer = Timer:add_timer(key, sec, func, nil, nil, math.maxinteger)
    self.v_timers[key] = timer
  end
end

function M:timer_call_out_remove(key)
  if key and self.v_timers[key] then
    Timer:remove_timer(self.v_timers[key])
  end
end

function M:remove_all_timer()
  for _, timer in pairs(self.v_timers) do
    Timer:remove_timer(timer)
  end
end

function M:switch_gameobject_position(src_name, target_name)
  local scene_logic = SceneMgr:get_scene_logic()
  if scene_logic then
    scene_logic:switch_gameobject_position(src_name, target_name)
  else
    Log.Error("switch_gameobject_position with no scene logic：", Account:get_account())
  end
end

function M:remove_world_model(name)
  local scene_logic = SceneMgr:get_scene_logic()
  if scene_logic then
    scene_logic:remove_world_model(name)
  else
    Log.Error("remove_world_model with no scene logic：", Account:get_account())
  end
end

function M:create_world_model_on_position(object_name, name, pos_key, offset_y, face_pos_key, arg_map)
  local scene_logic = SceneMgr:get_scene_logic()
  if scene_logic then
    local euler_y
    if face_pos_key then
      euler_y = scene_logic:get_face_euler(pos_key, face_pos_key)
    end
    scene_logic:create_world_model_on_position(object_name, name, pos_key, offset_y, nil, euler_y, arg_map)
  else
    Log.Error("create_world_model_on_position with no scene logic：", Account:get_account(), object_name)
  end
end

function M:set_scene_tips(id, is_visible, param)
  Behavior.set_scene_tips(id, is_visible, param)
end

function M:set_ui_object_visible(ui_name, object_name, is_visible)
  Behavior.set_ui_object_visible(ui_name, object_name, is_visible)
  if is_visible then
    Behavior.remove_fight_ui_to_table(ui_name, object_name)
  else
    Behavior.add_fight_ui_to_table(ui_name, object_name)
  end
end

function M:lookat_position(npc, posx, posz, force)
  if npc then
    npc:face_to_pos(posx, posz, force, true)
  else
    Log.Error("lookat_position with no scene npc：", Account:get_account())
  end
end

function M:draw_areas()
  local scene_logic = SceneMgr:get_scene_logic()
  if scene_logic then
    scene_logic:draw_areas()
  else
    Log.Error("draw_areas with no scene logic：", Account:get_account())
  end
end

function M:actvie_obstacle(key, tag, is_active)
  local scene_logic = SceneMgr:get_scene_logic()
  if scene_logic then
    scene_logic:actvie_obstacle(key, tag, is_active)
    SceneMgr:c2gs_call_scene("actvie_obstacle", key, tag, is_active)
  else
    Log.Error("actvie_obstacle with no scene logic：", Account:get_account())
  end
end

function M:actvie_collider(obj_name, is_active, block_char, block_missile)
  local scene_logic = SceneMgr:get_scene_logic()
  if scene_logic then
    scene_logic:actvie_collider(obj_name, is_active, block_char, block_missile)
  else
    Log.Error("actvie_collider with no scene logic：", Account:get_account())
  end
end

function M:set_sceneobj_visible(path, is_visible, is_save, save_type)
  if is_save then
    SceneMgr:c2gs_call_scene("save_sceneobj_visible", path, is_visible, save_type)
  end
  if SceneMgr then
    local obj = SceneMgr:get_gameobject(path)
    M:set_save_state_scene_obj_component_visible(obj, is_save)
    SceneMgr:show_gameobject(path, is_visible)
  else
    Log.Error("set_sceneobj_visible with no v_scene_mngr：", Account:get_account())
  end
end

function M:sync_save_sceneobj_visible_list(scene_obj_list)
  if not scene_obj_list then
    return
  end
  for path, info in pairs(scene_obj_list) do
    M:set_sceneobj_visible(path, info.visible, info.is_last_frame, true)
  end
end

function M:set_save_state_scene_obj_component_visible(obj, is_save_state)
  if Util.is_nil(obj) then
    return
  end
  local camera_timeline = obj:GetComponentInChildren(typeof(CS.CameraShakeTimeline))
  local timeline_track_audio = obj:GetComponentInChildren(typeof(CS.TimeLineTrackAudio))
  if not Util.is_nil(camera_timeline) then
    camera_timeline.enabled = not is_save_state
  end
  if not Util.is_nil(timeline_track_audio) then
    timeline_track_audio.enabled = not is_save_state
  end
end

function M:hide_scene_effect_status_obj(path, is_save)
  if is_save then
    SceneMgr:c2gs_call_scene("save_scene_data", "effect_status_obj", {effect_name = path})
  end
  if SceneMgr then
    SceneMgr:hide_scene_effect_status_obj(path)
  else
    Log.Error("set_sceneobj_visible with no v_scene_mngr：", Account:get_account())
  end
end

function M:remove_area(key, tag, is_save)
  local scene_logic = SceneMgr:get_scene_logic()
  if scene_logic then
    scene_logic:remove_area(key, tag)
    if is_save then
      SceneMgr:c2gs_call_scene("auto_save_scene_data", "remove_area", {key = key, tag = tag})
    end
  else
    Log.Error("remove_area with no scene logic：", Account:get_account())
  end
end

function M:set_npc_level(npc, level, is_update_attr)
  if npc then
    Behavior._set_npc_level(npc, level, is_update_attr)
  else
    Log.Error("set_npc_level with no scene npc：", Account:get_account())
  end
end

function M:cast_magic(npc, target, magic_id, level)
  if Util.is_destroy(npc) then
    Log.Error("cast_magic with no scene npc：", Account:get_account(), magic_id, debug.traceback())
    return
  end
  if Util.is_destroy(target) then
    Log.Error("cast_magic with no scene target", Account:get_account(), magic_id, debug.traceback())
    return
  end
  target.magic_mgr:add_magic(npc, magic_id, nil, nil, level)
end

function M:cast_skill(npc, target, skill_id, targetx, targetz)
  if not npc then
    Log.Error("cast_skill with no scene npc：", Account:get_account(), skill_id, debug.traceback())
    return
  end
  npc.skill_mgr:cast_skill(skill_id, target, targetx, nil, targetz)
end

function M:abort_magic_by_id(npc, magic_id)
  if not npc then
    Log.Error("abort_magic_by_id with no scene npc：", Account:get_account(), magic_id, debug.traceback())
    return
  end
  npc.magic_mgr:remove_magic_by_id(magic_id)
end

function M:create_npc(res_id, x, y, z, face_x, face_z, abs_camp, level, hp, npc_group, npc_name)
  local ext_args = {
    cur_hp = hp,
    npc_group = npc_group,
    npc_name = npc_name
  }
  SceneMgr:create_npc(res_id, x, y, z, face_x, face_z, abs_camp, level, ext_args)
end

function M:create_npc_new(res_id, x, y, z, dir, abs_camp, level, hp, npc_group, npc_name, params, magic_id, is_look_at_role, ai_group_id, ai_group, is_end_action, is_max_wave, event_key)
  local ext_args = {
    cur_hp = hp,
    npc_group = npc_group,
    npc_name = npc_name,
    params = params,
    magic_id = magic_id,
    is_look_at_role = is_look_at_role,
    ai_group_id = ai_group_id,
    ai_group = ai_group,
    is_end_action = is_end_action,
    is_max_wave = is_max_wave,
    event_key = event_key
  }
  SceneMgr:create_npc_new(res_id, x, y, z, dir, abs_camp, level, ext_args)
end

function M:create_cd_npc(res_id, x, y, z, dir, abs_camp, level, npc_name, npc_cd, hp, npc_group, ignore_lock)
  local ext_args = {
    cur_hp = hp,
    npc_group = npc_group,
    npc_name = npc_name
  }
  local npc = SceneMgr:create_npc_new(res_id, x, y, z, dir, Config.CAMPS.ENEMY, level, ext_args)
  npc.v_be_hit_cd = npc_cd
  npc:set_ignore_lock(ignore_lock)
end

function M:add_cd_pos_key_npc(camp, res_id, pos_key, offset_x, offset_z, rotation, abs_camp, level, name, cd, ignore_lock)
  local scene_map = SceneMgr:get_scene_map()
  if not scene_map then
    return
  end
  local position = scene_map:get_area_position(pos_key)
  if nil == position then
    Log.Error("添加Npc失败！当前地图没有点位" .. pos_key)
    return
  end
  return self:create_cd_npc(res_id, position.X, position.Y, position.Z, rotation, abs_camp, level, name, cd, nil, nil, ignore_lock)
end

function M:add_npc_by_pos_key_old(self_camp, res_id, pos_key, arg_npc)
  local scene_map = SceneMgr:get_scene_map()
  if not scene_map then
    return
  end
  local position = scene_map:get_area_position(pos_key)
  local vec3_pos = Vec3.New(position.X + arg_npc.offset_x, position.Y, position.Z + arg_npc.offset_z)
  local tgt_position = scene_map:get_area_position(arg_npc.tgt_pos_key)
  local vec3_target = Vec3.New(tgt_position.X + arg_npc.tgt_offset_x, 0, tgt_position.Z + arg_npc.tgt_offset_z)
  local ext_args = {
    cur_hp = arg_npc.cur_hp,
    npc_group = arg_npc.npc_group
  }
  local abs_camp = M:get_camp(self_camp, arg_npc.camp)
  SceneMgr:create_npc(res_id, vec3_pos.x, vec3_pos.y, vec3_pos.z, vec3_target.x, vec3_target.z, abs_camp, arg_npc.level, ext_args)
end

function M:add_npc(self_camp, res_id, vec3_pos, vec3_target, relationship, level, cur_hp, npc_group, magic_id)
  local exargs = {
    cur_hp = cur_hp,
    npc_group = npc_group,
    magic_id = magic_id
  }
  return SceneMgr:create_npc_old(res_id, vec3_pos, vec3_target, level, Config.get_camp(self_camp, relationship), exargs)
end

function M:add_npc_by_pos_key(self_camp, res_id, pos_key, arg_npc)
  local scene_map = SceneMgr:get_scene_map()
  if not scene_map then
    return
  end
  local born_pos = arg_npc.born_pos
  local x, y, z = 0, 0, 0
  if born_pos then
    if born_pos[1] and born_pos[2] and born_pos[3] then
      x, y, z = born_pos[1], born_pos[2], born_pos[3]
    else
      x, y, z = born_pos.x, born_pos.y, born_pos.z
    end
  else
    local position = scene_map:get_area_position(pos_key)
    if nil == position then
      Log.Error("添加Npc失败！当前地图没有点位" .. pos_key)
      return
    end
    x, y, z = position.X, position.Y, position.Z
  end
  local vec3_pos = Vec3.New(x + (arg_npc.offset_x or 0), y, z + (arg_npc.offset_z or 0))
  local ext_args = {
    uuid = arg_npc.uuid,
    cur_hp = arg_npc.cur_hp,
    npc_group = arg_npc.npc_group,
    params = arg_npc.npc_params,
    magic_id = arg_npc.magic_id,
    is_look_at_role = arg_npc.is_look_at_role,
    ai_group_id = arg_npc.ai_group_id,
    ai_group = arg_npc.ai_group,
    is_end_action = arg_npc.is_end_action,
    is_max_wave = arg_npc.is_max_wave,
    event_key = arg_npc.event_key,
    npc_name = arg_npc.npc_name,
    lock_enemy_list = arg_npc.lock_enemy_list,
    difficulty_tag = arg_npc.difficulty_tag,
    auto_level = arg_npc.auto_level
  }
  local abs_camp = M:get_camp(self_camp, arg_npc.camp)
  local npc = SceneMgr:create_npc_new(res_id, vec3_pos.x, vec3_pos.y, vec3_pos.z, arg_npc.rotation, abs_camp, arg_npc.level, ext_args)
  return npc
end

function M:add_cd_npc_by_pos_key(self_camp, res_id, pos_key, arg_npc)
  arg_npc.camp = RELATIONSHIP.OPPOSED
  local npc = self:add_npc_by_pos_key(self_camp, res_id, pos_key, arg_npc)
  if not npc then
    return
  end
  npc.v_be_hit_cd = arg_npc.npc_cd
  npc.v_npc_local_name = arg_npc.npc_name
end

function M:add_params_npc_by_pos_key(self_camp, res_id, pos_key, arg_npc)
  local npc = self:add_npc_by_pos_key(self_camp, res_id, pos_key, arg_npc)
  if not npc then
    return
  end
end

function M:get_camp(self_camp, relationship)
  local npc_camp
  if self_camp == CAMPS.FRIEND and relationship == RELATIONSHIP.SIMILAR or self_camp == CAMPS.ENEMY and relationship == RELATIONSHIP.OPPOSED then
    npc_camp = CAMPS.FRIEND
  elseif self_camp == CAMPS.FRIEND and relationship == RELATIONSHIP.OPPOSED or self_camp == CAMPS.ENEMY and relationship == RELATIONSHIP.SIMILAR then
    npc_camp = CAMPS.ENEMY
  end
  return npc_camp
end

function M:sync_scene_comm_info(npc_uuid, attr, npc_id)
  SceneMgr:set_god_npc_uuid(npc_uuid, attr, npc_id)
end

function M:remove_npc(npc)
  if not npc then
    Log.Error("尝试移除的npc不存在", Account:get_account(), debug.traceback())
    return
  end
  SceneMgr:remove_npc2(npc)
end

function M:on_npc_logic_stop(npc_uuid)
  local npc = SceneMgr:pick_by_uuid(npc_uuid)
  if not npc then
    Log.Error("remove_npc with no scene npc：", Account:get_account(), npc_uuid)
    return
  end
  npc.state_manager:stop_move()
end

function M:on_npc_logic_restart(npc_uuid)
  local npc = SceneMgr:pick_by_uuid(npc_uuid)
  if not npc then
    Log.Error("remove_npc with no scene npc：", Account:get_account(), npc_uuid)
    return
  end
  npc.state_manager:to_move_state()
end

function M:set_cam_default_angles(x, y, z, ease_in)
  Behavior.set_cam_default_angles(x, y, z, ease_in)
end

function M:set_cam_default_dist(dist)
  Behavior.set_cam_default_dist(dist)
end

function M:enter_main_scene()
  SceneMgr:on_enter_main_scene()
end

function M:enter_special_area(type)
  Global.log.Debug("enter special area ", type)
  local msg = MsgGame:mq_publish2(Const.MSG_TOG_SPECIAL_AREA)
  msg.mm_x = type
  msg.mm_y = true
end

function M:leave_special_area(type)
  local msg = MsgGame:mq_publish2(Const.MSG_TOG_SPECIAL_AREA)
  msg.mm_x = type
  msg.mm_y = false
end

function M:set_scene_camera(camera_id, not_clear_data, is_new_config, is_force_depress_cameramode, forbid_camera_blend)
  if Global.camera then
    Global.camera:set_scene_camera(camera_id, nil, true, not_clear_data, is_new_config, is_force_depress_cameramode, forbid_camera_blend)
  end
end

function M:set_cam_pinch_switch(is_open)
  if Global.camera then
    Global.camera:set_cam_pinch_switch(is_open)
  end
end

function M:enter_func_npc_area(type)
end

function M:leave_func_npc_area(type)
end

function M:add_functional_npc(npc_id, pos_key, face2_pos_key, is_get, mArgs)
  local rotation = face2_pos_key
  if type(rotation) == "string" then
    rotation = 0
  end
  local msg = MsgGame:mq_publish2(Const.MSG_CREATE_FUNCTIONAL_NPC)
  msg.mm_obj = {
    npc_id = npc_id,
    pos_key = pos_key,
    rotation = rotation,
    is_get = is_get,
    mArgs = mArgs
  }
end

function M:create_notice_obstacle_effect(pos_key, effect_name, dir, euler_y)
  local scene_logic = SceneMgr:get_scene_logic()
  if scene_logic then
    scene_logic:create_notice_obstacle_effect(pos_key, effect_name, dir, euler_y)
  end
end

function M:clear_notice_obstacle_effect(pos_key)
  local scene_logic = SceneMgr:get_scene_logic()
  if scene_logic then
    scene_logic:clear_notice_obstacle_effect(pos_key)
  end
end

function M:on_hero_room_recover(is_new_floor)
  SceneMgr:on_hero_room_recover(is_new_floor)
end

function M:tower_settle()
  if TowerMgr then
    TowerMgr:tower_settle()
  end
end

function M:quit_scene()
  local function cb()
    Global.scene_mgr:on_enter_main_scene()
  end
  
  if TowerMgr then
    TowerMgr:on_exit_tower(cb)
  end
end

function M:moveto_npc(npc, target)
  if not npc then
    Log.Error("moveto_npc with no scene npc：", Account:get_account())
    return
  end
  if not target then
    Log.Error("moveto_npc with no scene target", Account:get_account())
    return
  end
  npc.role_move_ctrl:move_to_target(target)
end

function M:move_to_pos(npc, pos)
  if not npc then
    Log.Error("move_to_pos with no scene npc：", Account:get_account())
    return
  end
  npc.role_move_ctrl:move_to_postion(pos)
end

function M:move_by_dir(npc)
  if not npc then
    Log.Error("move_by_dir with no scene npc：", Account:get_account())
    return
  end
  local vec_dir = npc:get_dir_vec()
  npc.state_manager:move_by_dir(vec_dir.x, vec_dir.z)
end

function M:switch_move_type(npc, move_type)
  if not npc then
    Log.Error("switch_move_type with no scene npc：", Account:get_account())
    return
  end
  if npc:get_move_type() ~= move_type then
    npc:update_move_type(move_type)
    npc.state_manager:update_move_type()
  end
end

function M:stop_move()
  if not Global.hero then
    Log.Error("stop_move with no scene npc：", Account:get_account())
    return
  end
  Global.hero.state_manager:stop_move()
end

function M:clear_input(keycode)
  local msg = MsgGame:mq_publish2(Const.MSG_CLEAR_INPUT_KEY)
  msg.mm_x = keycode
end

function M:on_up_skill_btn(keycode, cancle)
  local msg = MsgGame:mq_publish2(Const.MSG_ON_UP_SKILL)
  msg.mm_x = keycode
  msg.mm_y = cancle
end

function M:start_guide(guide_id)
  if GuideMgr then
    GuideMgr:enter_guide(guide_id)
  end
end

function M:finish_guide(guide_id)
  if GuideMgr then
    GuideMgr:finish_guide(guide_id)
  end
end

function M:set_time_cut_tips(tips_id, is_start)
  local msg = MsgGame:mq_publish2(Const.MSG_ON_SET_TIME_CUT_TIPS)
  msg.mm_x = tips_id
  msg.mm_y = is_start
end

function M:remove_functional_npc(npcId)
  SceneMgr:c2gs_call_scene("remove_functional_npc", npcId)
  local scene_logic = SceneMgr:get_scene_logic()
  if not scene_logic then
    return
  end
  scene_logic:remove_functional_npc(npcId)
end

function M:set_functional_npc_visible(npcId, is_visible)
  local scene_logic = SceneMgr:get_scene_logic()
  if not scene_logic then
    return
  end
  scene_logic:set_func_npc_visible(npcId, is_visible)
end

function M:set_in_challenge(is_challenge)
  local fight_ui = UIMgr:try_get_visible_ui("fight")
  if fight_ui then
    fight_ui:set_map_visible(not is_challenge)
  end
  SceneMgr:c2gs_call_scene("set_in_challenge", is_challenge)
end

function M:remove_tp(tp_name)
  local scene_logic = SceneMgr:get_scene_logic()
  if not scene_logic then
    return
  end
  scene_logic:remove_tp(tp_name)
end

function M:remove_tp_point_by_behavior_func(tp_name)
  local full_name = "tppoint" .. tp_name
  self:remove_tp(full_name)
  SceneMgr:c2gs_call_scene("remove_tp_point_by_behavior_func", tp_name)
end

function M:play_timeline(timeline_name, fade_in, fade_out, npc_id_list, can_skip, is_stop_lua, close_transparent, black_in, black_hold_time, black_out, is_show_ui, delay_destroy, before_black_in, before_hold, before_black_out, is_white)
  local data = {
    name = timeline_name,
    fade_in = fade_in,
    fade_out = fade_out,
    uuid_list = npc_id_list,
    can_skip = can_skip,
    is_active_lua = is_stop_lua,
    close_camera_transparent = close_transparent,
    black_fade_in = black_in,
    black_hold = black_hold_time,
    black_fade_out = black_out,
    is_show_ui = is_show_ui,
    before_black_fade_in = before_black_in,
    before_black_fade_out = before_hold,
    before_black_hold = before_black_out,
    is_white = is_white,
    is_delay_destroy = delay_destroy
  }
  TimeLineSeqPlayer.play_time_line_seq(data)
end

function M:play_simple_timeline(name, is_play)
  if is_play then
    SceneRoomPrefabLoader:load_prefab(name)
  else
    SceneRoomPrefabLoader:release_prefab(name)
  end
end

function M:play_video(video, is_can_skip)
  local video_data = {
    video_name = video,
    is_skip = is_can_skip,
    end_cb = function()
      SceneMgr:c2gs_call_scene("in_play_video_end", video)
      BehaviorMgr:call_scene_logic_event_fun("in_play_video_end", video)
    end
  }
  VideoMgr:on_play_video(video_data)
end

function M:stop_timeline(name)
  TimeLineSeqPlayer.stop()
end

function M:create_scene_effect(prefab_name, position, duration, obj_name)
  SceneMgr:create_scene_effect(prefab_name, position, duration, obj_name)
end

function M:remove_scene_effect(obj_name)
  SceneMgr:remove_scene_effect(obj_name)
end

function M:set_force_use_bag(can_use)
  FightBagMgr:set_force_use_bag(can_use)
end

function M:open_sync_api_id_map(api_type_tb)
  if api_type_tb[CommonDefine.SYNC_API_TYPE.on_skill_hit] then
    local tower = TowerMgr:get_tower()
    if tower then
      local room = tower:get_room()
      room:set_is_upload_skill_hit(true)
    end
  end
end

function M:set_sync_var(key, value, is_save)
  BehaviorShareMgr:set_sync_var(key, value)
  SceneMgr:c2gs_call_scene("set_sync_save_var", key, value, is_save)
end

function M:set_map_visible(visible)
  local fight_ui = UIMgr:try_get_visible_ui("fight")
  if fight_ui then
    fight_ui:set_map_visible(visible, true)
  end
end

function M:force_finish_cur_guide()
  if GuideMgr then
    GuideMgr:force_finish_cur_guide()
  end
end

function M:trigger_fight_story(story_id)
  UIMgr:get_ui("uifight_story"):ui_show(story_id)
end

function M:set_camera_focus_pos(is_clear, pos_key, speed)
  if Global.camera then
    Global.camera:set_camera_focus_pos(is_clear, pos_key, speed)
  end
end

function M:play_story(story_id, EnableBlackFade, PlayFadeInTime, PlayStayTime, PlayFadeOutTime, StopFadeInTime, StopStayTime, StopFadeOutTime, bDelayDestroy, bSkipStory, boSettleStory)
  local arg_params = {
    enable_black_fade = EnableBlackFade,
    play_fade_in_time = PlayStayTime,
    play_stay_time = PlayStayTime,
    play_fade_out_time = PlayFadeOutTime,
    stop_fade_in_time = StopFadeInTime,
    stop_stay_time = StopStayTime,
    stop_fade_out_time = StopFadeOutTime,
    is_delay_destroy = bDelayDestroy,
    no_skip_story = bSkipStory,
    is_settle_story = boSettleStory
  }
  local is_settle_story = arg_params and arg_params.is_settle_story
  if is_settle_story then
    StoryMgr:set_settle_story(story_id)
  end
  if nil == arg_params or not arg_params.enable_black_fade then
    if StoryMgr then
      StoryMgr:on_start(story_id, nil, arg_params and arg_params.is_delay_destroy, nil, arg_params and arg_params.no_skip_story, nil, arg_params and arg_params.is_settle_story)
    end
  else
    local play_fade_in_time = arg_params.play_fade_in_time or 0
    local play_stay_time = arg_params.play_stay_time or 0
    local play_fade_out_time = arg_params.play_fade_out_time or 0
    local stop_fade_in_time = arg_params.stop_fade_in_time or 0
    local stop_stay_time = arg_params.stop_stay_time or 0
    local stop_fade_out_time = arg_params.stop_fade_out_time or 0
    local stop_arg_params = {}
    stop_arg_params.stop_fade_in_time = stop_fade_in_time
    stop_arg_params.stop_stay_time = stop_stay_time
    stop_arg_params.stop_fade_out_time = stop_fade_out_time
    StoryMgr:set_story_stop_arg_params(stop_arg_params)
    if play_fade_in_time > 0 or play_fade_out_time > 0 then
      UIMgr:get_ui("ui_blackfade"):ui_show(play_fade_in_time, play_stay_time, play_fade_out_time, function()
        if StoryMgr then
          StoryMgr:on_start(story_id, nil, arg_params.is_delay_destroy, nil, arg_params.no_skip_story, nil, arg_params.is_settle_story)
        end
      end)
    elseif StoryMgr then
      StoryMgr:on_start(story_id, nil, arg_params.is_delay_destroy, nil, arg_params.no_skip_story, nil, arg_params.is_settle_story)
    end
  end
end

function M:update_plat_movement(name, is_move, anim, is_save)
  if SceneMgr then
    SceneMgr:get_plat_mgr():update_plat_movement(name, is_move, anim)
  end
  if is_save then
    SceneMgr:c2gs_call_scene("save_scene_data", "plat", {
      name = name,
      is_move = is_move,
      anim = anim
    })
  end
end

function M:update_plat_moved(name, anim)
  if SceneMgr then
    SceneMgr:get_plat_mgr():update_plat_moved(name, anim)
  end
end

function M:create_random_room_out_door(object_name, name, pos_key, offset_y, face_pos_key)
  local scene_logic = SceneMgr:get_scene_logic()
  if scene_logic then
    scene_logic:create_random_room_out_door(object_name, name, pos_key, offset_y, face_pos_key)
  else
    Log.Error("create_world_model_on_position with no scene logic：", Account:get_account(), object_name)
  end
end

function M:start_texture_guide(group_id)
  if GraphicGuideMgr then
    GraphicGuideMgr:init(group_id)
  end
end

function M:hide_task_line(is_hide)
  if not Global.hero then
    return
  end
  if is_hide then
    Global.hero:clear_navigator_effect()
  else
    Global.hero:create_navigator_effect()
  end
end

function M:set_mapview_transmit(is_can_transmit)
  TowerMgr.v_is_can_transmit = is_can_transmit
end

function M:enable_god_skill(is_enable)
  TowerMgr:enable_god_skill(is_enable)
end

function M:appoint_char_appear()
end

function M:transmit_npc(npc, target_pos_key, face_pos_key, transition)
  if not npc then
    return
  end
  npc:on_transmit_pos(target_pos_key, face_pos_key, transition)
end

function M:transmit_npc_new(npc, target_pos_key, face_angle, transition)
  if not npc then
    return
  end
  npc:on_transmit_pos_new(target_pos_key, face_angle, transition)
  if Global.camera and Global.camera:get_camera_mode() == Config.CAMERA_VIEW_TYPE.SHOULDER and npc == Global.hero and 0 == transition then
    Global.camera:set_focal_point(npc:get_pos())
    Global.camera:set_camera_to_default_pos_in_shouldermode()
  end
end

function M:switch_fight_bgm(bgm_name, volume, fadeout_time)
  if not Global.sound_mgr then
    return
  end
  Global.sound_mgr:switch_fight_bgm(bgm_name, volume, fadeout_time)
end

function M:set_source_volume(source_type, lerp_time, target_volume)
  if not Global.sound_mgr then
    return
  end
  Global.sound_mgr:set_source_volume(source_type, lerp_time, target_volume)
end

function M:play_common_sound(sound_name)
  if not Global.sound_mgr then
    return
  end
  Global.sound_mgr:play_common_sound(sound_name)
end

function M:start_play_bgm(change_time)
  if not Global.sound_mgr then
    return
  end
  Global.sound_mgr:start_play_bgm(change_time)
end

function M:stop_play_bgm(change_time)
  if not Global.sound_mgr then
    return
  end
  Global.sound_mgr:stop_play_bgm(change_time)
end

function M:switch_play_bgm(bgm_name)
  if not Global.sound_mgr then
    return
  end
  Global.sound_mgr:switch_play_bgm(bgm_name)
end

function M:start_environment_bgm(change_time)
  if not Global.sound_mgr then
    return
  end
  Global.sound_mgr:start_environment_bgm(change_time)
end

function M:stop_environment_bgm(change_time)
  if not Global.sound_mgr then
    return
  end
  Global.sound_mgr:stop_environment_bgm(change_time)
end

function M:switch_environment_bgm(change_time, bgm_name)
  if not Global.sound_mgr then
    return
  end
  Global.sound_mgr:switch_environment_bgm(change_time, bgm_name)
end

function M:play_desc_story(story_id)
  UIMgr:get_ui("desc_story"):ui_show(story_id)
end

function M:curse_time_start()
  if TowerMgr then
    local fight_info = TowerMgr:get_fight_info()
    if fight_info and fight_info.type == CommonDefine.CHALLENGE_TYPE.CURSE_CIRCLE then
      MsgGame:mq_publish2(Const.MSG_ON_CURSE_TIME_START)
    end
  end
end

function M:show_finger_scale_guide()
  if UIMgr then
    UIMgr:get_ui("ui_finger_guide"):ui_show()
  end
end

function M:cancel_footmark()
  if not TowerMgr then
    return
  end
  local room = TowerMgr:get_cur_room()
  if not room then
    return
  end
  room:cancel_footmark()
end

function M:hide_npc(npc)
  if nil ~= npc then
    npc:set_obj_enable(false)
  end
end

function M:show_npc(npc)
  if nil ~= npc then
    npc:set_obj_enable(true)
  end
end

function M:set_npc_mesh_enable(npc, enable)
  if nil ~= npc then
    npc:set_mesh_enable(enable)
  end
end

function M:stop_story()
  if StoryMgr then
    StoryMgr:stop_story()
  end
end

function M:start_count_down(add_time)
  local end_time = Date.server_time() + add_time
  SceneMgr:c2gs_call_scene("start_count_down", end_time)
  GeCaoBattleMgr:count_down_start(end_time)
end

function M:start_fight_timer(use_time)
  FightDataMgr:start_fight_timer(use_time)
  GeCaoBattleMgr:start_timer(use_time)
  SceneMgr:c2gs_call_scene("check_timing_start_time", Date.server_time())
end

function M:stop_fight_timer()
  FightDataMgr:stop_fight_timer()
  GeCaoBattleMgr:stop_timer()
end

function M:monster_event_max_wave(num)
  GeCaoBattleMgr:refresh_total_wave(num)
end

function M:update_monster_event_wave(num, ui_style_type)
  ui_style_type = ui_style_type or 0
  SceneMgr:c2gs_call_scene("update_monster_event_wave", num)
  if 1 == ui_style_type then
    local fight_info = TowerMgr:get_fight_info()
    if fight_info and fight_info.type ~= CommonDefine.CHALLENGE_TYPE.WEEK_ACTY_PVP_EPI then
      GeCaoBattleMgr:refresh_right_wave(num)
    end
    WeeklyMgr:set_weekly_fight_wave_num(num)
  else
    GeCaoBattleMgr:refresh_current_wave(num)
  end
end

function M:add_text_collection(id)
  UIMgr:get_ui("collection_tip"):ui_show(id)
end

function M:update_functional_npc_data(npc_id, pos_key, face2_pos_key, is_get, mArgs)
  local scene_logic = SceneMgr:get_scene_logic()
  if scene_logic then
    scene_logic:update_functional_npc_data(npc_id, pos_key, face2_pos_key, is_get, mArgs)
  else
    Log.Error("update_functional_npc_data with no scene logic：", Account:get_account())
  end
end

function M:update_functional_npc_interaction_status(npc_id, is_get)
  local scene_logic = SceneMgr:get_scene_logic()
  if scene_logic then
    scene_logic:update_functional_npc_interaction_status(npc_id, is_get)
  else
    Log.Error("update_functional_npc_status with no scene logic：", Account:get_account())
  end
end

function M:play_reversible_scene_timeline(path, plat_names, rewind_time, is_save)
  local logic = SceneMgr:get_scene_logic()
  if not logic then
    return
  end
  logic:play_scene_time_line_back_foward(path, rewind_time)
  if plat_names then
    local split = Util.split_str(plat_names, ",")
    for _, name in pairs(split) do
      SceneMgr:get_plat_mgr():set_is_moving(name)
    end
  end
  if is_save then
    SceneMgr:c2gs_call_scene("play_reversible_scene_timeline", path, plat_names, rewind_time)
  end
end

function M:play_scene_timeline(path, plat_list)
  if not SceneMgr then
    return
  end
  local logic = SceneMgr:get_scene_logic()
  if not logic then
    return
  end
  logic:play_scene_timeline(path)
  if not plat_list or 0 == #plat_list then
    return
  end
  for i, plat_name in pairs(plat_list) do
    local split = Util.split_str(plat_name, ",")
    for _, name in pairs(split) do
      SceneMgr:get_plat_mgr():set_is_moving(name)
    end
  end
end

function M:tp_revive_room(pos_key, archive_num, is_back_scene)
  SceneMgr:set_archive_num(archive_num)
  SceneMgr:c2gs_call_scene("tp_revive_room", pos_key, archive_num, is_back_scene)
end

function M:set_player_control_on()
  SceneMgr:set_player_control_on()
  local fight_ui = UIMgr:try_get_loaded_ui("fight")
  if fight_ui then
    fight_ui:set_main_interactable(true)
  end
end

function M:set_player_control_off()
  SceneMgr:set_player_control_off()
  local fight_ui = UIMgr:try_get_loaded_ui("fight")
  if fight_ui then
    fight_ui:set_main_interactable(false)
  end
end

function M:black_fade_anim(fade_in_time, hold_time, fade_out_time, is_white)
  UIMgr:get_ui("ui_blackfade"):ui_show(fade_in_time, hold_time, fade_out_time, nil, nil, is_white)
end

function M:set_camera_focus(name, is_open, camera_style, duration, stop_lua_script, hide_ui, has_ots, ots_camera_style, ots_duration, back_to_default)
  if false == is_open then
    M:set_camera_no_focus(back_to_default)
    return
  end
  local npc = self:get_npc_by_name(name)
  local pos
  if not npc then
    local scene_map = SceneMgr:get_scene_map()
    if not scene_map then
      return
    end
    local target_pos = scene_map:get_area_position(name)
    pos = Vec3.New(target_pos.X, target_pos.Y, target_pos.Z)
  end
  local temp_table = SceneMgr:get_camera_focus_params()
  local param = {
    temp_table[1],
    temp_table[2],
    temp_table[3],
    temp_table[4],
    temp_table[5],
    nil,
    npc,
    pos,
    camera_style
  }
  if not pos and not npc then
    Log.Error("找不到命名为", name, "的点位或npc")
    return
  end
  if Global.camera then
    local camera_view_type = Global.camera:get_camera_mode()
    local temp_duration = duration
    if camera_view_type == Config.CAMERA_VIEW_TYPE.SHOULDER and has_ots then
      param[9] = ots_camera_style
      temp_duration = ots_duration
    end
    Global.camera:change_follow_target2(3, param)
    if temp_duration and temp_duration > 0 then
      if stop_lua_script then
        Global.is_cg_active_lua = false
      end
      if hide_ui then
        self:set_ui_object_visible("fight", "Main", false)
      end
      self:timer_call_out("hide_camera_focus", function()
        M:set_camera_no_focus(back_to_default)
        if stop_lua_script then
          Global.is_cg_active_lua = true
        end
        if hide_ui then
          self:set_ui_object_visible("fight", "Main", true)
        end
      end, temp_duration)
    end
  end
end

function M:set_camera_no_focus(back_to_default)
  if Global.camera then
    local type = back_to_default and 4 or 0
    Global.camera:change_follow_target2(type)
  end
end

function M:set_battle_task_show_state(is_visible, valid_in_tower)
  local fight_ui = UIMgr:try_get_visible_ui("fight")
  if fight_ui then
    local tower = TowerMgr and TowerMgr:get_tower()
    if tower then
      tower:set_is_show_battle_task(is_visible, valid_in_tower)
    end
    fight_ui:update_battle_task_visible(is_visible)
  end
end

function M:destroy_unit_group(group_id)
  if not SceneMgr then
    return
  end
  SceneMgr:remove_npc_npc_by_group_id(group_id)
end

function M:start_ct_timer(seconds, text, event_name)
  local end_time = Date.server_time() + seconds
  SceneMgr:c2gs_call_scene("start_ct_timer", end_time, Date.server_time())
  UIMgr:get_ui("ui_ct_timer"):ui_show(seconds, text, event_name)
end

function M:hide_ct_timer()
  UIMgr:try_hide_ui("ui_ct_timer")
end

function M:kill_all_monster()
  if not SceneMgr then
    return
  end
  SceneMgr:get_scene_logic():remove_all_monster_silently()
end

function M:create_navigator_effect(name, is_open, is_continue)
  if not SceneMgr then
    return
  end
  if false == is_open then
    M:clear_navigator_effect()
    return
  end
  local logic = SceneMgr:get_scene_logic()
  logic:create_navigator_effect(name, is_continue)
end

function M:clear_navigator_effect()
  if not SceneMgr then
    return
  end
  local logic = SceneMgr:get_scene_logic()
  logic:clear_navigator_effect()
end

function M:hide_tp_point_effect(tp_dir)
  if not SceneMgr then
    return
  end
  local logic = SceneMgr:get_scene_logic()
  logic:hide_tp_point_effect(tp_dir)
end

function M:show_tp_point_effect(tp_dir)
  if not SceneMgr then
    return
  end
  local logic = SceneMgr:get_scene_logic()
  logic:show_tp_point_effect(tp_dir)
end

function M:set_empty_wall_visible(tag, is_visible)
  local scene_map = SceneMgr:get_scene_map()
  if not scene_map then
    return
  end
  scene_map:set_empty_wall_visible(tag, is_visible)
  scene_map:set_empty_wall_group_visible(tag, is_visible)
end

function M:close_fight_air_wave_group(group_id)
  local scene_map = SceneMgr:get_scene_map()
  if not scene_map then
    return
  end
  scene_map:set_empty_wall_group_visible(group_id, false)
end

function M:open_fight_air_wave_group(group_id)
  local scene_map = SceneMgr:get_scene_map()
  if not scene_map then
    return
  end
  scene_map:set_empty_wall_group_visible(group_id, true)
end

function M:set_cd_npc_can_hit(npc_name, cant_be_hit)
  local npc = self:get_npc_by_name(npc_name)
  if not npc then
    Log.Error("找不到cdnpc:", npc_name)
    return
  end
  SceneMgr:c2gs_call_scene("set_cd_npc_can_hit", npc_name, cant_be_hit)
  local collider = npc:get_collider()
  npc:hide_invalid_collider()
  if not collider then
    self:timer_call_out("set_npc_hit_state" .. npc_name .. tostring(cant_be_hit), function()
      collider = npc:get_collider()
      npc:set_can_searched(not cant_be_hit)
      npc:set_cant_be_hit(cant_be_hit)
      if collider then
        collider.enabled = not cant_be_hit
      end
    end, 0.2)
  else
    npc:set_can_searched(not cant_be_hit)
    npc:set_cant_be_hit(cant_be_hit)
    collider.enabled = not cant_be_hit
  end
end

function M:set_room_collider_visible(index, is_visible, room_collider_name)
  local CSSceneIllumination = CS.SceneIllumination
  CSSceneIllumination.SetRoomColliderVisible(index, is_visible, room_collider_name)
end

function M:show_tips(is_open, duration, tips)
  local ui_fight = UIMgr:try_get_ui("fight")
  if not ui_fight then
    return
  end
  if not is_open then
    ui_fight:hide_dbm_with_banner()
    return
  end
  ui_fight:show_dbm_with_banner(tips, duration, 1)
end

function M:set_scene_obj_state(contanier_name, name_list, state_list, save_type)
  if not name_list then
    return
  end
  if not state_list then
    return
  end
  local scene_logic = SceneMgr:get_scene_logic()
  scene_logic:set_scene_obj_state(contanier_name, name_list, state_list)
  SceneMgr:c2gs_call_scene("set_scene_obj_state", name_list, state_list, save_type, contanier_name)
end

function M:set_navigator_state(state_info_list)
  if not state_info_list then
    return
  end
  if not SceneMgr or not SceneMgr:get_hero_list() then
    return
  end
  local hero_list = SceneMgr:get_hero_list()
  for key, hero in pairs(hero_list) do
    if not Util.is_destroy(hero) then
      hero:change_navi_arrows_info(state_info_list)
    end
  end
end

function M:change_functional_npc_action(npc_id, action_name)
  if FunctionalNpcMgr then
    FunctionalNpcMgr:change_functional_npc_action(npc_id, action_name)
  end
end

function M:set_fog_intensity(intensity)
  local scene_logic = SceneMgr:get_scene_logic()
  scene_logic:set_fog_intensity(intensity)
end

function M:set_fog_start_height(start_height)
  local scene_logic = SceneMgr:get_scene_logic()
  scene_logic:set_fog_start_height(start_height)
end

function M:set_fog_start_distance(start_distance)
  local scene_logic = SceneMgr:get_scene_logic()
  scene_logic:set_fog_start_distance(start_distance)
end

function M:switch_bgm_block(sound_name, block_num)
  if not Global.sound_mgr then
    return
  end
  Global.sound_mgr:switch_block(sound_name, block_num)
end

function M:add_scene_npc(obj_name, level_obj_name, npcid, status, abs_camp, level, penetrable)
  local uuid = SceneMgr:get_uuid()
  SceneMgr:add_scene_npc(level_obj_name, obj_name, npcid, abs_camp, level, status, penetrable, uuid)
end

function M:cast_custom_event_magic(uuid, event_type, arg)
  local ext_args = {
    arg = {type = event_type, arg = arg}
  }
  local hero = SceneMgr:get_hero_by_uuid(uuid)
  if hero then
    hero.magic_mgr:add_magic(hero, Config.CUSTOM_MAGIC, nil, nil, 1, nil, ext_args)
  end
end

function M:open_progress_display(init_value, curr_room__final_value, all_room_final_value, up_speed, is_need_anim, up_interval, ui_style_index)
  if not Global.ui_dynamic_canvas then
    return
  end
  Global.ui_dynamic_canvas:on_progress_display_open(init_value, curr_room__final_value, all_room_final_value, up_speed, is_need_anim, up_interval, ui_style_index)
end

function M:close_progress_display(is_need_anim)
  if not Global.ui_dynamic_canvas then
    return
  end
  Global.ui_dynamic_canvas:on_progress_display_close(is_need_anim)
end

function M:update_progress_display(up_value)
  if not Global.ui_dynamic_canvas then
    return
  end
  Global.ui_dynamic_canvas:on_progress_display_update(up_value)
end

function M:relive_hero_uuid(relive_uuid_list, remain_hp_percent)
  Global.log.Debug("reborn all ok")
  if TowerMgr then
    local tower = TowerMgr:get_tower()
    if tower then
      local relive_hero
      local reduce_per = remain_hp_percent - Config.RATIO_TO_NUM
      local CommDefine = Config.CommonDefine
      for key, relive_uuid in pairs(relive_uuid_list) do
        tower:reborn_hero_by_uuid(relive_uuid)
        relive_hero = SceneMgr:get_hero_by_uuid(relive_uuid)
        if relive_hero then
          relive_hero.attr_mgr:set_cur_attr(Config.ATTR_GROUP_TYPE.BASE, Config.CHAR_ATTR_TYPE.CHAR_HP, reduce_per, CommDefine.VALUE_TYPE.RATIO, Config.ATTR_SET_TYPE.CHANGE_BY_DELTA)
        end
      end
      MsgGame:mq_publish2(Const.MSG_ON_ALL_HERO_REBORN_END)
    end
  end
end

function M:set_camera_far_clip_plane(value)
  if Global.camera then
    Global.camera:set_camera_far_clip(value)
  end
end

function M:set_camera_far_clip_plane_default()
  if Global.camera then
    Global.camera:reset_camera_far_clip()
  end
end

function M:lock_camera_mode(value)
  if Global.camera then
    Global.camera:lock_camera_mode(value)
  end
end

function M:StartFightTiming()
  SceneMgr:c2gs_call_scene("start_fight_time", Date.server_time())
end

function M:StopFightTiming(is_force)
  SceneMgr:c2gs_call_scene("stop_fight_time", Date.server_time(), FightDataMgr:get_use_time())
  FightDataMgr:stop_fight_timer()
  GeCaoBattleMgr:stop_timer(is_force)
  MineSweeperBattleMgr:stop_timer()
end

function M:set_god_skill_level(level, is_tower_valid)
  SceneMgr:c2gs_call_scene("set_god_skill_level", level, is_tower_valid)
end

function M:add_god_skill_level(level, is_tower_valid)
  SceneMgr:c2gs_call_scene("add_god_skill_level", level, is_tower_valid)
end

function M:broadcast_monster_count(statistics_index, statistics_type, manual_count, finish_not_add, change_room_reset, kill_monster_reach_event_name, unit_id_str)
  if 1 == statistics_index and 0 ~= manual_count then
    self.m_nMonsterCount = manual_count
  end
  self:refresh_need_statistics_npc_id_map(nil)
  if unit_id_str and "" ~= unit_id_str and self.m_statistics_monster_info then
    local strs = Util.split_str(unit_id_str, ",")
    local count = 0
    local need_statistics_npc_id_map = {}
    for i = 1, #strs do
      local unit_id = tonumber(strs[i])
      local unit_count = self.m_statistics_monster_info[unit_id]
      if unit_count then
        count = count + unit_count
      end
      need_statistics_npc_id_map[unit_id] = 1
    end
    if count > 0 then
      self.m_nMonsterCount = count
      self:refresh_need_statistics_npc_id_map(need_statistics_npc_id_map)
    end
  end
  GeCaoBattleMgr:refresh_right_wave(self.m_nMonsterCount, 1)
  GeCaoBattleMgr:refresh_statistics_monster_info(statistics_type, finish_not_add, change_room_reset, kill_monster_reach_event_name)
end

function M:hide_broadcast_monster_count()
  self:StopFightTiming(true)
end

function M:set_scene_timeline_speed(timeline_obj_path, speed)
  Behavior.set_scene_timeline_speed(timeline_obj_path, speed)
end

function M:set_scene_plat_speed(plat_name, speed, anim_name, is_move)
  Behavior.set_scene_plat_speed(plat_name, speed, anim_name, is_move)
end

function M:judge_all_tp(area)
  if string.sub(area.Key, 1, 2) ~= "tp" then
    return
  end
  SceneMgr:c2gs_call_scene("judge_tp", area.Key)
end

function M:end_perform()
  self:cast_magic(Global.hero, Global.hero, 1999132, 999)
  self:cast_magic(Global.hero, Global.hero, 1999133, 999)
  self:cast_magic(Global.hero, Global.hero, 1999172, 999)
end

local HERO_NPC_NAME = "Hero"
local GOD_NPC_NAME = "God"

function M:get_npc_by_name(name)
  if name == HERO_NPC_NAME then
    return Global.hero
  elseif name == GOD_NPC_NAME then
    return SceneMgr:get_god_npc()
  end
  local npc = SceneMgr:get_npc_by_name(name)
  if not npc then
    local hero_buddy_id = tonumber(name)
    if hero_buddy_id and hero_buddy_id > 0 then
      npc = SceneMgr:get_hero_by_id(hero_buddy_id)
    end
  end
  return npc
end

function M:hero_go_out(nSlot, boGoOut, SavePos)
  if not Util.is_more_than_zero(SavePos) then
    SavePos = nil
  end
  SceneMgr:c2gs_call_scene("hero_go_out", nSlot, boGoOut, SavePos)
end

function M:get_scene_map_pos_postion(pos_key)
  local scene_logic = SceneMgr:get_scene_logic()
  local x, _, z = scene_logic:get_pos_key_position(pos_key)
  return x, z
end

function M:new_lookat_point(point_name)
  local x, y = self:get_scene_map_pos_postion(point_name)
  self:lookat_position(Global.hero, x, y, true)
  if Global.camera and Global.camera:get_camera_mode() == Config.CAMERA_VIEW_TYPE.SHOULDER then
    Global.camera:set_camera_to_default_pos_in_shouldermode()
  end
end

function M:is_pass_room()
  local tower = TowerMgr and TowerMgr:get_tower()
  if not tower then
    return false
  end
  return tower:is_pass_room()
end

function M:set_route_status(roomNum, targetRoomNum, isOpen)
  SceneMgr:c2gs_call_scene("set_route_status", roomNum, targetRoomNum, isOpen)
end

function M:add_functional_npc(npc_type, pos_key, face2_pos_key, args_map)
  SceneMgr:c2gs_call_scene("add_functional_npc", npc_type, pos_key, face2_pos_key, args_map)
end

function M:add_functional_npc_new(npc_id, pos_key, face2_pos_key, name)
  SceneMgr:c2gs_call_scene("add_functional_npc_new", npc_id, pos_key, face2_pos_key, name)
end

function M:add_exhibition_functional_npc(npc_id, pos_key, face2_pos_key, name, cfg, is_remove, event_name)
  SceneMgr:c2gs_call_scene("add_exhibition_functional_npc", npc_id, pos_key, face2_pos_key, name, cfg, is_remove, event_name)
end

function M:accept_task_group(task_group_id)
  SceneMgr:c2gs_call_scene("accept_task_group", task_group_id)
end

function M:complete_task(task_id)
  SceneMgr:c2gs_call_scene("complete_task", task_id)
end

function M:battle_condition_update(condId, condValue)
  SceneMgr:c2gs_call_scene("battle_condition_update", condId, condValue)
end

function M:enable_god_skill(is_enable)
  SceneMgr:c2gs_call_scene("enable_god_skill", is_enable)
end

function M:set_mapview_transmit(is_open)
  SceneMgr:c2gs_call_scene("set_mapview_transmit", is_open)
end

function M:change_appoint_char(hero_id)
  SceneMgr:c2gs_call_scene("change_appoint_char", hero_id)
end

function M:skip_finish_anim(status)
  SceneMgr:c2gs_call_scene("skip_finish_anim", status)
end

function M:open_all_transmit(transmit_type, sTpName)
  SceneMgr:c2gs_call_scene("open_all_transmit", transmit_type, sTpName)
end

function M:remove_all_transmit()
  SceneMgr:c2gs_call_scene("remove_all_transmit")
end

function M:open_floor_reset_timer(nTime)
  assert(nil, "客户端暂未实现此api")
end

function M:close_floor_reset_timer()
  assert(nil, "客户端暂未实现此api")
end

function M:open_appoint_tp_dir(nDir, sName)
  SceneMgr:c2gs_call_scene("open_appoint_tp_dir", nDir, sName)
end

function M:set_func_npc_interact_state(nNpcId, bState)
  SceneMgr:c2gs_call_scene("set_func_npc_interact_state", nNpcId, bState)
end

function M:remove_exhibition_npc(sNpcName)
  SceneMgr:c2gs_call_scene("remove_exhibition_npc", sNpcName)
end

function M:create_scene_npc(configs)
  if not configs then
    return
  end
  for _, config in ipairs(configs) do
    SceneMgr:c2gs_call_scene("creat_scene_npc", config)
  end
end

local function get_tower_drop_cfg()
  local progress = TowerMgr and TowerMgr:get_tower_progress()
  if not progress then
    return
  end
  local tower_id = progress.tower_id
  if progress.challenge_type == CommonDefine.CHALLENGE_TYPE.ACTIVITY_MINESWEEPER then
    local minesweeper_chapter_info = MineSweeperMgr:get_minesweeper_chapter_info()
    local chapter_id = minesweeper_chapter_info.chapter_id
    local floor_idx = minesweeper_chapter_info.floor_idx
    local cfg = ShareRes.get_minesweeper_floor_monster_level_cfg(chapter_id, floor_idx, tower_id)
    return cfg
  elseif tower_id then
    local tower_drop_cfgs = ShareRes.get_tower_drop_cfg(tower_id)
    if not tower_drop_cfgs then
      return
    end
    local floorNum = progress.floor_id
    for _, v in ipairs(tower_drop_cfgs) do
      if floorNum >= v.FloorNum then
        return v
      end
    end
  end
end

function M:get_tower_monster_level(sKey)
  local cfg = get_tower_drop_cfg()
  if not cfg or not cfg[sKey] then
    return 0
  end
  return cfg[sKey]
end

function M:play_barrage(story_id, play_type, alpha, speed)
  if StoryMgr then
    StoryMgr:play_barrage(story_id, play_type, alpha, speed)
  end
end

function M:stop_barrage()
  if StoryMgr then
    StoryMgr:stop_barrage()
  end
end

function M:on_scene_object_list_play(key_names)
  if not SceneMgr then
    return
  end
  SceneMgr:on_scene_object_list_play(key_names)
end

function M:on_scene_object_list_pause(key_names, is_pause)
  if not SceneMgr then
    return
  end
  SceneMgr:on_scene_object_list_pause(key_names, is_pause)
end

function M:set_fight_timer_ui_enable(enable)
  FightDataMgr:set_fight_timer_ui_enable(enable)
end

function M:show_finger_drag_guide(custom_event_name)
  if UIMgr then
    UIMgr:get_ui("ui_finger_guide"):ui_show(CommonDefine.SHOW_FINGER_GUIDE_TYPE.LeftRightDrag, custom_event_name)
  end
end

function M:add_treasure_chest(id, pos_key, rotation, is_play_effect_and_audio, is_can_open, custom_event_name)
  Behavior.add_treasure_chest(id, pos_key, rotation, is_play_effect_and_audio, is_can_open, custom_event_name)
end

function M:set_treasure_chest_state(id, is_can_open)
  local body = {id = id, is_can_open = is_can_open}
  SceneMgr:c2gs_call_scene("change_battle_episode_box_status", body)
end

function M:add_task_progress(id, value)
  Behavior.add_task_progress(id, value)
end

function M:set_sound_reverb_val(bus_name, bus_level)
  if Global.sound_mgr then
    Global.sound_mgr:set_sound_reverb_val(bus_name, bus_level)
  end
end

function M:show_egg_tips(egg_id)
  UIMgr:try_show_ui("egg_tips", nil, egg_id)
end

function M:revive_all_hero()
  local death_event_type = BehaviorShareMgr:get_sync_var("death_event_type")
  if not death_event_type then
    return
  end
  local scene_rpc = SceneMgr:get_scene_rpc()
  if not scene_rpc then
    return
  end
  local hero_list = SceneMgr:get_hero_list()
  if not hero_list then
    return
  end
  BehaviorShareMgr:set_sync_var("death_event_type", nil)
  SceneMgr:c2gs_call_scene("revive_all_hero", death_event_type)
  local uuid_list = {}
  for uuid in pairs(hero_list) do
    uuid_list[#uuid_list + 1] = uuid
  end
  scene_rpc:relive_hero_uuid(uuid_list)
end

function M:switch_the_atmosphere(index)
  local scene_effect_obj = UnityFind("SceneEffect")
  if not scene_effect_obj then
    return
  end
  local scene_illumination = scene_effect_obj:GetComponent(typeof(CS.SceneIllumination))
  scene_illumination.curLightDataIndex = index
  scene_illumination:ApplySceneEffect()
  Global.scene_mgr:_init_diff_light(index)
end

function M:open_mini_game(game_type, game_id)
  local function finish_cb()
    BehaviorMgr:call_scene_logic_event_fun("on_mini_game_finish", game_type, game_id)
  end
  
  if game_type == Config.MINI_GAME_TYPE.WATER_PIPE then
    if game_id and 0 ~= game_id then
      local game_cfg = ShareRes.create("minigame.waterpipe." .. game_id)
      if 2 == game_cfg.uiType then
        UIMgr:get_ui("ui_water_pipe_sp"):ui_show(game_id, finish_cb)
      else
        UIMgr:get_ui("ui_water_pipe"):ui_show(game_id, finish_cb)
      end
    end
  elseif game_type == Config.MINI_GAME_TYPE.INSERT_NEEDLE then
    UIMgr:get_ui("mini_game_insert_needle"):ui_show(game_id, finish_cb)
  end
end

function M:show_skill_combo_tips(skill_id_list, visible)
  UIMgr:get_ui("skill_teach_tips"):ui_show(skill_id_list)
end

function M:add_spawner_behavior(config)
  local scene_logic = SceneMgr:get_scene_logic()
  if scene_logic then
    local logic_runner = scene_logic:get_scene_logic_runner()
    if logic_runner then
      logic_runner:add_spawner_behavior(config)
    end
  end
end

function M:open_capture_system(config)
  CaptureMgr:open_capture_system(config.CfgId)
end

function M:close_capture_system(config)
  CaptureMgr:close_capture_system()
end

function M:set_visual_prefabs_visible(config)
  VisualGameManager:set_visual_prefabs_visible(config.Visible)
end

return M
