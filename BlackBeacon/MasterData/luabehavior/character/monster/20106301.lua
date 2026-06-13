local monstBase = import("character.base.monster_base")
local monster = Util.create_child_mt(monstBase)
local CDMAX = math.huge

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
    DoubleSlash = {
      2020630101,
      14,
      4,
      0,
      6,
      -60,
      60
    },
    SpringJump = {
      2020630106,
      12,
      8,
      0,
      4,
      -60,
      60
    },
    Downslash = {
      2020630102,
      18,
      12,
      0,
      6,
      -60,
      60
    },
    Stomp = {
      2020630105,
      24,
      6,
      0,
      6,
      -60,
      60
    },
    SpiningSlash = {
      2020630103,
      22,
      20,
      0,
      6,
      -60,
      60
    },
    DoubleCrimson = {
      2020630104,
      25,
      15,
      0,
      4,
      -60,
      60
    },
    RisingSlash = {
      2020630107,
      24,
      18,
      0,
      7,
      -60,
      60
    },
    RageMode = {
      2020630108,
      CDMAX,
      0,
      0,
      19,
      -60,
      60
    },
    StompLaunch = {
      2020630109,
      18,
      10,
      0,
      6,
      -60,
      60
    }
  }
  monstBase._init(monster, skills)
  do
    local _ENV = monster.states
    _ENV.meleeAtk(_ENV.RageMode, _ENV.StompLaunch(_ENV.RisingSlash), _ENV.DoubleSlash(_ENV.Downslash), _ENV.Stomp(_ENV.SpringJump), _ENV.SpiningSlash, _ENV.DoubleCrimson)
    _ENV.rangedAtk()
  end
  do
    local RageMode = monster.states.RageMode
    
    function RageMode.isReady(RageMode)
      local hp_max = get_npc_attr(monster.npc, 4)
      local hp_cur = get_npc_attr(monster.npc, 1)
      local hp_per = hp_cur / hp_max
      if hp_per > 0.5 then
        return false
      end
      return RageMode.base.isReady(RageMode)
    end
    
    function RageMode.start(RageMode)
      RageMode.base.start(RageMode)
      RageMode.isReady = Const.FALSE_FUN
      cast_magic(monster.npc, monster.npc, 20105501012)
      cast_magic(monster.npc, monster.npc, 20105501311)
    end
  end
  do
    local Stomp = monster.states.Stomp
    
    function Stomp.finish(Stomp)
      Stomp.base.finish(Stomp)
      monster.states.StompLaunch.timer = get_npc_time(Stomp.monster.npc) + get_npc_time(Stomp.monster.npc) + 8
      print("踩踏击飞cd额外增加8s")
      local lunchcd = monster.states.StompLaunch.timer - get_npc_time(Stomp.monster.npc)
      print(lunchcd)
    end
  end
end

return monster
