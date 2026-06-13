local monstBase = import("character.base.monster_base")
local monster = Util.create_child_mt(monstBase)

function monster._init(monster, npc)
  monster.npc = npc
  monster.wander = {
    minDis = 1.5,
    maxDis = 5,
    minTime = 1,
    maxTime = 2,
    type = "walk"
  }
  local skills = {
    skill01 = {
      2010280101,
      3,
      1,
      0,
      3,
      -45,
      45
    }
  }
  local nodes = {"ATK1"}
  local actMoves = {"stand"}
  monstBase._init(monster, skills, actMoves, nodes)
  monster.states.attack.interval = 1
  local states = monster.states
  local skills = monster.skills
  replace_ragdoll_power_profile(monster.npc, 0)
  do
    local _ENV = monster.states
    _ENV.freeAtk(_ENV.ATK1)
    _ENV.ATK1(_ENV.skill01)
    _ENV.wander(_ENV.stand)
  end
  do
    local stand = monster.states.stand
    
    function stand.start(stand)
      stop_move(stand.monster.npc)
    end
  end
end

function monster.on_start(monster)
  enable_part_damage(monster.npc, 1, false)
end

return monster
