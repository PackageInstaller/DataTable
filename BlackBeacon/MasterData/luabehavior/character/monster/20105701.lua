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
    BackJump = {
      2010570101,
      17,
      0,
      0,
      6,
      -60,
      60
    },
    FarAttack = {
      2010570102,
      13,
      20,
      0,
      5,
      -60,
      60
    },
    JumpAttack = {
      2010570103,
      0,
      0,
      0,
      5,
      -90,
      90
    },
    SpinningSlash = {
      2010570104,
      14,
      0,
      0,
      5,
      -90,
      90
    },
    FarAttack_free = {
      2010570102,
      13,
      20,
      0,
      5,
      -60,
      60
    },
    JumpAttack_free = {
      2010570103,
      0,
      0,
      0,
      999,
      -90,
      90
    }
  }
  monstBase._init(monster, skills)
  do
    local _ENV = monster.states
    _ENV.meleeAtk(_ENV.SpinningSlash)
    _ENV.rangedAtk(_ENV.FarAttack(_ENV.JumpAttack))
    _ENV.freeAtk(_ENV.BackJump, _ENV.FarAttack_free(_ENV.JumpAttack_free))
  end
  do
    local idle = monster.states.idle
    
    function idle.start(idle)
      idle.base.start(idle)
      lookat_npc(monster.npc, monster.target, false)
    end
  end
end

return monster
