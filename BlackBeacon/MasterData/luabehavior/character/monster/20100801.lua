local monstBase = import("character.base.monster_base")
local monster = Util.create_child_mt(monstBase)

function monster._init(monster, npc)
  monster.npc = npc
  monster.wander = {
    minDis = 0,
    maxDis = 5,
    minTime = 1,
    maxTime = 2,
    type = "walk"
  }
  monster.born = 2010080101
  local skills = {
    skill01 = {
      2010080102,
      2,
      0,
      0,
      5,
      nil,
      nil,
      -4
    }
  }
  local nodes = {}
  local actMoves = {
    "Stand",
    "MoveToTarget"
  }
  monstBase._init(monster, skills, actMoves, nodes)
  do
    local _ENV = monster.states
    _ENV.freeAtk(_ENV.skill01)
    _ENV.wander(_ENV.MoveToTarget, _ENV.Stand)
  end
  do
    local Stand = monster.states.Stand
    local MoveToTarget = monster.states.MoveToTarget
    
    function MoveToTarget.isReady(MoveToTarget)
      if check_npc_distance(monster.npc, monster.target, 5, true) then
        return false
      end
      return true
    end
    
    function MoveToTarget.start(MoveToTarget)
      switch_move_type(MoveToTarget.monster.npc, 1)
      moveto_npc(MoveToTarget.monster.npc, MoveToTarget.monster.target)
    end
    
    function MoveToTarget.tickTrans(MoveToTarget)
      if check_npc_distance(monster.npc, monster.target, 3.5, true) then
        return monster.states.Stand
      end
    end
    
    function Stand.isReady(Stand)
      return true
    end
    
    function Stand.start(Stand)
      stop_move(Stand.monster.npc)
    end
    
    function Stand.tickTrans(Stand)
      local MoveToTarget = Stand.monster.states.MoveToTarget
      if MoveToTarget.isReady(MoveToTarget) then
        return MoveToTarget
      end
    end
  end
end

return monster
