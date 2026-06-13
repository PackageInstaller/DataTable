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
  monster.born = 2010150103
  local skills = {
    ATK1 = {
      2010150102,
      5 + 5 * math.random(),
      2 + 6 * math.random(),
      0,
      4,
      -45,
      45
    },
    ATK2 = {
      2010150101,
      1 + 4 * math.random(),
      2 + 6 * math.random(),
      0,
      2,
      -45,
      45
    },
    counterAtk1 = {
      2010150102,
      0,
      0,
      0,
      4,
      nil,
      nil,
      nil,
      5,
      2
    }
  }
  monstBase._init(monster, skills)
  do
    local _ENV = monster.states
    _ENV.freeAtk(_ENV.ATK1, _ENV.ATK2)
    _ENV.freeCounter(_ENV.counterAtk1)
  end
end

return monster
