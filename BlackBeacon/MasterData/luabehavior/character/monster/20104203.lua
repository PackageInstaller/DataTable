local monstBase = import("character.base.monster_base")
local monster = Util.create_child_mt(monstBase)
local tool = import("common.monster_tool")

function monster._init(monster, npc)
  monster.npc = npc
  monster.wander = {
    minDis = 0.5,
    maxDis = 2.5,
    minTime = 1,
    maxTime = 2,
    type = "walk"
  }
  local skills = {
    skill01 = {
      2010420201,
      5,
      2,
      0,
      3,
      -30,
      30
    },
    skill02 = {
      2010420202,
      6,
      4,
      0,
      3,
      -30,
      30
    },
    skill03 = {
      2010420203,
      8,
      4,
      0,
      3,
      -30,
      30
    },
    skill04 = {
      "skill01",
      0,
      0,
      0,
      0,
      -30,
      30
    },
    stealth = {
      2010420104,
      25,
      3 + 10 * math.random(),
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
      0,
      0,
      0,
      99
    },
    blink_skill02 = {
      2010420108,
      0,
      0,
      0,
      99
    },
    blink_skill03 = {
      2010420208,
      0,
      0,
      0,
      99
    },
    sprint = {
      2010420204,
      0,
      0,
      0,
      8
    },
    sprint_atk1 = {
      2010420207,
      0,
      0,
      0,
      99
    },
    sprint_atk2 = {
      2010420206,
      0,
      0,
      0,
      99
    },
    sprint_atk3 = {
      2010420205,
      0,
      0,
      0,
      99
    }
  }
  local nodes = {
    "ATK",
    "Blink_ATK",
    "Sprint_Atk",
    "Blink",
    "Invisible_Atk",
    "Invisible_Atk"
  }
  local actMoves = {"Jump"}
  monstBase._init(monster, skills, actMoves, nodes)
  monster.InvisibleTimer = 0
  monster.Blink_switch = true
  monster.maxDisbackup = monster.wander.maxDis
  do
    local _ENV = monster.states
    _ENV.freeAtk(_ENV.stealth, _ENV.Sprint_Atk)
    _ENV.meleeAtk(_ENV.ATK)
    _ENV.Sprint_Atk(_ENV.sprint(_ENV.sprint_atk1(_ENV.sprint_atk2(_ENV.sprint_atk3))))
    _ENV.ATK(_ENV.skill03, _ENV.skill02(_ENV.skill04), _ENV.skill01)
  end
  do
    local stealth = monster.states.stealth
    
    function stealth.isReady(stealth)
      if check_magic(stealth.monster.npc, 20104201048) then
        return false
      end
      if not stealth.base.isReady(stealth) then
        return false
      end
      return true
    end
    
    function stealth.start(stealth)
      monster.InvisibleRandom = 1 + 2 * math.random()
      stealth.base.start(stealth)
    end
  end
  do
    local ATK = monster.states.ATK
    local skill03 = monster.states.skill03
    
    function ATK.isReady()
      if not check_magic(monster.npc, 20104201048) then
        return true
      end
    end
  end
  do
    local faint = monster.states.faint
    
    function faint.start(faint)
      abort_magic_by_id(faint.monster.npc, 20104201048, 99)
      monster.states.stealth.timer = get_npc_time(monster.npc) + monster.states.stealth.cd
    end
  end
  do
    local Sprint_Atk = monster.states.Sprint_Atk
    local sprint_atk1 = monster.states.sprint_atk1
    local sprint_atk2 = monster.states.sprint_atk2
    local sprint_atk3 = monster.states.sprint_atk3
    local sprint = monster.states.sprint
    
    function Sprint_Atk.isReady()
      if check_magic(monster.npc, 20104201048) then
        return Sprint_Atk.base.isReady(Sprint_Atk)
      end
    end
    
    function sprint.start(sprint)
      local self = sprint.monster
      local target_pos = get_npc_pos(self.target)
      local randompoint = math.random(0, 90)
      self.teletportposx = target_pos.x + 9 * math.cos(randompoint)
      self.teletportposz = target_pos.z + 9 * math.sin(randompoint)
      flash_to_pos(self.npc, self.teletportposx, self.teletportposz)
      sprint.base.start(sprint)
    end
    
    function sprint_atk2.start(sprint_atk2)
      local self = sprint_atk2.monster
      local target_pos = get_npc_pos(self.target)
      local randompoint = math.random(180, 270)
      self.teletportposx = target_pos.x + 2 * math.cos(randompoint)
      self.teletportposz = target_pos.z + 2 * math.sin(randompoint)
      flash_to_pos(self.npc, self.teletportposx, self.teletportposz)
      lookat_npc(monster.npc, monster.target, true)
      sprint_atk2.base.start(sprint_atk2)
    end
    
    function sprint_atk3.start(sprint_atk3)
      local self = sprint_atk3.monster
      local target_pos = get_npc_pos(self.target)
      local randompoint = math.random(270, 360)
      self.teletportposx = target_pos.x + 3 * math.cos(randompoint)
      self.teletportposz = target_pos.z + 3 * math.sin(randompoint)
      flash_to_pos(self.npc, self.teletportposx, self.teletportposz)
      lookat_npc(monster.npc, monster.target, true)
      sprint_atk3.base.start(sprint_atk3)
    end
  end
end

function monster.on_self_magic_begin(monster, target, magic_id)
  if 20104201048 == magic_id then
    set_npc_hp_visible(monster.npc, false)
    enable_shadow(monster.npc, false)
    if not check_magic(monster.npc, Const.LOCK_MASK) then
      cast_magic(monster.npc, monster.npc, Const.LOCK_MASK, 1)
    end
  end
end

function monster.on_self_magic_end(monster, target, magic_id)
  if 20104201048 == magic_id then
    abort_magic_by_id(monster.npc, Const.LOCK_MASK, 99)
    set_npc_hp_visible(monster.npc, true)
    enable_shadow(monster.npc, true)
  end
end

function monster.go_mad(monster)
  cast_magic(monster.npc, monster.npc, 500100101, 1)
  cast_magic(monster.npc, monster.npc, 500100102, 1)
  cast_magic(monster.npc, monster.npc, 500100111, 1)
  monster.states.attack.interval = 1
  monster.states.stealth.cd = 8
end

return monster
