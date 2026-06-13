local CommDefine = require("cs_share.common_define")
local LOGIC_ACTION = CommDefine.LOGIC_ACTION
local LOGIC_OTHER_PARAMETER = CommDefine.LOGIC_OTHER_PARAMETER
local LOGIC_FINISH_CONDITION = CommDefine.LOGIC_FINISH_CONDITION
local M = {}
local LOGIC_ACTION_FUNCTION = {
  [LOGIC_ACTION.ADD_FUNCTION_NPC] = function(behavior, config)
    behavior:add_functional_npc_new(config.NPCId, config.PosKey, config.Rotation, config.NPCName)
  end,
  [LOGIC_ACTION.ADD_EXHIBITION_FUNC_NPC] = function(behavior, config)
    behavior:add_exhibition_functional_npc(config.NpcId, config.PosKey, config.Rotation, config.NPCName, config.NpcParams, config.IsRemove, config.CustomEventName)
  end,
  [LOGIC_ACTION.REMOVE_FUNCTIONAL_NPC] = function(behavior, config)
    behavior:remove_functional_npc(config.NPCId)
  end,
  [LOGIC_ACTION.ADD_NPC_BY_POS_KEY] = function(behavior, config)
    if config.AutoSave then
      behavior:add_server_save_npc(LOGIC_OTHER_PARAMETER.NPC_CAMP, config.ResId, config.PosKey, config.OffsetX, config.OffsetZ, config.Rotation, config.Camp, config.Level, config.NPCName, config.Params)
    else
      local uuid = SceneMgr:get_uuid()
      behavior:add_npc_by_pos_key(uuid, LOGIC_OTHER_PARAMETER.NPC_CAMP, config.ResId, config.PosKey, config.OffsetX, config.OffsetZ, config.Rotation, 0, 0, config.Camp, config.Level, nil, nil, nil, config.NPCName, config.Params)
    end
  end,
  [LOGIC_ACTION.LOOK_AT] = function(behavior, config)
    behavior:new_lookat_point(config.Point)
  end,
  [LOGIC_ACTION.CLEAR_INPUT] = function(behavior, config)
    behavior:clear_input()
  end,
  [LOGIC_ACTION.COMPLETE_TASK] = function(behavior, config)
    behavior:complete_task(config.TaskId)
  end,
  [LOGIC_ACTION.PLAY_TIMELINE] = function(behavior, config)
    behavior:play_timeline(config.TimelineName, config.Fadein, config.Fadeout, nil, config.IsCanSkip, config.NotPauseLua, config.IsCloseTransparent, config.BlackIn, config.Hold, config.BlackOut, config.IsShowUI, config.DelayDestroy, config.BeforeBlackIn, config.BeforeHold, config.BeforeBlackOut, config.IsWhite)
  end,
  [LOGIC_ACTION.STOP_TIMELINE] = function(behavior, config)
    behavior:stop_timeline(config.TimelineName)
  end,
  [LOGIC_ACTION.ADD_MONSTER] = function(behavior, config)
    behavior:AddMonsterEvent(config.RefreshCfg)
  end,
  [LOGIC_ACTION.REMOVE_AREA] = function(behavior, config)
    behavior:remove_area(config.AreaName, nil, config.RemoveForever)
  end,
  [LOGIC_ACTION.PLAY_STORY] = function(behavior, config)
    behavior:play_story(config.StoryId, config.EnableBlackFade, config.PlayFadeInTime, config.PlayStayTime, config.PlayFadeOutTime, config.StopFadeInTime, config.StopStayTime, config.StopFadeOutTime, config.DelayDestroy, config.NoSkipStory, config.IsSettleStory)
  end,
  [LOGIC_ACTION.SET_SCENE_CAMERA] = function(behavior, config)
    behavior:set_scene_camera(config.Camera, nil, config.IsNewConfig, config.IsForceDepressCameraMode, config.ForbidCameraBlend)
  end,
  [LOGIC_ACTION.CREATE_ALL_TRANSMIT] = function(behavior, config)
    behavior:open_all_transmit(nil, config.TpName)
  end,
  [LOGIC_ACTION.SET_SCENE_OBJ_VISIBLE] = function(behavior, config)
    behavior:set_sceneobj_visible(config.ObjName, config.Visible, config.IsAutoSave, config.SaveType)
  end,
  [LOGIC_ACTION.STOP_MOVE] = function(behavior, config)
    behavior:stop_move()
  end,
  [LOGIC_ACTION.SET_SCENE_TIPS] = function(behavior, config)
    behavior:set_scene_tips(config.TipsId, config.Visible, {
      Flip = config.Flip
    })
  end,
  [LOGIC_ACTION.CAST_MAGIC] = function(behavior, config)
    local target = behavior:get_npc_by_name(config.Target)
    behavior:cast_magic(target, target, config.MagicId, config.Level)
  end,
  [LOGIC_ACTION.ENABLE_GOD_SKILL] = function(behavior, config)
    behavior:enable_god_skill(config.Enable)
  end,
  [LOGIC_ACTION.PLAT_MOVE] = function(behavior, config)
    behavior:update_plat_movement(config.PlatName, config.IsMove, config.Anim, config.IsAutoSave)
  end,
  [LOGIC_ACTION.CALL_CUSTOM_EVENT] = function(behavior, config)
    behavior:RunFuncModule(config.CustomEventName)
  end,
  [LOGIC_ACTION.ADD_BATTLE_TASK_GROUP] = function(behavior, config)
    behavior:accept_task_group(config.TaskGroupId)
  end,
  [LOGIC_ACTION.END_PERFORM] = function(behavior, config)
    behavior:end_perform(behavior.room_type)
  end,
  [LOGIC_ACTION.SET_SYNC_VAR] = function(behavior, config)
    behavior:set_sync_var(config.Key, config.Value, config.ValidInTower)
  end,
  [LOGIC_ACTION.SET_ROUTE_STATUS] = function(behavior, config)
    behavior:set_route_status(config.StartRoomId, config.TargetRoomId, config.IsOpen)
  end,
  [LOGIC_ACTION.TRIGGER_DESC_STORY] = function(behavior, config)
    behavior:play_desc_story(config.storyId)
  end,
  [LOGIC_ACTION.TRANSMIT_NPC] = function(behavior, config)
    local npc = behavior:get_npc_by_name(config.NPC)
    behavior:transmit_npc_new(npc, config.Point, config.Rotate, config.TransmitTime)
  end,
  [LOGIC_ACTION.ADD_MACHINE] = function(behavior, config)
    behavior:AddMachineGroup(config.GroupId)
  end,
  [LOGIC_ACTION.FORCED_CHANGE_CHAR] = function(behavior, config)
  end,
  [LOGIC_ACTION.CHANGE_APPOINT_CHAR] = function(behavior, config)
    behavior:change_appoint_char(config.HeroId)
  end,
  [LOGIC_ACTION.FINISH_END] = function(behavior, config)
    behavior:fight_end(config.isVictory, config.isPopConfirmTips, LanguageMgr:get_code_text(config.tipsValue))
  end,
  [LOGIC_ACTION.SET_CUSTOM_VARIABLE] = function(behavior, config)
    behavior:SetCustomVariable(config.Variable, config.IsTmpVariable, config.ValidInTower)
  end,
  [LOGIC_ACTION.ADD_BATTLE_TASK_CONDITION] = function(behavior, config)
    behavior:battle_condition_update(config.CondId, config.CondValue)
  end,
  [LOGIC_ACTION.SET_UI_OBJECT_VISIBLE] = function(behavior, config)
    behavior:set_ui_object_visible(config.UIName, config.ObjectName, config.IsShow)
  end,
  [LOGIC_ACTION.CANCEL_FOOTMARK] = function(behavior, config)
    behavior:cancel_footmark()
  end,
  [LOGIC_ACTION.OPEN_ALL_TRANSMIT] = function(behavior, config)
    behavior:open_all_transmit(nil, config.TpName)
  end,
  [LOGIC_ACTION.REMOVE_ALL_TRANSMIT] = function(behavior, config)
    behavior:remove_all_transmit()
  end,
  [LOGIC_ACTION.SKIP_FINISH_ANIM] = function(behavior, config)
    behavior:skip_finish_anim(config.IsSkip)
  end,
  [LOGIC_ACTION.ON_HIDE_NPC] = function(behavior, config)
    local npc = behavior:get_npc_by_name(config.Target)
    behavior:hide_npc(npc)
  end,
  [LOGIC_ACTION.ON_SHOW_NPC] = function(behavior, config)
    local npc = behavior:get_npc_by_name(config.Target)
    behavior:show_npc(npc)
  end,
  [LOGIC_ACTION.OPEN_FLOOR_RESET] = function(behavior, config)
    behavior:open_floor_reset_timer(config.Time)
  end,
  [LOGIC_ACTION.CLOSE_FLOOR_RESET] = function(behavior, config)
    behavior:close_floor_reset_timer()
  end,
  [LOGIC_ACTION.START_GUIDE] = function(behavior, config)
    behavior:start_guide(config.GuideId)
  end,
  [LOGIC_ACTION.START_TESTTURE_GUIDE] = function(behavior, config)
    behavior:start_texture_guide(config.GroupId)
  end,
  [LOGIC_ACTION.OPEN_POINT] = function(behavior, config)
    behavior:BanAddAreaKey(config.PosKey)
  end,
  [LOGIC_ACTION.CLOSE_POINT] = function(behavior, config)
    behavior:CancelBanAreaKey(config.PosKey)
  end,
  [LOGIC_ACTION.SET_GOD_SKILL_LEVEL] = function(behavior, config)
    behavior:set_god_skill_level(config.SkillLevel, config.TowerValid)
  end,
  [LOGIC_ACTION.STOP_STORY] = function(behavior, config)
    behavior:stop_story()
  end,
  [LOGIC_ACTION.SHOW_FINGER_SCALE_GUIDE] = function(behavior, config)
    behavior:show_finger_scale_guide()
  end,
  [LOGIC_ACTION.START_FIGHT_TIMING] = function(behavior, config)
    behavior:StartFightTiming()
  end,
  [LOGIC_ACTION.STOP_FIGHT_TIMING] = function(behavior, config)
    behavior:StopFightTiming()
  end,
  [LOGIC_ACTION.START_COUNT_DOWN] = function(behavior, config)
    behavior:start_count_down(config.Seconds)
  end,
  [LOGIC_ACTION.OPEN_APPOINT_TP_DIR] = function(behavior, config)
    behavior:open_appoint_tp_dir(config.Direction, config.TpName)
  end,
  [LOGIC_ACTION.TIMER_CALL_OUT_REMOVE] = function(behavior, config)
    behavior:timer_call_out_remove(config.Key)
  end,
  [LOGIC_ACTION.HIDE_SCENE_EFFECT_STATUS_OBJ] = function(behavior, config)
    behavior:hide_scene_effect_status_obj(config.ObjName, config.IsAutoSave)
  end,
  [LOGIC_ACTION.SET_FUNC_NPC_INTERACT_STATE] = function(behavior, config)
    behavior:set_func_npc_interact_state(config.NPCId)
  end,
  [LOGIC_ACTION.ADD_CD_NPC_BY_POS_KEY] = function(behavior, config)
    behavior:add_server_save_cd_npc(LOGIC_OTHER_PARAMETER.NPC_CAMP, config)
  end,
  [LOGIC_ACTION.PLAY_REVERSIBLE_TIMELINE] = function(behavior, config)
    behavior:play_reversible_scene_timeline(config.Path, config.Plat, config.Rewind, config.IsSaveState)
  end,
  [LOGIC_ACTION.TP_REVIVE_ROOM] = function(behavior, config)
    behavior:tp_revive_room(config.PosKey, config.ArchiveNumber, config.RevertSceneTimeline)
  end,
  [LOGIC_ACTION.PLAYER_CONTROLL_ON] = function(behavior, config)
    behavior:set_player_control_on()
  end,
  [LOGIC_ACTION.PLAYER_CONTROLL_OFF] = function(behavior, config)
    behavior:set_player_control_off()
  end,
  [LOGIC_ACTION.CAST_SKILL] = function(behavior, config)
    local src = behavior:get_npc_by_name(config.Source)
    local tar = behavior:get_npc_by_name(config.Target)
    behavior:cast_skill(src, tar, config.SkillId)
  end,
  [LOGIC_ACTION.PLAY_BLACK_FADE] = function(behavior, config)
    behavior:black_fade_anim(config.FadeIn, config.Hold, config.FadeOut, config.IsWhite)
  end,
  [LOGIC_ACTION.SET_CAMERA_FOCUS] = function(behavior, config)
    behavior:set_camera_focus(config.PosKey, config.IsOpen, config.CameraStyle, config.Duration, config.StopLuaScript, config.HideUI, config.HasOTSConfig, config.OTSCameraStyle, config.OTSDuration, config.BackToDefault)
  end,
  [LOGIC_ACTION.SET_CAMERA_NO_FOCUS] = function(behavior, config)
    behavior:set_camera_no_focus(config.BackToDefault)
  end,
  [LOGIC_ACTION.SET_BATTLE_TASK_UI_STATE] = function(behavior, config)
    behavior:set_battle_task_show_state(config.IsShow, config.ValidInTower)
  end,
  [LOGIC_ACTION.DESTROY_UNIT_GROUP] = function(behavior, config)
    behavior:destroy_unit_group(config.Group, config.UnitType)
  end,
  [LOGIC_ACTION.START_CT_TIMER] = function(behavior, config)
    behavior:start_ct_timer(config.Seconds, LanguageMgr:get_code_text(config.Text), config.EventName)
  end,
  [LOGIC_ACTION.FINISH_GUIDE] = function(behavior, config)
    behavior:finish_guide(config.GuideId)
  end,
  [LOGIC_ACTION.HIDE_CT_TIMER] = function(behavior, config)
    behavior:hide_ct_timer()
  end,
  [LOGIC_ACTION.CLEAR_ALL_MONSTER] = function(behavior, config)
    behavior:kill_all_monster()
  end,
  [LOGIC_ACTION.CREATE_NAVIGATOR_EFFECT] = function(behavior, config)
    behavior:create_navigator_effect(config.KeyName, config.IsOpen, config.IsContinue)
  end,
  [LOGIC_ACTION.CLEAR_NAVIGATOR_EFFECT] = function(behavior, config)
    behavior:clear_navigator_effect()
  end,
  [LOGIC_ACTION.HIDE_TP_POINT_EFFECT] = function(behavior, config)
    behavior:hide_tp_point_effect(config.Index)
  end,
  [LOGIC_ACTION.SHOW_TP_POINT_EFFECT] = function(behavior, config)
    behavior:show_tp_point_effect(config.Index)
  end,
  [LOGIC_ACTION.START_BGM] = function(behavior, config)
    behavior:start_play_bgm(config.ChangeTime)
  end,
  [LOGIC_ACTION.STOP_BGM] = function(behavior, config)
    behavior:stop_play_bgm(config.ChangeTime)
  end,
  [LOGIC_ACTION.SWITCH_BGM] = function(behavior, config)
    behavior:switch_play_bgm(config.PlayBgm)
  end,
  [LOGIC_ACTION.SET_CD_NPC_INOFFENSIVE] = function(behavior, config)
    behavior:set_cd_npc_can_hit(config.NpcName, config.CanHit)
  end,
  [LOGIC_ACTION.SUB_HERO_JOIN] = function(behavior, config)
    behavior:hero_go_out(config.Pos, config.IsGoOut, config.SavePos)
  end,
  [LOGIC_ACTION.SET_MAPVIEW_TRANSMIT] = function(behavior, config)
    behavior:set_mapview_transmit(config.IsOpen)
  end,
  [LOGIC_ACTION.START_ENVIRONMENT_BGM] = function(behavior, config)
    behavior:start_environment_bgm(config.ChangeTime)
  end,
  [LOGIC_ACTION.CLOSE_ENVIRONMENT_BGM] = function(behavior, config)
    behavior:stop_environment_bgm(config.ChangeTime)
  end,
  [LOGIC_ACTION.SWITCH_ENVIRONMENT_BGM] = function(behavior, config)
    behavior:switch_environment_bgm(config.ChangeTime, config.PlayBgm)
  end,
  [LOGIC_ACTION.REMOVE_NPC_BY_NAME] = function(behavior, config)
    local npc = behavior:get_npc_by_name(config.NpcName)
    behavior:remove_npc(npc)
  end,
  [LOGIC_ACTION.RANDOM_ADD_MONSTER_EVENT] = function(behavior, config)
    behavior:random_add_monster_event(config)
  end,
  [LOGIC_ACTION.OPEN_FIGHT_AIR_WAVE_GROUP] = function(behavior, config)
    behavior:open_fight_air_wave_group(config.GroupID)
  end,
  [LOGIC_ACTION.CLOSE_FIGHT_AIR_WAVE_GROUP] = function(behavior, config)
    behavior:close_fight_air_wave_group(config.GroupID)
  end,
  [LOGIC_ACTION.PLAY_VIDEO] = function(behavior, config)
    behavior:play_video(config.Video, config.IsCanSkip)
  end,
  [LOGIC_ACTION.SET_ROOM_COLLIDER_VISIBLE] = function(behavior, config)
    behavior:set_room_collider_visible(config.mIdx, config.mVisible, config.RoomColliderName)
  end,
  [LOGIC_ACTION.ON_NPC_LOGIC_STOP] = function(behavior, config)
    behavior:on_npc_logic_stop(config.NPCId)
  end,
  [LOGIC_ACTION.ON_NPC_LOGIC_RESTART] = function(behavior, config)
    behavior:on_npc_logic_restart(config.NPCId)
  end,
  [LOGIC_ACTION.REMOVE_EXHIBITION_NPC] = function(behavior, config)
    behavior:remove_exhibition_npc(config.NPCName)
  end,
  [LOGIC_ACTION.SHOW_TIPS] = function(behavior, config)
    behavior:show_tips(config.IsOpen, config.Duration, LanguageMgr:get_code_text(config.Tips))
  end,
  [LOGIC_ACTION.ADD_SCENE_SKILL_LEVEL] = function(behavior, config)
    behavior:add_god_skill_level(config.Level or 1, config.TowerValid)
  end,
  [LOGIC_ACTION.PLAY_SCENE_TIME_LINE] = function(behavior, config)
    behavior:play_scene_timeline(config.Path, config.PlatList)
  end,
  [LOGIC_ACTION.SET_SCENE_OBJ_STATE] = function(behavior, config)
    behavior:set_scene_obj_state(config.ContainerName, config.Names, config.States, config.SaveType)
  end,
  [LOGIC_ACTION.SET_NAVIGATOR_STATE] = function(behavior, config)
    behavior:set_navigator_state(config.StateInfos)
  end,
  [LOGIC_ACTION.CHANGE_FUNCTION_NPC_ACTION] = function(behavior, config)
    behavior:change_functional_npc_action(config.NPCId, config.NPCActionName)
  end,
  [LOGIC_ACTION.BROADCAST_MONSTER_COUNT] = function(behavior, config)
    behavior:broadcast_monster_count(config.StatisticsIndex, config.StatisticsType, config.ManualCount, config.FinishNotAdd, config.ChangeRoomReset, config.EventName, config.UnitIdStr)
  end,
  [LOGIC_ACTION.SET_FOG_INTENSITY] = function(behavior, config)
    behavior:set_fog_intensity(config.Intensity)
  end,
  [LOGIC_ACTION.CREATE_SCENE_NPC] = function(behavior, config)
    behavior:create_scene_npc(config.Configs)
  end,
  [LOGIC_ACTION.OPEN_PROGRESS_DISPLAY] = function(behavior, config)
    behavior:open_progress_display(config)
  end,
  [LOGIC_ACTION.ADD_PROGRESS_DISPLAY] = function(behavior, config)
    behavior:add_progress(config.AddValue)
  end,
  [LOGIC_ACTION.REMOVE_MAGIC] = function(behavior, config)
    local tar = behavior:get_npc_by_name(config.Target)
    behavior:abort_magic_by_id(tar, config.MagicId)
  end,
  [LOGIC_ACTION.CLOSE_PROGRESS_DISPLAY] = function(behavior, config)
    behavior:close_progress_display(config)
  end,
  [LOGIC_ACTION.SET_CAMERA_FAR_CLIP_PLANE] = function(behavior, config)
    behavior:set_camera_far_clip_plane(config.CameraFarClipPlane)
  end,
  [LOGIC_ACTION.LockCameraMode] = function(behavior, config)
    behavior:lock_camera_mode(config.IsCameraModeLocked)
  end,
  [LOGIC_ACTION.DEFAULT_CAMERA_FAR_CLIP_PLANE] = function(behavior, config)
    behavior:set_camera_far_clip_plane_default()
  end,
  [LOGIC_ACTION.REMOVE_TP_POINT] = function(behavior, config)
    behavior:remove_tp_point_by_behavior_func(config.Point)
  end,
  [LOGIC_ACTION.LOAD_PREFAB] = function(behavior, config)
    behavior:play_simple_timeline(config.TimelineName, config.IsPlay)
  end,
  [LOGIC_ACTION.PLAY_TIMELINE_SPEED] = function(behavior, config)
    behavior:set_scene_timeline_speed(config.TimelineName, config.Speed)
  end,
  [LOGIC_ACTION.SET_PLAT_FORMAT_SPEED] = function(behavior, config)
    behavior:set_scene_plat_speed(config.PlatPath, config.Speed, config.AnimName, config.IsMove)
  end,
  [LOGIC_ACTION.PLAY_BARRAGE] = function(behavior, config)
    behavior:play_barrage(config.StoryId, config.BarrageStyle, config.Alpha, config.Speed)
  end,
  [LOGIC_ACTION.STOP_BARRAGE] = function(behavior, config)
    behavior:stop_barrage()
  end,
  [LOGIC_ACTION.LEVEL_COUNTER_ADD] = function(behavior, config)
    behavior:on_level_counter_add(config.Key, config.AddType)
  end,
  [LOGIC_ACTION.LEVEL_COUNTER_CLEAR] = function(behavior, config)
    behavior:on_level_counter_clear(config.Key)
  end,
  [LOGIC_ACTION.SCENE_OBJECT_LIST_PLAY] = function(behavior, config)
    behavior:on_scene_object_list_play(config.KeyNames)
  end,
  [LOGIC_ACTION.SCENE_OBJECT_LIST_PAUSE] = function(behavior, config)
    behavior:on_scene_object_list_pause(config.KeyNames, config.IsPause)
  end,
  [LOGIC_ACTION.ENABLE_NPC_MESH] = function(behavior, config)
    local npc = behavior:get_npc_by_name(config.Target)
    behavior:set_npc_mesh_enable(npc, config.Enable)
  end,
  [LOGIC_ACTION.ENABLE_FIGHT_TIMER_UI] = function(behavior, config)
    behavior:set_fight_timer_ui_enable(config.Enable)
  end,
  [LOGIC_ACTION.HIDE_BROADCAST_MONSTER_COUNT] = function(behavior, config)
    behavior:hide_broadcast_monster_count()
  end,
  [LOGIC_ACTION.SHOW_FINGER_DRAG_GUIDE] = function(behavior, config)
    behavior:show_finger_drag_guide(config.CustomEventName)
  end,
  [LOGIC_ACTION.SET_FOG_START_DISTANCE] = function(behavior, config)
    behavior:set_fog_start_distance(config.StartDistance)
  end,
  [LOGIC_ACTION.SET_FOG_START_HEIGHT] = function(behavior, config)
    behavior:set_fog_start_height(config.StartHeight)
  end,
  [LOGIC_ACTION.SWITCH_BGM_BLOCK] = function(behavior, config)
    behavior:switch_bgm_block(config.SoundName, config.BlockNum)
  end,
  [LOGIC_ACTION.ADD_TREASURE_CHEST] = function(behavior, config)
    behavior:add_treasure_chest(config.TreasureChestId, config.PosKey, config.Rotation, config.IsPlayEffectAndSound, config.IsCanOpen, config.CustomEventName)
  end,
  [LOGIC_ACTION.SET_TREASURE_CHEST_STATE] = function(behavior, config)
    behavior:set_treasure_chest_state(config.TreasureChestId, config.IsCanOpen)
  end,
  [LOGIC_ACTION.ADD_TOWER_TASK_PROGRESS] = function(behavior, config)
    behavior:add_task_progress(config.TaskId, config.ProgressValue)
  end,
  [LOGIC_ACTION.CTL_AUDIO_REVERB] = function(behavior, config)
    behavior:set_sound_reverb_val(config.BUSName, config.BUSLevel)
  end,
  [LOGIC_ACTION.SET_FOREVER_VARIABLE] = function(behavior, config)
    behavior:SetForeverVariable(config.Variable)
  end,
  [LOGIC_ACTION.SHOW_EGG_TIPS] = function(behavior, config)
    behavior:show_egg_tips(config.EggID)
  end,
  [LOGIC_ACTION.REVIVE_ALL_HERO] = function(behavior, config)
    behavior:revive_all_hero()
  end,
  [LOGIC_ACTION.TRACK_EVENT] = function(behavior, config)
    SDKTrack:track_event(config.EventName, config.Params)
  end,
  [LOGIC_ACTION.RUN_TREASURE_CHEST_GUIDE_EVENT] = function(behavior, config)
    behavior:refresh_treasure_chest_guide()
  end,
  [LOGIC_ACTION.SWITCH_THE_ATMOSPHERE] = function(behavior, config)
    behavior:switch_the_atmosphere(config.AtmosphereIndex)
  end,
  [LOGIC_ACTION.OPEN_MINI_GAME] = function(behavior, config)
    behavior:open_mini_game(config.GameType, config.GameID)
  end,
  [LOGIC_ACTION.OPEN_COMBO_TIPS] = function(behavior, config)
    behavior:show_skill_combo_tips(config.SkillIdList, config.Visible)
  end,
  [LOGIC_ACTION.SURVIVORS_UNIT_SPAWNER] = function(behavior, config)
    behavior:add_spawner_behavior(config)
  end,
  [LOGIC_ACTION.OPEN_CAPTURE_SYSTEM] = function(behavior, config)
    behavior:open_capture_system(config)
  end,
  [LOGIC_ACTION.CLOSE_CAPTURE_SYSTEM] = function(behavior, config)
    behavior:close_capture_system()
  end,
  [LOGIC_ACTION.SET_VISUAL_PREFABS_VISIBLE] = function(behavior, config)
    behavior:set_visual_prefabs_visible(config)
  end
}

function M.GetActionFunc(nType)
  return LOGIC_ACTION_FUNCTION[nType]
end

local NEED_CHECK_PASS_ROOM_EVENT = {
  [LOGIC_FINISH_CONDITION.GAIN_ITEM] = function(mCondition, val, behavior)
    if val == mCondition.parameter.ItemId then
      mCondition.state = true
    end
  end,
  [LOGIC_FINISH_CONDITION.KILLALL_MONSTER] = function(mCondition, val, behavior)
    if behavior:CheckIsKillAllMonster() then
      mCondition.state = true
    end
  end,
  [LOGIC_FINISH_CONDITION.INTERACT_NPC] = function(mCondition, val, behavior)
    if val == mCondition.parameter.NpcId then
      mCondition.state = true
    end
  end,
  [LOGIC_FINISH_CONDITION.STORY_END] = function(mCondition, val, behavior)
    if val == mCondition.parameter.StoryId then
      mCondition.state = true
    end
  end,
  [LOGIC_FINISH_CONDITION.PLAY_TIMELINE_END] = function(mCondition, val, behavior)
    if val == mCondition.parameter.TimeLineId then
      mCondition.state = true
    end
  end,
  [LOGIC_FINISH_CONDITION.ENTER_ROOM] = function(mCondition, val, behavior)
    mCondition.state = true
  end,
  [LOGIC_FINISH_CONDITION.TIME_OUT] = function(mCondition, val, behavior)
    mCondition.state = true
  end,
  [LOGIC_FINISH_CONDITION.STORY_BEGIN] = function(mCondition, val, behavior)
    if val == mCondition.parameter.StoryId then
      mCondition.state = true
    end
  end
}

function M.GetFinishEvent(event_type)
  return NEED_CHECK_PASS_ROOM_EVENT[event_type]
end

return M
