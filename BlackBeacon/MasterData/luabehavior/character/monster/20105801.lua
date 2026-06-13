local monstBase = import("character.base.monster_base")
local monster = Util.create_child_mt(monstBase)

function monster._init(monster, npc)
  monster.npc = npc
  monster.wander = {
    minDis = 3,
    maxDis = 5,
    minTime = 1.6,
    maxTime = 1.6,
    type = "walk"
  }
  local t = monster.create_skill_node_cfg
  local actSkills = {
    HeadButt = t(2010580101, 4, 0, 0, 3, -60, 60),
    Dive = t(2010580102, 10, 0, 0, 5, -60, 60),
    Morphling = t(2010580103),
    Jump = t(2010580104)
  }
  local nodes = {"moveState"}
  local actMoves = {"stand"}
  monstBase._init(monster, actSkills, actMoves, nodes)
  do
    local _ENV = monster.states
    _ENV.meleeAtk(_ENV.HeadButt)
    _ENV.rangedAtk(_ENV.Dive(_ENV.Morphling(_ENV.Jump)))
    _ENV.wander(_ENV.moveState)
    _ENV.moveState(_ENV.forward, _ENV.backward, _ENV.stand)
  end
  do
    local moveState = monster.states.moveState
    local stand = monster.states.stand
    
    function moveState.isReady(moveState)
      return true
    end
    
    function stand.start(stand)
      stop_move(stand.monster.npc)
    end
    
    function stand.tick(stand)
      lookat_npc(monster.npc, monster.target, false)
    end
    
    function stand.tickTrans(stand)
      local forward = stand.monster.states.forward
      local backward = stand.monster.states.backward
      if forward.base.isReady(forward) then
        return forward
      end
      if backward.base.isReady(backward) then
        return backward
      end
    end
  end
  do
    local Jump = monster.states.Jump
    
    function Jump.finTrans(Jump)
      return Jump.monster.states.forward
    end
  end
end

return monster
