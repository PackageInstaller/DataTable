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
  local counter_move = {
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    3,
    3,
    3,
    3,
    3
  }
  local skills = {
    skill01 = {
      2010410101,
      5,
      3,
      0,
      3,
      -60,
      60
    },
    skill02 = {
      2010410102,
      8,
      3,
      1,
      6,
      -45,
      45
    },
    power_star = {
      2010410103,
      20,
      8,
      0,
      10
    },
    power_loop = {
      2010410104,
      0,
      0,
      0,
      20
    },
    power_end = {
      2010410105,
      0,
      0,
      0,
      20
    },
    counterskill01 = {
      2010410101,
      0,
      0,
      0,
      4,
      nil,
      nil,
      nil,
      5,
      counter_move
    }
  }
  local nodes = {"Power_Up"}
  monstBase._init(monster, skills, nil, nodes)
  monster.buff = {}
  do
    local _ENV = monster.states
    _ENV.freeAtk(_ENV.Power_Up)
    _ENV.meleeAtk(_ENV.skill01, _ENV.skill02)
    _ENV.Power_Up(_ENV.power_star(_ENV.power_loop(_ENV.power_end)))
    _ENV.meleeCounter(_ENV.counterskill01)
  end
  do
    local Power_Up = monster.states.Power_Up
    local power_end = monster.states.power_end
    local power_star = monster.states.power_star
    local power_loop = monster.states.power_loop
    
    function Power_Up.isReady(Power_Up)
      local self = Power_Up.monster
      if _G.next(self.buff) == nil then
        return false
      end
      if not check_magic(self.npc, 20104101002) and power_star.base.isReady(power_star) then
        return true
      end
    end
    
    function power_loop.start(power_loop)
      cast_magic(power_loop.monster.npc, power_loop.monster.npc, 20104101099, 1)
      power_loop.base.start(power_loop)
    end
    
    function power_end.start(power_end)
      local self = power_end.monster
      cast_magic(self.npc, self.npc, 20104101001, 1)
      cast_magic(self.npc, self.npc, 20104101002, 1)
      local list_monster = self.buff
      for _, value in pairs(list_monster) do
        cast_magic(self.npc, value, 20104101001, 1)
        cast_magic(self.npc, value, 20104101002, 1)
      end
      power_end.base.start(power_end)
    end
  end
  do
    local hit = monster.states.hit
    
    function hit.start(hit)
      abort_magic_by_id(hit.monster.npc, 20104101099, 99)
      hit.base.start(hit)
    end
  end
  
  function monster.states.gotTarget.tick(gotTarget)
    local self = gotTarget.monster
    self.buff = search_npc(self.npc, 2, 7, nil, false, true, 20103701, 2)
  end
end

return monster
