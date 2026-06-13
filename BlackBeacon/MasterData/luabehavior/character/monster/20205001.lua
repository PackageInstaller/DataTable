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
    punch = {
      2020500101,
      5,
      1 + 5 * math.random(),
      0,
      3,
      -90,
      90
    },
    smash = {
      2020500102,
      8,
      0,
      0,
      4,
      -90,
      90
    },
    Rage = {
      2020500103,
      24,
      5,
      0,
      5,
      -90,
      90
    },
    stab_start = {
      2020500104,
      15,
      3 + 8 * math.random(),
      1,
      6,
      -90,
      90
    },
    stab_loop = {
      2020500105,
      0,
      0,
      0,
      99
    },
    stab_end = {
      2020500106,
      0,
      0,
      0,
      99
    }
  }
  local nodes = {}
  local actMoves = {}
  monstBase._init(monster, skills, actMoves, nodes)
  do
    local _ENV = monster.states
    _ENV.meleeAtk(_ENV.punch(_ENV.smash))
    _ENV.rangedAtk(_ENV.stab_start(_ENV.stab_loop(_ENV.stab_end)))
  end
  do
    local faint = monster.states.faint
    local stab_end = monster.states.stab_end
    
    function faint.start(faint)
      cast_magic(monster.npc, monster.npc, 201050010110, 1)
    end
    
    function stab_end.finTrans(stab_end)
      return monster.states.wander
    end
    
    function monster.states.idle.finish(idle)
      idle.monster.search.minDis = 8
      idle.monster.search.maxDis = 99
    end
  end
end

function monster.on_born_behavior(monster)
  monster.base.on_born_behavior(monster)
  if get_sync_var("qian_dark") == true then
    monster.search.minDis = 4
    monster.search.maxDis = 4
  end
end

return monster
