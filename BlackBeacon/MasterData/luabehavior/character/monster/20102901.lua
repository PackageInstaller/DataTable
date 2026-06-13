local monstBase = import("character.base.monster_base")
local monster = Util.create_child_mt(monstBase)

function monster._init(monster, npc)
  monster.npc = npc
  monster.wander = {
    minDis = 0.5,
    maxDis = 4,
    minTime = 1,
    maxTime = 2,
    type = "walk"
  }
  local skills = {
    attack1 = {
      2010290101,
      5,
      1,
      0,
      3.5,
      -60,
      60
    },
    attack2 = {
      2010290102,
      7,
      1,
      0,
      3.5,
      -60,
      60
    },
    Attack360 = {
      2010290103,
      10,
      1,
      1.5,
      7,
      -60,
      60
    },
    CounterAttack1 = {
      2010290101,
      0,
      0,
      0,
      3.5,
      nil,
      nil,
      nil,
      1,
      1
    }
  }
  local nodes = {"ATK"}
  monstBase._init(monster, skills, nil, nodes)
  do
    local _ENV = monster.states
    _ENV.meleeAtk(_ENV.attack1)
    _ENV.meleeCounter(_ENV.CounterAttack1)
  end
end

function monster.go_mad(monster)
  monster.base.go_mad(monster)
  monster.states.attack1.cd = 4
  monster.states.Attack360.cd = 6
  monster.wander.maxDis = 2.5
  monster.wander.minDis = 0.5
  monster.states.attack.interval = 1
  do
    local _ENV = monster.states
    _ENV.meleeAtk(_ENV.Attack360, _ENV.attack1)
  end
end

return monster
