local monstBase = import("character.base.monster_base")
local monster = Util.create_child_mt(monstBase)
local tool = import("common.monster_tool")

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
    skill01 = {
      2010420101,
      8 + 3 * math.random(),
      2,
      0,
      3,
      -30,
      30
    },
    skill02 = {
      2010420102,
      8 + 3 * math.random(),
      4,
      0,
      4,
      -60,
      60
    },
    skill03 = {
      2010420103,
      5,
      4,
      0,
      3,
      -30,
      30
    },
    stealth = {
      2010420104,
      25,
      1 + 2 * math.random(),
      0,
      math.huge
    },
    blink = {
      2010420105,
      0,
      0,
      0,
      math.huge
    },
    blink_skill01 = {
      2010420106,
      10,
      0,
      0,
      8
    },
    blink_skill02 = {
      2010420108,
      10,
      0,
      0,
      8
    },
    blink_skill03 = {
      2010420107,
      10,
      0,
      0,
      8
    },
    counterskill02 = {
      2010420102,
      0,
      0,
      0,
      4,
      nil,
      nil,
      nil,
      0,
      2
    }
  }
  local actSkills = {}
  monstBase._init(monster, skills, actSkills)
  do
    local _ENV = monster.states
    _ENV.meleeAtk(_ENV.skill01, _ENV.skill02, _ENV.skill03)
    _ENV.meleeCounter(_ENV.counterskill02)
  end
end

function monster.go_mad(monster)
  monster.base.go_mad(monster)
  monster.states.skill01.cd = 6
  monster.states.skill02.cd = 4
  monster.states.skill03.cd = 3
  monster.wander.maxDis = 3
  monster.wander.minDis = 0.5
  monster.states.attack.interval = 1
end

return monster
