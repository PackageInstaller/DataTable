local monstBase = import("character.base.monster_base")
local monster = Util.create_child_mt(monstBase)

function monster._init(monster, npc)
  print("zhuziInit")
  monster.npc = npc
  monster.wander = {
    minDis = 2,
    maxDis = 10,
    minTime = 1.2,
    maxTime = 2,
    type = "walk"
  }
  monster.search = {minDis = 2000, maxDis = 2000}
  monster.phase = 1
  monster.bornpointX, monster.bornpointY, monster.bornpointZ = get_area_pos("bornpoint")
  monster.bornpoint = {
    x = monster.bornpointX,
    y = monster.bornpointY,
    z = monster.bornpointZ
  }
  monster.thecopyingMissile = nil
  monster.missile_copying = false
  local t = monster.create_skill_node_cfg
  local actSkills = {
    sommon_resonance_energy = t(2010640201, 0, 0, 0, 999)
  }
  local nodes = {"Other"}
  monstBase._init(monster, actSkills, nil, nodes)
  local states = monster.states
  local skills = monster.skills
  do
    local _ENV = monster.states
    _ENV.wander(_ENV.wanderStand)
    _ENV.gotTarget(_ENV.attack, _ENV.wander)
    _ENV.attack(_ENV.freeAtk)
    _ENV.freeAtk(_ENV.Other(_ENV.sommon_resonance_energy))
  end
  
  function states.attack.isReady(attack)
    return false
  end
  
  function states.standIdle.isReady(standIdle)
    return true
  end
  
  states.standIdle.time = 2
  states.wander.tick = nil
  
  function states.standIdle.finTrans(standIdle)
    return standIdle.monster.states.standIdle
  end
  
  function states.Other.isReady(Other)
    return false
  end
end

function monster.on_start(monster)
  monster.base.on_start(monster)
  set_camera(2010480102, false)
end

function monster.on_target_self_magic_begin(monster, npc, magic_id, magic_level, magic_kind, magic_type)
  monster.base.on_target_self_magic_begin(monster, npc, magic_id, magic_level, magic_kind, magic_type)
  if 2010640103 == magic_id then
    monster.tree:transState(monster.states.sommon_resonance_energy, true)
    print("柱子状态强制切换：共鸣")
    abort_magic_by_id(monster.npc, 2010640103)
  end
  if 2010640108 == magic_id then
    print("Killing")
    monster.transState(monster, monster.states.dead, true)
  end
end

return monster
