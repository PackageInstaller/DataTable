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
  set_npc_status(npc, 1, true)
  set_npc_status(npc, 2, true)
  set_npc_status(npc, 3, true)
  cast_magic(npc, npc, 30010630902, 1)
  cast_magic(npc, npc, 30010630202, 1)
  cast_magic(npc, npc, 30010630302, 1)
  local skills = {
    smoke = {300106901, 0}
  }
  local nodes = {}
  local actMoves = {"stand"}
  monstBase._init(monster, skills, actMoves, nodes)
  local states = monster.states
  cast_magic(npc, npc, 399001, 1)
  local god = get_god_npc()
  god.timer_roompass = 0
  monster.timer_remove = get_npc_time(npc) + 7.5
  monster.freezeHero = false
  monster.reborn = false
  if not check_magic(god, 3001064000) then
    cast_magic(npc, god, 3001064000, 1)
  end
  do
    local _ENV = monster.states
    _ENV.attack(_ENV.smoke)
    _ENV.active(_ENV.daze, _ENV.attack, _ENV.stand)
  end
  
  function states.born.start(born)
    born.isDone = true
  end
  
  function states.stand.start(stand)
    local npc = stand.monster.npc
    stop_move(npc)
    
    local function delay()
      remove_npc(monster.npc)
    end
    
    monster:doAfter(delay, 1)
  end
  
  function states.stand.finTrans(stand)
    return stand
  end
  
  function states.smoke.start(smoke)
    smoke.base.start(smoke)
    npc.D_hitted = false
  end
  
  function states.smoke.finish(smoke)
    smoke.base.finish(smoke)
    abort_skill(monster.npc)
  end
  
  function states.smoke.tickTrans(smoke)
    if get_npc_time(monster.npc) > monster.timer_remove then
      return smoke.monster.states.stand
    end
  end
  
  function states.smoke.finTrans(smoke)
    return smoke.monster.states.stand
  end
end

function monster.on_be_absorb(monster)
  abort_skill(monster.npc)
  cast_magic(monster.npc, monster.npc, 30010630903, 1)
  monster.tree:finTrans()
end

function monster.on_self_npc_hp_zero(monster)
end

return monster
