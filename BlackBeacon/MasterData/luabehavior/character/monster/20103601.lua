local monstBase = import("character.base.monster_base")
local monster = Util.create_child_mt(monstBase)

function monster._init(monster, npc)
  monster.npc = npc
  monster.wander = {
    minDis = 1.5,
    maxDis = 4,
    minTime = 1,
    maxTime = 2,
    type = "walk"
  }
  local skills = {
    skill01 = {
      2010360102,
      5,
      3,
      0,
      3,
      -60,
      60
    },
    skill02 = {
      2010360101,
      15,
      3,
      0,
      10,
      -90,
      90
    },
    CounterSkill01 = {
      2010360102,
      0,
      0,
      0,
      2,
      nil,
      nil,
      nil,
      1,
      1
    }
  }
  local actMoves = {"Blink"}
  monstBase._init(monster, skills, actMoves, nil)
  do
    local _ENV = monster.states
    _ENV.rangedAtk(_ENV.skill02)
    _ENV.meleeAtk(_ENV.skill01)
    _ENV.meleeCounter(_ENV.CounterSkill01)
  end
end

function monster.go_mad(monster)
  monster.base.go_mad(monster)
  monster.states.skill02.cd = 4
  monster.states.skill01.cd = 2
  monster.wander.maxDis = 3
  monster.wander.minDis = 0.5
  monster.states.attack.interval = 1
  
  function monster.states.skill01.moveScale()
    return 1.2
  end
end

return monster
