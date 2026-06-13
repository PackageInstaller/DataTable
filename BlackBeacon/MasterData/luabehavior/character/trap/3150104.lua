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
    laser1 = {315010401, 0},
    laser2 = {315010402, 0},
    broken1 = {315010102, 0},
    broken2 = {315010102, 0},
    broken_forever = {315010103, 0}
  }
  monstBase._init(monster, skills)
  local states = monster.states
  cast_magic(npc, npc, 399001, 0)
  abort_magic_by_id(monster.npc, 399933)
  cast_magic(npc, npc, 4032905, 1)
  monster.laser_time = 2
  monster.broken_time = 5
  monster.currentCD = get_npc_time(npc) + monster.laser_time
  do
    local _ENV = monster.states
    _ENV.attack(_ENV.laser1, _ENV.laser2, _ENV.broken1, _ENV.broken2)
    _ENV.active(_ENV.daze, _ENV.attack, _ENV.broken_forever, _ENV.wander)
    _ENV.wander(_ENV.wanderStand(_ENV.standIdle))
  end
  
  function states.broken1.isReady()
    return false
  end
  
  function states.broken1.start(broken1)
    monster.refreshTime = get_npc_time(npc) + monster.broken_time
    monster.currentCD = monster.currentCD + monster.broken_time
    cast_magic(monster.npc, monster.npc, 399933, 1)
    broken1.base.start(broken1)
  end
  
  function states.broken1.tickTrans(broken1)
    if get_npc_time(npc) > monster.refreshTime then
      return broken1.monster.states.laser1
    end
  end
  
  function states.broken1.finTrans(broken1)
    return broken1.monster.states.laser1
  end
  
  function states.broken2.isReady()
    return false
  end
  
  function states.broken2.start(broken2)
    monster:setTarget()
    monster.refreshTime = get_npc_time(npc) + monster.broken_time
    monster.currentCD = monster.currentCD + monster.broken_time
    cast_magic(monster.npc, monster.npc, 399933, 1)
    broken2.base.start(broken2)
  end
  
  function states.broken2.tickTrans(broken2)
    if get_npc_time(npc) > monster.refreshTime then
      return broken2.monster.states.laser2
    end
  end
  
  function states.broken2.finTrans(broken2)
    return broken2.monster.states.laser2
  end
  
  function states.broken_forever.isReady()
    return false
  end
  
  function states.broken_forever.start(broken_forever)
    cast_magic(monster.npc, monster.npc, 399933, 1)
    broken_forever.base.start(broken_forever)
  end
  
  function states.broken_forever.finTrans(broken_forever)
    return broken_forever
  end
  
  function states.laser1.isReady()
    return true
  end
  
  function states.laser1.tickTrans(laser1)
    if get_npc_time(npc) > monster.currentCD then
      monster.currentCD = get_npc_time(npc) + monster.laser_time
      return laser1.monster.states.laser2
    end
  end
  
  function states.laser1.finish(laser1)
  end
  
  function states.laser1.finTrans(laser1)
    return laser1.monster.states.laser1
  end
  
  function states.laser2.isReady()
    return true
  end
  
  function states.laser2.tickTrans(laser2)
    if get_npc_time(npc) > monster.currentCD then
      monster.currentCD = get_npc_time(npc) + monster.laser_time
      return laser2.monster.states.laser1
    end
  end
  
  function states.laser2.finish(laser2)
  end
  
  function states.laser2.finTrans(laser2)
    return laser2.monster.states.laser2
  end
end

function monster.on_target_self_skill_hit(monster, skill_id, attacker, hit_type, missile_cfg, missile)
  if 0 ~= hit_type and is_cast_skill_time(monster.npc, 315010401, true) then
    abort_skill(monster.npc)
    
    function monster.states.broken1.isReady()
      return true
    end
    
    monster.tree:transState(monster.states.broken1, true)
  elseif 0 ~= hit_type and is_cast_skill_time(monster.npc, 315010402, true) then
    abort_skill(monster.npc)
    
    function monster.states.broken2.isReady()
      return true
    end
    
    monster.tree:transState(monster.states.broken2, true)
  end
end

function monster.on_room_pass(monster, room_id)
  abort_skill(monster.npc)
  monster.tree:transState(monster.states.broken_forever, true)
  
  function monster.states.wander.tickTrans()
    return
  end
end

return monster
