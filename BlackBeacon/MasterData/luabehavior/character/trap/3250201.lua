local monstBase = import("character.base.monster_base")
local monst = Util.create_child_mt(monstBase)

function monst._init(monster, npc)
  monster.npc = npc
  cast_magic(npc, monster.npc, 399001, 1)
  cast_magic(npc, monster.npc, 4032905, 1)
  cast_magic(npc, monster.npc, 3250203, 1)
  cast_magic(npc, monster.npc, 3250204, 1)
  local actSkills = {
    close = {325020101},
    healHitten = {325020102},
    openning = {325020103}
  }
  local nodes = {"heal"}
  local actMoves = {
    "normalHitten"
  }
  monstBase._init(monster, actSkills, actMoves, nodes)
  local states = monster.states
  local pileHp = 20
  local currentHP = pileHp
  do
    local _ENV = states
    _ENV.root(_ENV.normalHitten, _ENV.close, _ENV.heal, _ENV.openning, _ENV.decisionFailed)
    _ENV.heal(_ENV.healHitten)
  end
  states.normalHitten.quitTime = 0
  
  function states.normalHitten.start(normalHitten)
    local monster = normalHitten.monster
    abort_skill(monster.npc, true)
    stop_move(npc)
    math.randomseed(os.time())
    local elapse = math.random() * 1 + 4
    print("张开", elapse, "秒")
    normalHitten.quitTime = get_npc_time(monster.npc) + elapse
    normalHitten.base.start(normalHitten)
  end
  
  states.normalHitten.close = states.close
  
  function states.normalHitten.tickTrans(normalHitten)
    if get_npc_time(normalHitten.monster.npc) > normalHitten.quitTime then
      return normalHitten.close
    end
  end
  
  function states.close.start(close)
    local monster = close.monster
    close.base.start(close)
  end
  
  states.close.heal = states.heal
  
  function states.close.finTrans(close)
    return close.heal
  end
  
  states.heal.quitTime = 0
  
  function states.heal.start(heal)
    local monster = heal.monster
    abort_skill(monster.npc, true)
    stop_move(npc)
    math.randomseed(os.time())
    local elapse = math.random() * 2 + 3
    print("合拢", elapse, "秒")
    heal.quitTime = get_npc_time(monster.npc) + elapse
    heal.base.start(heal)
  end
  
  states.heal.openning = states.openning
  
  function states.heal.tickTrans(heal)
    if get_npc_time(heal.monster.npc) > heal.quitTime then
      return heal.openning
    else
      function states.healHitten.finTrans(healHitten)
        return states.healHitten
      end
    end
  end
  
  function states.openning.start(openning)
    local monster = openning.monster
    openning.base.start(openning)
  end
  
  states.openning.normalHitten = states.normalHitten
  
  function states.openning.finTrans(openning)
    return openning.normalHitten
  end
end

function monst.on_target_self_skill_hit(monster, skill_id, attacker, hit_type, missile_cfg, missile)
  monster.base.on_target_self_skill_hit(monster, skill_id, attacker, hit_type, missile_cfg, missile)
  if monster.state.name == "healHitten" then
    print("heal中")
    cast_magic(monster.npc, monster.npc, 3250201, 1)
  else
    cast_magic(monster.npc, monster.npc, 3250202, 1)
  end
end

return monst
