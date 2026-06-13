local monstBase = import("character.base.monster_base")
local monster = Util.create_child_mt(monstBase)
local hasSetFound = false

function monster._init(monster, npc)
  monster.npc = npc
  monster.search = {}
  set_can_searched(npc, false)
  local actSkills = {
    guard = {328010101},
    talk = {328010102}
  }
  local actMoves = {}
  local nodes = {"standby"}
  monstBase._init(monster, actSkills, actMoves, nodes)
  local states = monster.states
  do
    local _ENV = states
    _ENV.root(_ENV.standby, _ENV.decisionFailed)
    _ENV.standby(_ENV.guard, _ENV.talk)
  end
  
  function states.talk.start(talk)
    local monster = talk.monster
    abort_skill(monster.npc, true)
    talk.base.start(talk)
  end
  
  function states.talk.finTrans(talk)
    talk.guard = states.guard
    return talk.guard
  end
end

function monster.on_self_magic_begin(monster, target, magic_id)
  if 3000001 == magic_id then
    monster:transState(monster.states.talk)
  end
  if 3000002 == magic_id then
    hasSetFound = false
  end
  if 3000003 == magic_id then
    monster:transState(monster.states.guard)
  end
end

function monster.on_self_skill_hit(monster, skill_id, hit_target, hit_type, missile_cfg, missile)
  if 5 == get_role_kind(hit_target) and false == hasSetFound then
    hasSetFound = true
    set_sync_var("hasBeenFound", true)
  end
end

return monster
