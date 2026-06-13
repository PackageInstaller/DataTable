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
  set_can_searched(npc, false)
  enable_shadow(npc, false)
  local skills = {
    atk = {300100101, 0},
    check = {300100102, 0}
  }
  monstBase._init(monster, skills)
  cast_magic(npc, npc, 399001, 1)
  do
    local _ENV = monster.states
    _ENV.attack(_ENV.check, _ENV.atk)
    _ENV.wander(_ENV.wanderStand)
    _ENV.active(_ENV.daze, _ENV.attack, _ENV.wander)
  end
  local states = monster.states
  
  function states.standIdle.isReady()
    return true
  end
  
  states.standIdle.time = 2
  states.wander.tick = nil
  
  function states.standIdle.finTrans()
    return standIdle.monster.states.standIdle
  end
  
  function states.wander.tickTrans(wander)
    local monster = wander.monster
    local states = monster.states
    if states.attack then
      return tree:chooseChildAction(states.attack)
    end
  end
  
  function states.attack.isReady()
    return true
  end
  
  function states.attack.finTrans(attack)
    return attack.monster.states.check
  end
  
  function monster.states.standIdle.tickTrans()
    return
  end
end

function monster.on_room_pass(monster, room_id)
  if not get_sync_var("trap_switch_on") then
    abort_skill(monster.npc)
    remove_missile_by_id(30010010201, monster.npc, false)
    
    function monster.states.wander.tickTrans()
      return
    end
    
    monster.tree:transState(monster.states.standIdle, true)
  end
end

function monster.on_self_skill_hit(monster, skill_id, hit_target, hit_type, missile_cfg, missile)
  if 300100102 == skill_id then
    monster.tree:transState(monster.states.atk, true)
  end
end

return monster
