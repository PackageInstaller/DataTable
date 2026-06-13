local BehaviorMgr = require("manager.fight.behaviormgr")
local _min = math.min
local _insert = table.insert
local Fifo = require("manager.res.res_fifo")
local PRELOAD_COMMON_FUNC = require("gamemode.preload_common_func")
local MAX_PRELOAD_UNIT_NUM = 6
local LOW_MEMORY_DEVICE_MAX_PRELOAD_UNIT_NUM = 4
local LOAD_FRAME_INTERVAL = 2
local SAME_LOAD_NUM = 6
local MAX_PRELOAD_FX_NUM = 6
local LOW_MEMORY_DEVICE_MAX_PRELOAD_FX_NUM = 4
local PRELOAD_RES_TYPE = {
  MODEL = 1,
  EFFECT = 2,
  TIMELINE = 3,
  FUNCTIONAL_NPC = 4,
  EXTRA_ANIM = 5,
  SPINE = 6,
  SCENE_EFFECT = 7,
  UI_HP_RES = 9,
  UI_EFFECT = 10,
  BEHAVIOR_FILE = 11,
  CONFIG_FILE = 12,
  COLLIDER = 16
}
local PRELOAD_STATE = {LOADING = 1, LOADEND = 2}
local BIG_HP_BAR_LIMIT = 3
local UI_HP_BAR_LIMIT = 8
local EFFECT_MAX_PRELOAD_NUM = 5
local M = Util.create_class()
M.PRELOAD_RES_TYPE = PRELOAD_RES_TYPE

function M:_init(preload_cfg, callback, is_new_floor)
  self.v_preload_res_list = Fifo:new()
  self.v_need_load_res_num = 0
  self.v_cur_load_num = 0
  self.v_load_suc_num = 0
  self.v_room_preload = false
  self.v_is_new_floor = is_new_floor
  self.v_preload_cfg = preload_cfg
  self.v_last_load_frame = Global.frame_id
  self.v_push_big_hp_bar_count = 0
  self.v_push_ui_hp_max_count = 0
  self.v_load_behavior_file_path_map = {}
  self.v_load_config_file_path_map = {}
  self.v_load_effect_count_map = {}
  self.v_hero_preload_effects = {}
  self.v_role_hit_effect_count_map = {}
  self.v_role_hit_effect_map = {}
  self.v_fashion_index_map = {}
  PRELOAD_COMMON_FUNC.set_common_param(self, PRELOAD_RES_TYPE)
  self:set_callback(callback)
  self:init_preload()
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

function M:set_callback(cb)
  self.v_callback = cb
end

function M:init_preload()
  if not self.v_preload_cfg then
    return
  end
  local cfg = self.v_preload_cfg
  self.v_preload_effects = {}
  self:get_hero_res(cfg.stand_by_pos_list)
  self:get_timeline_res(cfg.timeline)
  self:get_story_res(cfg.story_id_list)
  self:get_monster_res(cfg.monster)
  self:get_monster_res(cfg.machine)
  self:get_functional_npc_res(cfg.functional_npc)
  self:get_treasure_chest_res(cfg.treasure_chest)
  self:get_config_file(cfg.monster_group, "unit.MonsterGroup.")
  self:get_config_file(cfg.machine_group, "unit.MachineGroup.")
  self:get_ui_hp_preload()
  self:push_all_need_load_effects_data()
end

function M:get_treasure_chest_res(id_to_num_tb)
  if not id_to_num_tb then
    return
  end
  local model_id_to_num = {}
  for treasure_chest_id, num in pairs(id_to_num_tb) do
    local treasure_chest_cfg = ShareRes.create("episode_box.episode_box", treasure_chest_id)
    if not treasure_chest_cfg then
      Log.Error("功能性NPC表找不到Id为", treasure_chest_id, "的配置！", debug.traceback())
      return
    end
    local model_id = treasure_chest_cfg.ModelId
    local model_cfg = ShareRes.create("character.character_model", model_id)
    if not model_cfg then
      Log.Error("模型表找不到Id为", model_id, "的模型配置！", debug.traceback())
      return
    end
    if not model_id_to_num[model_id] then
      model_id_to_num[model_id] = 0
    end
    model_id_to_num[model_id] = model_id_to_num[model_id] + num
    if treasure_chest_cfg.Effect then
      for key, effect_name in pairs(treasure_chest_cfg.Effect) do
        if not Util.is_empty(effect_name) then
          self:add_preload_effect(effect_name, num)
        end
      end
    end
  end
  for model_id, num in pairs(model_id_to_num) do
    self:add_model_preload(model_id, num)
  end
end

function M:get_functional_npc_res(id_to_num_tb)
  if not id_to_num_tb then
    return
  end
  local model_id_to_num = {}
  for functional_npc_id, num in pairs(id_to_num_tb) do
    local functional_npc_cfg = ShareRes.create("npc.functional_npc", functional_npc_id)
    if not functional_npc_cfg then
      Log.Error("功能性NPC表找不到Id为", functional_npc_id, "的配置！", debug.traceback())
      return
    end
    local model_id = functional_npc_cfg.ModelId
    local model_cfg = ShareRes.create("character.character_model", model_id)
    if not model_cfg then
      Log.Error("模型表找不到Id为", model_id, "的模型配置！", debug.traceback())
      return
    end
    if not model_id_to_num[model_id] then
      model_id_to_num[model_id] = 0
    end
    model_id_to_num[model_id] = model_id_to_num[model_id] + num
    if functional_npc_cfg.Effect then
      for key, effect_name in pairs(functional_npc_cfg.Effect) do
        if not Util.is_empty(effect_name) then
          self:add_preload_effect(effect_name, num)
        end
      end
    end
  end
  for model_id, num in pairs(model_id_to_num) do
    self:add_model_preload(model_id, num)
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

function M:push_config_file(config_file_path)
  if not Util.is_empty(config_file_path) and not self.v_load_config_file_path_map[config_file_path] then
    local insert_data = {
      type = PRELOAD_RES_TYPE.CONFIG_FILE,
      config_file_path = config_file_path
    }
    self:push_need_load_data(insert_data)
    self.v_load_config_file_path_map[config_file_path] = true
  end
end

function M:get_hero_res(stand_by_pos_list)
  local role_model_map = {}
  local all_role_model_map = {}
  local preload_res_done = TowerMgr:check_hero_preload_res_done()
  local team_info = TowerMgr:get_battle_team_info()
  if team_info then
    local fashion_cfg, model_id, character_cfg
    for _, buddy_data in pairs(team_info.hero_list) do
      local role_id = buddy_data.data.id
      local fashion = buddy_data.data.fashion
      if Util.is_more_than_zero(fashion) then
        fashion_cfg = ShareRes.get_fashion_cfg(fashion)
        model_id = fashion_cfg and fashion_cfg.ModelId
        self.v_fashion_index_map[role_id] = fashion
      end
      if not model_id then
        character_cfg = ShareRes.get_character_cfg(role_id)
        model_id = character_cfg.ModelId
      end
      if not preload_res_done then
        role_model_map[role_id] = model_id
      end
      all_role_model_map[role_id] = model_id
    end
  end
  TowerMgr:set_hero_preload_res_done(true)
  if self.v_is_new_floor then
    self:get_point_team_res(stand_by_pos_list, all_role_model_map)
  end
  if not preload_res_done then
    local hero_list = SceneMgr:get_hero_list()
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
  for role_id, model_id in pairs(all_role_model_map) do
    if role_model_map then
      local character_cfg = ShareRes.get_character_cfg(role_id)
      if not character_cfg then
        Log.Error("找不到Id为", role_id, "的角色配置！", debug.traceback())
      else
        if character_cfg.SummonNpcIdList then
          for _, id_num in pairs(character_cfg.SummonNpcIdList) do
            local summon_id = id_num[1]
            local summon_num = id_num[2] or 1
            self:check_role_preload(summon_id, summon_num)
          end
        end
        self:check_role_preload(role_id, 1, model_id, true)
        local hit_effect_list = ShareRes.get_character_preload_hit_effect_list(role_id)
        if hit_effect_list then
          for _, effect_name in pairs(hit_effect_list) do
            self.v_role_hit_effect_map[effect_name] = true
          end
        end
      end
    end
  end
end

function M:get_point_team_res(stand_by_pos_list, role_model_map)
  if not TowerMgr or not stand_by_pos_list then
    return
  end
  local tower = TowerMgr:get_tower()
  if not tower then
    return
  end
  local point_id = TowerMgr:get_cur_point_id()
  if not point_id then
    return
  end
  local floor_num = tower:get_floor_num()
  local chapter_team_cfg = ShareRes.get_chapter_team_cfg(point_id, floor_num)
  if not chapter_team_cfg then
    return
  end
  local stand_by_id_list = chapter_team_cfg.StandbyId
  if stand_by_id_list then
    for _, pos in pairs(stand_by_pos_list) do
      local fixed_id = stand_by_id_list[pos]
      if Util.is_more_than_zero(fixed_id) then
        local fixed_buddy_cfg = ShareRes.get_fixed_buddy_config(fixed_id)
        local role_id = fixed_buddy_cfg and fixed_buddy_cfg.BuddyId
        if Util.is_more_than_zero(role_id) then
          local fashion = fixed_buddy_cfg.FashionId
          local model_id
          if Util.is_more_than_zero(fashion) then
            local fashion_cfg = ShareRes.get_fashion_cfg(fashion)
            model_id = fashion_cfg and fashion_cfg.ModelId
            self.v_fashion_index_map[role_id] = fashion
          end
          if not model_id then
            local character_cfg = ShareRes.get_character_cfg(role_id)
            model_id = character_cfg.ModelId
          end
          role_model_map[role_id] = model_id
        end
      end
    end
  end
end

function M:get_monster_res(id_to_num_tb)
  if not id_to_num_tb then
    return
  end
  for id, num in pairs(id_to_num_tb) do
    self:check_role_preload(id, num)
    local character_cfg = ShareRes.get_character_cfg(id)
    if character_cfg.SummonNpcIdList then
      for _, id_num in pairs(character_cfg.SummonNpcIdList) do
        local summon_id = id_num[1]
        local summon_num = id_num[2] or 1
        self:check_role_preload(summon_id, summon_num)
      end
    end
  end
end

function M:check_role_preload(role_id, num, use_model_id, is_hero)
  local character_cfg = ShareRes.get_character_cfg(role_id)
  if not character_cfg then
    Log.Error("找不到Id为", role_id, "的角色配置！", debug.traceback())
    return
  end
  PRELOAD_COMMON_FUNC.get_collider_preload(role_id)
  local ModelId = use_model_id or character_cfg.ModelId
  if not UtilTable.is_empty(character_cfg.BornMagic) then
    self:push_behavior_file(character_cfg.BornMagic[1])
  end
  self:add_model_preload(ModelId, num, character_cfg.ModelId)
  if character_cfg.ModelIdList then
    for _, model_id in pairs(character_cfg.ModelIdList) do
      if character_cfg.ModelId ~= model_id then
        self:add_model_preload(model_id, num, character_cfg.ModelId)
      end
    end
  end
  self:get_effect_data_by_model_id(FashionMgr:get_fashion_model_id(role_id), num, is_hero)
  self:get_effect_data_by_id(role_id, num, is_hero)
  self:check_role_ui_effect(role_id, num)
  self:get_role_hit_effect(role_id, num)
end

function M:get_role_hit_effect(role_id, num)
  local character_cfg = ShareRes.get_character_cfg(role_id)
  if not character_cfg or character_cfg.Kind == Config.CommonDefine.NPC_KIND.ROLE or character_cfg.Kind == Config.CommonDefine.NPC_KIND.SUMMON_MONSTER then
    return
  end
  local effect_map = self.v_role_hit_effect_map
  for effect_name in pairs(effect_map) do
    local pushed_count = self.v_role_hit_effect_count_map[effect_name] or 0
    local load_count = math.min(num, MAX_PRELOAD_UNIT_NUM - pushed_count)
    if Global.render_mgr:is_low_memory_device() then
      load_count = math.min(load_count, LOW_MEMORY_DEVICE_MAX_PRELOAD_FX_NUM)
    end
    if pushed_count < MAX_PRELOAD_UNIT_NUM then
      self:add_preload_effect(effect_name, load_count, true)
    end
    self.v_role_hit_effect_count_map[effect_name] = pushed_count + load_count
  end
end

function M:check_role_ui_effect(role_id, num)
  self._push_ui_effect_data_count = 0
  local character_cfg = ShareRes.get_character_cfg(role_id)
  if not character_cfg or character_cfg.Kind == Config.CommonDefine.NPC_KIND.ROLE then
    return
  end
  local hp_type = character_cfg.ShowSmallHpType
  local show_ui_hp, show_elite_bar, show_big_bar = Util.check_show_hp_bar_type(hp_type)
  local need_load_ui_hp = show_ui_hp
  local need_load_big_hp_bar = show_elite_bar or show_big_bar
  if need_load_ui_hp or need_load_big_hp_bar then
    self:_push_ui_effect_data("Fx_UI_Common_HP_1", num)
  end
  if need_load_big_hp_bar and self.v_push_big_hp_bar_count < BIG_HP_BAR_LIMIT then
    self.v_push_big_hp_bar_count = self.v_push_big_hp_bar_count + 1
    num = math.min(num, BIG_HP_BAR_LIMIT)
    self:get_element_ui_effect(role_id, num, false)
    self:_push_ui_effect_data("Fx_Common_LifeTem", num)
    self:_push_ui_effect_data("FX_UI_toughness_Star", num)
    if show_elite_bar then
      self:_push_ui_effect_data("Fx_UI_Bloodbreak_Elite", num)
    end
    if show_big_bar then
      self:_push_ui_effect_data("Fx_UI_Bloodbreak_Boss", num)
      self:_push_ui_effect_data("Fx_UI_DoubleEnemyBlood1", num)
    end
  end
  if need_load_ui_hp then
    self.v_push_ui_hp_max_count = math.min(self.v_push_ui_hp_max_count + num, UI_HP_BAR_LIMIT)
  end
end

function M:get_ui_hp_preload()
  local num = self.v_push_ui_hp_max_count
  self:get_element_ui_effect(num, true)
  local insert_data = {
    num = self.v_push_ui_hp_max_count,
    type = PRELOAD_RES_TYPE.UI_HP_RES
  }
  self:push_need_load_data(insert_data)
end

function M:get_element_ui_effect(num, is_low)
  local FightDefine = Config.FightDefine
  local FightConfig = require("uimodule.fight.fight_config")
  for element_id, open_state in pairs(FightDefine.ABNORMAL_DEFAULT_STATUS) do
    if open_state ~= FightDefine.ABNORMAL_STATUS.CLOSE then
      if is_low then
        self:_push_ui_effect_data(FightConfig.ELEMENT_ICON_EFFECT_LOW[element_id], num)
      else
        self:_push_ui_effect_data(FightConfig.ELEMENT_ICON_EFFECT[element_id], num)
      end
    end
  end
end

function M:_push_spine_data(prefab_name, num)
  num = num or 1
  local insert_data = {
    type = PRELOAD_RES_TYPE.SPINE,
    prefab_name = prefab_name,
    num = num
  }
  self:push_need_load_data(insert_data)
end

function M:_push_time_line_data(prefab_name, num)
  num = num or 1
  local insert_data = {
    type = PRELOAD_RES_TYPE.TIMELINE,
    prefab_name = prefab_name,
    num = num
  }
  self:push_need_load_data(insert_data)
end

function M:_push_ui_effect_data(prefab_name, num)
  local insert_data = {
    num = num,
    type = PRELOAD_RES_TYPE.UI_EFFECT,
    prefab_name = prefab_name
  }
  self:push_need_load_data(insert_data)
end

function M:get_behavior_file_effects(char_id, num, is_hero)
  local character_cfg = ShareRes.get_character_cfg(char_id)
  local hit_effects = character_cfg.HitEffect
  if hit_effects then
    for _, effect_info in ipairs(hit_effects) do
      self:add_preload_effect(effect_info[1], num, is_hero)
    end
  end
  if character_cfg.BornMagic then
    for key, magic_id in pairs(character_cfg.BornMagic) do
      if tonumber(magic_id) then
        self:get_magic_effect(magic_id, 1, is_hero)
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

function M:get_config_file(group_list, path)
  if not group_list then
    return
  end
  for id, group_id in pairs(group_list) do
    self:push_config_file(path .. group_id)
  end
end

function M:add_model_preload(model_id, num, default_model_id)
  num = _min(num or 0, MAX_PRELOAD_UNIT_NUM)
  if Global.render_mgr:is_low_memory_device() then
    num = math.min(num, LOW_MEMORY_DEVICE_MAX_PRELOAD_UNIT_NUM)
  end
  local model_cfg = ShareRes.create("character.character_model", model_id)
  local motion_path = model_cfg.MotionPath or default_model_id
  if motion_path then
    self:push_config_file("character.motion." .. motion_path)
  end
  if not model_cfg then
    Log.Error("缺少character_model配置, id = " .. model_id)
  else
    self:_add_monster_prefab_preload(model_cfg, num, model_id)
  end
end

function M:_add_monster_prefab_preload(model_cfg, num, prefab_name)
  self:check_preload_extra_anim(model_cfg.ExtraControllerPath)
  local insert_data = {
    prefab_name = prefab_name,
    animator_res_name = model_cfg.ControllerPath,
    type = PRELOAD_RES_TYPE.MODEL,
    num = num
  }
  self:push_need_load_data(insert_data)
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

function M:get_effect_data_by_model_id(model_id, num, is_hero)
  local extra_preload_data = ShareRes.get_character_model_extra_preload_effect_list(model_id)
  if extra_preload_data then
    for key, effect_name in pairs(extra_preload_data) do
      self:add_preload_effect(effect_name, num, is_hero)
    end
  end
end

function M:get_effect_data_by_id(npc_id, num, is_hero)
  local scene_effect_list = ShareRes.get_character_preload_scene_effect_list(npc_id)
  self:get_scene_effect_res(scene_effect_list)
  local role_effect_list = ShareRes.get_character_preload_role_effect_list(npc_id)
  if role_effect_list then
    for _, effect_name in pairs(role_effect_list) do
      local replace_effect
      local fashion = self.v_fashion_index_map[npc_id]
      if Util.is_more_than_zero(fashion) then
        replace_effect = ShareRes.get_effect_map_by_fashion_id(effect_name, fashion)
      end
      self:add_preload_effect(replace_effect or effect_name, num, is_hero)
    end
    return
  end
  self:_get_effect_data_by_id(npc_id, num, is_hero)
end

function M:_get_effect_data_by_id(npc_id, num, is_hero)
  self:get_behavior_file_effects(npc_id, num, is_hero)
  local skill_list = ShareRes.get_skill_list(npc_id)
  if not skill_list then
    local character_mgr_cfg = ShareRes.create("character.character_mgr", npc_id)
    local org_npc_id = character_mgr_cfg and character_mgr_cfg.OriginalNpcId
    if org_npc_id then
      skill_list = ShareRes.get_skill_list(org_npc_id)
      if not skill_list then
        Log.Error("技能列表找不到单位id为", org_npc_id, "的配置！将无法预加载其特效")
        return
      end
    else
      Log.Error("技能列表找不到单位id为", npc_id, "的配置！将无法预加载其特效")
      return
    end
  end
  local skill_cfg
  for _, skill_id in pairs(skill_list) do
    local skill_frame_cfg = ShareRes.create("skill.skillkeyframe", skill_id)
    if skill_frame_cfg then
      local key_data = skill_frame_cfg.Key
      for _, frame_data in pairs(key_data) do
        if "Effect" == frame_data[2] and "0" ~= frame_data[3] then
          self:get_obj_skill_effect(frame_data, skill_id, num, is_hero)
        elseif "Cast" == frame_data[2] then
          self:get_obj_missile_effect(frame_data, num, is_hero)
        elseif "Magic" == frame_data[2] then
          self:get_obj_magic_effect(frame_data, num, is_hero)
        end
      end
    elseif UNITY_EDITOR then
      Log.Info("预加载技能特效失败！技能帧事件中找不到技能id: ", skill_id)
    end
    skill_cfg = ShareRes.get_skill_cfg(skill_id)
    if skill_cfg and skill_cfg.CastMagicIds then
      for key, magic_id in pairs(skill_cfg.CastMagicIds) do
        if Util.is_more_than_zero(magic_id) then
          self:get_magic_effect(magic_id, num, is_hero)
        end
      end
    else
      Log.Info("no find skill cfg ,id :", skill_id)
    end
  end
end

function M:get_obj_skill_effect(frame_data, skill_id, num, is_hero)
  local effect_name = frame_data[3]
  if Util.is_empty(effect_name) then
    return
  end
  Util.assert("" ~= effect_name, "预加载对象技能特效失败，", skill_id)
  self:add_preload_effect(effect_name, num, is_hero)
end

function M:get_obj_missile_effect(frame_data, num, is_hero)
  local missile_id = frame_data[3]
  local missile_cfg = ShareRes.create("skill.missile", missile_id)
  if not missile_cfg then
    return
  end
  local effect_name = missile_cfg.Effect
  if not Util.is_empty(effect_name) then
    Util.assert("" ~= effect_name, "预加载子弹特效失败， 没有配置Effect字段，missile_id = ", missile_id)
    self:add_preload_effect(effect_name, num, is_hero)
  end
  if missile_cfg.HitEffect ~= nil then
    for _, name in pairs(missile_cfg.HitEffect) do
      if not Util.is_empty(name) then
        self:add_preload_effect(name, num, is_hero)
      end
    end
  end
end

function M:get_obj_magic_effect(frame_data, num, is_hero)
  local magic_id = frame_data[3]
  self:get_magic_effect(magic_id, num, is_hero)
end

function M:get_magic_effect(magic_id, num, is_hero)
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
  self:add_preload_effect(effect, num, is_hero)
end

function M:call_back()
  if self.v_callback then
    self.v_callback()
    self.v_callback = nil
  end
end

function M:update_preload_res()
  if self.v_room_preload then
    self:call_back()
    return true
  end
  if self.v_need_load_res_num <= 0 then
    self:update_load_progress()
    self.v_room_preload = true
    self:call_back()
    return true
  end
  local preload_state = self:check_preload_pro()
  if preload_state == PRELOAD_STATE.LOADEND then
    self:update_load_progress()
    self.v_room_preload = true
    self:call_back()
    return true
  end
  return false
end

function M:update_load_progress()
  self.v_cur_load_num = self.v_cur_load_num - 1
  self.v_cur_load_num = math.max(0, self.v_cur_load_num)
  self.v_load_suc_num = self.v_load_suc_num + 1
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

function M:load_res(res_data)
  local type = res_data.type
  local animator_res_name = res_data.animator_res_name
  local prefab_name = res_data.prefab_name
  local num = res_data.num
  self.v_cur_load_num = self.v_cur_load_num + 1
  if type == PRELOAD_RES_TYPE.MODEL then
    if prefab_name then
      self:load_model(prefab_name, animator_res_name, num)
    end
  elseif type == PRELOAD_RES_TYPE.EXTRA_ANIM then
    local animator_info = ResPoolMgr:get_animator(animator_res_name)
    ResPoolMgr:release_res(animator_info)
    self:update_load_progress()
  elseif type == PRELOAD_RES_TYPE.EFFECT then
    self:load_effect(prefab_name, num)
  elseif type == PRELOAD_RES_TYPE.TIMELINE then
    self:load_timeline_res(prefab_name)
  elseif type == PRELOAD_RES_TYPE.SPINE then
    self:load_spine_res(prefab_name)
  elseif type == PRELOAD_RES_TYPE.SCENE_EFFECT then
    self:load_scene_effect(prefab_name)
  elseif type == PRELOAD_RES_TYPE.UI_HP_RES then
    self:load_ui_hp(res_data)
  elseif type == PRELOAD_RES_TYPE.UI_EFFECT then
    self:load_ui_effect(res_data)
  elseif type == PRELOAD_RES_TYPE.BEHAVIOR_FILE then
    self:load_behavior_file_res(res_data)
  elseif type == PRELOAD_RES_TYPE.CONFIG_FILE then
    self:load_config_file_res(res_data)
  elseif type == PRELOAD_RES_TYPE.COLLIDER then
    PRELOAD_COMMON_FUNC.load_collider(res_data)
  end
end

function M:load_model(res_name, animator_res_name, num)
  local animator_info_tb = {}
  local model_tb = {}
  for i = 1, num do
    if animator_res_name then
      local animator_info = ResPoolMgr:get_animator(animator_res_name)
      _insert(animator_info_tb, animator_info)
    end
    local go = ResPoolMgr:get_model(res_name)
    _insert(model_tb, go)
  end
  for _, info in ipairs(animator_info_tb) do
    ResPoolMgr:release_res(info)
  end
  for _, go in ipairs(model_tb) do
    ResPoolMgr:release(go)
  end
  self:update_load_progress()
end

function M:load_effect(res_name, num)
  local tmp_table = {}
  for i = 1, num do
    local go = ResPoolMgr:get_effect_res(res_name)
    _insert(tmp_table, go)
  end
  for i = 1, num do
    ResPoolMgr:release(tmp_table[i])
  end
  self:update_load_progress()
  self:debug_uesless_preload_fx(res_name)
end

function M:load_timeline_res(res_name)
  local go = ResPoolMgr:get_timeline(res_name)
  ResPoolMgr:release(go)
  go:SetActiveEx(false)
  Global.sound_mgr:sound_preload_timeline(res_name)
  self:update_load_progress()
end

function M:load_spine_res(res_name)
  local go = ResPoolMgr:get_spine(res_name)
  ResPoolMgr:release(go)
  self:update_load_progress()
end

function M:load_scene_effect(res_name)
  local go = ResPoolMgr:get_effect_res(res_name)
  ResPoolMgr:release(go)
  self:update_load_progress()
  self:debug_uesless_preload_fx(res_name)
end

function M:get_load_progress()
  return self.v_need_load_res_num, self.v_load_suc_num
end

local function mask_the_story_res(flag_list, res_name)
  local not_mask = nil == flag_list[res_name]
  if not_mask then
    flag_list[res_name] = true
  end
  return not_mask
end

function M:get_story_res(story_id_list)
  if not story_id_list then
    return
  end
  local temp = "story_preload."
  local story_preload_cfg
  local flag_list = {}
  local path
  for _, story_id in pairs(story_id_list) do
    path = temp .. story_id
    if ShareRes.is_exist_config(path) then
      story_preload_cfg = ShareRes.create(path)
      local time_line_res = story_preload_cfg.TimelineRes
      if not Util.is_empty(time_line_res) and mask_the_story_res(flag_list, time_line_res) then
        self:_push_time_line_data(time_line_res)
      end
      if story_preload_cfg.EffectResources then
        for _, effect_name in pairs(story_preload_cfg.EffectResources) do
          if not Util.is_empty(effect_name) and mask_the_story_res(flag_list, effect_name) then
            self:_push_ui_effect_data(effect_name, 1)
          end
        end
      end
      if story_preload_cfg.RoleImgResources then
        for _, spine_name in pairs(story_preload_cfg.RoleImgResources) do
          if not Util.is_empty(spine_name) and mask_the_story_res(flag_list, spine_name) then
            self:_push_spine_data(spine_name)
          end
        end
      end
    end
  end
end

function M:get_timeline_res(timeline_names_tb)
  if not timeline_names_tb then
    return
  end
  for _, res_name in pairs(timeline_names_tb) do
    if res_name and "" ~= res_name then
      self:_push_time_line_data(res_name)
    end
  end
end

function M:get_spine_res(idx_to_res_name_tb)
  if not idx_to_res_name_tb then
    return
  end
  for _, res_name in pairs(idx_to_res_name_tb) do
    if res_name and "" ~= res_name then
      local insert_data = {
        type = PRELOAD_RES_TYPE.SPINE,
        prefab_name = res_name
      }
      self:push_need_load_data(insert_data)
    end
  end
end

function M:debug_uesless_preload_fx(prefab_name)
  if Global.debug_useless_preload_fx then
    Global.debug_preload = Global.debug_preload or {}
    Global.debug_preload[prefab_name] = 1
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

function M:add_preload_effect(res_name, num, is_hero)
  local effect_list = is_hero and self.v_hero_preload_effects or self.v_preload_effects
  local recored_num = effect_list[res_name] or 0
  effect_list[res_name] = recored_num + num
end

function M:push_all_need_load_effects_data()
  local max_preload_fx_num = MAX_PRELOAD_FX_NUM
  if Global.render_mgr:is_low_memory_device() then
    max_preload_fx_num = LOW_MEMORY_DEVICE_MAX_PRELOAD_FX_NUM
  end
  for res_name, num in pairs(self.v_preload_effects) do
    local insert_data = {
      type = PRELOAD_RES_TYPE.EFFECT,
      prefab_name = res_name,
      num = _min(max_preload_fx_num, num)
    }
    self:push_need_load_data(insert_data)
  end
  for res_name, num in pairs(self.v_hero_preload_effects) do
    local insert_data = {
      type = PRELOAD_RES_TYPE.EFFECT,
      prefab_name = res_name,
      num = _min(max_preload_fx_num, num),
      is_hero = true
    }
    self:push_need_load_data(insert_data)
  end
end

function M:load_ui_hp(res_data)
  local role_count = res_data.num
  local ui_hp_count = role_count
  local ui_dynamic_canvas = UIMgr:get_ui("uidynamic_canvas", true)
  local ui_hp_map = {}
  local ui_hp
  for index = 1, ui_hp_count do
    ui_hp = ui_dynamic_canvas:get_hp_item()
    ui_hp:preload()
    ui_hp_map[index] = ui_hp
  end
  for index = 1, ui_hp_count do
    if ui_hp_map[index] and index <= ui_hp_count then
      ui_dynamic_canvas:release_hp_item(ui_hp_map[index])
    end
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

return M
