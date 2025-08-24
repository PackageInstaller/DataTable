local _insert = table.insert
local _max = math.max
local CommonDefine = require("cs_share.common_define")
local Fifo = require("manager.res.res_fifo")
local MAX_PRELOAD_FX_NUM = 8
local LOW_MEMORY_DEVICE_MAX_PRELOAD_FX_NUM = 4
local LOAD_FRAME_INTERVAL = 2
local SAME_LOAD_NUM = 6
local PRELOAD_COMMON_FUNC = require("gamemode.preload_common_func")
local HIT_EFFECT_PRELOAD_NUM = 6
local LOW_MEMORY_DEVICE_HIT_EFFECT_PRELOAD_NUM = 3
local ONLY_PRELOAD_ONECE_EFFECT = {
  Config.HERO_HEAL_EFFECT_NAME,
  Config.HERO_CIRCEL_EFFECT_NAME
}
local PRELOAD_RES_TYPE = {
  HERO = 1,
  MONSTER = 2,
  EFFECT = 3,
  EXTRA_ANIM = 4,
  WORLD_MODEL = 5,
  CAMERA = 6,
  HUD_RES = 7,
  UI_MAIN_MODEL = 9,
  DROP_ITEM = 10,
  UI_EFFECT = 11,
  BEHAVIOR_FILE = 12,
  SCENE_EFFECT = 13,
  CONFIG_FILE = 14,
  TIMELINE = 15,
  COLLIDER = 16
}
local PRELOAD_STATE = {LOADING = 1, LOADEND = 2}
local EFFECT_MAX_PRELOAD_NUM = 5
local M = {}
M.PRELOAD_RES_TYPE = PRELOAD_RES_TYPE

function M:init_preload_res_data()
  self.v_preload_res_list = Fifo:new()
  self.v_need_load_res_num = 0
  self.v_cur_load_num = 0
  self.v_load_suc_num = 0
  self.v_last_load_frame = Global.frame_id
  self.v_load_behavior_file_path_map = {}
  self.v_load_config_file_path_map = {}
  self.v_load_effect_count_map = {}
  self.v_fashion_index_map = {}
  PRELOAD_COMMON_FUNC.set_common_param(self, PRELOAD_RES_TYPE)
  self:get_hero_res()
  self:get_god_npc_effect()
  self:get_element_effect()
  self:preload_camera()
  self:get_world_model()
  self:get_common_role_effect_res()
  self:get_hud_res()
  self:get_ui_main_model()
  self:get_drop_item()
  self:get_ui_effect_preload()
  self:get_common_effect()
  self:get_tower_preload_cfg()
  self:preload_config()
end

function M:_push_need_load_data(res_type, prefab_name, num)
  local insert_data = {
    type = res_type,
    prefab_name = prefab_name,
    num = num
  }
  self:push_need_load_data(insert_data)
end

function M:push_need_load_data(insert_data)
  local res_type = insert_data.type
  local prefab_name = insert_data.prefab_name
  if prefab_name and (res_type == PRELOAD_RES_TYPE.UI_EFFECT or res_type == PRELOAD_RES_TYPE.EFFECT) then
    local count_map = self.v_load_effect_count_map
    local cur_count = count_map[prefab_name] or 0
    local remain_count = EFFECT_MAX_PRELOAD_NUM - cur_count
    if remain_count <= 0 then
      return
    end
    local num = insert_data.num or 1
    local fix_count = math.min(num, remain_count)
    insert_data.num = fix_count
    count_map[prefab_name] = cur_count + fix_count
  end
  self.v_need_load_res_num = self.v_need_load_res_num + 1
  self.v_preload_res_list:push(insert_data)
end

function M:set_scene_mod(scene_mod)
  self.v_scene_mod = scene_mod
end

function M:get_load_progress()
  return self.v_need_load_res_num, self.v_load_suc_num
end

function M:load_res(res_data)
  local type = res_data.type
  local animator_res_name = res_data.animator_res_name
  local prefab_name = res_data.prefab_name
  self.v_cur_load_num = self.v_cur_load_num + 1
  if type == PRELOAD_RES_TYPE.HERO then
    if prefab_name then
      self:load_hero(prefab_name, res_data.role_id, animator_res_name, res_data.not_create_immediately)
    end
  elseif type == PRELOAD_RES_TYPE.MONSTER then
    if prefab_name then
      self:load_model(prefab_name, animator_res_name)
    end
  elseif type == PRELOAD_RES_TYPE.UI_MAIN_MODEL then
    if prefab_name then
      self:load_model(prefab_name, animator_res_name)
    end
  elseif type == PRELOAD_RES_TYPE.EXTRA_ANIM then
    self:load_animator(animator_res_name)
    self:update_load_progress()
  elseif type == PRELOAD_RES_TYPE.EFFECT then
    self:load_effect(prefab_name, res_data.num, res_data.is_hero)
  elseif type == PRELOAD_RES_TYPE.WORLD_MODEL then
    self:load_world_model(prefab_name)
  elseif type == PRELOAD_RES_TYPE.HUD_RES then
    self:load_hud_res(prefab_name)
  elseif type == PRELOAD_RES_TYPE.CAMERA then
    SceneMgr:create_camera(true)
    self:update_load_progress()
  elseif type == PRELOAD_RES_TYPE.DROP_ITEM then
    self:load_drop_item(res_data)
  elseif type == PRELOAD_RES_TYPE.UI_EFFECT then
    self:load_ui_effect(res_data)
  elseif type == PRELOAD_RES_TYPE.BEHAVIOR_FILE then
    self:load_behavior_file_res(res_data)
  elseif type == PRELOAD_RES_TYPE.SCENE_EFFECT then
    self:load_scene_effect(prefab_name)
  elseif type == PRELOAD_RES_TYPE.CONFIG_FILE then
    self:load_config_file_res(res_data)
  elseif type == PRELOAD_RES_TYPE.TIMELINE then
    self:load_timeline_res(res_data)
  elseif type == PRELOAD_RES_TYPE.COLLIDER then
    PRELOAD_COMMON_FUNC.load_collider(res_data)
  end
end

function M:check_preload_pro()
  local state = PRELOAD_STATE.LOADING
  local cur_frame = Global.frame_id
  if cur_frame - self.v_last_load_frame < LOAD_FRAME_INTERVAL then
    return state
  end
  self.v_last_load_frame = cur_frame
  local have_to_load = false
  for i = 1, SAME_LOAD_NUM do
    local res_data = self.v_preload_res_list:pop()
    if res_data then
      have_to_load = true
      self:load_res(res_data)
    end
  end
  if not have_to_load and self.v_cur_load_num <= 0 then
    state = PRELOAD_STATE.LOADEND
  end
  return state
end

function M:load_animator(res_name)
  local animator_info = ResPoolMgr:get_animator(res_name)
  ResPoolMgr:release_res(animator_info)
end

function M:load_hero(model_res_name, role_id, animator_res_name, not_create_immediately)
  if animator_res_name then
    self:load_animator(animator_res_name)
  end
  local go = ResPoolMgr:get_model(model_res_name)
  ResPoolMgr:release(go)
  self:update_load_progress()
end

local tmp_table = {}

function M:load_effect(res_name, num, is_hero)
  num = num or 1
  if 1 == num then
    local go = ResPoolMgr:get_effect_res(res_name)
    ResPoolMgr:release(go)
  else
    UtilTable.clear_map(tmp_table)
    for i = 1, num do
      local go = ResPoolMgr:get_effect_res(res_name)
      _insert(tmp_table, go)
    end
    for i = 1, num do
      ResPoolMgr:release(tmp_table[i])
    end
  end
  self:update_load_progress()
  self:debug_uesless_preload_fx(res_name)
end

function M:load_world_model(res_name)
  local go = ResPoolMgr:get_world_model(res_name)
  ResPoolMgr:release(go)
  self:update_load_progress()
end

function M:load_hud_res()
  Global.BloodHelper.preload_common_hud()
  local ui_dynamic_canvas = UIMgr:get_ui("uidynamic_canvas", true)
  for _ = 1, 2 do
    local item = ui_dynamic_canvas:get_float_icon_item()
    item:preload()
    ui_dynamic_canvas:release_float_icon_item(item)
  end
  self:update_load_progress()
end

function M:load_drop_item(res_data)
  local res_name = res_data.prefab_name
  local num = res_data.num
  local obj_list = {}
  for i = 1, num do
    obj_list[#obj_list + 1] = ResPoolMgr:get_drop_item_obj(res_name)
  end
  local length = #obj_list
  for index = 1, length do
    ResPoolMgr:release(obj_list[index])
  end
  self:update_load_progress()
end

function M:load_ui_effect(res_data)
  local obj_list = {}
  local prefab_name = res_data.prefab_name
  local num = res_data.num
  for i = 1, num do
    obj_list[#obj_list + 1] = ResPoolMgr:get_ui_effect(prefab_name)
  end
  local length = #obj_list
  for index = 1, length do
    ResPoolMgr:release(obj_list[index])
  end
  self:update_load_progress()
  self:debug_uesless_preload_fx(prefab_name)
end

function M:update_preload_res()
  if self.v_need_load_res_num <= 0 then
    self:update_load_progress()
    return true
  end
  local preload_state = self:check_preload_pro()
  if preload_state == PRELOAD_STATE.LOADEND then
    self:update_load_progress()
    return true
  end
  return false
end

function M:update_load_progress()
  self.v_cur_load_num = self.v_cur_load_num - 1
  self.v_cur_load_num = math.max(0, self.v_cur_load_num)
  self.v_load_suc_num = self.v_load_suc_num + 1
  if self.v_scene_mod then
    self.v_scene_mod:add_res_progress()
  end
end

function M:get_element_effect()
  if not self:need_load() then
    return
  end
  local all_element_cfg = ShareRes.create("buddy.buddy_element")
  if all_element_cfg then
    for key, cfg in pairs(all_element_cfg) do
      if not Util.is_empty(cfg.TriggerEffect) then
        self:push_effect_data(cfg.TriggerEffect)
      end
      if not Util.is_empty(cfg.DamageEffect) then
        self:push_effect_data(cfg.DamageEffect)
      end
      if Util.is_more_than_zero(cfg.AbnorMagicId) then
        self:get_magic_effect(cfg.AbnorMagicId)
      end
    end
  end
end

function M:get_role_id_to_model_map()
  local role_model_map = {}
  if DebugSetting and (not DebugSetting:is_enter_chapter() or Util.is_client_only()) then
    local role_list = DebugSetting:get_role_list()
    local character_cfg
    for _, role_id in pairs(role_list) do
      if role_id > 0 then
        character_cfg = ShareRes.get_character_cfg(role_id)
        role_model_map[role_id] = character_cfg.ModelId
      end
    end
  else
    local role_list = TowerMgr:get_battle_team_info()
    local fashion_cfg, character_cfg, model_id
    for _, buddy_data in pairs(role_list.hero_list) do
      local hero_id = buddy_data.data.id
      local fashion = buddy_data.data.fashion
      if Util.is_more_than_zero(fashion) then
        fashion_cfg = ShareRes.get_fashion_cfg(fashion)
        model_id = fashion_cfg and fashion_cfg.ModelId
        self.v_fashion_index_map[hero_id] = fashion
      end
      if not model_id then
        character_cfg = ShareRes.get_character_cfg(hero_id)
        model_id = character_cfg.ModelId
      end
      role_model_map[hero_id] = model_id
    end
  end
  return role_model_map
end

function M:get_hero_res()
  if not Util.is_client_only() then
    if not self:need_load() then
      return
    end
    if TowerMgr:check_hero_preload_res_done() then
      return
    end
    if TowerMgr then
      local tower = TowerMgr:get_tower()
      if not tower or not TowerMgr:need_check_create_hero() then
        return
      end
    end
  end
  local role_model_map = self:get_role_id_to_model_map()
  local hero_list = SceneMgr:get_hero_list()
  if not Util.is_client_only() then
    local release_all_hero_res = false
    if hero_list then
      for _, hero in pairs(hero_list) do
        if not role_model_map[hero.id] then
          release_all_hero_res = true
        end
        SceneMgr:remove_hero(hero)
      end
    end
    if release_all_hero_res then
      ResPoolMgr:clear_preload_gameobj()
    end
  end
  local character_cfg
  for role_id, model_id in pairs(role_model_map) do
    character_cfg = ShareRes.get_character_cfg(role_id)
    self:check_hero_preload(role_id, model_id)
    if character_cfg.SummonNpcIdList then
      for _, id_num in pairs(character_cfg.SummonNpcIdList) do
        local id = id_num[1]
        local num = id_num[2]
        self:check_monster_preload(id, num)
      end
    end
    self:check_hero_indicator_preload(role_id)
  end
  for key, effect_name in pairs(ONLY_PRELOAD_ONECE_EFFECT) do
    self:push_effect_data(effect_name)
  end
  if TowerMgr then
    TowerMgr:set_hero_preload_res_done(true)
  end
end

function M:push_behavior_file(behavior_file_path)
  if not Util.is_empty(behavior_file_path) and not self.v_load_behavior_file_path_map[behavior_file_path] then
    local insert_data = {
      type = PRELOAD_RES_TYPE.BEHAVIOR_FILE,
      behavior_file_path = behavior_file_path
    }
    self:push_need_load_data(insert_data)
    self.v_load_behavior_file_path_map[behavior_file_path] = true
  end
end

function M:push_config_file_file(config_file_path)
  if not Util.is_empty(config_file_path) and not self.v_load_config_file_path_map[config_file_path] then
    local insert_data = {
      type = PRELOAD_RES_TYPE.CONFIG_FILE,
      config_file_path = config_file_path
    }
    self:push_need_load_data(insert_data)
    self.v_load_config_file_path_map[config_file_path] = true
  end
end

function M:get_god_npc_effect()
  if not self:need_load() then
    return
  end
  local god_npc_id = SceneMgr:get_god_npc_id()
  if god_npc_id then
    self:check_monster_preload(god_npc_id, 1)
  end
end

function M:check_hero_indicator_preload(role_id)
  local indicator_effect_list = ShareRes.get_character_preload_indicator_list(role_id)
  if indicator_effect_list then
    for _, effect_name in pairs(indicator_effect_list) do
      local insert_count = self.v_load_effect_count_map[effect_name]
      if not Util.is_more_than_zero(insert_count) then
        self:push_effect_data(effect_name)
      end
    end
  end
end

function M:check_hero_preload(role_id, model_id)
  local character_cfg = ShareRes.get_character_cfg(role_id)
  assert(character_cfg, "角色id = " .. role_id)
  local ModelId = model_id or character_cfg.ModelId
  local model_cfg = ShareRes.create("character.character_model", ModelId)
  if not UtilTable.is_empty(character_cfg.BornMagic) then
    self:push_behavior_file(character_cfg.BornMagic[1])
  end
  PRELOAD_COMMON_FUNC.get_collider_preload(role_id)
  local extra_animator_path = model_cfg.ExtraControllerPath
  self:check_preload_extra_anim(extra_animator_path)
  local motion_path = model_cfg.MotionPath or character_cfg.ModelId
  self:push_config_file_file("character.motion." .. motion_path)
  local insert_data = {
    role_id = role_id,
    type = PRELOAD_RES_TYPE.HERO,
    prefab_name = ModelId,
    animator_res_name = model_cfg.ControllerPath,
    num = 2
  }
  self:push_need_load_data(insert_data)
  self:get_effect_data_by_id(role_id, true)
end

function M:check_monster_preload(role_id, num)
  local character_cfg = ShareRes.get_character_cfg(role_id)
  assert(character_cfg, "cfg Id = " .. role_id)
  if not UtilTable.is_empty(character_cfg.BornMagic) then
    self:push_behavior_file(character_cfg.BornMagic[1])
  end
  PRELOAD_COMMON_FUNC.get_collider_preload(role_id)
  self:add_monster_prefab_preload(character_cfg.ModelId, character_cfg.Kind, role_id, num)
  if character_cfg.ModelIdList then
    for key, model_id in pairs(character_cfg.ModelIdList) do
      if character_cfg.ModelId ~= model_id then
        self:add_monster_prefab_preload(model_id, character_cfg.Kind, role_id, num)
      end
    end
  end
  self:get_effect_data_by_id(role_id)
end

function M:add_monster_prefab_preload(model_id, kind, role_id, num)
  num = _max(num or 0, 1)
  local model_cfg = ShareRes.create("character.character_model", model_id)
  if not model_cfg then
    Log.Error("缺少character_model配置, id = " .. role_id)
  else
    local motion_path = model_cfg.MotionPath
    if motion_path then
      self:push_config_file_file("character.motion." .. motion_path)
    end
    self:_add_monster_prefab_preload(model_cfg, role_id, num, model_id, kind)
  end
end

function M:_add_monster_prefab_preload(model_cfg, role_id, num, prefab_name, kind)
  local extra_animator_path = model_cfg.ExtraControllerPath
  self:check_preload_extra_anim(extra_animator_path)
  for i = 1, num do
    local insert_data = {
      role_id = role_id,
      prefab_name = prefab_name,
      animator_res_name = model_cfg.ControllerPath
    }
    if kind == CommonDefine.NPC_KIND.ROLE then
      insert_data.type = PRELOAD_RES_TYPE.HERO
      insert_data.not_create_immediately = true
    else
      insert_data.type = PRELOAD_RES_TYPE.MONSTER
    end
    self.v_preload_res_list:push(insert_data)
  end
end

function M:check_preload_extra_anim(extra_animator_path)
  for _, animator_name in pairs(extra_animator_path) do
    if "" ~= animator_name then
      local insert_data = {
        type = PRELOAD_RES_TYPE.EXTRA_ANIM,
        animator_res_name = animator_name
      }
      self:push_need_load_data(insert_data)
    end
  end
end

function M:get_scene_effect_res(scene_effect_list)
  if not scene_effect_list then
    return
  end
  for _, res_name in pairs(scene_effect_list) do
    if res_name and "" ~= res_name then
      local insert_data = {
        type = PRELOAD_RES_TYPE.SCENE_EFFECT,
        prefab_name = res_name
      }
      self:push_need_load_data(insert_data)
    end
  end
end

function M:get_effect_data_by_id(npc_id, is_hero)
  local scene_effect_list = ShareRes.get_character_preload_scene_effect_list(npc_id)
  self:get_scene_effect_res(scene_effect_list)
  local role_effect_list = ShareRes.get_character_preload_role_effect_list(npc_id)
  if role_effect_list then
    for key, effect_name in pairs(role_effect_list) do
      local replace_effect
      local fashion = self.v_fashion_index_map[npc_id]
      if Util.is_more_than_zero(fashion) then
        replace_effect = ShareRes.get_effect_map_by_fashion_id(effect_name, fashion)
      end
      self:push_effect_data(replace_effect or effect_name, is_hero)
    end
    return
  end
  self:_get_effect_data_by_id(npc_id, is_hero)
end

function M:_get_effect_data_by_id(npc_id, is_hero)
  self:get_behavior_file_effects(npc_id, 1, is_hero)
  local skill_list = ShareRes.get_skill_list(npc_id)
  if not skill_list then
    if is_hero then
      Log.Error("单位没有配置技能列表，将导致无法预加载资源！", npc_id)
    end
    return
  end
  local skill_cfg
  for _, skill_id in pairs(skill_list) do
    local skill_frame_cfg = ShareRes.create("skill.skillkeyframe", skill_id)
    if skill_frame_cfg then
      local key_data = skill_frame_cfg.Key
      for _, frame_data in pairs(key_data) do
        if "Effect" == frame_data[2] and "0" ~= frame_data[3] then
          self:get_obj_skill_effect(frame_data, skill_id, is_hero)
        elseif "Cast" == frame_data[2] then
          self:get_obj_missile_effect(frame_data, is_hero)
        elseif "Magic" == frame_data[2] then
          self:get_obj_magic_effect(frame_data, is_hero)
        elseif "UltimateSkillMagic" == frame_data[2] then
          for _, magic_id in pairs(frame_data[3]) do
            self:get_magic_effect(magic_id, is_hero)
          end
          for _, magic_id in pairs(frame_data[4]) do
            self:get_magic_effect(magic_id, is_hero)
          end
        end
      end
    elseif UNITY_EDITOR then
      Log.Info("预加载找不到技能id: " .. skill_id)
    end
    skill_cfg = ShareRes.get_skill_cfg(skill_id)
    if skill_cfg and skill_cfg.CastMagicIds then
      for key, magic_id in pairs(skill_cfg.CastMagicIds) do
        if Util.is_more_than_zero(magic_id) then
          self:get_magic_effect(magic_id, is_hero)
        end
      end
    else
      Log.Info("预加载找不到技能配置，id :", skill_id)
    end
  end
end

function M:get_behavior_file_effects(char_id, num, is_hero)
  local character_cfg = ShareRes.get_character_cfg(char_id)
  local hit_effects = character_cfg.HitEffect
  if hit_effects then
    for _, effect_info in ipairs(hit_effects) do
      self:add_preload_effect(effect_info[1], num)
    end
  end
  if character_cfg.BornMagic then
    for key, magic_id in pairs(character_cfg.BornMagic) do
      if tonumber(magic_id) then
        self:get_magic_effect(magic_id, is_hero)
      end
    end
  end
  local dead_effects = character_cfg.DeadEffect
  if dead_effects then
    for _, effect_name in ipairs(dead_effects) do
      self:add_preload_effect(effect_name, num, is_hero)
    end
  end
end

function M:get_obj_skill_effect(frame_data, skill_id, is_hero)
  local effect_name = frame_data[3]
  if Util.is_empty(effect_name) then
    return
  end
  local res_name = frame_data[3]
  Util.assert("" ~= res_name, "预加载对象技能特效失败，", skill_id)
  local insert_data = {
    type = PRELOAD_RES_TYPE.EFFECT,
    prefab_name = res_name,
    is_hero = is_hero
  }
  self:push_need_load_data(insert_data)
end

function M:get_obj_missile_effect(frame_data, is_hero)
  local missile_id = frame_data[3]
  local missile_cfg = ShareRes.create("skill.missile", missile_id)
  if not missile_cfg then
    return
  end
  if not Util.is_empty(missile_cfg.Effect) then
    local res_name = missile_cfg.Effect
    Util.assert("" ~= res_name, "预加载子弹特效失败， 没有配置Effect字段，missile_id = ", missile_id)
    local insert_data = {
      type = PRELOAD_RES_TYPE.EFFECT,
      prefab_name = res_name,
      is_hero = is_hero
    }
    self:push_need_load_data(insert_data)
  end
  if missile_cfg.HitEffect ~= nil then
    for _, fx_name in pairs(missile_cfg.HitEffect) do
      if not Util.is_empty(fx_name) then
        local insert_data = {
          type = PRELOAD_RES_TYPE.EFFECT,
          prefab_name = fx_name,
          num = Global.render_mgr:is_low_memory_device() and LOW_MEMORY_DEVICE_HIT_EFFECT_PRELOAD_NUM or HIT_EFFECT_PRELOAD_NUM,
          is_hero = is_hero
        }
        self:push_need_load_data(insert_data)
      end
    end
  end
end

function M:get_obj_magic_effect(frame_data, is_hero)
  local magic_id = frame_data[3]
  self:get_magic_effect(magic_id, is_hero)
end

function M:get_magic_effect(magic_id, is_hero)
  local magic_cfg = ShareRes.get_magic_cfg(magic_id)
  if not magic_cfg then
    return
  end
  local effect_cfg = magic_cfg.effect
  if not effect_cfg then
    return
  end
  local effect = effect_cfg.Effect
  if Util.is_empty(effect) then
    return
  end
  self:push_effect_data(effect, is_hero)
end

function M:push_effect_data(res_name, is_hero)
  local insert_data = {
    type = PRELOAD_RES_TYPE.EFFECT,
    prefab_name = res_name,
    is_hero = is_hero
  }
  self:push_need_load_data(insert_data)
end

function M:check_continue_tower(floor_num, tower_preload_cfg)
  if not TowerMgr then
    return floor_num
  end
  if TowerMgr:check_continue_tower() and not tower_preload_cfg[floor_num] then
    local Diff_val = 999
    for _, cfg in pairs(tower_preload_cfg) do
      local floor_id = cfg.FloorId
      if floor_num > floor_id and Diff_val > floor_num - floor_id then
        floor_num = floor_id
        Diff_val = floor_num - floor_id
      end
    end
  end
  return floor_num
end

function M:get_common_role_effect_res()
  if not self:need_load() then
    return
  end
  local role_effect_res = ShareRes.get_preload_role_effect_cfg()
  for _, res in pairs(role_effect_res) do
    local load_num = res.Num or 1
    load_num = math.min(load_num, MAX_PRELOAD_FX_NUM)
    if Global.render_mgr:is_low_memory_device() then
      load_num = math.min(load_num, LOW_MEMORY_DEVICE_MAX_PRELOAD_FX_NUM)
    end
    local insert_data = {
      type = PRELOAD_RES_TYPE.EFFECT,
      prefab_name = res.Name,
      num = load_num
    }
    self:push_need_load_data(insert_data)
  end
end

function M:get_hud_res()
  if not self:need_load() then
    return
  end
  local insert_data = {
    type = PRELOAD_RES_TYPE.HUD_RES,
    prefab_name = nil
  }
  self:push_need_load_data(insert_data)
end

function M:get_drop_item()
  if not self:need_load() then
    return
  end
  local ccd = require("uimodule.stage_activity.challenge_ring_plus.curse_common_define")
  local DROP_ITEM_EFFECT_NAME = ccd.DROP_ITEM_EFFECT_NAME
  for key, effect_name in pairs(DROP_ITEM_EFFECT_NAME) do
    self:_push_need_load_data(PRELOAD_RES_TYPE.DROP_ITEM, effect_name, 1)
  end
end

function M:preload_config()
  ShareRes.create("sound.lipsync_data")
  ShareRes.create("shake.presetdata")
end

function M:get_tower_preload_cfg()
  if not self:need_load() then
    return
  end
  if not TowerMgr then
    return
  end
  local tower = TowerMgr:get_tower()
  if not tower then
    return
  end
  local tower_id = tower:get_tower_id()
  local floor_num = tower:get_floor_num()
  local all_config = ShareRes.get_tower_preload_cfg()
  local floor_preload_cfgs = all_config and all_config[tower_id]
  local floor_preload_cfg = floor_preload_cfgs and floor_preload_cfgs[floor_num]
  if not floor_preload_cfg then
    return
  end
  if floor_preload_cfg.TimeLineRes then
    for _, res_name in pairs(floor_preload_cfg.TimeLineRes) do
      if res_name and "" ~= res_name then
        local insert_data = {
          type = PRELOAD_RES_TYPE.TIMELINE,
          prefab_name = res_name
        }
        self:push_need_load_data(insert_data)
      end
    end
  end
end

function M:get_common_effect()
  if not self:need_load() then
    return
  end
  local role_effect_list, scene_effect_list = ShareRes.get_character_preload_common_effect_list()
  if role_effect_list then
    for key, effect_name in pairs(role_effect_list) do
      self:push_effect_data(effect_name)
    end
  end
  self:get_scene_effect_res(scene_effect_list)
end

function M:get_ui_effect_preload()
  if not self:need_load() then
    return
  end
  self:get_fight_ui_preload()
end

function M:get_fight_ui_preload()
  if not self:need_load() then
    return
  end
  local battle_team_info = TowerMgr and TowerMgr:get_battle_team_info()
  if not battle_team_info then
    return
  end
  local role_id, buddy_cfg
  local red_count = 0
  local recover_count = 0
  local element_count = {}
  for _, hero_data in pairs(battle_team_info.hero_list) do
    role_id = hero_data.data.id
    buddy_cfg = ShareRes.get_buddy_cfg(role_id)
    recover_count = recover_count + 1
    if buddy_cfg and buddy_cfg.ChargePointCount then
      red_count = math.max(buddy_cfg.ChargePointCount, red_count)
    end
    if buddy_cfg and buddy_cfg.Element then
      element_count[buddy_cfg.Element] = (element_count[buddy_cfg.Element] or 0) + 1
    end
  end
  local FightCfg = require("uimodule.fight.fight_config")
  for element_id, count in pairs(element_count) do
    local max_value = math.max(count, 3)
    self:_push_need_load_data(PRELOAD_RES_TYPE.UI_EFFECT, FightCfg.SKL_BTN_7_ELEMENT_EFFECT[element_id], max_value)
    self:_push_need_load_data(PRELOAD_RES_TYPE.UI_EFFECT, FightCfg.SKL_BTN_7_ELEMENT_EFFECT2[element_id], max_value)
  end
  if red_count > 0 then
    self:_push_need_load_data(PRELOAD_RES_TYPE.UI_EFFECT, "Fx_common_energy_button_redFlash", red_count)
  end
  if recover_count > 0 then
    self:_push_need_load_data(PRELOAD_RES_TYPE.UI_EFFECT, "Fx_common_energy_button_recoverFlash", recover_count)
  end
  local enable_btn_count = 0
  for _, index in pairs(Config.BTN_NAME_2_SKILL_INDEX) do
    if not Config.ABANDON_BTN_IDX[index] then
      enable_btn_count = enable_btn_count + 1
    end
  end
  if enable_btn_count > 0 then
    local min_value1 = math.min(enable_btn_count, 5)
    self:_push_need_load_data(PRELOAD_RES_TYPE.UI_EFFECT, "Fx_UI_FightSkill02", min_value1)
    self:_push_need_load_data(PRELOAD_RES_TYPE.UI_EFFECT, "Fx_UiFightSkill01", min_value1)
    local min_value2 = math.min(enable_btn_count, 2)
    self:_push_need_load_data(PRELOAD_RES_TYPE.UI_EFFECT, "Fx_UI_strengthen", min_value2)
    self:_push_need_load_data(PRELOAD_RES_TYPE.UI_EFFECT, "Fx_UI_strengthen_Show", min_value2)
  end
  for _, effect_name in pairs(FightCfg.FIGHT_UI_EFFECT) do
    self:_push_need_load_data(PRELOAD_RES_TYPE.UI_EFFECT, effect_name, 1)
  end
end

function M:preload_camera()
  if not self:need_load() then
    return
  end
  local insert_data = {
    type = PRELOAD_RES_TYPE.CAMERA
  }
  self.v_need_load_res_num = self.v_need_load_res_num + 1
  self.v_preload_res_list:push(insert_data)
end

function M:push_world_model_data(res_name, num)
  self.v_need_load_res_num = self.v_need_load_res_num + num
  self.v_preload_res_list:push({
    type = PRELOAD_RES_TYPE.WORLD_MODEL,
    prefab_name = res_name,
    num = num
  })
end

function M:get_world_model()
  if not TowerMgr then
    return
  end
  local tower = TowerMgr and TowerMgr:get_tower()
  local preload_res = tower and tower:get_preload_res()
  if not preload_res then
    return
  end
  for _, res_name in pairs(preload_res) do
    if res_name then
      self:push_world_model_data(res_name, 1)
    else
      Log.Error("找不到tower资源：", res_name)
    end
  end
  if TowerMgr and TowerMgr:get_fight_type() == CommonDefine.CHALLENGE_TYPE.CURSE_CIRCLE then
    local ccd = require("uimodule.stage_activity.challenge_ring_plus.curse_common_define")
    for _, res_name in pairs(ccd.WORLD_EFFECT_NAME) do
      if res_name then
        self:push_world_model_data(res_name, 1)
      else
        Log.Error("找不到tower资源：", res_name)
      end
    end
  end
end

function M:need_load()
  return not SceneMgr:check_main_scene()
end

function M:debug_uesless_preload_fx(prefab_name)
  if Global.debug_useless_preload_fx then
    Global.debug_preload = Global.debug_preload or {}
    Global.debug_preload[prefab_name] = 1
  end
end

function M:get_ui_main_model()
  if not SceneMgr:check_main_scene() then
    return
  end
  local board_id = PlayerMgr:get_signboard_girl_id()
  if board_id then
    self:push_preload_ui_model(board_id)
  end
  local brid_model_id = TaskMgr.bird_model_id
  local bird_board_id = TaskMgr.bird_board_id
  self:push_preload_ui_model(bird_board_id, brid_model_id)
end

function M:push_preload_ui_model(npc_id, model_id)
  local character_cfg = ShareRes.get_character_cfg(npc_id)
  model_id = model_id or character_cfg.ModelId .. "_UI"
  local model_cfg = ShareRes.create("character.character_model", model_id)
  local insert_data = {
    type = PRELOAD_RES_TYPE.UI_MAIN_MODEL,
    prefab_name = model_id,
    animator_res_name = model_cfg.ControllerPath
  }
  self.v_need_load_res_num = self.v_need_load_res_num + 1
  self.v_preload_res_list:push(insert_data)
end

function M:load_scene_effect(res_name)
  local go = ResPoolMgr:get_effect_res(res_name)
  ResPoolMgr:release(go)
  self:update_load_progress()
  self:debug_uesless_preload_fx(res_name)
end

function M:load_model(prefab_name, animator_res_name)
  if animator_res_name then
    self:load_animator(animator_res_name)
  end
  local go = ResPoolMgr:get_model(prefab_name)
  ResPoolMgr:release(go)
  self:update_load_progress()
end

function M:load_behavior_file_res(res_data)
  local behavior_file_path = res_data.behavior_file_path
  BehaviorMgr:preload_behavior_file(behavior_file_path)
  self:update_load_progress()
end

function M:load_config_file_res(res_data)
  local config_file_path = res_data.config_file_path
  ShareRes.create(config_file_path)
  self:update_load_progress()
end

function M:load_timeline_res(res_data)
  local go = ResPoolMgr:get_timeline(res_data.prefab_name)
  ResPoolMgr:release(go)
  go:SetActiveEx(false)
  Global.sound_mgr:sound_preload_timeline(res_data.res_name)
  self:update_load_progress()
end

return M
