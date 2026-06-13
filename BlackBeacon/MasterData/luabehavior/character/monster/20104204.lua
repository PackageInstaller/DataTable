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
      15,
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
    },
    Invisible_skill01 = {
      2010420106,
      0,
      0,
      0,
      2
    },
    Invisible_skill02 = {
      2010420108,
      0,
      0,
      0,
      2
    },
    Invisible_skill03 = {
      2010420208,
      0,
      0,
      0,
      2
    },
    Invisible_skill04 = {
      2010420106,
      0,
      0,
      0,
      2
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
  monster.Invisible_atk = 0
  monster.Invisible_blk = 0
  monster.InvisibleRandom = 0
  monster.Blink_switch = true
  monster.maxDisbackup = monster.wander.maxDis
  do
    local _ENV = monster.states
    _ENV.freeAtk(_ENV.stealth, _ENV.Blink_ATK, _ENV.Sprint_Atk)
    _ENV.meleeAtk(_ENV.Invisible_Atk, _ENV.ATK)
    _ENV.Sprint_Atk(_ENV.sprint(_ENV.sprint_atk1(_ENV.sprint_atk2(_ENV.sprint_atk3))))
    _ENV.Invisible_Atk(_ENV.Invisible_skill03, _ENV.Invisible_skill02(_ENV.Invisible_skill04), _ENV.Invisible_skill01)
    _ENV.Blink_ATK(_ENV.blink_skill01, _ENV.blink_skill02, _ENV.blink_skill03)
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
      monster.Invisible_atk = 0
      stealth.base.start(stealth)
    end
  end
  do
    local Invisible_Atk = monster.states.Invisible_Atk
    local Blink_ATK = monster.states.Blink_ATK
    local ATK = monster.states.ATK
    local skill03 = monster.states.skill03
    
    function ATK.isReady()
      if not check_magic(monster.npc, 20104201048) then
        return true
      end
    end
    
    function Blink_ATK.isReady()
      return false
    end
    
    function Blink_ATK.start(Blink_ATK)
      monster.Blink_switch = false
      monster.Invisible_atk = monster.Invisible_atk + 1
    end
    
    function Blink_ATK.fintrans()
      return monster.states.wander
    end
    
    function Invisible_Atk.isReady()
      return false
    end
    
    function Invisible_Atk.start(Invisible_Atk)
      monster.Invisible_atk = monster.Invisible_atk + 1
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
      return false
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
  do
    local Invisible_skill01 = monster.states.Invisible_skill01
    local Invisible_skill02 = monster.states.Invisible_skill02
    local Invisible_skill03 = monster.states.Invisible_skill03
    
    local function randomBaseCheck(actSkill, possibility)
      return tool.randByTime(actSkill.monster, possibility) and actSkill.base.isReady(actSkill)
    end
    
    function Invisible_skill03.isReady(actSkill)
      return randomBaseCheck(actSkill, 0.1)
    end
    
    function Invisible_skill02.isReady(actSkill)
      return randomBaseCheck(actSkill, 0.4)
    end
  end
  do
    local blink_skill01 = monster.states.blink_skill01
    local blink_skill02 = monster.states.blink_skill02
    local blink_skill03 = monster.states.blink_skill03
    
    local function randomBaseCheck(actSkill, possibility)
      return tool.randByTime(actSkill.monster, possibility) and actSkill.base.isReady(actSkill)
    end
    
    function blink_skill01.isReady(actSkill)
      return randomBaseCheck(actSkill, 0.5)
    end
    
    function blink_skill02.isReady(actSkill)
      return randomBaseCheck(actSkill, 0.4)
    end
    
    function blink_skill01.start(blink_skill01)
      local self = blink_skill01.monster
      local target_pos = get_npc_pos(self.target)
      local randompoint = math.random(0, 120)
      self.teletportposx = target_pos.x + 2 * math.cos(randompoint)
      self.teletportposz = target_pos.z + 2 * math.sin(randompoint)
      flash_to_pos(self.npc, self.teletportposx, self.teletportposz)
      lookat_npc(monster.npc, monster.target, true)
      blink_skill01.base.start(blink_skill01)
    end
    
    function blink_skill02.start(blink_skill02)
      local self = blink_skill02.monster
      local target_pos = get_npc_pos(self.target)
      local randompoint = math.random(120, 240)
      self.teletportposx = target_pos.x + 2 * math.cos(randompoint)
      self.teletportposz = target_pos.z + 2 * math.sin(randompoint)
      flash_to_pos(self.npc, self.teletportposx, self.teletportposz)
      lookat_npc(monster.npc, monster.target, true)
      blink_skill02.base.start(blink_skill02)
    end
    
    function blink_skill03.start(blink_skill03)
      local self = blink_skill03.monster
      local target_pos = get_npc_pos(self.target)
      local randompoint = math.random(240, 360)
      self.teletportposx = target_pos.x + 2 * math.cos(randompoint)
      self.teletportposz = target_pos.z + 2 * math.sin(randompoint)
      flash_to_pos(self.npc, self.teletportposx, self.teletportposz)
      lookat_npc(monster.npc, monster.target, true)
      blink_skill03.base.start(blink_skill03)
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
    
    local function blink1()
      monster.Blink_switch = true
      if check_magic(monster.npc, 20104201048) and monster.states.wander:isRunning() then
        if monster.Invisible_atk < monster.InvisibleRandom then
          function monster.states.Invisible_Atk.isReady()
            return true
          end
        else
          function monster.states.Invisible_Atk.isReady()
            return false
          end
          
          monster:transState(monster.states.Sprint_Atk, true)
        end
        monster.wander.maxDis = 6
        local self = monster
        local target_pos = get_npc_pos(get_come_on_hero())
        local randompoint = math.random(0, 360)
        self.teletportposx = target_pos.x + math.random(5, 10) * math.cos(randompoint)
        self.teletportposz = target_pos.z + math.random(5, 10) * math.sin(randompoint)
        flash_to_pos(self.npc, self.teletportposx, self.teletportposz)
      end
    end
    
    local function blink2()
      if monster.Blink_switch == false then
        return
      end
      
      function monster.states.Invisible_Atk.isReady()
        return false
      end
      
      if check_magic(monster.npc, 20104201048) and monster.states.wander:isRunning() then
        if monster.Invisible_atk < monster.InvisibleRandom then
          monster:transState(monster.states.Blink_ATK, true)
        else
          monster:transState(monster.states.Sprint_Atk, true)
        end
      end
    end
    
    monster:doAfter(blink1, 2.2)
    monster:doAfter(blink2, 6.7)
  end
end

function monster.on_self_magic_end(monster, target, magic_id)
  if 20104201048 == magic_id then
    abort_magic_by_id(monster.npc, Const.LOCK_MASK, 99)
    set_npc_hp_visible(monster.npc, true)
    enable_shadow(monster.npc, true)
  end
end

function monster.on_self_skill_end(monster, skill_id, is_time_out, is_break, behavior_abort)
  monster.base.on_self_skill_end(monster, skill_id, is_time_out, is_break, behavior_abort)
  if 2010420107 == skill_id then
    monster.states.stealth.timer = get_npc_time(monster.npc) + monster.states.stealth.cd
    monster.Invisible_atk = 0
    monster.wander.maxDis = monster.maxDisbackup
  end
  if 2010420205 == skill_id then
    monster.states.stealth.timer = get_npc_time(monster.npc) + monster.states.stealth.cd
    monster.Invisible_atk = 0
    monster.wander.maxDis = monster.maxDisbackup
  end
end

return monster
