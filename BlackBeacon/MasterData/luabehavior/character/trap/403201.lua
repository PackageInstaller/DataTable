local monstBase = import("character.base.monster_base")
local monster = Util.create_child_mt(monstBase)

function monster._init(monster, npc)
  monster.npc = npc
  monster.search = {}
  set_can_searched(npc, false)
  enable_shadow(npc, false)
  set_npc_status(npc, 1, true)
  set_npc_status(npc, 2, true)
  local skills = {
    boom_expend = {40320101, 0},
    boom = {40320102, 0}
  }
  monstBase._init(monster, skills)
  local states = monster.states
  cast_magic(npc, npc, 399001, 1)
  do
    local _ENV = monster.states
    _ENV.root(_ENV.boom_expend)
    _ENV.boom_expend(_ENV.boom)
  end
  
  function states.boom_expend.start(boom_expend)
    cast_magic(monster.npc, monster.npc, 399933, 1)
    boom_expend.base.start(boom_expend)
  end
  
  function states.boom.isReady()
    return true
  end
end

function monster.before_damage_target(monster, target, magic_id, damage_sign, damage_type, target_camp, change_level, magic_level, skill_id, missile)
  if 1 == get_role_kind(target) then
    cast_magic(monster.npc, target, 40104409, 1)
  end
end

function monster.on_self_npc_hp_zero(monster)
end

function monster.after_damage_self(monster, caster, magic_id, damage_sign, damage_type, is_crit, damage_val, base_dmg, element_dmg, skill_id, missile)
end

return monster
