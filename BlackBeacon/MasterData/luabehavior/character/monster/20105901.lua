local monstBase = import("character.base.monster_base")
local monster = Util.create_child_mt(monstBase)

function monster._init(monster, npc)
  monster.npc = npc
  monster.wander = {
    minDis = 1,
    maxDis = 1,
    minTime = 0.53,
    maxTime = 0.53,
    type = "walk"
  }
  local t = monster.create_skill_node_cfg
  local actSkills = {
    HeadButt = t(2010590101, 2, 0, 0, 3, -60, 60),
    Bomb = t(2010590102)
  }
  local nodes = {"moveState"}
  local actMoves = {"stand"}
  monstBase._init(monster, actSkills, actMoves, nodes)
  do
    local _ENV = monster.states
    _ENV.meleeAtk(_ENV.HeadButt)
    _ENV.freeAtk(_ENV.Bomb)
    _ENV.wander(_ENV.moveState)
    _ENV.moveState(_ENV.forward, _ENV.stand)
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
      if forward.base.isReady(forward) then
        return forward
      end
    end
  end
  
  function monster.states.Bomb.isReady()
    return false
  end
  
  function monster.states.Bomb.start(Bomb)
    set_can_searched(Bomb.monster.npc, false)
    enable_shadow(monster.npc, false)
    time_scale_immune(monster.npc, true)
    monster:addMagics(Const.INVULNERABLE, Const.IGNORE_OTHER_COLLISION, Const.IGNORE_SELF_COLLISION)
    return Bomb.base.start(Bomb)
  end
end

function monster.on_self_npc_hp_zero(monster, attacker, magic_id, missile_id, missile)
  function monster.states.Bomb.isReady()
    return true
  end
  
  monster.transState(monster, monster.states.Bomb)
end

function monster.on_keyframe_action(monster, kfId, npcTag, comnTag)
  if 201059010205 == kfId then
    monster.tree:transState(monster.states.dead)
  end
end

return monster
