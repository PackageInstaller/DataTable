local monstBase = import("character.base.monster_base")
local monster = Util.create_child_mt(monstBase)
local MISSILE_EVT_TYPE = Const.MISSILE_EVT_TYPE

function monster._init(monster, npc)
  monster.npc = npc
  monster.search = {}
  set_can_searched(monster.npc, false)
  set_can_searched(npc, false)
  set_npc_floating_text_hud_visible(npc, false)
  enable_shadow(npc, false)
  monster.hitTimes = 0
  local skills = {}
  local nodes = {}
  local actMoves = {"stand"}
  monstBase._init(monster, skills, actMoves, nodes)
  local states = monster.states
  local pos = get_npc_pos(monster.npc)
  cast_magic(npc, npc, 399001, 1)
  do
    local _ENV = monster.states
    _ENV.active(_ENV.daze, _ENV.stand)
  end
end

function monster.on_target_self_skill_hit(monster, skill_id, attacker, hit_type, missile_cfg, missile)
  if 1 == get_role_kind(attacker) then
    monster.hitTimes = monster.hitTimes + 1
    call_scene_logic_custom_event("weak")
  end
  if monster.hitTimes >= 1 then
    local facePos = get_npc_offset_position(monster.npc, nil, 0, 3)
    create_scene_effect("FX_SC05_jingcusi_1", monster.npc:get_pos_vec3(), 2, nil, facePos)
    remove_npc(monster.npc)
  end
end

function monster.on_self_npc_hp_zero(monster)
  on_not_monster_npc_dead(monster.npc)
end

return monster
