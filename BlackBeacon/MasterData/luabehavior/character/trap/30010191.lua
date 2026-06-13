local monstBase = import("character.base.monster_base")
local monster = Util.create_child_mt(monstBase)

function monster._init(monster, npc)
  monster.npc = npc
  monster.wander = {
    minDis = 0.5,
    maxDis = 3,
    minTime = 1,
    maxTime = 2,
    type = "walk"
  }
  monster.search = {}
  set_can_searched(npc, false)
  enable_shadow(npc, false)
  set_npc_floating_text_hud_visible(npc, false)
  local skills = {}
  local nodes = {}
  local actMoves = {"dark", "light"}
  monstBase._init(monster, skills, actMoves, nodes)
  local states = monster.states
  cast_magic(npc, npc, 399001, 1)
  do
    local _ENV = monster.states
    _ENV.active(_ENV.daze, _ENV.dark, _ENV.light)
  end
  
  function states.dark.start(dark)
    cast_magic(monster.npc, monster.npc, 399933)
  end
  
  function states.light.start(light)
    if get_npc_id(monster.npc) == 30010191 then
      cast_magic(monster.npc, monster.npc, 3001019001)
    end
    if get_npc_id(monster.npc) == 30010192 then
      cast_magic(monster.npc, monster.npc, 3001019002)
    end
    if get_npc_id(monster.npc) == 30010193 then
      cast_magic(monster.npc, monster.npc, 3001019003)
    end
    if get_npc_id(monster.npc) == 30010194 then
      cast_magic(monster.npc, monster.npc, 3001019004)
    end
    if get_npc_id(monster.npc) == 30010195 then
      cast_magic(monster.npc, monster.npc, 3001019005)
    end
    abort_magic_by_id(monster.npc, 399000, 1)
    abort_magic_by_id(monster.npc, 399933, 1)
  end
end

function monster.on_target_self_skill_hit(monster, skill_id, attacker, hit_type, missile_cfg, missile)
  if missile_cfg.Id == 30010700301 and monster.state.name == "dark" then
    change_npc_prefab(monster.npc, 1, true)
    monster:transState(monster.states.light)
  end
  if missile_cfg.Id == 30010630301 and monster.state.name == "dark" then
    local facePos = get_npc_offset_position(monster.npc, nil, 0, 3)
    if get_npc_id(monster.npc) == 30010191 then
      create_scene_effect("FX_SC05_jingcusi_1", monster.npc:get_pos_vec3(), 2, nil, facePos)
    end
    if get_npc_id(monster.npc) == 30010192 then
      create_scene_effect("FX_SC05_jingcusi_2", monster.npc:get_pos_vec3(), 2, nil, facePos)
    end
    if get_npc_id(monster.npc) == 30010193 then
      create_scene_effect("FX_SC05_jingcusi_3", monster.npc:get_pos_vec3(), 2, nil, facePos)
    end
    if get_npc_id(monster.npc) == 30010194 then
      create_scene_effect("FX_SC05_jingcusi_4", monster.npc:get_pos_vec3(), 2, nil, facePos)
    end
    if get_npc_id(monster.npc) == 30010195 then
      create_scene_effect("FX_SC05_jingcusi_5", monster.npc:get_pos_vec3(), 2, nil, facePos)
    end
    set_npc_dead(monster.npc, nil, true)
    remove_npc(monster.npc)
  end
  if monster.state.name == "light" and 0 ~= hit_type then
    local facePos = get_npc_offset_position(monster.npc, nil, 0, 3)
    if get_npc_id(monster.npc) == 30010191 then
      create_scene_effect("FX_SC05_jingcusi_1", monster.npc:get_pos_vec3(), 2, nil, facePos)
    end
    if get_npc_id(monster.npc) == 30010192 then
      create_scene_effect("FX_SC05_jingcusi_2", monster.npc:get_pos_vec3(), 2, nil, facePos)
    end
    if get_npc_id(monster.npc) == 30010193 then
      create_scene_effect("FX_SC05_jingcusi_3", monster.npc:get_pos_vec3(), 2, nil, facePos)
    end
    if get_npc_id(monster.npc) == 30010194 then
      create_scene_effect("FX_SC05_jingcusi_4", monster.npc:get_pos_vec3(), 2, nil, facePos)
    end
    if get_npc_id(monster.npc) == 30010195 then
      create_scene_effect("FX_SC05_jingcusi_5", monster.npc:get_pos_vec3(), 2, nil, facePos)
    end
    set_npc_dead(monster.npc, nil, true)
    remove_npc(monster.npc)
  end
end

function monster.on_self_npc_hp_zero(monster)
end

function monster.after_damage_self(monster, caster, magic_id, damage_sign, damage_type, is_crit, damage_val, base_dmg, element_dmg, skill_id, missile)
end

return monster
