local UnityQualitySetting = UnityEngine.QualitySettings
local UnityFind = _ENV.UnityFind
local CSCopyLens = CSHelper.CopyLens
local CSGameMgr = CS.Game.GameMgr
local CSGrassRenderer = CS.Game.GrassRenderer
local TypeBaseTransparent = typeof(CS.BaseTransparent)
local MsgGame = Global.mq_game
local CAMPS = Global.config.CAMPS
local UnityTime = UnityEngine.Time
local CSShadow = CS.Game.Shadow
local UnityDestroy = _ENV.UnityDestroy
local CompExtensions = _ENV.CompExtensions
local SyncTransforms = UnityEngine.Physics.SyncTransforms
local BehaviorLoader = require("utils.behavior_loader")
local FightHudMgr = require("uimodule.fight.fight_hud_mgr")
local Layer = require("utils.layer")
local Config = require("config")
local Const = require("const")
local Util = require("utils.util")
local ShareRes = require("utils.share_res")
local Missile = require("manager.fight.missile")
local Vec3 = require("base.vec3")
local ShareStateMgr = require("cs_share.stat_mgr")
local StatDef = require("cs_share.stat_defines")
local SceneDef = require("cs_share.scene_define")
local Seri = require("seri")
local LuaObjPoolMgr = require("manager.res.lua_obj_pool_mgr")
local Math = require("base.mathx")
local SwitchHeroHelper = require("gamelogic.switch_hero.swtich_hero")
local Account = require("gamelogic.account.account")
local LAND_LAYER = Layer.LayerMask.Terrain
local BASE_ATTR_GROUP_TYPE = Config.ATTR_GROUP_TYPE.BASE
local FIXED_VALUE_TYPE = require("cs_share.common_define").VALUE_TYPE.FIXED
local REPLACE_SET_TYPE = Config.ATTR_SET_TYPE.REPLACE
local SEARCH_TARGET_TYPE = Config.SETTING.SEARCH_TARGET_TYPE
local TypePostProcessBehavior = typeof(UnityEngine.PostProcessing.PostProcessingBehaviour)
local TypeCollider = typeof(UnityEngine.Collider)
local TypePosBind = typeof(CS.Game.PosBindObj)
local _insert = table.insert
local MISSILE_TYPE = Config.MISSILE_TYPE
local MISSILE_TYPE_TAG = Config.MISSILE_TYPE_TAG
local ResPool = Global.res_pool_mgr
local _tremove = table.remove
local _tinsert = table.insert
local _maxinteger = math.maxinteger
local _sin = math.sin
local _cos = math.cos
local MathX = require("base.mathx")
local _amost_zero2 = MathX.almost_zero2
local _get_vec2_angle = MathX.get_vec2_angle
local NONE_MOVEMENT = 0
local MISSILE_PART_DEG = Config.MISSILE_PART_DEG
local TRANSPARENT_UPDATE_INTERVAL = 2
local TRANSPARENT_LIFE_INTERVAL = 10
local CommonDefine = require("cs_share.common_define")
local NPC_KIND = CommonDefine.NPC_KIND
local TypePlayableDirector = typeof(UnityEngine.Playables.PlayableDirector)
local TypeSpeedSceneTimeline = typeof(CS.Game.SpeedSceneTimeline)
local monster_drop_type = {
  [NPC_KIND.MONSTER] = NPC_KIND.MONSTER,
  [NPC_KIND.ELITE] = NPC_KIND.ELITE,
  [NPC_KIND.BOSS] = NPC_KIND.BOSS
}
local record_battle_type = {
  [NPC_KIND.MONSTER] = true,
  [NPC_KIND.ELITE] = true,
  [NPC_KIND.BOSS] = true
}
local UnityShader = UnityEngine.Shader
local LOCK_OUTLINE_WIDTH_ID = UnityShader.PropertyToID("_LockWidthInViewByCode")
local OPEN_PCF_SFOT = UnityShader.PropertyToID("_OPEN_PCF_SFOT")
local APPLY_CUSTOM_DIST_FOG = UnityShader.PropertyToID("_APPLY_CUSTOM_DIST_FOG")
local CustomShadowIntensity = UnityShader.PropertyToID("_CustomShadowIntensity")
local CUSTOM_POINT_LIGHT_FOR_SCENE = UnityShader.PropertyToID("_CUSTOM_POINT_LIGHT_FOR_SCENE")
local JOYSTICK_DIR = Vec3.New(0, 0, 0)
local JOYSTICK_TARGET_DIR = Vec3.New(0, 0, 0)
local MAIN_SCENE_ID = Config.MAIN_SCENE_ID
local TEST_SCENE_ID = 101
local UID_IDX = CommonDefine.SCENE_UUID_OFFSET
local Quat = require("base.quat")
local SCENE_ROOT = "Root"
local CHANGE_ROOT_NAME = "Change"
local LIGHT_ROOT_NAME = "Light"
local SKYBOX_ROOT_NAME = "SkyBox"
local CSLight = UnityEngine.Light
local TypeSceneContainer = typeof(CS.Game.SceneContainer)
local TYPE_EFFECT_STATUS = TypeEffectStatus
local search_target_param = {}
local M = Util.create_class()
local CollideInfo = Util.create_class()
local reversible_scene_timeline_dic

function CollideInfo:_init(missile, other, cid, dist, part_cid)
  self.missile = missile
  self.other = other
  self.cid = cid
  self.dist = dist
  self.part_cid = part_cid
  self.fixed_frame = Global.fixed_frame_id
  self.can_use = true
end

function CollideInfo:on_destroy()
  self.missile = nil
  self.other = nil
  self.cid = nil
  self.dist = nil
  self.part_cid = nil
  self.can_use = nil
  self.fixed_frame = nil
end

local RemoveMissileInfo = Util.create_class()

function RemoveMissileInfo:_init(luaobj, skip_check_limit, need_explosion)
  self[1] = luaobj
  self[2] = skip_check_limit
  self[3] = need_explosion
end

function RemoveMissileInfo:on_destroy()
end

function M:_init()
  self.loading = false
  self.v_scene_rpc = require("manager.scene.scene_rpc"):new(self)
  self.v_collide_info_pool = LuaObjPoolMgr.get_pool("collide_info_pool") or LuaObjPoolMgr.register("collide_info_pool", 50, CollideInfo)
  self.v_remove_missile_pool = LuaObjPoolMgr.get_pool("remove_missile_pool") or LuaObjPoolMgr.register("remove_missile_pool", 50, RemoveMissileInfo)
  self:clear_scene()
  self.v_first_enter = false
  self.v_pause_update = false
  self.v_player_control = true
  self.v_our_camp_betarget = false
  self.v_temp_our_camp_betarget = false
  Util.bind_msg(self, Const.MSG_ADD_TRANSPARENT_OBJ, self._on_add_transparent_obj, self)
  Util.bind_msg(self, Const.MSG_DEL_TRANSPARENT_OBJ, self._on_del_transparent_obj, self)
  Util.bind_msg(self, Const.MSG_NETWORK_RCT_SUC, self._on_reconnect, self)
  Util.bind_msg(self, Const.MSG_NETWORK_FIGHT_RCT_SUC, self._on_fight_reconnect, self)
  Util.bind_msg(self, Const.MSG_CG_TIMELINE_START, self.hide_npc_hp_obj, self)
  Util.bind_msg(self, Const.MSG_CG_TIMELINE_END, self.show_npc_hp_obj, self)
  Util.bind_msg(self, Const.MSG_ON_FIGHT_OVER_WIN_OPEN, self.on_fight_over_win_open, self)
  self.v_limited_missiles = {}
  self.v_jump_floor_ui = false
  self:clear_recreate_hero_count()
  self.v_npc_pool_mgr = Global.npc_pool_mgr
end

function M:set_born_dir(dir)
  self.v_born_dir = dir
end

function M:can_update()
  return not self.v_pause_update and not Global.is_enter_room_failed
end

function M:update(delta_time)
  local can_update = self:can_update()
  if self.is_main_scene then
    return
  end
  if Global.is_enter_room_failed or not Util.is_story_only() and not Global.hero then
    return
  end
  if can_update then
    self:_update_collider()
  end
  if not self.v_scene_logic then
    if not Util.is_client_only() then
      local room = TowerMgr:get_cur_room() or TowerMgr:get_story_room()
      if room then
        room:update(delta_time)
      end
    end
    return
  end
  if can_update and Network:is_fs_connected() or Util.is_client_only() then
    BehaviorMgr:update()
  end
  self.v_scene_logic:update(delta_time)
  local need_low_update = Global.low_update
  if can_update then
    if self.v_skill_link_mgr then
      self.v_skill_link_mgr:update()
    end
    self.v_scene_plat_mgr:update()
    if self.v_operate_chars then
      for _, hero in pairs(self.v_operate_chars) do
        if hero:can_update() then
          hero:update()
          if need_low_update then
            hero:low_update()
          end
        end
      end
    end
    if self.v_missile_map then
      self.v_missile_add_lock = true
      for _, missile in pairs(self.v_missile_map) do
        missile:update()
        if need_low_update then
          missile:low_update()
        end
      end
      self.v_missile_add_lock = false
      self:_check_delay_add_missile()
    end
    if self.v_npc_map then
      if need_low_update then
        self.v_temp_our_camp_betarget = false
      end
      for _, npc in pairs(self.v_npc_map) do
        if npc and not npc:is_destroy() then
          npc:update()
          if need_low_update then
            npc:low_update()
            if not self.v_temp_our_camp_betarget and not self:check_main_scene() and npc:is_monster() and npc:get_target() then
              self.v_temp_our_camp_betarget = true
            end
          end
        end
      end
    end
    if self.v_temp_our_camp_betarget ~= self.v_our_camp_betarget then
      self.v_our_camp_betarget = self.v_temp_our_camp_betarget
      if Global.camera and Global.camera:get_camera_mode() ~= Config.CAMERA_VIEW_TYPE.SHOULDER then
        Global.camera:on_in_fight_state_changed(self.v_our_camp_betarget)
      end
    end
    if self.v_fun_npc_map then
      for _, fun_npc in pairs(self.v_fun_npc_map) do
        if fun_npc and not fun_npc:is_destroy() then
          fun_npc:update()
          if need_low_update then
            fun_npc:low_update()
          end
        end
      end
    end
    if self.v_scene_effect_mgr then
      self.v_scene_effect_mgr:update()
    end
    if self.v_global_scale_duration then
      self.v_elapse = self.v_elapse + Global.delta_time
      if self.v_elapse > self.v_global_scale_duration then
        if self.v_scene_effect_mgr then
          self.v_scene_effect_mgr:update_speed(nil, false)
        end
        self.v_global_scale_duration = nil
        self.v_elapse = nil
      end
    end
    if self.v_scene_item_mgr then
      self.v_scene_item_mgr:update()
    end
    if self.v_god_npc then
      self.v_god_npc:update()
      if need_low_update then
        self.v_god_npc:low_update()
      end
    end
  end
  BehaviorShareMgr:update()
  MagicReporter:update()
  self.v_transparent_update_count = (self.v_transparent_update_count + 1) % TRANSPARENT_UPDATE_INTERVAL
  if 0 == self.v_transparent_update_count then
    self:_update_building_transparent()
  end
  self:_update_cs_hero()
  if UNITY_EDITOR_WIN and can_update and Global.CollectionMagicInfo and Global.MagicPool then
    Global.MagicPool:collection_active_magic_info()
  end
end

local last_hero

function M:_update_cs_hero()
  local cur_hero = Global.hero
  if Util.is_destroy(cur_hero) or not cur_hero:can_update() then
    return
  end
  if last_hero == cur_hero then
    return
  end
  last_hero = cur_hero
  local hero_cs_gameobj = cur_hero.gameobj.gameObject
  CSGameMgr.Hero = hero_cs_gameobj
  CSGameMgr.HeroTrans = hero_cs_gameobj.transform
  if self.v_crilisten_pos and not Util.is_nil(self.v_crilisten_pos) then
    self.v_crilisten_pos:ObjBind(hero_cs_gameobj.transform)
  end
end

function M:_update_cs_isfight(isfight)
  CSGameMgr.InGameFight = isfight
  CSGameMgr.timeLineShadow = false
end

function M:_check_delay_add_missile()
  local wait_map = self.v_wait_add_missile_map
  local map = self.v_missile_map
  if next(wait_map) then
    for id, missile in pairs(wait_map) do
      map[id] = missile
      wait_map[id] = nil
    end
  end
end

function M:late_update()
  if Global.is_enter_room_failed or not Global.hero then
    return
  end
  if self.v_scene_logic then
    self.v_scene_logic:late_update()
  end
  if self:can_update() then
    if Global.camera then
      Global.camera:late_update()
    end
    if self.v_scene_plat_mgr then
      self.v_scene_plat_mgr:late_update()
    end
    if self.v_operate_chars then
      for uuid, hero in pairs(self.v_operate_chars) do
        hero:late_update()
      end
    end
    if self.v_missile_map then
      self.v_missile_add_lock = true
      for _, missile in pairs(self.v_missile_map) do
        missile:late_update()
      end
      self.v_missile_add_lock = false
      self:_check_delay_add_missile()
    end
    if self.v_npc_map then
      for _, npc in pairs(self.v_npc_map) do
        if npc and not npc:is_destroy() then
          npc:late_update()
        end
      end
    end
    local remove_missiles = self.v_remove_missile_pool:get_active_objs()
    for info, _ in pairs(remove_missiles) do
      self:remove_missile(info[1], info[2], info[3])
    end
    self.v_remove_missile_pool:release_active_objs()
  end
end

function M:fixed_update()
  if Global.is_enter_room_failed or not Global.hero then
    return
  end
  if self.is_main_scene then
    return
  end
  SyncTransforms()
  local can_update = self:can_update()
  if not can_update then
    return
  end
  if self.v_missile_map then
    self.v_missile_add_lock = true
    for _, missile in pairs(self.v_missile_map) do
      missile:fixed_update()
    end
    self.v_missile_add_lock = false
  end
end

function M:pick_by_uuid(uuid)
  if not uuid then
    return nil
  end
  return self.v_uuid_map[uuid]
end

function M:pick_by_luaid(luaid)
  return self.v_luaid_map[luaid]
end

function M:pick_by_cid(cid)
  local result = self.v_cid_map[cid]
  result = result or self.v_fun_npc_instance_id_map[cid]
  return result
end

function M:on_enter_main_scene()
  reversible_scene_timeline_dic = nil
  if UIMgr then
    UIMgr:set_default_camera_obj_visible(true)
  end
  if not self:try_enter_scene(MAIN_SCENE_ID) then
    self:on_load_scene()
  end
  self:clear_god_npc()
  self.v_group_ctrl_obj_container = nil
  self.v_group_ctrl_obj = nil
  self.v_root_container = nil
  self.v_root_obj = nil
end

function M:add_reversible_scene_timeline_dic(key, value)
  if nil == reversible_scene_timeline_dic then
    reversible_scene_timeline_dic = {}
  end
  reversible_scene_timeline_dic[key] = value
end

function M:reset_reversible_scene_timeline_dic()
  if reversible_scene_timeline_dic then
    for i, v in pairs(reversible_scene_timeline_dic) do
      if i and Util.is_nil(v) == false then
        v:Reset()
      end
    end
  end
end

function M:try_enter_scene(scene_id, is_tp_next_floor, enter_scene_data, need_reload_same_scene)
  if not need_reload_same_scene and self.v_scene_id == scene_id then
    return false
  end
  if scene_id ~= TEST_SCENE_ID then
    Global.sound_mgr:set_audio_active(false, true)
  end
  self.v_target_scene_id = scene_id
  self.v_target_scene_cfg = ShareRes.create("scene", scene_id)
  self.v_enter_scene_data = enter_scene_data
  self.is_main_scene = scene_id == MAIN_SCENE_ID
  assert(self.v_target_scene_cfg, "can't find scene cfg: " .. scene_id)
  if Global.sound_mgr and not self.is_main_scene then
    Global.sound_mgr:stop_main_bgm()
  end
  if self.is_main_scene then
    if Global.sound_mgr then
      Global.sound_mgr:bgm2_stop()
    end
    UIMgr:clear_ui_stack(Config.UI_STACK_TYPE.FIGHT_SCENE)
  else
    BehaviorLoader:on_enter_battle_scene()
  end
  self:_update_cs_isfight(not self.is_main_scene)
  Global.gamemode:set_is_tp_next_floor(true)
  Global.gamemode:gmode_set_mode(Const.MODE_LOAD_SCENE)
  return true
end

function M:check_main_scene()
  return self.is_main_scene
end

function M:check_main_scene_loaded()
  return self.v_scene_id == MAIN_SCENE_ID
end

function M:get_enter_scene_data()
  return self.v_enter_scene_data
end

function M:get_target_scene_id()
  return self.v_target_scene_id, self.v_enter_scene_data
end

function M:get_target_scene_type()
  return self.v_target_scene_cfg and self.v_target_scene_cfg.scene_type or 0
end

function M:get_tartget_scene_config()
  return self.v_target_scene_cfg
end

function M:set_scene_id(scene_id)
  self.v_scene_id = scene_id
  self.v_scene_cfg = ShareRes.create("scene", scene_id)
end

function M:get_scene_id()
  return self.v_scene_id
end

function M:get_scene_cfg()
  return self.v_scene_cfg
end

function M:get_scene_name()
  local scene_cfg = self:get_scene_cfg()
  if not scene_cfg then
    return nil
  end
  return scene_cfg.SceneName
end

function M:get_scene_npc_cfg()
  return self.v_scene_config
end

function M:get_scene_type()
  return self.v_scene_cfg and self.v_scene_cfg.scene_type or 0
end

function M:get_scene_type_by_id(scene_id)
  return ShareRes.create("scene", scene_id).scene_id
end

function M:reset_target_scene_id()
  self.v_target_scene_id = nil
  self.v_target_scene_cfg = nil
end

function M:init_scene_root_objs()
  local root_obj = UnityFind(Config.SceneRootName)
  if root_obj and not root_obj:IsNull() then
    self.v_root_obj = root_obj
    self.v_root_container = root_obj:GetComponent(TypeSceneContainer)
  end
  local group_ctrl_obj = UnityFind(Config.SceneGroupCtrlObjName)
  if group_ctrl_obj and not group_ctrl_obj:IsNull() then
    self.v_group_ctrl_obj = group_ctrl_obj
    self.v_group_ctrl_obj_container = group_ctrl_obj:GetComponent(TypeSceneContainer)
  end
end

function M:get_group_ctrl_container()
  return self.v_group_ctrl_obj_container
end

function M:get_root_container()
  return self.v_root_container
end

function M:on_load_scene()
  CSGameMgr.CSOnLoadScene()
  CSShadow.SetCameraShader()
  self:set_scene_id(self.v_target_scene_id)
  GeCaoBattleMgr:reset_show_status()
  if not StoryMgr:is_playing_story() then
    UIMgr:try_destory_ui("uistory")
    UIMgr:try_destory_ui("ui_blackfade")
  end
  if Global.sound_mgr then
    Global.sound_mgr:clear_bgm_setting()
  end
  UnityShader.SetGlobalFloat(CustomShadowIntensity, 1)
  UnityShader.SetGlobalFloat(CUSTOM_POINT_LIGHT_FOR_SCENE, 0)
  if self.is_main_scene then
    self:_on_load_main_scene()
    if UIMgr then
      UIMgr:get_ui("ui_click_effect"):ui_show()
    end
    if Global.sound_mgr then
      Global.sound_mgr:reset_bgm_state()
      Global.sound_mgr:scene_switch_clear()
    end
    UnityShader.SetGlobalFloat(LOCK_OUTLINE_WIDTH_ID, 0)
    UnityShader.SetGlobalFloat(OPEN_PCF_SFOT, 1)
    UnityShader.SetGlobalFloat(APPLY_CUSTOM_DIST_FOG, 1)
  else
    self:set_curtain_show(true)
    UnityShader.SetGlobalFloat(LOCK_OUTLINE_WIDTH_ID, 0)
    UnityShader.SetGlobalFloat(OPEN_PCF_SFOT, 0)
    UnityShader.SetGlobalFloat(APPLY_CUSTOM_DIST_FOG, 0)
    CSGrassRenderer.cam = Global.camera:get_camera()
    if Global.sound_mgr then
      Global.sound_mgr:voice_sound_up()
      Global.sound_mgr:reset_fade_sound()
    end
    self:init_scene_root_objs()
  end
  self.v_scene_effect_mgr = require("manager.scene.scene_effect_mgr"):new()
  self.v_time_keeper_mgr = require("manager.fight.time_keeper_mgr"):new()
  if not self.is_main_scene then
    self.v_scene_item_mgr = require("manager.scene.scene_item_mgr"):new()
    self.v_skill_link_mgr = require("gamelogic.fight.skill_link_mgr"):new()
  end
  self.v_scene_plat_mgr = require("manager.scene.scene_platform_mgr"):new()
  self.v_special_terrain_mgr = require("manager.scene.scene_special_terrain_mgr"):new()
  local container = SceneMgr:get_root_container()
  if container then
    self.v_special_terrain_mgr:load_scene_special_terrain(container)
  end
  if not self.is_main_scene then
    if self:check_on_load_scene_story() then
      self:set_curtain_show(true)
      return
    end
    self.v_limited_missiles = {}
  end
  if self.v_camera then
    self.v_camera:SetActive(false)
    self.v_camera:SetActive(true)
  end
  if Global.camera then
    Global.camera:try_enter_scene()
  end
  if Global.missile_movement_pool_mgr then
    Global.missile_movement_pool_mgr:release_all()
  end
  MsgGame:mq_publish2(Const.MSG_SCENE_LOAD)
  if Util.is_client_only() then
    self.v_gm_room:enter_room()
  elseif Util.is_story_only() then
    local story_room = TowerMgr:get_story_room()
    story_room:enter_room()
  else
    local cur_room = TowerMgr:get_cur_room()
    if cur_room then
      cur_room:enter_room(true)
    end
  end
end

function M:check_on_load_scene_story()
  local function cb()
    MsgGame:mq_publish2(Const.MSG_SCENE_LOAD)
    
    local cur_room = TowerMgr:get_cur_room()
    if cur_room then
      cur_room:enter_room(true)
    end
  end
  
  if TowerMgr and TowerMgr:check_play_fight_story(true, cb) then
    return true
  end
end

function M:play_tower_sound(is_check)
  if not TowerMgr then
    return
  end
  local tower = TowerMgr:get_tower()
  if not tower then
    return
  end
  local tower_id = tower:get_tower_id()
  if 100 == tower_id and (tower:get_cur_floor_id() == 1001 or tower:get_cur_floor_id() == 1003 or tower:get_cur_floor_id() == 1004) then
    return
  end
  local tower_cfg = ShareRes.create("tower.tower", tower_id)
  Util.assert(tower_cfg, "can't find tower cfg: " .. tower_id)
  local bgm_id = tower_cfg.BGMId
  self.v_cur_tower_sound = bgm_id
  local env_cfg = ShareRes.get_map_env_bgm(self:get_scene_name(), tower:get_diff_light_index())
  local switch_bgm = Global.sound_mgr:get_epi_switch_bgm2()
  if switch_bgm then
    Global.sound_mgr:play_sound_by_id(switch_bgm, nil, nil, nil, nil, nil, true)
  elseif nil ~= env_cfg then
    Global.sound_mgr:play_sound_by_id(env_cfg.EvnBGMId, nil, nil, nil, nil, nil, true)
  elseif tower_cfg.EvnBGMId then
    Global.sound_mgr:play_sound_by_id(tower_cfg.EvnBGMId, nil, nil, nil, nil, nil, true)
  end
  if not bgm_id or "" == bgm_id then
    return
  end
  if not is_check and tower:check_play_prewar_story() then
    local cur_bgm = Global.sound_mgr:get_epi_switch_bgm() or bgm_id
    Global.sound_mgr:set_last_bgm_id(cur_bgm)
    return
  end
  Global.sound_mgr:enter_tower_flag()
  local play_bgm_id = Global.sound_mgr:get_epi_switch_bgm() or bgm_id
  Global.sound_mgr:play_sound_by_id(play_bgm_id)
  self.v_cur_tower_sound = play_bgm_id
end

function M:get_tower_sound()
  return self.v_cur_tower_sound
end

function M:_on_load_main_scene()
  UIMgr:try_destory_ui("fight")
  FightHudMgr.clear_hud_config()
  UIMgr:show_main_leave_tower()
  Network:quit_fs()
  Global.sound_mgr:sound_release()
  Global.sound_mgr:set_audio_active(true, true)
  self:clear_offset_shadow()
  self:clear_scene_data(true)
  CSGameMgr.OnEnterMainScene()
end

function M:clear_scene(is_clear_all)
  Global.scene_loader:clear()
  if TimeLineMgr then
    TimeLineMgr:clear_curr_scene_preload_timeline()
  end
  if self.v_scene_effect_mgr then
    self.v_scene_effect_mgr:release()
    self.v_scene_effect_mgr = nil
  end
  if self.v_scene_item_mgr then
    self.v_scene_item_mgr:release()
    self.v_scene_item_mgr = nil
  end
  if self.v_special_terrain_mgr then
    self.v_special_terrain_mgr:on_clear_scene()
    self.v_special_terrain_mgr = nil
  end
  if self.v_skill_link_mgr then
    self.v_skill_link_mgr:on_destroy()
    self.v_skill_link_mgr = nil
  end
  self:clear_scene_data(is_clear_all)
  if Global.share_state_report then
    Global.share_state_report:clear()
    Global.share_state_report = nil
  end
  self.v_scene_config = nil
  self.v_scene_id = nil
  if TowerMgr and not TowerMgr:get_tower() then
    BehaviorMgr:clear_all(true)
  end
  collectgarbage("collect")
end

function M:before_enter_next_room()
  self:clear_scene_data()
end

function M:clear_scene_data(is_clear_all)
  self.v_cur_ill = nil
  self.v_main_light = nil
  search_target_param = {}
  self.v_be_cleaning_up_scene_data = true
  self:_clear_collide_info()
  self:clear_missile(true)
  self.v_uuid_map = {}
  self.v_kind_to_uuid_map = {}
  self.v_magic_to_uuid_map = {}
  self.v_npc_id_to_uuid_map = {}
  if self.v_cid_map then
    for cid, luaobj in pairs(self.v_cid_map) do
      if luaobj:is_destroy() then
        self.v_cid_map[cid] = nil
      elseif is_clear_all or not luaobj:is_hero() then
        self:_destroy_luaobj(luaobj)
      end
    end
  end
  self.v_fun_npc_instance_id_map = {}
  if self.v_fun_npc_map then
    for _, fun_npc in pairs(self.v_fun_npc_map) do
      self:_destroy_luaobj(fun_npc)
    end
  end
  if self.v_scene_obj_map then
    for _, scene_obj in pairs(self.v_scene_obj_map) do
      self:_destroy_luaobj(scene_obj)
    end
  end
  if self.v_scene_plat_mgr then
    self.v_scene_plat_mgr:clear()
  end
  if is_clear_all then
    self.v_scene_plat_mgr = nil
    self.v_limited_missiles = nil
  end
  if self.v_time_keeper_mgr then
    self.v_time_keeper_mgr:clear()
  end
  if Cinemachine then
    Cinemachine:clear_ct()
  end
  self.v_missile_map = {}
  self.v_missile_add_lock = false
  self.v_wait_add_missile_map = {}
  self.v_obstacle_missile = {}
  self.v_cid_map = {}
  self.v_terrain_collider_cid_map = {}
  self.v_npc_map = {}
  self.v_fun_npc_map = {}
  self.v_fun_npc_instance_id_map = {}
  self.v_scene_obj_map = {}
  self.v_group_npc_num = {}
  self.v_collide_info_pool:release_active_objs()
  self.v_remove_missile_pool:release_active_objs()
  self:set_game_pause(false)
  if self.v_operate_chars then
    for uuid, hero in pairs(self.v_operate_chars) do
      if not is_clear_all then
        self.v_cid_map[hero.cid] = hero
        self:add_obj_to_uuid_map(uuid, hero)
        hero.act_effect_ctrl:stop_all(true)
        hero.skill_mgr:clear_missile_cache()
      else
        self:_destroy_luaobj(hero)
        self.v_operate_chars[uuid] = nil
      end
    end
  end
  if self.v_god_npc then
    if not is_clear_all then
      local god_uuid = self.v_god_npc.uuid
      self:add_obj_to_uuid_map(god_uuid, self.v_god_npc)
    else
      self:clear_god_npc()
    end
  end
  if self.v_scene_logic then
    self.v_scene_logic:release()
  end
  self.v_scene_logic = nil
  self.v_scene_map = nil
  if self.v_transparent_dict then
    for transparent in pairs(self.v_transparent_dict) do
      if transparent and not transparent:IsNull() then
        transparent:OnRayExit()
      end
    end
  end
  self.v_transparent_update_count = 0
  self.v_transparent_comps = {}
  self.v_transparent_dict = {}
  if self.scene_effect_mgr then
    self.scene_effect_mgr:clear_effect_list()
  end
  if MissileConfigHookMgr then
    MissileConfigHookMgr:clear()
  end
  self.v_gm_terrain_list = self.v_gm_terrain_list or {}
  for _, obj in pairs(self.v_gm_terrain_list) do
    ResPool:release(obj)
  end
  self.v_gm_terrain_list = {}
  last_hero = nil
  if FunctionalNpcMgr then
    FunctionalNpcMgr:release_all()
  end
  self.v_be_cleaning_up_scene_data = false
  Config.FightDefine.release_single_attr_temp()
  self.m_scene_timeline_animator_list = nil
end

function M:clear_missile(force)
  self.v_be_cleaning_up_missile = true
  if self.v_missile_map then
    for key, missile in pairs(self.v_missile_map) do
      if force or missile.missile_cfg.DeleteOnSettle then
        self:_destroy_luaobj(missile)
      end
    end
    UtilTable.clear_map(self.v_missile_map)
  end
  if self.v_wait_add_missile_map then
    for key, missile in pairs(self.v_wait_add_missile_map) do
      if force or missile.missile_cfg.DeleteOnSettle then
        self:_destroy_luaobj(missile)
      end
    end
    UtilTable.clear_map(self.v_wait_add_missile_map)
  end
  self.v_be_cleaning_up_missile = false
end

function M:clear_hero_magic_on_settle()
  if not self.v_hero_list then
    return
  end
  for key, hero in pairs(self.v_hero_list) do
    if not Util.is_destroy(hero) then
      hero.magic_mgr:on_settle()
    end
  end
end

function M:add_obj_to_uuid_map(uuid, obj)
  self.v_uuid_map[uuid] = obj
  if not obj.magic_mgr then
    return
  end
  if obj.character_cfg then
    self:add_to_npc_id_to_uuid_map(obj.character_cfg.NpcId, uuid)
    self:add_to_kind_to_uuid_map(obj.character_cfg.Kind, uuid)
  else
    Log.Info("调试 -- 添加obj到uuid时 character_cfg 为空", debug.traceback())
  end
end

function M:remove_obj_at_uuid_map(uuid, obj)
  self.v_uuid_map[uuid] = nil
  if not obj.magic_mgr then
    return
  end
  if obj.character_cfg then
    self:remove_at_npc_id_to_uuid_map(obj.character_cfg.NpcId, uuid)
    self:remove_at_kind_to_uuid_map(obj.character_cfg.Kind, uuid)
  else
    Log.Info("调试 -- 从uuid移除obj时 character_cfg 为空", debug.traceback())
  end
end

function M:get_scene()
  return ShareRes.create("scene", self.v_scene_id)
end

function M:sync_hero_status(sync_hero_info)
  local sync_attr_list = sync_hero_info.hero_base_attrs or {}
  local hero = Global.hero
  if not hero then
    return
  end
end

function M:create_hero(data, init_data)
  self.v_hero_list = self.v_hero_list or {}
  self.v_robot_hero_list = self.v_robot_hero_list or {}
  self.v_operate_chars = self.v_operate_chars or {}
  local uuid
  if Util.is_client_only() then
    uuid = self:get_uuid()
  else
    uuid = data.uuid
  end
  local hero = require("obj.hero"):new()
  local born_pos = DebugSetting:get_born_pos()
  hero:set_team_pos(data.team_pos)
  hero:buddy_type(data.buddy_type)
  self:_create_cobj(hero, born_pos.x, born_pos.y, born_pos.z, data, init_data)
  local is_robot = init_data and init_data.is_robot or false
  hero:set_is_robot_hero(is_robot)
  if is_robot then
    self.v_robot_hero_list[uuid] = hero
  else
    self.v_hero_list[uuid] = hero
  end
  self:add_obj_to_uuid_map(uuid, hero)
  self.v_operate_chars[uuid] = hero
  hero.uuid = uuid
  hero:check_module_attrs()
  if not StateReport then
    self.v_report_hero_state = true
  end
  return hero
end

function M:set_heros_team_pos(data)
  self.v_heros_team_pos = data
end

function M:get_heros_team_pos()
  return self.v_heros_team_pos or {}
end

function M:clear_character_renderer(uuid)
  local hero = self.v_hero_list[uuid]
  if not hero then
    return
  end
  hero:clear_renderer_info()
end

function M:client_create_team()
  if Util.is_client_only() then
    if self.v_hero_list then
      for key, hero in pairs(self.v_hero_list) do
        self:remove_hero(hero)
      end
    end
    local temp_team = {}
    local count = 0
    local role_list = DebugSetting:get_role_list()
    for i = 1, 3 do
      if 0 ~= role_list[i] then
        count = count + 1
        table.insert(temp_team, {
          id = role_list[i],
          uuid = count * 10 + 1,
          pos = count
        })
      end
    end
    if 0 == count then
      Log.Error("请在Service界面至少填上一个合法的roleId")
    end
    self:create_team(1, temp_team)
  end
end

function M:create_team(main_pos, team)
  self.v_hero_list = {}
  for i = 1, #team do
    local info = team[i]
    local id = info.id
    if 0 ~= id then
      local buddy_cfg = ShareRes.create("buddy.buddy", id)
      local buddy_data, buddy_type = FixedBuddyMgr:get_gm_fight_or_client_only_buddy_info(id, true)
      buddy_data.uuid = info.uuid
      buddy_data.role_id = id
      buddy_data.buddy_type = buddy_type
      local hero = SceneMgr:create_hero(buddy_data)
      hero.buddy_cfg = buddy_cfg
      if main_pos ~= info.pos then
        hero:on_to_background_state(nil, true)
      else
        hero:on_to_control_state(true)
      end
    end
  end
end

function M:check_create_hero()
  if TowerMgr and TowerMgr:need_check_create_hero() then
    self:create_hero_by_battle_team_info()
    TowerMgr:set_recreate_hero()
    TowerMgr:set_create_hero()
    BattleSkillBookMgr:init_hero_btn_skill()
  end
end

function M:create_hero_by_battle_team_info()
  local battle_team_info = TowerMgr and TowerMgr:get_battle_team_info()
  if not battle_team_info then
    Log.Error("战斗编队不存在，将无法创建角色")
    return
  end
  local is_recreate = TowerMgr:check_recreate_hero()
  if self.v_hero_list then
    for key, hero in pairs(self.v_hero_list) do
      self:remove_hero(hero)
      is_recreate = true
    end
  end
  local main_pos, team = battle_team_info.main_pos, battle_team_info.hero_list
  if is_recreate then
    self:add_recreate_hero_count(#team)
  end
  for _, buddy_data in ipairs(team) do
    local hero = self:new_hero(buddy_data)
    if is_recreate then
      self:after_recreate_hero(hero)
    elseif main_pos ~= buddy_data.pos then
      hero:on_to_background_state(nil, true)
    else
      hero:on_to_control_state(true)
    end
  end
end

function M:creat_single_hero(id, is_recreate)
  if self.v_scene_logic then
    return
  end
  local info = TowerMgr:get_battle_team_info()
  local main_pos, team = info.main_pos, info.hero_list
  for _, buddy_data in ipairs(team) do
    local data = buddy_data.data
    local buddy_id = data.id
    if buddy_id == id then
      local hero = self:new_hero(buddy_data)
      if is_recreate then
        self:after_recreate_hero(hero)
        break
      end
      if main_pos ~= buddy_data.pos then
        hero:on_to_background_state(nil, true)
        break
      end
      hero:on_to_control_state(true)
      break
    end
  end
end

function M:after_recreate_hero(recreate_hero)
  if TowerMgr then
    if TowerMgr:get_tower() and not TowerMgr:get_tower():is_first_enter() then
      BattleSkillBookMgr:init_single_hero_btn_skill(recreate_hero.uuid, recreate_hero)
      recreate_hero:on_enter_room(self.v_scene_logic)
      self.v_recreate_suc_hero_count = self.v_recreate_suc_hero_count + 1
    end
    if self.v_recreate_suc_hero_count >= self.v_recreate_hero_count then
      local info = TowerMgr:get_battle_team_info()
      local main_pos = info.main_pos
      local keycode = Config.INPUT_CODE.QTE1
      for _, hero in pairs(self.v_hero_list) do
        if hero:get_team_pos() == main_pos then
          hero:on_to_control_state(true)
        else
          hero:on_to_background_state(keycode, true)
          keycode = keycode + 1
        end
      end
      self:on_new_hero_done(Global.hero)
      self:clear_recreate_hero_count()
    end
  end
end

function M:new_hero(buddy_data)
  local data = buddy_data.data
  local buddy_id = data.id
  local buddy_cfg = ShareRes.create("buddy.buddy", buddy_id)
  local new_data = UtilTable.copy_table(data)
  new_data.uuid = buddy_data.uuid
  new_data.role_id = buddy_id
  new_data.team_pos = buddy_data.pos
  new_data.buddy_type = buddy_data.type
  new_data.advance = data.advance_lv
  local hero = self:create_hero(new_data)
  hero.buddy_cfg = buddy_cfg
  return hero
end

function M:replace_team_pos_data(new_data)
  local uuid = new_data.replace_id
  local hero_data = new_data.hero
  local replace_pos = hero_data.pos
  local main_pos = new_data.main_pos
  local is_go_back = new_data.replace_type == CommonDefine.REPLACE_HERO_TYPE.GOBACK
  local is_background = true
  local hero_in_team = false
  local need_remove_hero, new_hero
  for uuid, hero in pairs(self.v_hero_list) do
    local pos = hero:get_team_pos()
    if is_go_back and main_pos == pos then
      new_hero = hero
      is_background = false
    end
    if pos == replace_pos then
      hero_in_team = true
      if not is_go_back then
        is_background = hero:check_background()
      end
      need_remove_hero = hero
    end
  end
  if not is_go_back then
    local function load_done_callback()
      new_hero:on_enter_room(self.v_scene_logic)
      
      if not hero_in_team then
        new_hero:setup_born_behavior()
      end
      BattleSkillBookMgr:init_single_hero_btn_skill(new_hero.uuid, new_hero)
      self:on_new_hero_done(Global.hero)
    end
    
    new_hero = self:new_hero(hero_data)
    if not new_hero:is_real_finish_init() then
      new_hero:set_finish_init_gameobj_cb(load_done_callback)
    else
      load_done_callback()
    end
  end
  local msg = MsgGame:mq_publish2(Const.MSG_ON_REPLACE_TEAM_POS_CHAR)
  msg.mm_x = uuid
  msg.mm_y = true
  if not is_background then
    if Global.hero_uuid ~= new_hero.uuid then
      new_hero:on_to_control_state()
      if Global.camera then
        Global.camera:stop_follow_tar()
        Global.camera:set_target(new_hero)
      end
      self:create_scene_effect("Fx_Switch_Hero", new_hero:get_pos_vec3(), 2)
    end
  else
    new_hero:on_to_background_state()
  end
  if need_remove_hero then
    self:_destroy_luaobj(need_remove_hero)
  end
end

function M:reborn_npc_by_uuid(uuid, dispatch)
  if not self.v_hero_list then
    return
  end
  local hero = self.v_hero_list[uuid]
  if not hero then
    return
  end
  local attr_ratio_map = TowerMgr:get_reborn_attr_ratio_map()
  hero:reset(nil, attr_ratio_map)
  if dispatch then
    BehaviorMgr:call_event_fun(BehaviorMgr.EVENTS.ON_HERO_REBORN, hero)
  end
end

function M:archieve_reborn_npc_by_uuid(uuid)
  if not self.v_hero_list then
    return
  end
  local hero = self.v_hero_list[uuid]
  if not hero then
    return
  end
  local attr_ratio_map = TowerMgr:get_reborn_attr_ratio_map()
  hero:reset(nil, attr_ratio_map)
  BehaviorMgr:call_event_fun(BehaviorMgr.EVENTS.ON_HERO_REBORN, hero)
end

function M:get_hero_by_uuid(uuid)
  return self.v_hero_list[uuid]
end

function M:get_hero_by_id(buddy_id)
  for _, hero in pairs(self.v_hero_list) do
    local now_buddy_id = hero:get_npc_id()
    if buddy_id == now_buddy_id then
      return hero
    end
  end
end

function M:get_hero_by_pos(pos)
  for _, hero in pairs(self.v_hero_list) do
    if pos == hero:get_team_pos() then
      return hero
    end
  end
end

function M:get_wait_hero()
  local wait_hero_list = {}
  for uuid, hero in pairs(self.v_hero_list) do
    if uuid ~= Global.hero_uuid then
      table.insert(wait_hero_list, hero)
    end
  end
  return wait_hero_list
end

function M:get_hero_list()
  return self.v_hero_list
end

local temp_hero_list = {}

function M:get_hero_list_except(uuid)
  UtilTable.clear_map(temp_hero_list)
  for _uuid, hero in pairs(self.v_hero_list) do
    if uuid ~= _uuid and not hero:is_die() and not hero:is_destroy() then
      _tinsert(temp_hero_list, hero)
    end
  end
  return temp_hero_list
end

function M:get_hero_id_list()
  local hero_id_list = {}
  for uuid, hero in pairs(self.v_hero_list) do
    local hero_id = hero.buddy_cfg.Id
    _insert(hero_id_list, hero_id)
  end
  return hero_id_list
end

function M:check_all_hero_hp_zero()
  if not self.v_hero_list then
    return false
  end
  for _, hero in pairs(self.v_hero_list) do
    local hp = hero.attr_mgr:get_hp()
    if hp > 0 then
      return false
    end
  end
  return true
end

function M:check_play_hero_born_sound(hero)
  if not TowerMgr then
    return
  end
  if not TowerMgr:check_init_ok() then
    return
  end
  if self.v_play_init_sound then
    return
  end
  if hero then
    self:play_born_sound(hero)
  elseif self.v_hero_list then
    for uuid, hero in pairs(self.v_hero_list) do
      if self:play_born_sound(hero) then
        return
      end
    end
  end
end

function M:play_born_sound(hero)
  if not hero:check_background() then
    local is_play_timeline = TowerMgr:check_cur_point_play_timeline()
    local tower = TowerMgr:get_tower()
    local is_pass_tower = tower:check_pass_all_room(true)
    if Global.state_sound_mgr and not is_play_timeline and not is_pass_tower then
      Global.state_sound_mgr:trigger_fight_state_by_id(Config.FIGHT_STATE.FIGHT_START_BORN)
    end
    self.v_play_init_sound = true
    return true
  end
end

function M:release_sound_state()
  self.v_play_init_sound = false
end

function M:get_missile_by_char(char)
  local tb = {}
  for _, v in pairs(self.v_missile_map) do
    if v:get_owner() == char then
      table.insert(tb, v)
    end
  end
  for _, v in pairs(self.v_wait_add_missile_map) do
    if v:get_owner() == char then
      table.insert(tb, v)
    end
  end
  return tb
end

function M:switch_hero(hero_uuid, keycode, cur_hero_background)
  if not Util.is_client_only() then
    Network:call("c2gs_switch_hero", {uuid = hero_uuid})
  end
  if not hero_uuid or not self.v_hero_list[hero_uuid] then
    Log.Error("switch error ")
    return
  end
  if hero_uuid == Global.hero_uuid then
    return
  end
  local cur_hero
  if Global.hero:get_is_robot_hero() then
    cur_hero = self.v_robot_hero_list[Global.hero_uuid]
  else
    cur_hero = self.v_hero_list[Global.hero_uuid]
  end
  local next_hero = self.v_hero_list[hero_uuid]
  if Global.camera then
    Global.camera:stop_follow_tar()
    Global.camera:set_target(next_hero)
    Global.camera:reset_attach_point(next_hero)
  end
  local area_mask = cur_hero:get_area_mask()
  if cur_hero_background then
    if not keycode then
      local fight = UIMgr:try_get_loaded_ui(UIMgr.FIGHT_UI_NAME)
      if fight then
        keycode = fight:get_keycode_by_uuid(next_hero.uuid)
      end
    end
    cur_hero:on_to_background_state(keycode)
  end
  next_hero:on_to_control_state()
  next_hero:set_area_mask(area_mask)
  SwitchHeroHelper.is_switching = false
  return true
end

function M:create_missile(owner, uuid, ...)
  if self.v_be_cleaning_up_scene_data then
    Log.Info("禁止在清理missile_map时创建子弹")
    return
  end
  if not owner or owner:is_destroy() then
    Log.Error("create_missile error owner is nil or destroy", select(1, ...), debug.traceback())
    return
  end
  local missile = Missile:new(owner, ...)
  if not missile then
    Log.Error("create_missile error", select(1, ...), debug.traceback())
    return
  end
  missile.id = uuid or self:get_uuid()
  self:setup_cobj(missile, ...)
  missile:create_emptygameobj()
  if self.v_missile_add_lock then
    self.v_wait_add_missile_map[missile.id] = missile
  else
    self.v_missile_map[missile.id] = missile
  end
  if missile:is_obstacle() then
    self:record_obstacle_missile(missile.id)
  end
  self:_add_limited_missile(missile)
  return missile
end

function M:mark_limited_missile(missile_id, max_count)
  if max_count > 20 then
    Log.Error("可以同时存在的missile数量超过20个")
    return
  end
  self.v_limited_missiles = self.v_limited_missiles or {}
  local info = self.v_limited_missiles[missile_id]
  if not info then
    info = {
      missiles = {},
      count = 0
    }
    self.v_limited_missiles[missile_id] = info
  end
  info.missile_id = missile_id
  info.max_count = max_count
end

function M:unmark_limited_missile(missile_id)
  self.v_limited_missiles[missile_id] = nil
end

function M:_add_limited_missile(missile)
  local missile_id = missile.missile_id
  local info = self.v_limited_missiles[missile_id]
  if not info then
    return
  end
  local missiles = info.missiles
  if info.count >= info.max_count then
    local first_missile = missiles[1]
    _tremove(missiles, 1)
    self:remove_missile(first_missile, true)
  else
    info.count = info.count + 1
  end
  _tinsert(missiles, missile)
end

function M:_remove_limited_missile(missile)
  local missile_id = missile.missile_id
  local info = self.v_limited_missiles[missile_id]
  if info then
    local missiles = info.missiles
    for idx, m in pairs(missiles) do
      if missile == m then
        _tremove(missiles, idx)
        info.count = info.count - 1
        break
      end
    end
  end
end

function M:record_obstacle_missile(missile_id)
  self.v_obstacle_missile[missile_id] = true
end

function M:check_obstacle_missile()
  return next(self.v_obstacle_missile)
end

function M:_init_vcamera_param()
  local global_camera = Global.camera
  if global_camera and global_camera:get_camera_mode() == Config.CAMERA_VIEW_TYPE.DEPRESSION then
    local far_clip_plane = 150
    CSCopyLens(self.v_vcam, self.v_camera.gameObject, 0.1, far_clip_plane)
  end
  self.v_vcam.Priority = 100
end

function M:create_camera(is_preload)
  if self.v_camera then
    if not is_preload then
      Global.camera:set_active(true)
      Global.camera:set_target(Global.hero)
      self:_init_vcamera_param()
    end
    return
  end
  self.v_camera = ResMgr:load_gameobj(Path.get_res_path(Config.GAME_CAMER_PREFAB), nil, true)
  self.v_camera.name = Config.CAMERA_NAME
  if self.v_crilisten_obj and not Util.is_nil(self.v_crilisten_obj.gameObject) then
    UnityDestroy(self.v_crilisten_obj)
    self.v_crilisten_obj = nil
  end
  self.v_crilisten_pos = Util.get_component("CriListener", self.v_camera.gameObject, TypePosBind)
  self.v_crilisten_pos:RotBind(self.v_camera.gameObject.transform)
  if self.v_crilisten_pos then
    self.v_crilisten_obj = self.v_crilisten_pos.gameObject
    self.v_crilisten_obj.transform.parent = nil
    UnityGameObject.DontDestroyOnLoad(self.v_crilisten_obj)
    self.v_crilisten_obj.transform:SetPositionA(-10000, 0, 0)
  end
  local vcamera_brain = self.v_camera:GetComponent(TypeCinemachineBrain)
  vcamera_brain.m_CustomBlends = Cinemachine:get_settings()
  local vcamera_obj = UnityGameObject("vcamera")
  vcamera_obj.transform:SetParent(self.v_camera.transform)
  vcamera_obj:ResetAttr()
  local vcam = vcamera_obj:AddComponent(TypeCinemaVirtalCamera)
  self.v_vcam = vcam
  Global.camera = require("obj.camera"):new(Global.hero, self.v_camera)
  Global.listener_mgr:add_listener(Global.camera, vcamera_brain, function(incoming_camera, outgoing_camera)
    Global.camera:camera_activated_event(incoming_camera, outgoing_camera)
  end)
  MsgGame:mq_publish2(Const.MSG_CREATE_CAMERA)
  return Global.camera
end

function M:destroy_camera()
  if Global.camera then
    Global.camera:on_destroy()
    Global.listener_mgr:remove_listener(Global.camera, self.v_camera:GetComponent(TypeCinemachineBrain))
  end
  if self.v_camera then
    if self.v_crilisten_obj then
      self.v_crilisten_obj.transform:SetPositionA(0, 0, 0)
    end
    ResMgr:destroy_gameobj(self.v_camera)
  end
  self.v_camera = nil
  self.v_vcam = nil
  Global.camera = nil
  self.v_crilisten_obj = nil
  self.v_crilisten_pos = nil
end

function M:fight_reconnect()
  if Global.camera then
    Global.camera:close_camera_aimed()
    Global.camera:back_to_scene_camera(nil, true)
  end
end

function M:get_create_npc_param(res_id, x, y, z, dir, abs_camp, level, ext_args)
  ext_args = ext_args or {}
  local param = {}
  local uuid
  if ext_args.uuid then
    uuid = ext_args.uuid
    assert(self.v_uuid_map[uuid] == nil, string.format("repeated server npc rtid %s", uuid))
  else
    uuid = self:get_uuid()
  end
  param.uuid = uuid
  param.res_id = res_id
  param.x = x
  param.y = y
  param.z = z
  param.dir = dir
  param.abs_camp = abs_camp
  param.level = level
  param.ext_args = ext_args
  return param
end

function M:create_npc(res_id, x, y, z, face_x, face_z, abs_camp, level, ext_args)
  local dir = Math.get_lookat_dir(x, z, face_x, face_z)
  return self:create_npc_new(res_id, x, y, z, dir, abs_camp, level, ext_args)
end

function M:create_npc_new(res_id, x, y, z, dir, abs_camp, level, ext_args)
  local param = self:get_create_npc_param(res_id, x, y, z, dir, abs_camp, level, ext_args)
  local npc = self.v_npc_pool_mgr:get_npc(param)
  local group = npc:get_group_id()
  self:add_group_npc_num(group)
  self:check_set_battle_monster_type(npc)
  self.v_npc_map[param.uuid] = npc
  self:add_obj_to_uuid_map(param.uuid, npc)
  if ext_args then
    npc:refresh_lock_info(ext_args.lock_enemy_list)
  end
  return npc
end

function M:add_group_npc_num(group)
  if not self.v_group_npc_num[group] then
    self.v_group_npc_num[group] = 1
  else
    self.v_group_npc_num[group] = self.v_group_npc_num[group] + 1
  end
end

function M:create_part_npc(res_id, owner, attach_name, part_id, camp)
  local px, py, pz = owner:get_pos()
  local npc = self:create_npc(res_id, px, py, pz, 0, 0, camp or Config.CAMPS.ENEMY, owner:get_level())
  npc:add_loaded_cb(function()
    npc:became_part(owner, attach_name, part_id)
  end)
  return npc
end

function M:create_scene_obj(x, y, z, body_radius, model_id, callback)
  local uuid = self:get_uuid()
  local scene_obj = require("obj.scene_obj"):new()
  scene_obj.uuid = uuid
  self.v_scene_obj_map[uuid] = scene_obj
  self:_create_scene_obj(x, y, z, scene_obj, body_radius, model_id, callback)
  self:add_obj_to_uuid_map(uuid, scene_obj)
  return scene_obj
end

function M:_create_scene_obj(x, y, z, luaobj, body_radius, model_id, callback, ...)
  local model_cfg = ShareRes.create("character.character_model", model_id)
  assert(model_cfg, "can't find model config: " .. model_id)
  luaobj.model_cfg = model_cfg
  luaobj.character_cfg = {ModelId = model_id, BodyRadius = body_radius}
  if not luaobj:is_setup() then
    self:setup_cobj(luaobj, ...)
  end
  luaobj:set_pos(x, y, z)
  if not luaobj:will_init_gameobj() then
    if model_cfg and model_cfg.ControllerPath then
      self:load_model_animator(luaobj, callback)
    else
      self:load_gameobj_async(luaobj, callback)
    end
  end
  return luaobj
end

function M:create_functional_npc(res_id, x, y, z, rotation, data, src_path, callback)
  local uuid = self:get_uuid()
  local npc = require(src_path):new()
  npc.uuid = uuid
  self.v_fun_npc_map[uuid] = npc
  npc:set_camp(Config.CAMPS.FRIEND)
  self:_create_functional_npc_obj(res_id, npc, x, y, z, data, function()
    self:add_fun_obj_to_instance_id_map(npc)
    callback(npc)
  end)
  self:add_obj_to_uuid_map(uuid, npc)
  npc:face_dir(rotation, true)
  return npc
end

function M:create_treasure_chest(res_id, x, y, z, rotation, data, callback)
  local uuid = self:get_uuid()
  local box_logic = self.v_scene_logic:get_scene_treasure_chest_logic()
  local npc = require(box_logic):new()
  npc.uuid = uuid
  self.v_fun_npc_map[uuid] = npc
  npc:set_camp(Config.CAMPS.FRIEND)
  self:_create_treasure_chest_obj(res_id, npc, x, y, z, data, function()
    self:add_fun_obj_to_instance_id_map(npc)
    callback(npc)
  end)
  self:add_obj_to_uuid_map(uuid, npc)
  npc:face_dir(data.rotation, true)
  return npc
end

function M:add_fun_obj_to_instance_id_map(npc_lua)
  local npc_cid = npc_lua:get_cid()
  if npc_cid then
    self.v_fun_npc_instance_id_map[npc_cid] = npc_lua
  end
end

function M:_create_functional_npc_obj(model_id, luaobj, x, y, z, data, callback, ...)
  if not model_id then
    Log.Error("no modelid", model_id, debug.traceback())
  end
  local functional_npc_cfg = ShareRes.create("npc.functional_npc", model_id)
  if not functional_npc_cfg then
    if not data.mArgs or not data.mArgs.npc_type then
      assert(functional_npc_cfg, "can't find character config: " .. model_id)
    end
    functional_npc_cfg = data.npc_cfg
  end
  local model_cfg = ShareRes.create("character.character_model", functional_npc_cfg.ModelId)
  assert(model_cfg, "can't find model config: " .. model_id .. " ModelId: " .. functional_npc_cfg.ModelId)
  luaobj.character_cfg = functional_npc_cfg
  luaobj.model_cfg = model_cfg
  luaobj.data = data
  if not luaobj:is_setup() then
    self:setup_cobj(luaobj, ...)
  end
  luaobj:set_pos(x, y, z)
  if not luaobj:will_init_gameobj() then
    if model_cfg and model_cfg.ControllerPath then
      self:load_model_animator(luaobj, callback)
    else
      self:load_gameobj_async(luaobj, callback)
    end
  end
  return luaobj
end

function M:_create_treasure_chest_obj(box_id, luaobj, x, y, z, data, callback, ...)
  if not box_id then
    Log.Error("no modelid", box_id, debug.traceback())
  end
  local box_cfg = ShareRes.create("episode_box.episode_box", box_id)
  if not box_cfg then
    assert(box_cfg, "can't find character config: " .. box_id)
    return
  end
  local model_cfg = ShareRes.create("character.character_model", box_cfg.ModelId)
  assert(model_cfg, "can't find model config: " .. box_id .. " ModelId: " .. box_cfg.ModelId)
  luaobj.character_cfg = box_cfg
  luaobj.model_cfg = model_cfg
  luaobj.data = data
  if not luaobj:is_setup() then
    self:setup_cobj(luaobj, ...)
  end
  luaobj:set_pos(x, y, z)
  if not luaobj:will_init_gameobj() then
    if model_cfg and model_cfg.ControllerPath then
      self:load_model_animator(luaobj, callback)
    else
      self:load_gameobj_async(luaobj, callback)
    end
  end
  return luaobj
end

function M:create_god(uuid, attr, npc_id)
  if self.v_god_npc then
    self:clear_god_npc()
  end
  if Util.is_client_only() then
    return
  end
  if not TowerMgr then
    return
  end
  if not Global.hero then
    return
  end
  self.v_god_uuid = uuid
  self.v_god_attr = attr
  self.v_god_npc_id = npc_id
  local tower = TowerMgr:get_tower()
  local tower_id = tower and tower:get_tower_id()
  local char_id = npc_id
  if not char_id and tower_id then
    local tower_cfg = ShareRes.create("tower.tower", tower_id)
    assert(tower_cfg, "NO TOWER CONFIG" .. tower_id)
    char_id = tower_cfg.TowerCharId
  end
  if not char_id or 0 == char_id then
    return
  end
  self:_do_create_god(self.v_god_uuid, self.v_god_attr, char_id)
end

function M:_do_create_god(uuid, attr, char_id)
  local luaobj = require("obj.god"):new()
  if attr then
    luaobj:set_sync_attr_data(attr)
  end
  if uuid then
    luaobj.uuid = uuid
  end
  local character_cfg = ShareRes.get_character_cfg(char_id)
  luaobj.character_cfg = character_cfg
  if not luaobj:is_setup() then
    self:setup_cobj(luaobj)
  end
  luaobj:set_camp(CAMPS.FRIEND)
  luaobj:creat_god_obj()
  self.v_god_npc = luaobj
  self.v_god_npc:setup_born_behavior()
  if uuid then
    self:add_obj_to_uuid_map(uuid, self.v_god_npc)
  end
  MsgGame:mq_publish2(Const.MSG_CREATE_SCENE_SKILL)
end

function M:get_god_npc()
  return self.v_god_npc
end

function M:get_god_npc_id()
  return self.v_god_npc_id
end

function M:set_god_npc_uuid(uuid, attr, npc_id)
  self:create_god(uuid, attr, npc_id)
end

function M:get_enemy_npc_count()
  local count = 0
  for _, npc in pairs(self.v_npc_map) do
    if npc:get_camp() == CAMPS.ENEMY then
      count = count + 1
    end
  end
  return count
end

function M:get_alive_ai_count()
  local count = 0
  for _, npc in pairs(self.v_npc_map) do
    if npc:is_monster() and not npc:is_die() and npc:get_ai_group_id() then
      count = count + 1
    end
  end
  return count
end

function M:test_get_enemy_npc_count()
  for _, npc in pairs(self.v_npc_map) do
    if npc:get_camp() == CAMPS.ENEMY then
      return npc
    end
  end
end

function M:get_npc_count_by_res_id(res_id)
  local count = 0
  for _, npc in pairs(self.v_npc_map) do
    if npc:get_config_id() == res_id then
      count = count + 1
    end
  end
  return count
end

function M:get_all_npc()
  return self.v_npc_map
end

function M:get_all_functional_npc()
  return self.v_fun_npc_map
end

function M:check_npc_scene_missile(luaobj)
  for _, missile in pairs(self.v_missile_map) do
    if missile:get_owner() == luaobj then
      return true
    end
  end
  for _, missile in pairs(self.v_wait_add_missile_map) do
    if missile:get_owner() == luaobj then
      return true
    end
  end
  return false
end

function M:cur_hero_suicide()
  if not Global.hero then
    return
  end
  Global.hero.magic_mgr:add_magic(Global.hero, 100176, nil, nil, 1)
end

function M:cur_scene_npc_suicide()
  local npc_map = self:get_all_npc()
  for _, npc in pairs(npc_map) do
    if npc and npc:is_npc() and not npc:is_die() and not npc:is_destroy() and npc:is_monster() and npc.character_cfg.Kind ~= CommonDefine.NPC_KIND.OBSTRUCT then
      npc.magic_mgr:add_magic(npc, 100176, nil, nil, 1)
    end
  end
end

function M:remove_hero(luaobj)
  self:_destroy_luaobj(luaobj)
end

function M:remove_functional_npc(npc_obj)
  self:_destroy_luaobj(npc_obj)
end

function M:remove_scene_obj_npc(scene_obj)
  self:_destroy_luaobj(scene_obj)
end

function M:remove_npc_npc_by_group_id(group_id)
  if not self.v_npc_map then
    return
  end
  local uuid_list = {}
  for k, npc in pairs(self.v_npc_map) do
    if group_id == npc:get_group_id() then
      local uuid = npc.uuid
      local removed = self:remove_npc_by_rpc(npc)
      if removed then
        _tinsert(uuid_list, uuid)
      end
    end
  end
  self:c2gs_call_scene("on_rpc_remove_npc", uuid_list)
end

function M:remove_npc_by_rpc(luaobj, not_send_event)
  if luaobj.update_start or luaobj.late_update_start or luaobj.need_lock_destroy then
    luaobj.update_remove_npc = true
    return
  end
  if luaobj.uuid == nil or luaobj:is_destroy() then
    return
  end
  if not not_send_event then
    BehaviorMgr:call_event_fun(BehaviorMgr.EVENTS.ON_NPC_REMOVED, luaobj)
    BehaviorMgr:call_behavior_fun(luaobj, "on_self_npc_removed")
  end
  local msg = MsgGame:mq_publish2(Const.MSG_OBJ_LEAVE)
  msg.mm_obj = luaobj.uuid
  if self:check_npc_scene_missile(luaobj) then
    self.v_npc_map[luaobj.uuid] = nil
    self:remove_obj_at_uuid_map(luaobj.uuid, luaobj)
    luaobj:set_enable(false)
    luaobj:on_pre_destroy()
    return
  end
  self:_destroy_luaobj(luaobj)
  return true
end

function M:remove_npc2(npc)
  local is_building = MagicReporter:is_building_report()
  if is_building then
    MagicReporter:cache_remove_npc(npc)
  else
    self:remove_npc(npc)
  end
end

function M:remove_npc(luaobj)
  if luaobj.update_start or luaobj.late_update_start then
    luaobj.update_remove_npc = true
    return
  end
  if luaobj:is_destroy() then
    return
  end
  BehaviorMgr:call_event_fun(BehaviorMgr.EVENTS.ON_NPC_REMOVED, luaobj)
  BehaviorMgr:call_behavior_fun(luaobj, "on_self_npc_removed")
  local msg = MsgGame:mq_publish2(Const.MSG_OBJ_LEAVE)
  msg.mm_obj = luaobj.uuid
  if self.v_scene_logic then
    self.v_scene_logic:on_npc_remove(luaobj)
    if StateReport and luaobj.uuid then
      StateReport:remove_npc({
        uuid = luaobj.uuid,
        caster_type = luaobj.attacker_kind
      }, nil, function(ok, resp)
        local msg = MsgGame:mq_publish2(Const.MSG_ON_CONFIRM_NPC_DEAD)
        msg.mm_obj = luaobj
        msg.mm_x = ok
      end)
    end
  end
  if self:check_npc_scene_missile(luaobj) then
    self.v_npc_map[luaobj.uuid] = nil
    self:remove_obj_at_uuid_map(luaobj.uuid, luaobj)
    luaobj:set_enable(false)
    luaobj:on_pre_destroy()
    return
  end
  self:_destroy_luaobj(luaobj)
end

function M:reduce_npc_group_num(npc)
  local group = npc:get_group_id()
  if not self.v_group_npc_num[group] then
    return
  end
  local last_val = self.v_group_npc_num[group]
  local new_val = math.max(last_val - 1, 0)
  self.v_group_npc_num[group] = new_val
  if new_val <= 0 then
    BehaviorMgr:call_event_fun(BehaviorMgr.EVENTS.ON_NPC_GROUP_CLEAR, group)
    self.v_group_npc_num[group] = nil
  end
end

function M:safe_remove_missile(luaobj, skip_check_limit, need_explosion)
  self.v_remove_missile_pool:new_obj(luaobj, skip_check_limit, need_explosion)
end

function M:remove_missile(luaobj, skip_check_limit, need_explosion)
  if luaobj:get_remove_flag() or luaobj:is_destroy() then
    return
  end
  luaobj:set_remove_flag()
  if not skip_check_limit then
    self:_remove_limited_missile(luaobj)
  end
  if need_explosion then
    luaobj:do_explosion()
  end
  local is_remove_owner = false
  local owner = luaobj:get_owner()
  if owner:is_pre_destroy() and not self:check_npc_scene_missile(luaobj) then
    is_remove_owner = true
  end
  self:_destroy_luaobj(luaobj)
  if is_remove_owner then
    self:_destroy_luaobj(owner)
  end
end

function M:get_all_char()
  return self.v_uuid_map
end

function M:update_all_relation()
  for _, obj in pairs(self.v_uuid_map) do
    obj:update_relation()
  end
end

function M:npc_in_scene(npc)
  if nil == npc then
    return false
  end
  return nil ~= self.v_uuid_map[npc.uuid]
end

function M:get_npc_by_id(npc_uuid)
  return self.v_npc_map[npc_uuid]
end

function M:get_npc_by_name(name)
  for k, npc in pairs(self.v_npc_map) do
    if npc:get_local_name() == name then
      return npc
    end
  end
end

function M:get_monster_root()
  return self.v_monster_root
end

function M:get_player_root()
  return self.v_player_root
end

function M:set_monster_root_show(is_show)
  if self.v_monster_root then
    self.v_monster_root:SetActive(is_show)
  end
end

function M:_create_monster_root()
  if self.v_monster_root then
    return
  end
  self.v_monster_root = ResMgr:create_emptygameobj("MonsterRoot", true)
  self.v_monster_root:ResetAttr()
end

function M:_create_cobj(hero, x, y, z, data, ...)
  if not data or not data.id then
    Log.Error("create hero error", data, debug.traceback())
    return
  end
  hero:init_character_cfg(data)
  if not hero:is_setup() then
    self:setup_cobj(hero, data, ...)
  end
  if not y then
    local _, height
    if Global.hero then
      _, height = Util.raycast_by_role(Global.hero, x, z)
    else
      _, height = Util.get_height(x, z)
    end
    y = height
  end
  hero:set_pos(x, y, z)
  hero:init_canuse_pos()
  if hero:is_npc() then
    hero:report_create()
  end
  if not hero:will_init_gameobj() then
    local model_cfg = hero.model_cfg
    if model_cfg and model_cfg.ControllerPath then
      self:load_model_animator(hero)
    else
      self:load_gameobj_async(hero)
    end
  end
  return hero
end

function M:setup_cobj(luaobj, ...)
  luaobj:presetup(...)
  luaobj:setup(...)
  luaobj:aftersetup(...)
end

function M:load_gameobj_async(luaobj, callback)
  local model_id
  local change_gameobj_info = luaobj.get_change_gameobj_info and luaobj:get_change_gameobj_info()
  if not change_gameobj_info or not change_gameobj_info.model_id then
    if luaobj.model_cfg and luaobj.model_cfg.ModelId then
      model_id = luaobj.model_cfg.ModelId
    end
    if not model_id then
      model_id = luaobj.character_cfg.ModelId
    end
  else
    model_id = change_gameobj_info.model_id
  end
  luaobj:before_load_gameobj()
  local sync_load
  if luaobj.is_ui_hero and luaobj:is_ui_hero() then
    sync_load = true
  elseif luaobj:is_hero() then
    if Util.is_in_loading() then
      sync_load = true
    else
      sync_load = false
    end
  else
    sync_load = false
  end
  
  local function load_cb(gameobj)
    local on_recreate = luaobj:is_on_recreate_gameobj()
    local died_on_recreate = luaobj:is_die() and on_recreate
    if died_on_recreate or luaobj:is_destroy() or not luaobj:will_init_gameobj() then
      ResPool:release(gameobj)
      if luaobj.animator_info then
        ResPool:release_res(luaobj.animator_info)
      end
      if on_recreate then
        luaobj:clear_change_go_info()
      end
      return
    end
    local cid = gameobj:GetInstanceID()
    luaobj:init_gameobj(cid, gameobj, gameobj.transform)
    if callback then
      callback(luaobj)
    end
    if on_recreate then
      luaobj:on_recreate_go_suc()
    end
  end
  
  if sync_load then
    local gameobj = ResPool:get_model(model_id)
    load_cb(gameobj)
  else
    ResPool:get_model_async(model_id, load_cb)
  end
end

function M:load_model_animator(luaobj, callback)
  luaobj:before_load_gameobj()
  local sync_load
  if luaobj.is_ui_hero and luaobj:is_ui_hero() then
    sync_load = true
  elseif luaobj:is_hero() then
    if Util.is_in_loading() then
      sync_load = true
    else
      sync_load = false
    end
  else
    sync_load = false
  end
  
  local function load_cb(_, animator_info)
    local on_recreate = luaobj:is_on_recreate_gameobj()
    local died_on_recreate = luaobj:is_die() and on_recreate
    if died_on_recreate or luaobj:is_destroy() or not luaobj:will_init_gameobj() then
      ResPool:release_res(animator_info)
      if on_recreate then
        luaobj:clear_change_go_info()
      end
      return
    end
    luaobj.runtime_animator = animator_info.res
    luaobj.animator_info = animator_info
    self:on_load_animator_done(luaobj, callback)
  end
  
  if sync_load then
    local _, animator_info
    animator_info = ResPool:get_animator(luaobj.model_cfg.ControllerPath)
    load_cb(_, animator_info)
  else
    ResPool:get_animator_async(luaobj.model_cfg.ControllerPath, load_cb)
  end
end

function M:on_load_animator_done(luaobj, callback)
  if luaobj:need_load_gameobj() then
    SceneMgr:load_gameobj_async(luaobj, callback)
    return
  end
  if callback then
    callback(luaobj)
  end
end

function M:set_model_animator(npc, extra_controller_path)
  local animator_name = npc.model_cfg.ControllerPath
  if 0 ~= extra_controller_path then
    if npc.model_cfg.ExtraControllerPath and npc.model_cfg.ExtraControllerPath[extra_controller_path] then
      animator_name = npc.model_cfg.ExtraControllerPath[extra_controller_path]
    else
      Log.Error("*******无此额外动作控制器路径", debug.traceback())
      return
    end
  end
  if npc:is_destroy() or not npc:will_init_gameobj() then
    return
  end
  local animator_info = ResPool:get_animator(animator_name)
  npc:on_controller_change(animator_info, animator_name)
end

function M:check_wall_collision(char, temp_x, temp_z, temp_y)
  local y = 0
  if not temp_x or not temp_z then
    temp_x, y, temp_z = char.transform:GetPositionA()
  end
  if not self.v_scene_map then
    return false
  end
  if temp_y then
    y = temp_y
  elseif char.get_collider_posA then
    _, y, _ = char:get_collider_posA()
  end
  local collide, missile_uuid, collider_info, collide_border_type = self.v_scene_map:check_in_collision(temp_x, y, temp_z, char.radius)
  if char:is_super_ghost() and not collide_border_type then
    return false
  end
  return collide, missile_uuid, collider_info, collide_border_type
end

function M:check_in_collision(char, temp_x, temp_z, temp_y, check_scene_npc)
  if not check_scene_npc and char:is_ghost() then
    return false
  end
  if not temp_x and not temp_z then
    temp_x, temp_z = char:get_pos2()
  end
  if not char:is_role() then
    return false
  end
  local _, y, _
  if temp_y then
    y = temp_y
  else
    _, y, _ = char:get_collider_posA()
  end
  local len = Util.overlap_sphere(temp_x, y, temp_z, char.radius)
  if len > 0 then
    local is_self = true
    local cid, is_co, co_obj, co_gameobj, is_co_scene_npc
    for i = 0, len - 1 do
      cid = CompExtensions.GetOverlapSphereColliderID(i)
      co_obj = self.v_cid_map[cid]
      co_obj = co_obj or self.v_fun_npc_instance_id_map[cid]
      local not_collision = self:can_missile_collision(char, co_obj)
      if co_obj and co_obj ~= char and not not_collision then
        is_self = false
        if co_obj:is_air() or co_obj:is_friendly_air() and char:get_camp() == co_obj:get_camp() then
          goto lbl_112
        end
        local collider = CompExtensions.GetOverlapSphereCollider(i)
        is_co = true
        co_gameobj = TRANSFORMS[collider.gameObject]
        if not check_scene_npc then
          break
        end
        if co_obj and co_obj:is_scene_npc() and not co_obj:is_penetrable() then
          is_co_scene_npc = true
          break
        end
        goto lbl_112
        break
      elseif not co_obj then
        is_co = true
        if not check_scene_npc then
          break
        end
      end
      ::lbl_112::
    end
    if is_self then
      is_co = false
      return is_co
    end
    return is_co, co_obj, co_gameobj, is_co_scene_npc
  end
  return false
end

function M:can_missile_collision(char, collision_obj)
  if not collision_obj then
    return
  end
  if not collision_obj:is_missile() then
    return
  end
  if char:get_camp() == collision_obj:get_camp() then
    return true
  end
  return false
end

function M:check_all_collision(char, temp_x, temp_z, tempy, check_scene_npc)
  return self:check_in_collision(char, temp_x, temp_z, tempy, check_scene_npc) or self:check_wall_collision(char, temp_x, temp_z, tempy)
end

function M:on_collide_exit(a_cid, b_cid)
  if not self:can_update() then
    return
  end
  local missile = self.v_cid_map[a_cid]
  if missile and missile:is_missile() and missile:is_bound_missile() then
    local other = self.v_cid_map[b_cid]
    if not other then
      return
    end
    if other:is_missile() then
      missile:remove_missile_from_bound(other)
    elseif other:is_role() then
      missile:remove_npc_from_bound(other.uuid)
    end
  end
end

local temp_info_list = {}

function M:on_collide(a_cid, b_cid, a_layer, b_layer)
  if not self:can_update() then
    return
  end
  local missile = self.v_cid_map[a_cid]
  if missile and missile:is_missile() then
    local other = self.v_cid_map[b_cid]
    if 1 == (Layer.obstacle_check_mask >> b_layer) % 2 then
      missile:on_collide_obstacle_mask(b_cid)
    end
    if not other then
      return true
    end
    if not other:is_break_obj() then
      local is_tar_type = Util.is_target_camp(missile:get_owner(), other, missile.target_type)
      if not is_tar_type then
        return true
      end
    end
    local collide_cid = b_cid
    b_cid = other.cid
    if missile:collider_is_invalid(other) then
      return true
    end
    local part_info = other:is_role() and other:get_part(collide_cid)
    local cillide_info
    if part_info then
      cillide_info = self.v_collide_info_pool:new_obj(missile, other, b_cid, missile:get_collider_square_dist(other, part_info), collide_cid)
    else
      cillide_info = self.v_collide_info_pool:new_obj(missile, other, b_cid, missile:get_collider_square_dist(other))
    end
    temp_info_list[#temp_info_list + 1] = cillide_info
    return true
  elseif self.v_terrain_collider_cid_map[a_cid] then
    missile = self.v_terrain_collider_cid_map[a_cid]
    if missile.need_collide_wall_cb then
      missile:on_collide_obstacle_collider(false, true)
    end
    return true
  else
    return false
  end
end

function M._collide_info_sort(a, b)
  if not a or not b then
    return false
  end
  if a.missile and b.missile then
    local a_is_all_mis = a.other and a.other:is_missile()
    local b_is_all_mis = b.other and b.other:is_missile()
    if a_is_all_mis ~= b_is_all_mis then
      return a_is_all_mis
    end
    local a_owner = a.missile:get_owner()
    local b_owner = b.missile:get_owner()
    if not Util.is_destroy(a_owner) and not Util.is_destroy(b_owner) then
      local a_is_monster = b_owner:is_monster()
      local b_is_monster = a_owner:is_monster()
      if a_is_monster ~= b_is_monster then
        return not a_is_monster
      end
    end
  end
  if a.dist ~= b.dist then
    return a.dist < b.dist
  end
  return false
end

function M:_clear_collide_info()
  temp_info_list = {}
  self.v_collide_info_pool:release_active_objs()
end

local collide_sort_func = M._collide_info_sort

function M:_update_collider()
  local info_count = #temp_info_list
  if info_count > 0 then
    table.sort(temp_info_list, collide_sort_func)
    for i = 1, info_count do
      local info = temp_info_list[i]
      if nil ~= info then
        if info.part_cid and not self:_part_collide_valid(info, 1 == i) then
        else
          self:_on_missile_collide(info.missile, info.cid, info.part_cid, info.fixed_frame)
        end
        self.v_collide_info_pool:destroy_obj(info)
      end
      temp_info_list[i] = nil
    end
  end
end

function M:_part_collide_valid(info, is_nearst)
  local missile = info.missile
  local other = info.other
  local caster = missile:get_owner()
  if not caster then
    return false
  end
  if not other:part_hit_precheck(missile, info.part_cid) then
    return false
  end
  if is_nearst then
    return true
  end
  return true
end

local function _dodge_check_atkcd(dodge_missile, other)
  local owner = dodge_missile:get_owner()
  if not Util.is_destroy(owner) and not other:can_collide_other_missile(owner) then
    return true
  end
end

function M:on_missile_collde_missile(missile, other)
  if missile.v_is_die or other.v_is_die or missile:is_destroy() or other:is_destroy() then
    return
  end
  local a_type = missile.missile_type
  local b_type = other.missile_type
  local dodge_missile = a_type == MISSILE_TYPE.Dodge and missile or b_type == MISSILE_TYPE.Dodge and other
  if dodge_missile then
    local dodge_other = dodge_missile ~= missile and missile or other
    if _dodge_check_atkcd(dodge_missile, dodge_other) then
      return
    end
  end
  BehaviorMgr:call_event_fun(BehaviorMgr.EVENTS.ON_MISSILE_COLLIDE, missile.v_owner, other.v_owner, missile, other, missile.missile_cfg, other.missile_cfg)
  BehaviorMgr:call_behavior_fun(missile.v_owner, "on_self_missile_collide", other.v_owner, missile, other, missile.missile_cfg, other.missile_cfg)
  BehaviorMgr:call_behavior_fun(other.v_owner, "on_self_missile_collide", missile.v_owner, other, missile, other.missile_cfg, missile.missile_cfg)
  local a_tag = missile.missile_tag
  local b_tag = other.missile_tag
  if a_tag ~= b_tag then
    if a_tag == MISSILE_TYPE_TAG.BOUND then
      missile:catch_missile_to_bound(other)
      return
    elseif b_tag == MISSILE_TYPE_TAG.BOUND then
      other:catch_missile_to_bound(missile)
      return
    end
  end
end

function M:_on_missile_collide(missile, b_cid, part_cid, collide_fixed_frame)
  local other = self.v_cid_map[b_cid]
  if not other then
    return
  end
  if missile.time_out_fixed_frame and collide_fixed_frame > missile.time_out_fixed_frame then
    return
  end
  if other:is_missile() then
    if other.time_out_fixed_frame and collide_fixed_frame > other.time_out_fixed_frame then
      return
    end
    self:on_missile_collde_missile(missile, other)
    return
  end
  if missile.missile_type == MISSILE_TYPE.COMMON or missile.missile_type == MISSILE_TYPE.SnapShoot then
    local part_id
    if part_cid then
      part_id = other:get_part_id_by_cid(part_cid)
    end
    if other:is_break_obj() then
      other:be_crush()
      return
    end
    if other and other:is_hero() and other:check_background() then
      return
    end
    missile:try_attack(other, part_id)
  end
end

local function _check_obj_can_be_search(char, obj)
  local target_type = search_target_param.target_type
  local result = obj and obj:can_update() and char.uuid ~= obj.uuid and obj:is_can_searched() and not Util.is_destroy(obj) and obj.magic_mgr and Util.is_target_camp(char, obj, target_type)
  return result
end

local function _check_obj_can_be_target_by_limit(obj, target_magic_map, target_npc_id_map, target_kind_map)
  local need_check_magic = search_target_param.need_check_magic
  local need_check_npc_id = search_target_param.need_check_npc_id
  local need_check_kind = search_target_param.need_check_kind
  local result = false
  if need_check_magic then
    local has_magic = false
    for magic_id in pairs(target_magic_map) do
      if obj.magic_mgr:check_magic(magic_id) then
        has_magic = true
        break
      end
    end
    if not has_magic then
      return result
    end
  end
  if need_check_npc_id then
    local character_cfg = obj.character_cfg
    if not target_npc_id_map[character_cfg.NpcId] then
      return result
    end
  end
  if need_check_kind then
    local character_cfg = obj.character_cfg
    if not target_kind_map[character_cfg.Kind] then
      return result
    end
  end
  result = true
  return result
end

local function _check_obj_can_be_target_by_joystick_dir(obj)
  local result = true
  local joystick_dir = JOYSTICK_DIR
  local target_dir = JOYSTICK_TARGET_DIR
  local hero_pos = Global.hero:get_pos_vec3()
  local joystick_angle = search_target_param.joystick_angle
  if joystick_angle then
    local target_pos = obj:get_pos_vec3()
    target_dir.x = target_pos.x - hero_pos.x
    target_dir.z = target_pos.z - hero_pos.z
    local angel = Vec3.AngleRaw(joystick_dir:SetNormalize(), target_dir:SetNormalize())
    if joystick_angle < angel then
      result = false
    end
  end
  return result
end

local _tmp_search_list = setmetatable({}, Config.VALUE_WEAK_METATABLE)
local _tmp_search_cnt = 0

function M:search_target(char, target_type, distance, joystick_angle, target_magic_map, search_list, target_npc_id_map, target_kind_map, is_tmp_list, keycode)
  if joystick_angle and joystick_angle > 0 then
    if Util.is_more_than_zero(keycode) then
      local fight = UIMgr:try_get_ui(UIMgr.FIGHT_UI_NAME)
      if fight then
        JOYSTICK_DIR.x, JOYSTICK_DIR.z = fight:get_indicator_key_pos(keycode)
      end
    elseif 0 ~= Global.camera_joystick_x or 0 ~= Global.camera_joystick_y then
      JOYSTICK_DIR.x, JOYSTICK_DIR.z = Global.camera_joystick_x, Global.camera_joystick_y
    else
      JOYSTICK_DIR:SetA(Global.hero:get_dir_vec())
    end
  end
  local target_list
  if search_list then
    _tmp_search_cnt = 0
    if is_tmp_list then
      target_list = _tmp_search_list
    else
      target_list = {}
    end
  end
  local need_check_magic = not UtilTable.is_empty(target_magic_map)
  local need_check_npc_id = not UtilTable.is_empty(target_npc_id_map)
  local need_check_kind = not UtilTable.is_empty(target_kind_map)
  search_target_param.min_dt = _maxinteger
  search_target_param.min_hp = _maxinteger
  search_target_param.target_type = target_type
  search_target_param.joystick_angle = joystick_angle
  search_target_param.distance = distance
  search_target_param.search_list = search_list
  search_target_param.search_target_type = BattleSettingMgr:get_search_target_type()
  search_target_param.target_list = target_list
  search_target_param.need_check_magic = need_check_magic
  search_target_param.need_check_npc_id = need_check_npc_id
  search_target_param.need_check_kind = need_check_kind
  search_target_param.target = nil
  local search_map, limit_map
  if need_check_magic then
    limit_map, search_map = target_magic_map, self.v_magic_to_uuid_map
  end
  if need_check_npc_id then
    limit_map, search_map = target_npc_id_map, self.v_npc_id_to_uuid_map
  end
  if need_check_kind then
    limit_map, search_map = target_kind_map, self.v_kind_to_uuid_map
  end
  if limit_map and search_map then
    for limit_id in pairs(limit_map) do
      if search_map[limit_id] then
        self:_search_target_by_map(char, search_map[limit_id], target_magic_map, target_npc_id_map, target_kind_map, true)
      end
    end
  else
    self:_search_target_by_map(char, self.v_uuid_map, target_magic_map, target_npc_id_map, target_kind_map)
  end
  return search_list and search_target_param.target_list or search_target_param.target, _tmp_search_cnt
end

function M:_search_target_by_map(char, search_map, target_magic_map, target_npc_id_map, target_kind_map, is_uuid_map)
  for uuid, data in pairs(search_map) do
    local obj
    if is_uuid_map then
      obj = self:pick_by_uuid(uuid)
    else
      obj = data
    end
    if _check_obj_can_be_search(char, obj) and _check_obj_can_be_target_by_limit(obj, target_magic_map, target_npc_id_map, target_kind_map) and _check_obj_can_be_target_by_joystick_dir(obj) then
      self:check_obj_can_be_target(char, obj)
    end
  end
end

function M:check_obj_can_be_target(char, obj)
  local distance = search_target_param.distance
  local search_list = search_target_param.search_list
  local search_target_type = search_target_param.search_target_type
  local target_list = search_target_param.target_list
  local dt = char:get_distance_without_radius(obj)
  if distance >= dt then
    if search_list then
      _tmp_search_cnt = _tmp_search_cnt + 1
      target_list[_tmp_search_cnt] = obj
    elseif search_target_type == SEARCH_TARGET_TYPE.DISTANCE then
      local min_dt = search_target_param.min_dt
      if dt < min_dt then
        search_target_param.min_dt = dt
        search_target_param.target = obj
        return
      end
    elseif search_target_type == SEARCH_TARGET_TYPE.HP_PERCENT then
      local min_hp = search_target_param.min_hp
      local now_hp = obj.attr_mgr:get_hp()
      if min_hp > now_hp then
        search_target_param.min_dt = now_hp
        search_target_param.target = obj
        return
      end
    end
  end
end

function M:get_in_range_targets(char, target_type, range)
  local in_ranges = {}
  for _, obj in pairs(self.v_uuid_map) do
    if obj:can_update() and char.uuid ~= obj.uuid and Util.is_target_camp(char, obj, target_type) and obj:is_can_searched() then
      local dist = char:get_distance_without_radius(obj)
      obj.temp_sign_search_dist = dist
      if range >= dist then
        _insert(in_ranges, obj)
      end
    end
  end
  return in_ranges
end

function M:release_emptyobj(luaobj)
  local obj = luaobj.gameobj
  ResPool:release(obj)
  local cid = obj:GetInstanceID()
  self.v_cid_map[cid] = nil
end

local function on_load_obj(self, luaobj, obj)
  if not luaobj then
    return
  end
  local cid = obj:GetInstanceID()
  self.v_cid_map[cid] = luaobj
  luaobj:init_gameobj(cid, obj, obj.transform)
end

function M:load_emptyobj(luaobj)
  local obj = ResPool:get_empty()
  on_load_obj(self, luaobj, obj)
  return obj
end

function M:load_boxcollider(luaobj, need_multi_collide)
  local obj = ResPool:get_box_collider(need_multi_collide)
  on_load_obj(self, luaobj, obj)
  return obj
end

function M:load_capsulecollider(luaobj, need_multi_collide)
  local obj = ResPool:get_capsule_collider(need_multi_collide)
  on_load_obj(self, luaobj, obj)
  return obj
end

function M:load_sectorcollider(luaobj, need_multi_collide, degree)
  local obj = ResPool:get_sector_collider(degree, need_multi_collide)
  on_load_obj(self, luaobj, obj)
  return obj
end

function M:load_spherecollider(luaobj, need_multi_collide)
  local obj = ResPool:get_sphere_collider(need_multi_collide)
  on_load_obj(self, luaobj, obj)
  return obj
end

function M:get_terrain_collider(luaobj)
  local obj = ResPool:get_box_collider()
  local cid = obj:GetInstanceID()
  self.v_terrain_collider_cid_map[cid] = luaobj
  return obj
end

function M:remove_terrain_collider(obj)
  local cid = obj:GetInstanceID()
  self.v_terrain_collider_cid_map[cid] = nil
  ResPool:release(obj)
end

function M:sycn_saved_attrs(data)
  self.v_attrs_data = data
end

function M:set_attrs_data()
  if self.v_attrs_data then
    Network:call("c2gs_module_ready")
    for uuid, attrs in pairs(self.v_attrs_data.hero_base_attrs) do
      local hero = self.v_hero_list[uuid]
      if hero then
        local attr_mgr = hero.attr_mgr
        if attr_mgr then
          for attr_type, value in pairs(attrs) do
            attr_mgr:set_cur_attr(BASE_ATTR_GROUP_TYPE, attr_type, value, FIXED_VALUE_TYPE, REPLACE_SET_TYPE)
          end
        else
          Log.Error("角色无属性管理器:", uuid, hero.id, debug.traceback())
        end
      else
        Log.Error("属性列表中有不存在于场上的英雄uuid:", uuid, debug.traceback())
      end
    end
  end
  self.v_attrs_data = nil
end

function M:clear_hero_list()
  if not self.v_operate_chars then
    return
  end
  for _, hero in pairs(self.v_operate_chars) do
    self:remove_hero(hero)
  end
  self.v_hero_list = nil
  self.v_robot_hero_list = nil
  Global.hero = nil
  Global.hero_uuid = nil
  Global.need_clear_hero_list = nil
end

function M:clear_god_npc()
  if self.v_god_npc then
    self:_destroy_luaobj(self.v_god_npc)
  end
  self.v_god_npc = nil
  self.v_god_npc_id = nil
  self.v_god_attr = nil
end

function M:clear_all_npc()
  if self.v_npc_map then
    for _, npc_obj in pairs(self.v_npc_map) do
      self:remove_npc(npc_obj)
    end
  end
  self.v_npc_map = {}
end

function M:load()
end

function M:destroy_cobj(luaobj)
  luaobj:destroy_loading_gameobj()
  if luaobj.cid then
    if (Global.hero and luaobj.uuid or luaobj:is_npc()) and Global.hero then
      Global.hero:on_scene_remove_obj(luaobj)
    end
    self.v_cid_map[luaobj.cid] = nil
    local gameobj = luaobj.gameobj
    ResPool:release_res(luaobj.animator_info)
    luaobj:on_destroy_gameobj()
    if luaobj:can_destroy_gameobj() then
      ResPool:release(gameobj)
    end
  end
end

function M:_destroy_luaobj(luaobj)
  if luaobj:is_missile() then
    self.v_missile_map[luaobj.id] = nil
    self.v_wait_add_missile_map[luaobj.id] = nil
    self.v_obstacle_missile[luaobj.id] = nil
  end
  if self.v_fun_npc_instance_id_map[luaobj.cid] then
    self.v_fun_npc_instance_id_map[luaobj.cid] = nil
  end
  if luaobj:is_npc() then
    self.v_npc_map[luaobj.uuid] = nil
    self:reduce_npc_group_num(luaobj)
  end
  if luaobj:is_functional_npc() then
    self.v_fun_npc_map[luaobj.uuid] = nil
  end
  if luaobj:is_scene_obj() then
    self.v_scene_obj_map[luaobj.uuid] = nil
  end
  if luaobj:is_break_obj() then
    self.v_cid_map[luaobj.cid] = nil
    return
  end
  if luaobj:is_hero() then
    luaobj:set_enable(false)
    luaobj.act_effect_ctrl:stop_all()
    if luaobj.uuid then
      if luaobj:get_is_robot_hero() then
        self.v_robot_hero_list[luaobj.uuid] = nil
      else
        self.v_hero_list[luaobj.uuid] = nil
      end
      self.v_operate_chars[luaobj.uuid] = nil
    end
  end
  luaobj:on_destroy_luaobj()
  self:destroy_cobj(luaobj)
  if luaobj.on_destroy then
    luaobj:on_destroy()
  end
  if luaobj.uuid then
    self:remove_obj_at_uuid_map(luaobj.uuid, luaobj)
  end
end

function M:reload_all()
  for _, obj in pairs(self.v_uuid_map) do
    if obj.skill_mgr then
      obj.skill_mgr:load_skill()
      obj.skill_mgr:init_energy()
    end
  end
  BehaviorMgr:call_event_fun("on_all_born_behavior")
  MsgGame:mq_publish2(Const.MSG_SCENE_RELOAD_END)
end

function M:start_scene_logic()
  self.v_scene_logic:start_scene_logic()
end

function M:create_scene_logic_on_story_room(logic_id, room)
  self.v_scene_logic = require("manager.scene.scene_logic"):new(room, logic_id)
end

function M:create_scene_logic(logic_id, room)
  if self.v_scene_logic then
    self:clear_scene_data()
  end
  self:create_camera()
  if Global.camera then
    Global.camera:on_scene_load()
  end
  self.v_scene_logic = require("manager.scene.scene_logic"):new(room, logic_id)
  self.v_scene_map = self.v_scene_logic:get_scene_map()
  self.v_scene_logic:on_enter()
  SyncTransforms()
  self:_update_cs_hero()
  CSGameMgr:RefreshRoomColliders()
  Global.hero:update_pos_height()
  if not StoryMgr:is_playing_story() then
    UIMgr:try_destory_ui("uistory")
    UIMgr:try_destory_ui("ui_blackfade")
  end
  BehaviorLoader:on_enter_room()
  if not self.v_gm_room then
    local report_id = room:get_state_report_id()
    Global.share_state_report = ShareStateMgr:new(StatDef.RUN_MODE.CLIENT, report_id, Global.player_uuid, self)
    StateReport = Global.share_state_report
    if self.v_report_hero_state then
      Global.hero:report_create()
      self.v_report_hero_state = false
    end
  end
  for _, hero in pairs(self.v_operate_chars) do
    hero:on_enter_room(self.v_scene_logic)
  end
  if Util.is_client_only() then
    for _, npc in pairs(self.v_npc_map) do
      npc:setup_born_behavior()
    end
  end
  if self.v_god_npc then
    self.v_god_npc:setup_born_behavior()
  end
  MsgGame:mq_publish2(Const.MSG_ON_HERO_CREAT_FINISH)
  BehaviorMgr:call_event_fun(BehaviorMgr.EVENTS.ON_SCENE_CHANGE)
  if false == self.v_first_enter then
    MsgGame:mq_publish2(Const.MSG_ON_FIRST_ENTER_BATTLE_FIELD)
    self.v_first_enter = true
  end
  MsgGame:mq_publish2(Const.MSG_SCENE_LOGIC_FINISH)
  if self.v_is_gm_change and Util.is_client_only() then
    local born_key
    if self.v_gm_born_key and not Util.is_empty(self.v_gm_born_key) then
      born_key = self.v_gm_born_key
    end
    local pos_x, pos_y, pos_z = 0, 0, 0
    if born_key and "" ~= born_key then
      pos_x, pos_y, pos_z = self.v_scene_logic:get_pos_key_position(born_key, true)
      if not pos_x then
        Log.Error("当前地图不存在", born_key)
        pos_x, pos_y, pos_z = 0, 0, 0
      end
    end
    if Global.hero then
      Global.hero:set_pos(pos_x, pos_y, pos_z)
    end
  end
end

function M:set_gm_enter_born_key(born_key)
  self.v_gm_born_key = born_key
end

function M:get_npc_attrs(uuid)
  local npc = self.v_uuid_map[uuid]
  if npc then
    return npc.attr_mgr.attrs
  end
end

function M:get_plat_mgr()
  return self.v_scene_plat_mgr
end

function M:get_time_keeper_mgr()
  return self.v_time_keeper_mgr
end

function M:get_scene_logic()
  return self.v_scene_logic
end

function M:get_scene_logic_runner()
  return self.v_scene_logic and self.v_scene_logic:get_scene_logic_runner()
end

function M:get_scene_map()
  return self.v_scene_map
end

function M:get_scene_rpc()
  return self.v_scene_rpc
end

function M:get_uuid()
  UID_IDX = UID_IDX + 1
  return UID_IDX * 10
end

function M:get_rtid()
  return self:get_uuid()
end

function M:gm_enter_room(room_id, is_gm_change)
  if self.v_gm_room and not is_gm_change then
    return
  end
  self.v_is_gm_change = is_gm_change
  Global.share_state_report = ShareStateMgr:new(StatDef.RUN_MODE.NONE, 0, "1", self)
  StateReport = Global.share_state_report
  local room_data = {room_info = room_id}
  self.v_gm_room = require("gamelogic.tower_mgr.room"):new(room_data)
end

function M:create_scene_effect(prefab_name, position, duration, obj_name, callback, remove_callback, scale, face_pos, not_time_scale)
  if self.v_scene_effect_mgr then
    local dir
    if face_pos then
      dir = MathX.get_lookat_dir(position.x, position.z, face_pos.x, face_pos.z)
    end
    self.v_scene_effect_mgr:create_effect(prefab_name, position, duration, obj_name, callback, remove_callback, dir, scale, not_time_scale)
  end
end

function M:remove_scene_effect(obj_name)
  if self.v_scene_effect_mgr then
    self.v_scene_effect_mgr:remove_effect_by_name(obj_name)
  end
end

function M:get_scene_effect_mgr()
  return self.v_scene_effect_mgr
end

function M:_update_building_transparent()
  local camera = Global.camera
  if not camera or not Global.hero then
    CSGameMgr.Hero = nil
    return
  end
  local camera_transform = camera:get_camera_trans()
  local hero_transform = Global.hero.transform
  if not (not camera_transform:IsNull() and hero_transform) or hero_transform:IsNull() then
    return
  end
  CSGameMgr.CheckCameraRayCollider(camera_transform, hero_transform, -1, Layer.LayerMask.CameraCastTransparent)
  if TimeLineSeqPlayer.close_camera_transparent then
    for transparent, count in pairs(self.v_transparent_dict) do
      if not transparent:IsNull() then
        transparent:OnRayExit()
      end
    end
    self.v_transparent_dict = {}
    return
  end
  local hit_count = CSGameMgr.CameraRayHitCount
  local hit_trans = CSGameMgr.CameraRayHitTrans
  for i = 0, hit_count - 1 do
    local transform = hit_trans[i]
    local instance_id = transform:GetInstanceID()
    local transparent = self.v_transparent_comps[instance_id]
    if nil == transparent then
      transparent = transform:GetComponent(TypeBaseTransparent)
      transparent = transparent or false
      self.v_transparent_comps[instance_id] = transparent
    end
    if transparent then
      if transparent:IsNull() then
        self.v_transparent_dict[transparent] = nil
      else
        transparent:OnRayHit()
        self.v_transparent_dict[transparent] = TRANSPARENT_LIFE_INTERVAL
      end
    end
  end
  for transparent, count in pairs(self.v_transparent_dict) do
    count = count - TRANSPARENT_UPDATE_INTERVAL
    if count <= 0 then
      self.v_transparent_dict[transparent] = nil
      if not transparent:IsNull() then
        transparent:OnRayExit()
      end
    else
      self.v_transparent_dict[transparent] = count
    end
  end
end

function M:c2gs_call_scene(method, ...)
  if self.v_fs_connect_lost then
    return
  end
  if not Util.is_client_only() and (not TowerMgr or TowerMgr:get_has_exist() == true) then
    return
  end
  local request = {
    method = method,
    pack_args = Seri.packstring(...)
  }
  Network:call("c2gs_call_scene", request)
end

function M:_on_add_transparent_obj()
  Global.transparent_obj_count = Global.transparent_obj_count + 1
end

function M:_on_del_transparent_obj()
  Global.transparent_obj_count = math.max(Global.transparent_obj_count + 1, 0)
end

function M:add_plat_time_scale(scale, duration, ease_in, ease_out, magic_id, is_global, ignoral_missile, impact_sound_type, impact_sound_volume)
  if self.v_scene_plat_mgr then
    local scale_data = {
      ease_in = ease_in,
      ease_out = ease_out,
      magic_id = magic_id,
      ignoral_missile = ignoral_missile,
      impact_sound_type = impact_sound_type,
      impact_sound_volume = impact_sound_volume,
      is_global = is_global
    }
    self.v_scene_plat_mgr.time_mgr:add_time_scale(scale, duration, scale_data)
  end
end

function M:add_obj_time_scale(scale, duration, ease_in, ease_out, magic_id, is_global, ignoral_missile, impact_sound_type, impact_sound_volume, ignore_move, only_effect_enemy)
  local scale_data = {
    ease_in = ease_in,
    ease_out = ease_out,
    magic_id = magic_id,
    ignoral_missile = ignoral_missile,
    impact_sound_type = impact_sound_type,
    impact_sound_volume = impact_sound_volume,
    ignore_move = ignore_move,
    is_global = is_global
  }
  for _, npc in pairs(self.v_npc_map) do
    if only_effect_enemy then
      if npc:is_monster() then
        npc.time_mgr:add_time_scale(scale, duration, scale_data)
      end
    elseif npc:is_monster() or not npc:is_summons() then
      npc.time_mgr:add_time_scale(scale, duration, scale_data)
    end
  end
  self:add_plat_time_scale(scale, duration, ease_in, ease_out, magic_id, is_global, ignoral_missile, impact_sound_type, impact_sound_volume, ignore_move, only_effect_enemy)
end

function M:remove_obj_time_scale(magic_id, only_effect_enemy)
  for _, npc in pairs(self.v_npc_map) do
    if only_effect_enemy then
      if npc:is_monster() and not Util.is_destroy(npc) and not npc:is_die() then
        npc.time_mgr:remove_time_scale(magic_id)
      end
    else
      npc.time_mgr:remove_time_scale(magic_id)
    end
  end
  if self.v_scene_plat_mgr then
    self.v_scene_plat_mgr.time_mgr:remove_time_scale(magic_id)
  end
end

function M:add_other_time_scale(scale, duration, ease_in, ease_out, magic_id, is_global, ignoral_missile, impact_sound_type, impact_sound_volume, ignore_move, self_uuid)
  local scale_data = {
    ease_in = ease_in,
    ease_out = ease_out,
    magic_id = magic_id,
    ignoral_missile = ignoral_missile,
    impact_sound_type = impact_sound_type,
    impact_sound_volume = impact_sound_volume,
    ignore_move = ignore_move,
    is_global = is_global
  }
  for cid, luaobj in pairs(self.v_cid_map) do
    if not Util.is_destroy(luaobj) and not luaobj:is_die() and luaobj.uuid ~= self_uuid and luaobj.time_mgr then
      luaobj.time_mgr:add_time_scale(scale, duration, scale_data)
    end
  end
  self:add_plat_time_scale(scale, duration, ease_in, ease_out, magic_id, is_global, ignoral_missile, impact_sound_type, impact_sound_volume)
end

function M:remove_other_time_scale(magic_id, self_uuid)
  for cid, luaobj in pairs(self.v_cid_map) do
    if not Util.is_destroy(luaobj) and not luaobj:is_die() and luaobj.uuid ~= self_uuid and luaobj.time_mgr then
      luaobj.time_mgr:remove_time_scale(magic_id)
    end
  end
  if self.v_scene_plat_mgr then
    self.v_scene_plat_mgr.time_mgr:remove_time_scale(magic_id)
  end
end

function M:set_curtain_show(show)
  local trans = Global.camera and Global.camera:get_camera_trans()
  local get_trans = trans and not trans:IsNull()
  if not get_trans then
    Log.Info("转场失败，相机不存在")
    return
  end
  trans:SetCurtainShow(show)
end

function M:set_scene_show(param, cb, dir, duration)
  dir = dir or 0
  local trans = Global.camera and Global.camera:get_camera_trans()
  local get_trans = trans and not trans:IsNull()
  if not get_trans then
    Log.Info("转场失败，相机不存在")
    return
  end
  local msg1 = MsgGame:mq_publish2(Const.MSG_ON_BATTLE_LOADING_START)
  msg1.mm_x = param
  
  local function msg_cb()
    if cb then
      cb()
    end
    local msg2 = MsgGame:mq_publish2(Const.MSG_ON_BATTLE_LOADING_END)
    msg2.mm_x = param
  end
  
  if duration then
    trans:SetCamShowByDuration(param, msg_cb, duration, dir)
  else
    trans:SetCamShow(param, msg_cb, dir)
  end
  local ui_fight = UIMgr:try_get_visible_ui("fight")
  if ui_fight then
    ui_fight:update_effect_obj_visible(not param)
  end
end

function M:set_game_pause(pause, no_click_feedback)
  self.v_pause_update = pause
  CSGameMgr.GamePause = pause
  InputMgr:release_all_input_key()
  if not TowerMgr then
    return
  end
  local tower = TowerMgr:get_tower()
  if tower then
    if pause then
      GlobalTimeMgr:on_stop()
      self:c2gs_call_scene("sync_scene_logic_action", SceneDef.SCENE_LOGIC_ACTION.PAUSE, Date.server_time(true))
    else
      GlobalTimeMgr:on_resume()
      self:c2gs_call_scene("sync_scene_logic_action", SceneDef.SCENE_LOGIC_ACTION.CONTINUE, Date.server_time(true))
    end
  else
    GlobalTimeMgr:on_resume()
  end
  if self.v_scene_plat_mgr then
    self.v_scene_plat_mgr:pause_time(pause)
  end
  for _, npc in pairs(self.v_npc_map) do
    if npc and not npc:is_destroy() then
      npc.time_mgr:pause_time(pause)
    end
  end
  if self.v_operate_chars then
    for uuid, hero in pairs(self.v_operate_chars) do
      if hero:can_update() then
        hero.time_mgr:pause_time(pause)
      end
    end
  end
  if self.v_scene_effect_mgr then
    self.v_scene_effect_mgr:update_speed(pause)
  end
  if pause and not no_click_feedback then
    UIMgr:get_ui("ui_click_effect"):ui_show()
  elseif not self:check_main_scene() then
    UIMgr:try_hide_ui("ui_click_effect")
  end
  if Global.sound_mgr then
    Global.sound_mgr:pause_scene_fade(pause, self.is_main_scene)
  end
  TimeLineSeqPlayer.on_game_pause_state_change(pause)
  local msg = MsgGame:mq_publish2(Const.MSG_ON_GAME_PAUSE)
  msg.mm_x = pause
  if self.v_scene_logic then
    self.v_scene_logic:set_scene_timeline_state(not pause)
  end
end

function M:get_game_pause()
  return self.v_pause_update
end

function M:_on_reconnect()
  NewbieTowerMgr:on_reconnect()
  if self.v_scene_id ~= MAIN_SCENE_ID then
    return
  end
  for _, sys_info in ipairs(Config.system_modules) do
    _G[sys_info.global_name]:on_reconnect()
  end
  Network:call("c2gs_roleinfo", {}, function(ok, resp)
    Log.Info("_on_connect suc")
    if self.v_scene_id == MAIN_SCENE_ID then
      self:_on_load_main_scene()
    end
  end)
end

function M:_on_fight_reconnect(msg)
  do return end
  if Util.is_client_only() then
    return
  end
  local tower = TowerMgr:get_tower()
  if not tower then
    return
  end
  local msg_data = {
    tower_id = tower:get_tower_id(),
    floor_id = tower:get_floor_num(),
    room_num = tower:get_room_num()
  }
  local role_list = {}
  for _, v in pairs(self.v_operate_chars) do
    local data = v:pack_msg_data()
    _insert(role_list, data)
  end
  for _, v in pairs(self.v_npc_map) do
    local data = v:pack_msg_data()
    _insert(role_list, data)
  end
  if self.v_god_npc then
    local data = self.v_god_npc:pack_msg_data()
    _insert(role_list, data)
  end
  msg_data.role_list = role_list
  Network:call("c2gs_scene_restore_role", msg_data, function(ok, resp)
    if 0 == resp.errcode then
      local room = self.v_scene_logic:get_room()
      room:set_random_seed(resp.random_seed)
    end
  end)
end

function M:get_scene_item_mgr()
  return self.v_scene_item_mgr
end

function M:check_create_tp_point()
  if not TowerMgr then
    return
  end
  local tower = TowerMgr:get_tower()
  if not tower then
    return
  end
  if tower:check_pass_all_room(true) then
    return
  end
  return true
end

function M:on_hero_room_recover(is_new_floor)
  if not self.v_scene_logic then
    return
  end
  self:c2gs_call_scene("sync_hero_room_recover")
end

function M:add_client_obj(cid, obj)
  self.v_cid_map[cid] = obj
end

function M:remove_client_obj(cid)
  self.v_cid_map[cid] = nil
end

function M:set_gloabl_time_scale(duration, is_add, ease_in, ease_out, owner, time_scale_index, magic_id)
  self.v_global_scale_duration = duration
  self.v_elapse = 0
  local scale_data = {
    ease_in = ease_in,
    ease_out = ease_out,
    is_global = true,
    global_scale_index = time_scale_index,
    magic_id = magic_id
  }
  local scale = GlobalTimeMgr:get_time_scale()
  for _, npc in pairs(self.v_npc_map) do
    if npc and not npc:is_destroy() then
      npc.time_mgr:remove_global_time_scale()
      npc.time_mgr:set_global_caster(owner)
      if is_add then
        npc.time_mgr:add_time_scale(scale, duration, scale_data)
      end
    end
  end
  for _, hero in pairs(self.v_operate_chars) do
    if hero:can_update() then
      hero.time_mgr:remove_global_time_scale()
      hero.time_mgr:set_global_caster(owner)
      if is_add then
        hero.time_mgr:add_time_scale(scale, duration, scale_data)
      end
    end
  end
  if self.v_scene_effect_mgr then
    self.v_scene_effect_mgr:update_speed(nil, is_add)
  end
  if self.v_scene_plat_mgr then
    self.v_scene_plat_mgr.time_mgr:remove_global_time_scale()
    self.v_scene_plat_mgr.time_mgr:set_global_caster()
    if is_add then
      self.v_scene_plat_mgr.time_mgr:add_time_scale(scale, duration, scale_data)
    end
  end
end

function M:jump_floor_ui()
  if GAME_DEBUG then
    self.v_jump_floor_ui = true
  end
end

function M:get_jump_floor_ui()
  if GAME_DEBUG then
    return self.v_jump_floor_ui
  end
  return false
end

function M:is_can_controlled()
  return self.v_player_control
end

function M:set_player_control_on()
  self.v_player_control = true
end

function M:set_player_control_off()
  self.v_player_control = false
  InputMgr:release_all_input_key()
end

function M:show_scene_position()
  if not self.v_scene_logic then
    return
  end
  self.v_scene_logic:show_scene_position()
end

do
  local GET_DIS_TYPE = {
    NPC = 1,
    POS = 2,
    WALL = 3,
    OBSTACLE = 4
  }
  local _tmp_dis_vec = Vec3.New(0, 0, 0)
  
  local function _calc_dir(target_dir_type, npc)
    local add_deg = (target_dir_type - 1) * 90
    local deg = add_deg + npc:get_dir()
    local rad = deg * MathX.Deg2Rad
    local x = _sin(rad)
    local z = _cos(rad)
    _tmp_dis_vec.x, _tmp_dis_vec.z = x, z
  end
  
  local GET_DIS_FUNC = {
    [GET_DIS_TYPE.NPC] = function(npc, target, include_body)
      if not target then
        return
      end
      local posa = npc:get_pos_vec3()
      local posb = target:get_pos_vec3()
      local dt = MathX.distance2(posa.x, posa.z, posb.x, posb.z)
      if include_body then
        return dt - npc.radius - target.radius
      else
        return dt
      end
    end,
    [GET_DIS_TYPE.POS] = function(npc, posx, posz, include_body)
      local posa = npc:get_pos_vec3()
      local dt = MathX.distance2(posa.x, posa.z, posx, posz)
      if include_body then
        return dt - npc.radius
      else
        return dt
      end
    end,
    [GET_DIS_TYPE.WALL] = function(npc, target_dir_type, include_body)
      local posx, posy, posz = npc:get_pos()
      local map = SceneMgr:get_scene_map()
      local dis
      if target_dir_type then
        _calc_dir(target_dir_type, npc)
        local is_intersect, targetx, targetz = map:get_intersect_collider_point(posx, posy, posz, 10, _tmp_dis_vec)
        if not is_intersect then
          return
        end
        dis = MathX.distance2(posx, posz, targetx, targetz)
      else
        dis = map:get_min_dis_to_wall(posx, posz)
      end
      if include_body then
        return dis - npc.radius
      else
        return dis
      end
    end,
    [GET_DIS_TYPE.OBSTACLE] = function(npc, target_dir_type, include_body, limit)
      local posx, posy, posz = npc:get_pos()
      local map = SceneMgr:get_scene_map()
      local dis
      if target_dir_type then
        _calc_dir(target_dir_type, npc)
        local is_intersect, targetx, targetz = map:get_intersect_collider_point(posx, posy, posz, limit, _tmp_dis_vec)
        if not is_intersect then
          return
        end
        dis = MathX.distance2(posx, posz, targetx, targetz)
      else
        dis = map:get_min_dis_to_collider(posx, posy, posz, limit)
      end
      if include_body then
        return dis - npc.radius
      else
        return dis
      end
    end
  }
  
  function M:get_npc_distance(npc, type, param1, param2, param3)
    local func = GET_DIS_FUNC[type]
    if not func then
      Log.Error("get_npc_distance type error, type = ", type)
      return
    end
    return func(npc, param1, param2, param3)
  end
end

function M:cache_gm_terrain(terrain_obj)
  self.v_gm_terrain_list = self.v_gm_terrain_list or {}
  _tinsert(self.v_gm_terrain_list, terrain_obj)
end

function M:remove_terrain(index)
  self.v_gm_terrain_list = self.v_gm_terrain_list or {}
  local terrain_obj = self.v_gm_terrain_list[index]
  ResPool:release(terrain_obj)
  _tremove(self.v_gm_terrain_list, index)
end

function M:get_terrain_list()
  self.v_gm_terrain_list = self.v_gm_terrain_list or {}
  return self.v_gm_terrain_list
end

local function _find_scene_obj(root_name, object_name)
  local root = UnityFind(root_name)
  if not root or root:IsNull() then
    Log.Info("场景中找不到 ", root_name, object_name)
    return
  end
  local object = root.transform:Find(object_name)
  if object and not object:IsNull() then
    return object
  end
end

function M:show_gameobject(object_name, is_show)
  local object = self:get_gameobject(object_name)
  if not object then
    return
  end
  if self.v_special_terrain_mgr and object.tag == Config.TERRAIN_TAG.WATER then
    self.v_special_terrain_mgr:load_single_scene_special_terrain(object, Config.SPECIAL_TERRAIN[Config.TERRAIN_TAG.WATER])
  end
  object.gameObject:SetActive(is_show)
end

function M:get_gameobject(object_name)
  local object = _find_scene_obj("GroupCtrlObj", object_name) or _find_scene_obj("Root", object_name)
  return object
end

function M:hide_scene_effect_status_obj(path)
  local object = _find_scene_obj("GroupCtrlObj", path) or _find_scene_obj("Root", path)
  if not object then
    Log.Error("not found, name = ", path)
    return
  end
  local effect_status = object:GetComponent(TYPE_EFFECT_STATUS)
  if not effect_status then
    object.gameObject:SetActive(false)
    return
  end
  local animator = Util.get_animator(nil, object)
  local end_effect_time = animator and effect_status:GetEndLength() or 0
  effect_status:PlayEndEffect()
  Timer:add_timer("hide_effect_status_obj", end_effect_time, function()
    object.gameObject:SetActive(false)
  end)
end

function M:set_scene(scene_id, map_name)
  local root = UnityFind("Root")
  if not root or root:IsNull() then
    return
  end
  local scene_cfg = ShareRes.create("scene", self.v_target_scene_id)
  local scene_name = scene_cfg.SceneName and scene_cfg.SceneName or scene_cfg.MapName
  local size_cfg = ShareRes.create("map." .. scene_name .. "." .. map_name .. ".size")
  if not size_cfg or not size_cfg.HasSetSceneTra then
    return
  end
  local offset = size_cfg.SceneOffset
  local euler_angle = size_cfg.SceneRotation
  root.transform:SetPositionA(offset[1], offset[2], offset[3])
  root.transform:SetEuler(euler_angle[1], euler_angle[2], euler_angle[3])
  local effect = UnityFind("SceneEffect")
  if not effect or effect:IsNull() then
    Log.Error("get SceneEffect failue!")
    return
  end
  local ill = effect:GetComponent(typeof(CS.SceneIllumination))
  if not ill then
    Log.Error("get SceneIllumination failue!")
    return
  end
  self.v_cur_ill = ill
  self:_init_diff_light()
  self.v_main_light = ill.MainLight
  if self.v_main_light then
    local light_euler_angle = size_cfg.LightRotation
    if not Vec3.IsZeroVectorA(light_euler_angle[1], light_euler_angle[2], light_euler_angle[3]) then
      self.v_main_light_dir = Vec3.New(self.v_main_light.transform:GetLocalEulerAnglesA3())
      self.v_main_light.transform:SetLocalEuler(light_euler_angle[1], light_euler_angle[2], light_euler_angle[3])
    end
  end
end

function M:set_scene_on_story_room()
  self:_init_diff_light()
end

function M:revert_main_light_dir()
  if not self.v_main_light_dir or not self.v_main_light then
    return
  end
  self.v_main_light.transform:SetLocalEuler(self.v_main_light_dir:Get())
  self.v_main_light_dir = nil
end

local function _active_child_but(root_trans, index)
  if not root_trans then
    return
  end
  local ret_child_trans
  for i = 0, root_trans.childCount - 1 do
    local child = root_trans:GetChild(i)
    child.gameObject:SetActive(i == index)
    if i == index then
      ret_child_trans = child
    end
  end
  return ret_child_trans
end

function M:_init_diff_light(ill_index)
  local root = UnityFind(SCENE_ROOT)
  if nil == root then
    return
  end
  local container = root:GetComponent(TypeSceneContainer)
  if nil == container then
    return
  end
  local index = 0
  if TowerMgr then
    local tower = TowerMgr:get_tower()
    if tower then
      index = tower:get_diff_light_index()
    else
      local story_room = TowerMgr:get_story_room()
      if story_room then
        index = story_room:get_diff_light_index()
      elseif ill_index then
        index = ill_index
      end
    end
  end
  if ill_index then
    index = ill_index
  end
  local change = container:Get(CHANGE_ROOT_NAME)
  if change then
    _active_child_but(change.transform, index)
  end
  local skybox = container:Get(SKYBOX_ROOT_NAME)
  if not Util.is_nil(skybox) then
    _active_child_but(skybox.transform, index)
  end
  if not Util.is_nil(self.v_cur_ill) and not Util.is_nil(change) then
    self.v_cur_ill:ActiveChangeGameObject(change.gameObject, index)
  end
  MsgGame:mq_publish2(Const.MSG_ON_LIGHT_DATA_INDEX_UPDATE)
end

function M:check_hide_npc_hp_obj()
  return self.v_is_hide_npc_hp_obj
end

function M:set_hide_npc_hp_obj(is_hide)
  self.v_is_hide_npc_hp_obj = is_hide
end

function M:show_npc_hp_obj()
  if not Util.is_client_only() and not TowerMgr:get_tower() then
    return
  end
  local show_data, show_big, show_elite, show_small, show_hero
  for uuid, npc in pairs(self.v_npc_map) do
    show_big, show_elite, show_small = true, true, true
    show_data = FightDataMgr:get_hp_visible_state(uuid)
    if show_data then
      if show_data.show_big ~= nil then
        show_big = show_data.show_big
      end
      if nil ~= show_data.show_elite then
        show_elite = show_data.show_elite
      end
      if nil ~= show_data.show_small then
        show_small = show_data.show_small
      end
    end
    npc:set_small_hp_visible(show_small)
    npc:set_big_hp_visible(show_big)
    npc:set_elite_hp_visible(show_elite)
  end
  local fight = UIMgr:try_get_loaded_ui("fight")
  if fight and not fight:is_destroy() and fight:has_inited() then
    show_hero = true
    for uuid, hero in pairs(self.v_hero_list) do
      show_data = FightDataMgr:get_hp_visible_state(uuid)
      if show_data and nil ~= show_data.show_hero then
        show_hero = show_data.show_hero
      end
      if not show_hero then
        break
      end
    end
    fight:set_hp_visible(show_hero)
  end
  self:set_hide_npc_hp_obj(false)
end

function M:hide_npc_hp_obj(msg, target_type, show_hero_bar)
  if not Util.is_client_only() and not TowerMgr:get_tower() then
    return
  end
  local all_hide = not Util.is_more_than_zero(target_type)
  local all_show
  local show_hero = true == show_hero_bar
  local show_big, show_elite, show_small, before_show_big, before_show_elite, before_show_small, before_show_hero
  if all_hide then
    show_big, show_elite, show_small, all_show = false, false, false, false
  elseif 1 == (target_type >> 3) % 2 then
    show_big, show_elite, show_small, all_show = true, true, true, true
    show_hero = true
  else
    show_big = 1 == target_type % 2
    show_elite = 1 == (target_type >> 1) % 2
    show_small = 1 == (target_type >> 2) % 2
    all_show = false
  end
  local fight = UIMgr:try_get_ui("fight")
  local enemy_bar = fight and fight:get_panel("enemy_bar")
  for uuid, npc in pairs(self.v_npc_map) do
    if not self.v_is_hide_npc_hp_obj then
      if enemy_bar then
        before_show_big = enemy_bar:get_big_enemy_item_visible(uuid)
        before_show_elite = enemy_bar:get_elite_enemy_item_visible(uuid)
      end
      before_show_small = npc:get_hp_visible()
      FightDataMgr:set_hp_visible_state(uuid, before_show_big, before_show_elite, before_show_small)
    end
    npc:set_small_hp_visible(show_small)
    npc:set_big_hp_visible(show_big)
    npc:set_elite_hp_visible(show_elite)
  end
  if fight and not fight:is_destroy() and fight:has_inited() then
    local hero_bar = fight:get_panel("hero_bar")
    if not self.v_is_hide_npc_hp_obj then
      before_show_hero = hero_bar:get_enable()
      for _, hero in pairs(self.v_hero_list) do
        FightDataMgr:set_hp_visible_state(hero.uuid, nil, nil, nil, before_show_hero)
      end
    end
    fight:set_hp_visible(show_hero)
  end
  self:set_hide_npc_hp_obj(true)
end

function M:create_god_npc_in_client(char_id, is_recreate)
  char_id = char_id or DebugSetting:get_god_id()
  if not Util.is_more_than_zero(char_id) then
    return
  end
  if not Util.is_client_only() then
    return
  end
  if self.v_god_npc then
    if is_recreate then
      self:clear_god_npc()
    else
      return
    end
  end
  local uuid = self:get_uuid()
  self:_do_create_god(uuid, nil, char_id)
end

function M:try_interact_special_terrain(missile)
  self.v_special_terrain_mgr:try_interact(missile)
end

function M:get_special_terrain_cfg(cid)
  return self.v_special_terrain_mgr and self.v_special_terrain_mgr:get_cfg(cid)
end

function M:create_robot_heros(info)
  self.v_robot_hero_list = {}
  local buddy_cfg = ShareRes.create("buddy.buddy", info.id)
  local hero = SceneMgr:create_hero({
    uuid = info.uuid,
    role_id = info.id,
    res_id = buddy_cfg.ModelId
  }, {is_robot = true})
  hero.buddy_cfg = buddy_cfg
  hero:on_to_background_state()
end

function M:switch_robot_hero(keycode)
  local cur_hero = self.v_hero_list[Global.hero_uuid]
  local _, next_hero = next(self.v_robot_hero_list)
  if Global.camera then
    Global.camera:stop_follow_tar()
    Global.camera:set_target(next_hero)
  end
  cur_hero:on_to_background_state(keycode)
  next_hero:on_to_control_state()
  return true
end

function M:get_has_robot_hero()
  return self.v_robot_hero_list and next(self.v_robot_hero_list) ~= nil
end

function M:get_robot_hero_list()
  return self.v_robot_hero_list or {}
end

function M:set_forbid_switch_hero_state(is_forbid)
  if not self.v_hero_list or not next(self.v_hero_list) then
    return
  end
  self.v_forbid_switch_hero_state = is_forbid
  MsgGame:mq_publish2(Const.MSG_ON_FORBID_SWITCH_HERO)
end

function M:check_switch_hero()
  return not self.v_forbid_switch_hero_state
end

function M:check_is_switching_hero()
  return SwitchHeroHelper.is_switching
end

function M:change_hero_state(hero, current_state, keycode, cur_hero_background, state_type)
  state_type = state_type or Config.CHANGE_HERO_ANIM_TYPE.IDLE
  self.v_change_hero_state_lock = true
  local last_state = hero:get_current_state()
  if last_state == current_state then
    return
  end
  if state_type == Config.CHANGE_HERO_ANIM_TYPE.IDLE then
    hero.state_manager:to_idle_state(true)
  elseif state_type == Config.CHANGE_HERO_ANIM_TYPE.RUN then
    hero.state_manager:set_dir_to_run(true)
    hero.state_manager:to_run_state(true)
  end
  local uuid = hero.uuid
  if current_state == Config.HERO_STATE.IN_CONTROL then
    if Util.is_client_only() then
      self:switch_hero(hero.uuid, nil, cur_hero_background)
    else
      SwitchHeroHelper.check_switch_hero(uuid, keycode, cur_hero_background)
    end
  elseif current_state == Config.HERO_STATE.IN_BACKGROUND then
    hero:on_to_background_state(keycode)
  else
    hero:on_to_ground_state(keycode)
  end
  if last_state == Config.HERO_STATE.IN_CONTROL then
    hero:on_exit_control_state()
  end
  self.v_change_hero_state_lock = nil
end

function M:remove_missile_by_id(missile_id, char, skip_check_limit, need_explosion)
  local remove_list = {}
  if char then
    local missiles = self:get_missile_by_char(char)
    for _, missile in ipairs(missiles) do
      if missile.missile_id == missile_id then
        table.insert(remove_list, missile)
      end
    end
  else
    for _, v in pairs(self.v_missile_map) do
      if v.missile_id == missile_id then
        table.insert(remove_list, v)
      end
    end
    for _, v in pairs(self.v_wait_add_missile_map) do
      if v.missile_id == missile_id then
        table.insert(remove_list, v)
      end
    end
  end
  for _, missile in pairs(remove_list) do
    self:remove_missile(missile, skip_check_limit, need_explosion)
  end
end

function M:get_nearest_walkable_pos(src_pos, tar_pos, body_size, check_ground_dist, check_layer)
  if not self.v_scene_map then
    return false, src_pos
  end
  return self.v_scene_map:get_nearest_walkable_pos(src_pos, tar_pos, body_size, check_ground_dist, check_layer)
end

function M:gm_set_monster_footmark_state()
  if not self.is_hide_footmark then
    self.is_hide_footmark = true
  else
    self.is_hide_footmark = false
  end
end

function M:is_show_footmark_state()
  return not self.is_hide_footmark
end

function M:check_set_battle_monster_type(npc)
  local character_cfg = npc.character_cfg
  local kind = character_cfg.Kind
  if record_battle_type[kind] then
    if not self.v_cur_battle_type then
      self.v_cur_battle_type = kind
    else
      self.v_cur_battle_type = math.max(kind, self.v_cur_battle_type)
    end
  end
end

function M:get_battle_monster_type()
  return self.v_cur_battle_type
end

function M:reset_battle_monster_type()
  self.v_cur_battle_type = nil
end

function M:on_cd_npc_hit(npc_name, hit_num)
  self:c2gs_call_scene("on_cd_npc_hit", npc_name, hit_num)
  BehaviorMgr:call_scene_logic_event_fun("on_cd_npc_hit", npc_name, hit_num)
end

function M:set_root_trans(pos_x, pos_y, pos_z, rot_x, rot_y, rot_z)
  local root = UnityFind("Root")
  if not root or root:IsNull() then
    return
  end
  local light_quat
  if self.v_main_light then
    light_quat = self.v_main_light.transform.rotation
  end
  local root_trans = root.transform
  root_trans:SetPositionA(pos_x, pos_y, pos_z)
  root_trans.rotation = Quat.Euler(rot_x, rot_y, rot_z)
  self.v_main_light.transform.rotation = light_quat
end

function M:apply_defualt_scene_illumination()
  local effect = UnityFind("SceneEffect")
  if not effect or effect:IsNull() then
    Log.Error("get SceneEffect failue!")
    return
  end
  local ill = effect:GetComponent(typeof(CS.SceneIllumination))
  if not ill then
    Log.Error("get SceneIllumination failue!")
    return
  end
  ill:ApplySceneIlluminationInfo()
end

function M:apply_second_scene_illumination()
  local effect = UnityFind("SceneEffect")
  if not effect or effect:IsNull() then
    Log.Error("get SceneEffect failue!")
    return
  end
  local ill = effect:GetComponent(typeof(CS.SceneIllumination))
  if not ill then
    Log.Error("get SceneIllumination failue!")
    return
  end
  ill:ApplySecondSceneIlluminationInfo()
end

function M:scene_illumination_defualt_to_second(gradient_time)
  local effect = UnityFind("SceneEffect")
  if not effect or effect:IsNull() then
    Log.Error("get SceneEffect failue!")
    return
  end
  local ill = effect:GetComponent(typeof(CS.SceneIllumination))
  if not ill then
    Log.Error("get SceneIllumination failue!")
    return
  end
  gradient_time = gradient_time or 1.0
  if gradient_time < 0.02 then
    gradient_time = 0.02
  end
  ill:GradientApplySecondSceneIlluminationInfo(1.0 / (gradient_time / 0.02))
end

function M:scene_illumination_second_to_defualt(gradient_time)
  local effect = UnityFind("SceneEffect")
  if not effect or effect:IsNull() then
    Log.Error("get SceneEffect failue!")
    return
  end
  local ill = effect:GetComponent(typeof(CS.SceneIllumination))
  if not ill then
    Log.Error("get SceneIllumination failue!")
    return
  end
  gradient_time = gradient_time or 1.0
  if gradient_time < 0.02 then
    gradient_time = 0.02
  end
  ill:GradientApplySceneIlluminationInfo(1.0 / (gradient_time / 0.02))
end

function M:add_recreate_hero_count(count)
  self.v_recreate_hero_count = self.v_recreate_hero_count + count
end

function M:clear_recreate_hero_count()
  self.v_recreate_hero_count = 0
  self.v_recreate_suc_hero_count = 0
end

function M:send_tp_befoce_req(tp_dir)
  local tower = TowerMgr:get_tower()
  if tower then
    local tower_id = tower:get_tower_id()
    local floor_id = tower:get_floor_num()
    local room_num = tower:get_room_num()
    Network:call("c2gs_tower_tp_next_room_before", {
      tower_id = tower_id,
      floor_id = floor_id,
      room_num = room_num,
      tp_dir = tp_dir
    }, nil)
  end
end

function M:check_continue_tp_room()
  if self.v_scene_logic then
    local continue_tp_room_params = self.v_scene_logic:get_continue_tp_room_params()
    if continue_tp_room_params then
      self.v_scene_logic:continue_tp_room(table.unpack(continue_tp_room_params))
      return true
    end
  end
  local room = TowerMgr and TowerMgr:get_cur_room()
  if room then
    return room:continue_tp_next_floor()
  end
end

function M:check_need_continue_tp_room()
  local need = false
  if self.v_scene_logic then
    local continue_tp_room_params = self.v_scene_logic:get_continue_tp_room_params()
    need = nil ~= continue_tp_room_params
  end
  if not need then
    local room = TowerMgr and TowerMgr:get_cur_room()
    if room then
      need = room:have_tp_next_floor_cb()
    end
  end
  return need
end

function M:is_delay_fight_end()
  if self.v_scene_logic then
    return self.v_scene_logic:is_delay_fight_end()
  else
    return false
  end
end

function M:on_go_out_role(data)
  if data and data.slot then
    for key, hero in pairs(self.v_hero_list) do
      if not hero:is_die() and hero:get_team_pos() == data.slot then
        self:change_hero_state(hero, Config.HERO_STATE.IN_CONTROL, nil, true)
        MsgGame:mq_publish2(Const.MSG_ON_GO_OUT_ROLE)
        break
      end
    end
  end
end

function M:on_new_hero_done(hero)
  local fight = UIMgr:try_get_loaded_ui("fight")
  if fight then
    local msg = {
      mm_x = hero and hero.uuid
    }
    fight:update_hero_info(msg)
    local hero_head_view = fight:get_panel("hero_head_view")
    hero_head_view:response_change_hero_team_pos(msg)
  end
end

function M:global_hero_is_destroyed()
  return Global.hero == nil or Global.hero:is_destroy()
end

function M:get_missile_by_id(id)
  return self.v_missile_map[id]
end

function M:get_missile_map()
  return self.v_missile_map
end

function M:after_enter_loading()
  TimeLineSeqPlayer.after_enter_loading()
end

function M:copy_attr_to_npc(from_npc, target_npc, type_arg)
  local temp
  local attr_list = {}
  for attr_id, ratio in pairs(type_arg) do
    temp = {}
    temp.attr_id = attr_id
    temp.ratio = ratio
    table.insert(attr_list, temp)
  end
  local ext_args = {
    arg = {
      type = Config.MagicDefine.MAGIC_CUSTOM_EVENTS_DEFINE_TYPE.COPY_ATTR,
      attr_list = attr_list
    }
  }
  target_npc.magic_mgr:add_magic(from_npc, Config.CUSTOM_MAGIC, nil, nil, 1, nil, ext_args)
end

function M:change_root_pos_and_rota(pos_x, pos_y, pos_z, rota_x, rota_y, rota_z)
  if not self.v_root_obj then
    self:init_scene_root_objs()
  end
  self.v_root_obj.transform:SetPositionA(pos_x, pos_y, pos_z)
  self.v_root_obj.transform:SetEuler(rota_x, rota_y, rota_z)
end

function M:_find_scene_bind_obj(level_obj_name, obj_name)
  local root_container = self:get_root_container()
  local levelObj = root_container:Get(level_obj_name)
  if not levelObj then
    Log.Error("Root的SceneContainer组件中找不到", level_obj_name, debug.traceback())
    return
  end
  local level_obj_container = levelObj:GetComponent(TypeSceneContainer)
  if not level_obj_container then
    Log.Error(level_obj_name .. "上找不到SceneContainer组件", debug.traceback())
    return
  end
  return level_obj_container:Get(obj_name)
end

function M:add_scene_npc(level_obj_name, obj_name, res_id, abs_camp, level, status, penetrable, uuid)
  local gameobj = self:_find_scene_bind_obj(level_obj_name, obj_name)
  if not gameobj then
    Log.Error("场景中找不到", level_obj_name, obj_name)
    return
  end
  local cid = gameobj:GetInstanceID()
  local trans = gameobj.transform
  local posx, posy, posz = trans:GetPositionA()
  local rotx, roty, rotz = trans:GetLocalEulerAnglesA3()
  local scalex, scaley, scalez = trans:GetLocalScaleA3()
  local ext_args = {uuid = uuid, npc_name = obj_name}
  local param = self:get_create_npc_param(res_id, posx, posy, posz, 0, abs_camp, level, ext_args)
  local npc = self.v_npc_pool_mgr:get_npc(param, function(luaobj)
    luaobj:set_scene_npc_status(status)
    luaobj:set_ignore_sync(true)
    luaobj:init_gameobj(cid, gameobj, trans)
    luaobj:set_pos(posx, posy, posz)
    luaobj:set_target_dir(roty, true)
    luaobj:set_penetrable(penetrable)
    NextFrameMgr:add(function()
      trans:SetLocalEuler(rotx, roty, rotz)
    end)
    trans:SetLocalScaleA(scalex, scaley, scalez)
  end, "obj.scene_npc")
  self.v_npc_map[uuid] = npc
  self:add_obj_to_uuid_map(uuid, npc)
  return npc
end

function M:check_our_camp_betarget()
  return self.v_our_camp_betarget
end

function M:get_camera_focus_params()
  if self.camera_focus_params then
    return self.camera_focus_params
  end
  self.camera_focus_params = {}
  local data_table = ShareRes.get_comm_string_value("CameraFocusParams")
  self.total_weight = 0
  if data_table then
    for index, v in ipairs(data_table) do
      if type(v) == "table" then
        local temp_table = {}
        temp_table.x = tonumber(v[1])
        temp_table.y = tonumber(v[2])
        temp_table.z = tonumber(v[3])
        self.camera_focus_params[index] = v
      elseif "nil" == v then
        self.camera_focus_params[index] = nil
      else
        self.camera_focus_params[index] = tonumber(v)
      end
    end
  end
  return self.camera_focus_params
end

function M:mat_vertexanim_reset()
  CSHelper.ReSetVertexAnim()
end

function M:room_offset_shadow(tower_id, floor_id, room_id)
  CSShadow.SetLightOffset(0, 0, 0)
end

function M:room_offset_shadow_api(x, y, z)
  CSShadow.SetLightOffset(x, y, z)
end

function M:clear_offset_shadow()
  CSShadow.SetLightOffset(0, 0, 0)
end

function M:add_magic_to_all_hero(magic_id, skip_dead_hero)
  for uuid, hero in pairs(self.v_hero_list) do
    if not hero:is_destroy() and (not skip_dead_hero or not hero:is_die()) then
      hero.magic_mgr:add_magic(hero, magic_id)
    end
  end
end

function M:set_archive_num(num)
  self.v_archive_num = num
end

function M:get_archive_num()
  return self.v_archive_num
end

function M:reborn_npc_by_buff(uuid, attr_ratio_map)
  if not self.v_hero_list then
    return
  end
  local hero = self.v_hero_list[uuid]
  if not hero then
    return
  end
  hero:reset(nil, attr_ratio_map)
  BehaviorMgr:call_event_fun(BehaviorMgr.EVENTS.ON_HERO_REBORN, hero)
end

function M:refresh_scene_timeline_animator_list(event_list)
  self.m_scene_timeline_animator_list = {}
  if not event_list then
    return
  end
  local container = SceneMgr:get_root_container()
  if not container then
    Log.Error("refresh_scene_timeline_animator_list SceneMgr:get_root_container 为空")
    return
  end
  for i, event_data in pairs(event_list) do
    local list = event_data.SceneTimelineObjectList
    if not list then
    else
      for index, event_info in ipairs(list) do
        local key_list = Util.split_str(event_info.KeyNames, ",")
        if not key_list then
        else
          local anim_list = Util.split_str(event_info.AnimNames, ",")
          if not anim_list then
          else
            for key_index, key_plat in ipairs(key_list) do
              if self.m_scene_timeline_animator_list[event_info.Key] ~= nil then
                Log.Error("当前关卡逻辑的场景timeline动画列表事件存在相同Key", event_info.Key)
              end
              local key_plat_list = Util.split_str(key_plat, "|")
              local key = key_plat_list[1]
              local data = {}
              data.key = key
              if 2 == #key_plat_list then
                data.plat_name = key_plat_list[2]
              end
              data.status = event_info.Status
              data.obj_list = {}
              data.curr_index = 0
              data.curr_type = event_info.CurrType
              data.is_play_forward = true
              local key_obj = SceneMgr:_find_scene_bind_obj(event_info.ContainerName, key)
              if key_obj then
                for anim_index, anim_name in ipairs(anim_list) do
                  local anim_trans = key_obj.transform:Find(anim_name)
                  if Util.is_nil(anim_trans) then
                  else
                    local obj_info = {}
                    local anim_obj = anim_trans.gameObject
                    local pd = anim_obj:GetComponentInChildren(TypePlayableDirector)
                    if not Util.is_nil(pd) then
                      local scene_timeline = anim_obj:TryAddComponent(TypeSpeedSceneTimeline)
                      obj_info.speed_timeline = scene_timeline
                      obj_info.timeline = pd
                    end
                    obj_info.anim_obj = anim_obj
                    obj_info.anim_name = anim_name
                    table.insert(data.obj_list, obj_info)
                  end
                end
              end
              self.m_scene_timeline_animator_list[key] = data
            end
          end
        end
      end
    end
  end
end

function M:on_scene_object_list_play(key_names)
  local key_list = Util.split_str(key_names, ",")
  if not key_list then
    return
  end
  for i, key in pairs(key_list) do
    local info = self.m_scene_timeline_animator_list[key]
    if not info then
    elseif not info.status then
    else
      if info.is_play_forward then
        info.curr_index = info.curr_index + 1
        if 0 == info.curr_type then
          if info.curr_index > #info.obj_list then
            info.curr_index = 1
          end
        elseif 1 == info.curr_type and info.curr_index > #info.obj_list then
          info.is_play_forward = false
          info.curr_index = #info.obj_list
        end
      else
        info.curr_index = info.curr_index - 1
        if info.curr_index <= 0 then
          info.curr_index = 1
          info.is_play_forward = true
        end
      end
      for obj_index = 1, #info.obj_list do
        info.obj_list[obj_index].anim_obj:SetActive(false)
      end
      for obj_index = 1, #info.obj_list do
        if info.curr_index == obj_index then
          local obj_info = info.obj_list[obj_index]
          obj_info.anim_obj:SetActive(true)
          if info.is_play_forward == false then
            obj_info.speed_timeline:SetSpeed(-1, obj_info.timeline.time)
          else
            obj_info.speed_timeline:SetSpeed(1, 0)
          end
          local plat
          if info.plat_name and SceneMgr then
            plat = SceneMgr:get_plat_mgr():_get_plat(info.plat_name)
          end
          if plat then
            plat:set_is_moving()
          end
          obj_info.speed_timeline:PlaySceneTimeline(function()
            if plat then
              plat:stop_move()
            end
          end)
          break
        end
      end
    end
  end
end

function M:on_scene_object_list_pause(key_names, is_pause)
  local key_list = Util.split_str(key_names, ",")
  if not key_list then
    return
  end
  for i, key in pairs(key_list) do
    local info = self.m_scene_timeline_animator_list[key]
    if not info then
    else
      info.status = not is_pause
    end
  end
end

function M:is_in_region(x, z, y)
  return self.v_scene_map and self.v_scene_map:get_region_at_pos(x, z, y) ~= nil
end

function M:get_func_npc_name(func_npc_id)
  local func_npc = self.v_scene_logic:get_func_npc(func_npc_id)
  if not func_npc then
    return nil
  end
  if func_npc.data then
    return func_npc.data.npc_name
  end
  return nil
end

function M:on_fight_over_win_open()
  if StoryMgr then
    StoryMgr:stop_barrage()
  end
end

function M:be_cleaning_up_scene_data()
  return self.v_be_cleaning_up_scene_data
end

function M:be_cleaning_up_missile()
  return self.v_be_cleaning_up_missile or self.v_be_cleaning_up_scene_data
end

function M:set_root_obj_visible(visible)
  if Util.is_nil(self.v_root_obj) then
    self:init_scene_root_objs()
    if Util.is_nil(self.v_root_obj) then
      return
    end
  end
  self.v_root_obj:SetActive(visible)
end

function M:add_to_magic_to_uuid_map(magic_id, uuid)
  self.v_magic_to_uuid_map[magic_id] = self.v_magic_to_uuid_map[magic_id] or {}
  self.v_magic_to_uuid_map[magic_id][uuid] = true
end

function M:remove_at_magic_to_uuid_map(magic_id, uuid)
  if not self.v_magic_to_uuid_map[magic_id] then
    return
  end
  self.v_magic_to_uuid_map[magic_id][uuid] = nil
  if not next(self.v_magic_to_uuid_map[magic_id]) then
    self.v_magic_to_uuid_map[magic_id] = nil
  end
end

function M:add_to_npc_id_to_uuid_map(npc_id, uuid)
  self.v_npc_id_to_uuid_map[npc_id] = self.v_npc_id_to_uuid_map[npc_id] or {}
  self.v_npc_id_to_uuid_map[npc_id][uuid] = true
end

function M:remove_at_npc_id_to_uuid_map(npc_id, uuid)
  if not self.v_npc_id_to_uuid_map[npc_id] then
    return
  end
  self.v_npc_id_to_uuid_map[npc_id][uuid] = nil
  if not next(self.v_npc_id_to_uuid_map[npc_id]) then
    self.v_npc_id_to_uuid_map[npc_id] = nil
  end
end

function M:add_to_kind_to_uuid_map(kind, uuid)
  self.v_kind_to_uuid_map[kind] = self.v_kind_to_uuid_map[kind] or {}
  self.v_kind_to_uuid_map[kind][uuid] = true
end

function M:remove_at_kind_to_uuid_map(kind, uuid)
  if not self.v_kind_to_uuid_map[kind] then
    return
  end
  self.v_kind_to_uuid_map[kind][uuid] = nil
  if not next(self.v_kind_to_uuid_map[kind]) then
    self.v_kind_to_uuid_map[kind] = nil
  end
end

function M:get_change_hero_state_lock()
  return self.v_change_hero_state_lock
end

function M:_global_hero_out_of_stuck(static_8_dir, ray_start_y, ray_max_dis, check_x, check_y, check_z, collider_height)
  local sx, sy, sz = Global.hero:get_pos()
  local out_of_stuck_suc = false
  local hero = Global.hero
  local max_out_length = 15
  local check_height = ray_start_y + check_y + collider_height
  local check_block_height = check_y + collider_height
  local obstacle_mask = Layer.obstacle_mask
  local collision = SceneMgr:check_all_collision(hero, check_x, check_z, check_height, true)
  local hit_block = Util.raycast(check_x, check_z, obstacle_mask, check_block_height, collider_height)
  if not collision and not hit_block and Util.almost_zero(check_x - sx) and Util.almost_zero(check_y - sy) and Util.almost_zero(check_z - sz) then
    local has_terrain, height = Util.raycast(check_x, check_z, LAND_LAYER, check_height, ray_max_dis)
    if has_terrain then
      hero:set_pos(check_x, height, check_z)
      out_of_stuck_suc = true
    end
  end
  if not out_of_stuck_suc then
    local len = 0.1
    local dx, dz
    while max_out_length > len do
      for i = 1, 15, 2 do
        dx = static_8_dir[i] * len
        dz = static_8_dir[i + 1] * len
        local nx, nz = dx + check_x, dz + check_z
        if not SceneMgr:check_all_collision(hero, nx, nz, check_y) and not Util.raycast(check_x, check_z, obstacle_mask, check_block_height, collider_height) then
          local has_terrain, height = Util.raycast(nx, nz, LAND_LAYER, check_height, ray_max_dis)
          if has_terrain then
            hero:set_pos(nx, height, nz)
            out_of_stuck_suc = true
            break
          end
        end
      end
      if out_of_stuck_suc then
        break
      end
      len = len * 1.5
    end
  end
  return out_of_stuck_suc
end

function M:global_hero_out_of_stuck()
  if self:global_hero_is_destroyed() then
    return
  end
  local static_8_dir = {
    1,
    0,
    0.707,
    0.707,
    0,
    1,
    -0.707,
    0.707,
    -1,
    0,
    -0.707,
    -0.707,
    0,
    -1,
    0.707,
    -0.707
  }
  local out_of_stuck_suc = false
  local hero = Global.hero
  local sx, sy, sz = hero:get_pos()
  local collider_height = hero:get_collider_offset_y()
  local ray_start_y = ShareRes.get_comm_value("RoleRayCheckStartY")
  local ray_max_dis = ShareRes.get_comm_value("RoleRayCheckMaxY") + collider_height
  if FightDataMgr.walkable_pos then
    local wx, wy, wz = FightDataMgr.walkable_pos:Get()
    out_of_stuck_suc = self:_global_hero_out_of_stuck(static_8_dir, ray_start_y, ray_max_dis, wx, wy, wz, collider_height)
  end
  if not out_of_stuck_suc then
    local suc, rx, ry, rz = CS.Game.AstarHelper.GetNearestByPos(hero.radius, sx, sy, sz)
    if suc then
      out_of_stuck_suc = self:_global_hero_out_of_stuck(static_8_dir, ray_start_y, ray_max_dis, rx, ry, rz, collider_height)
    end
  end
  if not out_of_stuck_suc then
    local scene_logic = SceneMgr:get_scene_logic()
    if scene_logic then
      scene_logic:set_hero_born_pos()
      out_of_stuck_suc = true
    end
  end
  if out_of_stuck_suc then
    Util.show_message_tip("脱离卡死成功")
  else
    Util.show_message_tip("脱离卡死失败")
    hero:set_pos(sx, sy, sz)
  end
  return out_of_stuck_suc
end

function M:get_skill_link_mgr()
  return self.v_skill_link_mgr
end

function M:temp_sort()
  function quickSort(arr, left, right)
    left = left or 1
    
    right = right or #arr
    if left >= right then
      return
    end
    local pivotIndex = partition(arr, left, right)
    quickSort(arr, left, pivotIndex - 1)
    quickSort(arr, pivotIndex + 1, right)
  end
  
  function partition(arr, left, right)
    local pivotValue = arr[right]
    local storeIndex = left
    for i = left, right - 1 do
      if pivotValue >= arr[i] then
        arr[storeIndex], arr[i] = arr[i], arr[storeIndex]
        storeIndex = storeIndex + 1
      end
    end
    arr[storeIndex], arr[right] = arr[right], arr[storeIndex]
    return storeIndex
  end
  
  local testArr = {
    8,
    9,
    11,
    0,
    -1,
    1,
    -3,
    4,
    5,
    -5,
    -6
  }
  print("排序前:", table.concat(testArr, ", "))
  quickSort(testArr)
  print("排序后:", table.concat(testArr, ", "))
end

return M
