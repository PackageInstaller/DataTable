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
  local skills = {
    charge = {
      300201202,
      3,
      3,
      0,
      5
    }
  }
  local actMoves = {"trace"}
  local nodes = {}
  monstBase._init(monster, skills, actMoves, nodes)
  do
    local _ENV = monster.states
    _ENV.wander(_ENV.trace)
    _ENV.freeAtk(_ENV.charge)
  end
  do
    local states = monster.states
    states.trace.timer = get_npc_time(monster.npc)
    
    function states.trace.start(trace)
      lookat_npc(monster.npc, monster.target, false)
      moveto_npc(monster.npc, monster.target)
      switch_move_type(monster.npc, 1)
    end
    
    function states.trace.tickTrans(trace)
      return trace.monster.states.attack
    end
  end
end

return monster
