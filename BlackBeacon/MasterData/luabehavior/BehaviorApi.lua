do return end
Util = {
  create_child_mt = function(table)
  end,
  create_class = function()
  end
}
Const = require("common.lua_behavior_const")
ComnMgr = require("common.common_manager")
mathx = require("base.mathx")
vec3 = require("base.vec3")
local behavior = {}

function behavior.on_start(behavior)
end

function behavior.on_remove(behavior)
end

function behavior.on_frame(behavior, dt)
end

function behavior.on_frame_background(behavior, dt)
end

function behavior.on_frame_ground(behavior, dt)
end

function behavior.on_input(behavior, input_id)
end

function behavior.on_touch_up(behavior, output_id, iscancle, input_time, source_type)
end

function behavior.on_skill_begin(behavior, npc, skill_id, skill_type, skill_cfg)
end

function behavior.on_self_skill_begin(behavior, skill_id, skill_type, skill_cfg)
end

function behavior.on_skill_before_time(behavior, skill_id)
end

function behavior.on_skill_cast_time(behavior, skill_id)
end

function behavior.on_keyframe_action(behavior, kfId, npcTag, comnTag)
end

function behavior.on_skill_hit(behavior, caster, skillId, hitTarget, hitType, missileCfg, missile, partNpc)
end

function behavior.on_self_skill_hit(behavior, skillId, hitTarget, hitType, missileCfg, missile, partNpc)
end

function behavior.on_skill_hit(behavior, caster, skillId, hitType, missileCfg, missile, partNpc)
end

function behavior.on_before_skill_end(behavior, npc, skill_id, is_time_out, is_break, behavior_abort)
end

function behavior.on_self_before_skill_end(behavior, skill_id, is_time_out, is_break, behavior_abort)
end

function behavior.on_skill_end(behavior, npc, skill_id, is_time_out, is_break, behavior_abort)
end

function behavior.on_self_skill_end(behavior, skill_id, is_time_out, is_break, behavior_abort)
end

function behavior.on_skill_break(behavior, npc, skill_id)
end

function behavior.on_missile_collide(behavior, m2_owner, m1_owner, m2, m1, m2_cfg, m1_cfg)
end

function behavior.on_self_missile_collide(behavior, m2_owner, m1, m2, m1_cfg, m2_cfg)
end

function behavior.on_npc_removed(behavior, npc, skill_id)
end

function behavior.on_before_npc_hp_zero(behavior, npc, attacker, magic_id, missile_id, missile)
end

function behavior.on_self_before_npc_hp_zero(behavior, attacker, magic_id, missile_id, missile)
end

function behavior.on_npc_hp_zero(behavior, npc, attacker, magic_id, missile_id, missile)
end

function behavior.on_self_npc_hp_zero(behavior, attacker, magic_id, missile_id, missile)
end

function behavior.on_hero_showup_or_back(behavior, npc, is_showup, by_ult_change)
end

function behavior.on_camera_operation(behavior, type, time)
end

function behavior.on_skill_shift_pause(behavior, keyframe_id, is_stop)
end

function behavior.before_damage(behavior, caster, target, magic_id, damage_sign, damage_type, camp, change_tough, magic_level, skillId, missile)
end

function behavior.before_damage_self(behavior, caster, magic_id, damage_sign, damage_type, camp, change_tough, magic_level, skillId, missile)
end

function behavior.before_damage_target(behavior, target, magic_id, damage_sign, damage_type, camp, change_tough, magic_level, skillId, missile)
end

function behavior.after_damage(behavior, caster, target, magic_id, damage_sign, damage_type, is_crit, damage_val, base_dmg, element_dmg, skillId, missile)
end

function behavior.after_damage_target(behavior, target, magic_id, damage_sign, damage_type, is_crit, damage_val, base_dmg, element_dmg, skillId, missile)
end

function behavior.after_damage_self(behavior, caster, magic_id, damage_sign, damage_type, is_crit, damage_val, base_dmg, element_dmg, skillId, missile)
end

function behavior.on_role_behit_state_change(role, state)
end

function behavior.before_abnormal_damage(behavior, caster, attacker, npc, magic_id)
end

function behavior.after_abnormal_damage(behavior, caster, attacker, npc, magic_id)
end

function behavior.on_critical(behavior, npc, target, magic_cfg, magic_id)
end

function behavior.before_heal(behavior, npc, target, magic_id)
end

function behavior.after_heal(behavior, npc, target, magic_id, heal_val)
end

function behavior.on_room_change(behavior, npc)
end

function behavior.on_floor_start(behavior, npc1, npc2, npc3, level)
end

function behavior.on_floor_finished(behavior, npc1, npc2, npc3, level)
end

function behavior.on_round_finished(behavior, npc1, npc2, npc3, round)
end

function behavior.on_hero_reborn(behavior, reborned_hero)
end

function behavior.on_scene_change(behavior)
end

function behavior.reset_on_enter_scene()
end

function behavior.on_part_hit(behavior, npc, target, part_id)
end

function behavior.on_part_damage(behavior, npc, target, part_id, cur_hp, is_crit, damage_val, magic_id)
end

function behavior.on_born_behavior(behavior)
end

function behavior.on_born_behavior(behavior)
end

function behavior.on_npc_beattack_collider(behavior, npc, hero, collider_npc, hit_wall_cfg)
end

function behavior.on_get_battle_skill(behavior, npc, magic_id)
end

function behavior.effect_aborn_magic(behavior, npc, target, element)
end

function behavior.on_magic_begin(behavior, npc, target, magic_id, magic_level, magic_kind, magic_type)
end

function behavior.on_self_magic_begin(behavior, target, magic_id, magic_level, magic_kind, magic_type)
end

function behavior.on_target_self_magic_begin(behavior, npc, magic_id, magic_level, magic_kind, magic_type)
end

function behavior.on_magic_end(behavior, npc, target, magic_id, magic_kind, magic_type, is_break)
end

function behavior.on_self_magic_end(behavior, target, magic_id, magic_kind, magic_type, is_break)
end

function behavior.on_target_self_magic_end(behavior, npc, magic_id, magic_kind, magic_type, is_break)
end

function behavior.on_missile_begin_pos(behavior, owner, pos_x, pos_z, missile_cfg, missile)
end

function behavior.on_self_missile_begin_pos(behavior, pos_x, pos_z, missile_cfg, missile)
end

function behavior.on_missile_end_pos(behavior, owner, pos_x, pos_z, missile_cfg, missile, is_break)
end

function behavior.on_self_missile_end_pos(behavior, pos_x, pos_z, missile_cfg, missile, is_break)
end

function behavior.on_reconnect(behavior)
end

function behavior.on_finish_guide(behavior, guide_id)
end

function behavior.on_click_fight_story(behavior, story_id, branch_id)
end

function behavior.on_texture_guide_finish(behavior, group_id)
end

function behavior.on_story_finish(behavior, story_id)
end

function behavior.on_skill_teach_tips_close(behavior, tips_id)
end

function behavior.on_ball_level_change(behavior, red, blue, yellow)
end

function behavior.on_npc_ball_level_change(behavior, npc, red, blue, yellow)
end

function behavior.on_hero_born_anim_end(behavior)
end

function behavior.on_enter_area(behavior, npc, area)
end

function behavior.on_leave_area(behavior, npc, area)
end

function behavior.on_npc_dead(behavior, npc)
end

function behavior.on_timeline_end(behavior, timeline_name)
end

function behavior.on_timeline_begin(behavior, timeline_name)
end

function behavior.on_npc_group_clear(behavior, group_id)
end

function behavior.on_video_play_end(behavior)
end

function behavior.remove_buff(behavior, buff_id)
end

function behavior.remove_curse(behavior, curse_id)
end

function behavior.on_role_level_change(behavior, level)
end

function behavior.on_npc_born(behavior, npc)
end

function behavior.on_room_pass(behavior, room_id)
end

function behavior.on_enter_room(behavior, room_id, is_first_enter)
end

function behavior.reset_on_enter_room()
end

function behavior.on_get_energy_ball(behavior, npc)
end

function behavior.on_toughness_change(behavior, npc, camp, change_level, enter_stun)
end

function behavior.on_story_begin(behavior, story_id, step_id, branch_id)
end

function behavior.on_element_aborn_start(behavior, npc, element, skill_id, attacker)
end

function behavior.on_target_self_element_aborn_start(behavior, attacker, element, skill_id)
end

function behavior.on_self_element_aborn_start(behavior, npc, element, skill_id)
end

function behavior.on_element_aborn_end(behavior, npc, element, attacker)
end

function behavior.on_self_element_aborn_end(behavior, npc, element)
end

function behavior.on_target_self_element_aborn_end(behavior, attacker, element)
end

function behavior.on_fate_book_battle_start(behavior)
end

function behavior.on_all_ai_dead(behavior)
end

function behavior.on_hero_enter_ground_state(behavior, hero)
end

function behavior.on_before_skill_link_end(behavior, hero)
end

function behavior.on_skill_link_start(behavior, hero)
end

function behavior.on_skill_link_timer_end(behavior, stage)
end

function behavior.before_shield(behavior, ...)
end

function behavior.after_shield(behavior, ...)
end

function behavior.on_tp_room_finish(behavior)
end

function behavior.on_controller_change(npc, extra_controller_path)
end

function check_npc_status(npc, status)
end

function get_npc_status(npc)
end

function check_npc_die(npc)
end

function search_joystick_npc(npc, target_type, distance, angel, keycode)
end

function is_npc_loaded(npc)
end

function set_search_npc_limit(target_kind, target_npc_id, target_magic_id)
end

function search_npc(npc, target_type, distance, magic_id, is_tmp_list, need_list, target_npc_id, target_npc_kind)
end

function search_npc_magic_count(npc, target_type, distance, magic_id, hero_cast_magic)
end

function get_grabed_obj(npc, attach_point)
end

function check_npc_distance(npc, target, distance, include_body)
end

function check_npc_distance_to_pos(npc, posx, posz, distance, include_body)
end

function get_npc_distance(npc, type, param1, param2, param3)
end

function get_target_angel(npc, target, is_negative)
end

function get_target_pos_angle(npc, x, z, is_negative)
end

function get_npc_pos(npc, attach_name)
end

function get_click_input(npc, input_code)
end

function get_time()
end

function get_npc_time(npc)
end

function change_char_special_ui(hero, data)
end

function get_joystick_target_pos(npc)
end

function cast_skill(npc, target, skill_id, targetx, targetz, skill_action_info, start_frame)
end

function cast_missile(npc, target, posx, posz, missile_id, missile_level, lookat_posx, lookat_posz, lookat_posy, posy, born_posx, born_posz, born_posy, skill_action_info)
end

function cast_missile2(param)
end

function cast_missile_new(npc, target, posx, posz, missile_id, missile_level, lookat_posx, lookat_posz, lookat_posy, posy, born_posx, born_posz, born_posy, skill_action_info)
end

function cast_missile2_new(param)
end

function cast_missile3(npc, target, posx, posz, missile_id, missile_level, lookat_posx, lookat_posz, lookat_posy, posy, born_posx, born_posz, born_posy, skill_action_info)
end

function change_missile_move_params(missile, ...)
end

function cast_magic(npc, target, magic_id, level, num)
end

function debug_all_magic()
end

function debug_magic(id)
end

function cast_skill_to_position(npc, skill_id, targetx, targetz)
end

function lookat_npc(npc, target, force)
end

function lookat_position(npc, posx, posz, force)
end

function moveto_npc(npc, target)
end

function create_part_npc(res_id, owner, attach_name, part_id, camp)
end

function get_missile_pos(missile)
end

function became_part(npc, owner, attach_name, part_id)
end

function became_follower(npc, leader)
end

function move_to_pos(npc, pos)
end

function move_by_dir(npc)
end

function check_activate(npc)
end

function stop_move(npc)
end

function switch_move_type(npc, move_type)
end

function set_sceneobj_visible(path, is_visible)
end

function set_sceneobj_visible_save_state(path, is_visible, is_timeline_to_last_frame)
end

function set_scene_effect(effect_path, is_visible, is_save_visible)
end

function idle_switch(npc, idle_state)
end

function is_cast_skill_time(npc, skill_id, include_aftertime)
end

function get_skill_cfg(skill_id)
end

function abort_skill(npc, break_abort)
end

function get_armor_def_level(npc)
end

function get_armor_atk_level(npc)
end

function get_hitfly_speed(npc)
end

function get_npc_height(npc)
end

function get_npc_id(npc)
end

function play_effect_anim(npc, effect_name, anim_state_name)
end

function missile_play_effect_anim(missile, anim_state_name)
end

function set_effect_end_anim_idx(npc, effect_name, idx)
end

function set_npc_turnpos(npc, pos)
end

function remove_npc(npc)
end

function get_npc_shield(npc)
end

function get_npc_group_id(npc)
end

function add_npc(self_camp, res_id, vec3_pos, vec3_target, relationship, level, npc_group)
end

function add_npc2(self_camp, res_id, posx, posz, tarx, tarz, relationship, level, npc_group)
end

function add_npc_by_pos_key(self_camp, res_id, pos_key, offset_x, offset_z, tgt_pos_key, tgt_offset_x, tgt_offset_z, camp, level, npc_group)
end

function get_position_offset_position(base_pos, face_to_pos, deg, length)
end

function get_npc_offset_position(npc, face_to_pos, deg, length)
end

function get_postion_raycast_obstruct_distance(base_pos, deg)
end

function get_npc_raycast_obstruct_distance(npc, deg)
end

function check_magic(npc, magic_id)
end

function get_weapon_advance_lv(npc)
end

function get_magic_num(npc, magic_id, hero_cast_magic)
end

function set_skill_end_to_idle(npc, param)
end

function set_action_keep_end(npc)
end

function replace_hero_skill(index, skill_id)
end

function get_god_npc()
end

function set_strength_visible(is_show)
end

function set_aimed_move_state(is_move)
end

function replace_tower_skill(skill_index)
end

function set_skill_ex_enengy(skill_id, ex_energy)
end

function set_cam_default_angles(x, y, ease_in_speed, prop)
end

function set_cam_default_dist(dist)
end

function get_enemy_npc_count()
end

function get_npc_count_by_res_id(res_id)
end

function set_can_searched(npc, is_can_searched)
end

function get_can_searched(npc)
end

function get_magic_kind_num(npc, type)
end

function get_npc_cd_charge(npc, skill_id)
end

function get_npc_exskill_energy(npc)
end

function get_fight_skill_id_by_index(npc, index)
end

function get_npc_attr(npc, attr_type)
end

function play_ui_fight_button_effect(params)
end

function stop_ui_fight_button_effect(params)
end

function abort_magic_by_id(npc, magic_id, num)
end

function mark_transparent(npc)
end

function enable_rim(npc, enable)
end

function set_ui_object_visible(ui_name, object_name, is_visible, cur_frame_execute)
end

function set_team_head_object_visible(head_index, object_name, is_visible)
end

function set_scene_object_visible(ui_name, object_name, is_visible)
end

function get_scene_map_pos_postion(pos_key)
end

function set_npc_level(npc, level, is_update_attr)
end

function _set_npc_level(npc, level, is_update_attr)
end

function get_tower_floor_info()
end

function create_scene_effect(prefab_name, position, duration, obj_name, face_pos, not_time_scale)
end

function remove_scene_effect(obj_name)
end

function enter_main_scene()
end

function set_npc_dead(npc, dead_action, action_remove, dead_cb)
end

function on_not_monster_npc_dead(npc)
end

function set_scene_tips(id, is_visible, param)
end

function set_npc_target(npc, target)
end

function get_target_hero()
end

function enable_shadow(npc, param)
end

function rgb_split(delay, time, power, inteval, powr, powg, powb)
end

function set_left_joystick_inverse(is_inverse)
end

function set_indicator_inverse(is_inverse)
end

function update_skill_indicator(key_code, area_cfg, indi_cfg, sensitivity)
end

function set_indicator_active(keycode, param, lock_tar, extra_pos_x, extra_pos_z, force_red, not_reset)
end

function set_is_force_red(key_code, is_force_red)
end

function set_indicator_pos(key_code, x, y)
end

function get_indicator_pos(key_code)
end

function left_joystick_skill_mode(area_cfg, indicator_cfg, sensitivity, lock_cfg)
end

function set_left_joystick_skill_mode_active(param, lock_tar)
end

function set_aim_pos(x, y)
end

function get_aim_pos()
end

function clear_aim()
end

function get_aim_tar()
end

function get_indicator_lock_tar(keycode)
end

function get_scene_hero_by_poskey(keycode)
end

function get_force_target()
end

function clear_force_target()
end

function set_hero_can_showup(npc, param)
end

function is_hero_in_ground(npc)
end

function hero_born_finish(skill_id)
end

function show_hero_by_keycode(key_code, ignore_cd)
end

function change_missile_config(missile_id, attr_name, new_value, change_mode)
end

function rebound_missile(missile, rebound_caster, tar, tarx, tarz, speed, not_change_owner, not_change_movement, need_change_tar)
end

function enable_part_damage(npc, part_id, enable)
end

function stop_missile(missile)
end

function time_scale_immune(target, is_immune)
end

function change_fight_btn(show_interact)
end

function set_lock_velocity(npc, turn_speed)
end

function set_scene_camera(camera_id)
end

function set_camera(camera_id, is_new_config, is_force_switch_cameramode, change_cam_cfg)
end

function get_cur_camera_id()
end

function back_to_scene_camera(is_reduction)
end

function focus_npc(npc, attach_name)
end

function clear_focal()
end

function change_follow_target(follow_target_type, npc, param)
end

function change_follow_target_new(follow_target_type, npc, param)
end

function get_focus_follow_speed()
end

function get_camera_follow_target()
end

function set_camera_click_swip_state(is_swip)
end

function keep_focus_pos_by_clear_target()
end

function set_charge(charge_type, time, charge_time)
end

function set_charged_active(is_show)
end

function damage_correct(npc, correct_val)
end

function heal_correct(npc, correct_val)
end

function is_pass_room(room_id)
end

function get_part_attr(npc, part_id, attr_type)
end

function set_part_attr(npc, part_id, attr_type, attr_value)
end

function change_skill_cd(npc, key_val, change_type, magic_id)
end

function check_skill_library(npc, key_val, check_skill_id)
end

function add_skill_library_id(npc, key_val, add_skill_id)
end

function remove_skill_library(npc, key_val, remove_skill_id)
end

function get_dir_offset(npc, px, pz)
end

function change_linetype(missile, linetype, lineparams)
end

function remove_missile(missile, need_explosion)
end

function mark_limited_missile(missile_id, max_count)
end

function set_skill_btn_charging(key_code, charged_type, param_cfg)
end

function set_skill_btn_icon(key_code, skill_icon)
end

function clear_skill_btn_charging(key_code)
end

function get_come_on_hero()
end

function set_npc_hp_visible(npc, is_visible)
end

function show_magic_num(key_code, value)
end

function enter_guide(guide_id)
end

function get_npc_temp_blue(npc)
end

function get_battle_setting_camera_type()
end

function stop_skill_joystick_move(npc)
end

function forced_reduce_skill_joystick_speed(npc)
end

function set_camera_animed_state(is_open)
end

function open_hero_head_follow(npc, is_open)
end

function get_aimed_camera_angle()
end

function lookat_by_npc_attach(npc, attach_name, target_pos, max_x, min_x, max_z, min_z)
end

function update_lookat_pos(npc, target_pos)
end

function close_npc_attach_lookat(npc)
end

function play_DBM_ani(text_id)
end

function disable_DBM(text_id, close_type)
end

function get_camera_view_type()
end

function joystick_end()
end

function get_active_char_element(npc)
end

function set_sync_var(k, v)
end

function get_sync_var(k)
end

function switch_fight_bgm(bgm_name, volume, fadeout_time)
end

function start_play_bgm(change_time)
end

function switch_play_bgm(bgm_name)
end

function stop_play_bgm(change_time)
end

function set_source_volume(source_type, lerp_time, target_volume)
end

function play_common_sound(sound_name)
end

function set_sound_reverb_state(state)
end

function switch_bgm_block(sound_name, block_num)
end

function is_in_challenge()
end

function trigger_fight_story(story_id)
end

function set_keyframe_enable(char, id, enable, force)
end

function set_keyframe_enable_by_tag(char, skill_id, tag, enable, force)
end

function force_finish_cur_guide()
end

function stop_touch_swip(is_stop_swip)
end

function pause_cinemachine(is_pause)
end

function set_cursor_enable(npc, bool)
end

function start_texture_guide(group_id)
end

function start_stroy(story_id)
end

function char_visible(is_hide)
end

function set_hud_config(key_code, res_config, usage, param1, param2)
end

function set_hud_config_world(key_code, res_config, usage, param1, param2)
end

function active_hud(npc, key_code, attach_point, is_active, txt)
end

function active_hud_world(npc, key_code, attach_point, is_active)
end

function start_skill_teach(skill_id)
end

function set_skill_state(step_id, success)
end

function start_long_click_skill()
end

function restart_skill_teach(skill_id)
end

function show_skill_teach_tips(tips_id, visible)
end

function show_skill_combo_tips(combo_tips_id_list, visible)
end

function set_skill_ban_use(idx, visible)
end

function check_npc_btn_interact(npc_id)
end

function listen_missile_evt(evt_type, npc, missile_id, callback, instance)
end

function unlisten_missile_evt(evt_type, npc, missile_id, instance)
end

function listen_missile_collide_obstacle(npc, missile_id, callback, listener)
end

function unlisten_missile_collide_obstacle(npc, missile_id, listener)
end

function listen_missile_begin_pos(npc, missile_id, callback, instance)
end

function unlisten_missile_begin_pos(npc, missile_id, instance)
end

function listen_missile_end_pos(npc, missile_id, callback, instance)
end

function unlisten_missile_end_pos(npc, missile_id, instance)
end

function listen_magic_begin(npc, magic_id, callback, instance)
end

function unlisten_magic_begin(npc, magic_id, instance)
end

function listen_magic_end(npc, magic_id, callback, instance)
end

function unlisten_magic_end(npc, magic_id, instance)
end

function get_weapon_attach_point(npc, attach_name)
end

function get_skill_lv(npc, skill_id)
end

function check_navigate(npc)
end

function is_path_possible(npc, target)
end

function set_cam_pinch_switch(is_open)
end

function change_focus_follow_speed(speed)
end

function request_teach_scene_create_monster(monster_group)
end

function request_end_teach_level(win)
end

function set_dynamic_bone_shake_list(npc, bone_type, bone_name_list)
end

function clear_dynamic_bone_shake_list(npc)
end

function set_npc_controller(npc, extra_controller_path)
end

function offset_shadow_api(x, y, z)
end

function set_npc_joint_active(npc, joint, is_active)
end

function get_ball_level()
end

function get_ball_level_on_npc(npc)
end

function get_npc_rune2_level_by_color(npc, color)
end

function get_npc_rune2_info(npc)
end

function set_stun_animation_group_id(npc, group_id)
end

function enter_stun(npc, exist_armor, duration)
end

function exit_stun(npc)
end

function is_really_enter_stun(npc)
end

function stun_is_end(npc)
end

function debug_missile_name()
end

function check_play_born_sound(npc)
end

function play_effect(char, effect_name, attach_point, is_weapon_attach)
end

function stop_effect(char, fx_id)
end

function flash_to_pos(npc, x, z, y, ignoreObstacle)
end

function set_face_skill_indicator_pos(npc, is_open, dev_val, move_speed, back_speed)
end

function get_char_long_press_skill_id(npc)
end

function set_effect_bar_length(npc, length)
end

function set_effect_bar_show(npc, is_show)
end

function set_missile_dt(missile, scale)
end

function play_timeline(name, fade_in, fade_out, uuid_list, can_skip, is_active_lua, close_camera_transparent, is_show_ui)
end

function stop_timeline(name)
end

function get_god_skill_level()
end

function init_special_fight_ui(type, max_num, active_list)
end

function update_point_fight_ui(max_num, active_list)
end

function get_team_rune_count_by_type(rune_type)
end

function play_video(video_name, is_skip, alpha_enter, alpha_out, sound_name)
end

function set_npc_pos(npc, pos_key)
end

function switch_ui_image(ui_name, obj_name, img_path)
end

function get_cur_card_cfg_info()
end

function get_nearest_walkable_pos(src_pos, tar_pos, body_size, check_ground_dist, ignoreObstacle)
end

function remove_missile_by_id(missile_id, char, need_explosion)
end

function check_betargetd()
end

function set_special_tag(npc, tag, is_remove)
end

function get_config_id(npc)
end

function get_role_kind(npc)
end

function get_button_cur_state(keycode)
end

function record_time_invert(npc, time_limit)
end

function play_time_invert(sec, speed, cb)
end

function set_show_hit_effect_state(npc, is_show_hit_effect)
end

function update_plat_movement(name, is_move, anim)
end

function remove_area(key, tag)
end

function enable_god_skill(is_enable)
end

function set_weapon_attach_point(npc, attach_name, active)
end

function set_npc_target_dir(npc, dir, force)
end

function set_root_trans(pos_x, pos_y, pos_z, rot_x, rot_y, rot_z)
end

function get_cur_room_id()
end

function get_npc_cur_tough_down_lv(npc)
end

function set_npc_floating_text_hud_visible(npc, is_show)
end

function get_missile_uuid(missile)
end

function set_btn_charging_type(skill_id, charge_type, is_on, cur_cd, max_cd, cd_recove_per_second, attr_id)
end

function get_common_value(key)
end

function get_area_pos(pos_key)
end

function stop_count_down_a_moment(time)
end

function npc_is_destroy(npc)
end

function set_dead_ball_count(npc, count)
end

function check_element_ab_state(npc, element_type)
end

function switch_behavior_file(file, char)
end

function copy_attr_to_npc(from_npc, target_npc, type_arg)
end

function change_npc_prefab(npc, prefab_index, save_vfx)
end

function set_enable_transparent(npc, is_enable)
end

function auto_forward_move(npc, is_open)
end

function set_npc_speed_correct_param(npc, param1, param2, param3, param4)
end

function change_root_pos_and_rota(pos_x, pos_y, pos_z, rota_x, rota_y, rota_z)
end

function get_unit_physical_button_cfg(char_id, btn_name)
end

function get_unit_logic_button_cfg(char_id, icon_name)
end

function get_unit_skill_action_cfg(char_id, skact_name)
end

function add_task_progress(id, value)
end

function set_scene_npc_status(scene_npc, status)
end

function get_scene_npc_status(scene_npc)
end

function get_ability_level(ability_id)
end

function get_ui_object_self_active(ui_name, object_name)
end

function get_develop_level(npc, level_type, param)
end

function set_scene_plat_speed(plat_name, speed, anim_name, is_move)
end

function set_scene_timeline_speed(timeline_obj_path, speed)
end

function replace_team_pos_data(pos, is_go_out)
end

function set_ult_skill_enabled(npc, enabled)
end

function get_ui_obj_list(ui_name)
end

function add_fight_ui_to_table(ui_name, obj_name)
end

function remove_fight_ui_to_table(ui_name, obj_name)
end

function clear_fight_ui_objs()
end

function get_group_ai_cfg(id)
end

function get_npc_group_ai(npc)
end

function play_simple_timeline(name, is_play)
end

function cancel_born_skill()
end

function set_npc_phase_number(npc, phase_num)
end

function change_npc_phase_state(npc, phase_num, phase_state)
end

function set_move_offsets_multi_map(npc, offsets_multi_map)
end

function set_joystick_alpha_visible(visible)
end

function set_npc_ignore_sync_area(npc, ignore_sync)
end

function get_npc_missile_distance(npc, missile)
end

function get_missile_skill_action_info(missile)
end

function get_npc_to_camera_offset_position(npc, length, deg)
end

function listen_button_mq(event_type, npc, callback, instance)
end

function unlisten_button_mq(event_type, npc, instance)
end

function listen_custom_event_mq(event_type, npc, callback, listener)
end

function unlisten_custom_event_mq(event_type, npc, listener)
end

function call_custom_event_mq(event_type, npc, ...)
end

function listen_attr_change_mq(npc, attr_type, callback, listener)
end

function unlisten_attr_change_mq(npc, attr_type, listener)
end

function get_button_drag_state(index)
end

function change_hero_state(hero, new_state, keycode, pos_x, pos_z, anim_type)
end

function can_change_hero_state()
end

function hero_stop_move(hero)
end

function set_attach_target_enable(enable)
end

function open_progress_display(init_value, curr_room__final_value, all_room_final_value, up_speed, is_need_anim, up_interval)
end

function close_progress_display(is_need_anim)
end

function update_progress_display(up_value)
end

function set_record_damage_trigger(is_open)
end

function clear_record_damage()
end

function on_level_counter_add(key, add_type)
end

function on_level_counter_clear(key)
end

function on_scene_object_list_play(key_names)
end

function on_scene_object_list_pause(key_names, is_pause)
end

function get_monster_npc_name(npc)
end

function get_monster_search_config(npc)
end

function set_link_stage_state(stage)
end

function set_skill_link_ui_state(stage, child_stage)
end

function set_link_timer_type(action)
end

function set_qte_effect_active(npc, effect_name, enable, priority)
end

function change_ult_effect(npc, state)
end

function is_in_region(pos)
end

function log_on_npc(npc, str, visible)
end

function set_npc_status(npc, status, status_enable)
end

function set_tough_bar_protect_state(npc, state)
end

function set_npc_hp_bar_type(npc, bar_type)
end

function set_all_npc_hp_visible(visible, show_hero_bar)
end

function create_navigator_effect(name, is_open, is_continue)
end

function get_ability_count(genres_id)
end

function recover_head_max_energy()
end

function set_skill_ignore_expend_detect(npc, skill_id, is_ignore)
end

function get_fate_book_coin_count()
end

function change_attach_point_parent(npc, attach_point, parent_attach_point, reset_time)
end

function set_fight_ui_object_visible(object_name, visible)
end

function get_fight_ui_object_visible(object_name)
end

function set_npc_pretend_visible(npc, visible, x, y, z)
end

function add_treasure_chest(id, pos_key, rotation, is_play_effect_and_audio, is_can_open, custom_event_name)
end

function get_equation_branch_info(equation_id)
end

function set_show_betargeted_arrow(hero, show)
end

function get_pos_to_camera_offset_position(target_pos, length, deg)
end

function time_scale_immune(target, is_immune)
end

function set_timer_pause(is_pause, ignore_notice_show)
end

function to_turn_over_state(npc)
end

function create_behavior_manager(file)
end

function add_sub_magic(magic_id, sub_magic_id, life)
end

function remove_sub_magic(magic_id, sub_magic_id)
end

function get_tower_id()
end

function get_cur_room_id()
end

function set_localrotation_component(npc, attach_name, x, y, z, speed, no_lerp)
end

function get_npc_difficulty_tag(npc)
end

function change_abnormal_flag_count(npc, element_id, change_count)
end

function get_missile_target(missile)
end

function call_scene_logic_custom_event(event_name)
end

function func_npc_try_call_behavior_fun(npc_id, func_name, ...)
end

function get_auto_trigger_qte_on_role_out()
end

function play_front_qte_btn_effect()
end

function get_role_fashion_id(role)
end

function get_role_weapon_fashion_id(role)
end

function get_missile_kill_role_count(npc, missile)
end

function disable_stun_anim(npc)
end

function enable_stun_anim(handler)
end

function add_missile_atk_cd(missile, npc, cd)
end

function transfer_missile_effect(missile, new_missile_owner)
end

function set_ban_skill_to_move(npc, isEnable)
end

function is_missile_target_camp(npc, missile)
end

function missile_has_hurt_magic(missile)
end

function is_judg_missile(missile)
end

function is_dodge_missile(missile)
end

function clear_hit_stop(npc)
end

function get_npc_time_scale(npc)
end

function get_tough_record_state(npc)
end

function get_part_npc_kind(npc)
end

function set_skill_target(npc, skId, newTarget, newTarPos)
end

function listen_npc_fight_status_change(npc, callback, listener)
end

function unlisten_npc_fight_status_change(npc, listener)
end

function behavior.on_npc_fight_status_change(behavior, npc, newIsSingleLock)
end

function get_npc_fight_status(npc)
end

function change_skill_link_duration(stage, delta)
end

function behavior.on_force_shift_end(behavior, caster, target, magic_id, is_success)
end

function behavior.on_minesweeper_battle_start(behavior)
end

function decrease_closeup_camera_priority()
end

function get_missile_owner(obj)
end

function clear_cam_magic(npc)
end

function get_role_job(npc)
end
