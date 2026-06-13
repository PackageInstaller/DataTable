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
  monster.born = 2010140103
  local skills = {
    ATK1 = {
      2010140101,
      5 + 5 * math.random(),
      2 + 5 * math.random(),
      1,
      5,
      -60,
      60
    },
    ATK2 = {
      2010140102,
      1 + 4 * math.random(),
      2 + 5 * math.random(),
      0,
      2,
      -60,
      60
    },
    counterAtk1 = {
      2010140101,
      0,
      0,
      0,
      5,
      nil,
      nil,
      nil,
      0,
      1
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
