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
    skill02 = {
      2010350202,
      0,
      3,
      1,
      6,
      -45,
      45
    },
    counterskill02 = {
      2010350202,
      0,
      0,
      0,
      4,
      nil,
      nil,
      nil
    }
  }
  monstBase._init(monster, skills)
  do
    local _ENV = monster.states
    _ENV.freeAtk(_ENV.skill02)
    _ENV.meleeCounter(_ENV.counterskill02)
  end
  do
    local root = monster.states.root
    
    function root.start(root)
      local self = root.monster
      set_npc_controller(self.npc, 1)
      cast_magic(self.npc, self.npc, 20103502011, 0)
    end
  end
end

return monster
