local monstBase = import("character.base.monster_base")
local monster = Util.create_child_mt(monstBase)

function monster._init(monster, npc)
  monster.npc = npc
  monster.wander = {
    minDis = -1,
    maxDis = 5,
    minTime = 1,
    maxTime = 2,
    type = "walk"
  }
  monster.born = 2010110117
  monster.dash = 0
  local skills = {
    skill01 = {
      2010110501,
      5,
      2,
      0,
      3,
      -60,
      60
    },
    skill02 = {
      2010110502,
      0,
      0,
      0,
      99
    },
    skill03 = {
      2010110503,
      0,
      0,
      0,
      99
    },
    stab1 = {
      2010110104,
      18,
      10,
      0,
      99,
      -60,
      60
    },
    stab2 = {
      2010110105,
      0,
      0,
      0,
      999
    },
    dashOut = {
      2010110106,
      7,
      0,
      0,
      5,
      -60,
      60
    },
    Rage = {
      2010110107,
      15,
      10,
      0,
      4,
      -90,
      90
    }
  }
  local nodes = {
    "ATK",
    "lunge",
    "ATK2"
  }
  local actMoves = {"Run"}
  monstBase._init(monster, skills, actMoves, nodes)
  do
    local _ENV = monster.states
    _ENV.freeAtk(_ENV.ATK, _ENV.lunge)
    _ENV.lunge(_ENV.stab1(_ENV.stab2))
    _ENV.ATK(_ENV.Run, _ENV.skill01(_ENV.skill02(_ENV.skill03)))
  end
  do
    local skill03 = monster.states.skill03
    
    function skill03.isReady(skill)
      if not skill03.base.isReady(skill03) then
        return false
      end
      local monster = skill.monster
      local tool = monster.tool
      if not tool.randByTime(monster, 0.45) then
        return false
      end
      return true
    end
  end
  monster.states.Run.timer = 2
  monster.states.Run.time = 0
  monster.states.attack.timer = 0
  do
    local active = monster.states.active
    local Run = monster.states.Run
    
    function active.start(active)
      active.monster:xRay()
    end
    
    function active.tick(active)
      active.monster.states.Run.time = get_npc_time(active.monster.npc)
    end
    
    function Run.isReady(Run)
      if monster.target and not check_npc_distance(Run.monster.npc, Run.monster.target, 3.5, false) and get_npc_time(monster.npc) > monster.skills.skill01.timer and Run.time > Run.timer then
        return true
      end
      return false
    end
    
    function Run.start(Run)
      local self = Run.monster
      Run.timer = Run.timer + 10
      switch_move_type(self.npc, 0)
      moveto_npc(self.npc, self.target)
      cast_magic(self.npc, self.npc, 201011010046, 1)
      cast_magic(self.npc, self.npc, 201011010049, 1)
      cast_magic(self.npc, self.npc, 201011010044, 1)
      cast_magic(self.npc, self.npc, 201011010047, 1)
      cast_magic(self.npc, self.npc, 201011010048, 1)
    end
    
    function Run.tick(Run)
      local self = Run.monster
      if self.target ~= nil and check_npc_distance(self.npc, self.target, 2, false) then
        abort_magic_by_id(self.npc, 201011010046, 99)
        abort_magic_by_id(self.npc, 201011010048, 99)
        abort_magic_by_id(self.npc, 201011010049, 99)
        abort_magic_by_id(self.npc, 201011010044, 99)
        abort_magic_by_id(self.npc, 201011010047, 99)
        monster.tree:transState(monster.states.skill01, true)
      end
    end
  end
end

return monster
