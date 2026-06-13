local monstBase = import("character.base.monster_base")
local monster = Util.create_child_mt(monstBase)

function monster._init(monster, npc)
  monster.npc = npc
  monster.wander = {
    minDis = 0.5,
    maxDis = 1,
    minTime = 0.5,
    maxTime = 2,
    type = "walk"
  }
  local skills = {
    Split = {
      2010510102,
      2,
      1,
      0,
      1.5
    }
  }
  local nodes = {}
  local actMoves = {"Stand"}
  monstBase._init(monster, skills, actMoves, nodes)
  do
    local _ENV = monster.states
    _ENV.freeAtk(_ENV.Split)
    _ENV.wander(_ENV.forward, _ENV.Stand)
  end
  do
    local Stand = monster.states.Stand
    
    function Stand.start(Stand)
      stop_move(Stand.monster.npc)
    end
    
    function Stand.tickTrans(Stand)
      if get_npc_distance(monster.npc, 1, monster.target, true) > monster.wander.maxDis then
        return monster.states.wander
      end
    end
  end
end

function monster.on_target_self_skill_hit(monster, skill_id, caster, hit_type, missile_cfg, missile)
  monster.base.on_target_self_skill_hit(monster, skill_id, caster, hit_type, missile_cfg, missile)
  if 300106301 == skill_id then
    cast_magic(monster.npc, monster.npc, 201051010207, 1)
  end
end

return monster
