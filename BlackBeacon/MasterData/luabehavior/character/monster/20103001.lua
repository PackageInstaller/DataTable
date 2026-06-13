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
    skill01 = {
      2010300101,
      8,
      3,
      1,
      4,
      -60,
      60
    },
    skill02 = {
      2010300102,
      5,
      3,
      0,
      3,
      -45,
      45
    },
    counterSkill1 = {
      2010300101,
      0,
      0,
      0,
      11.5,
      nil,
      nil,
      nil,
      5,
      1.5
    }
  }
  monstBase._init(monster, skills)
  do
    local _ENV = monster.states
    _ENV.meleeAtk(_ENV.skill01, _ENV.skill02)
    _ENV.meleeCounter(_ENV.counterSkill1)
  end
end

function monster.go_mad(monster)
  monster.base.go_mad(monster)
  cast_magic(monster.npc, monster.npc, 500100106, 1)
  monster.states.skill01.cd = 4
  monster.states.skill02.cd = 2
  monster.wander.maxDis = 1.5
  monster.wander.minDis = 0.5
  monster.states.attack.interval = 1
end

return monster
