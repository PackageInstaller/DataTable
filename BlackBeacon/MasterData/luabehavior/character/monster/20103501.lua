local monstBase = import("character.base.monster_base")
local monster = Util.create_child_mt(monstBase)
local tool = import("common.monster_tool")

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
    Atk = {
      2010350101,
      4,
      3,
      0,
      3,
      -60,
      60
    },
    Atk2 = {
      2010350103,
      12,
      3,
      0,
      3,
      -45,
      45
    },
    Shield_Start = {
      2010350105,
      15,
      8 + 5 * math.random(),
      0,
      4,
      -60,
      60
    },
    Shield_Loop = {
      2010350106,
      0,
      0,
      0,
      99
    },
    Shield_End = {
      2010350107,
      0,
      0,
      0,
      99
    },
    Shield_Atk = {
      2010350102,
      0,
      0,
      0,
      99
    },
    counterAtk1 = {
      2010350101,
      0,
      0,
      0,
      3,
      nil,
      nil,
      nil,
      6,
      1
    }
  }
  local nodes = {"Shield"}
  monstBase._init(monster, skills, nil, nodes)
  set_keyframe_enable(npc, 201035010104, false, false)
  do
    local _ENV = monster.states
    _ENV.meleeAtk(_ENV.Atk2, _ENV.Atk)
    _ENV.rangedAtk(_ENV.Shield)
    _ENV.Shield(_ENV.Shield_Start(_ENV.Shield_Loop(_ENV.Shield_End)), _ENV.Shield_Atk)
    _ENV.meleeCounter(_ENV.counterAtk1)
  end
  do
    local Shield_Start = monster.states.Shield_Start
    local Shield_Loop = monster.states.Shield_Loop
    local Shield_Atk = monster.states.Shield_Atk
    Shield_Loop.switch = false
    Shield_Loop.hitswitch = false
    
    function Shield_Start.start(Shield_Start)
      local npc = Shield_Start.monster.npc
      
      local function effect()
        cast_magic(npc, npc, 20103501015, 1)
      end
      
      monster:doAfter(effect, 0.7)
      Shield_Start.base.start(Shield_Start)
    end
    
    function Shield_Loop.start(Shield_Loop)
      Shield_Loop.switch = true
      Shield_Loop.base.start(Shield_Loop)
    end
    
    function Shield_Loop.tickTrans(Shield_Loop)
      if Shield_Loop.hitswitch == true then
        Shield_Loop.switch = false
        abort_magic_by_id(Shield_Loop.monster.npc, 20103501015, 99)
        return Shield_Loop.monster.states.Shield_Atk
      end
    end
    
    function Shield_Loop.finish(Shield_Loop)
      Shield_Loop.switch = false
      abort_magic_by_id(Shield_Loop.monster.npc, 20103501015, 99)
    end
    
    function Shield_Atk.isReady(skill)
      if skill.monster.states.Shield_Loop.hitswitch == false then
        return false
      end
      if not skill.base.isReady(skill) then
        return false
      end
      return true
    end
    
    function Shield_Atk.start(skill)
      skill.monster.states.Shield_Loop.hitswitch = false
      skill.base.start(skill)
    end
  end
  do
    local states = monster.states
    
    local function randomBaseCheck(actSkill, possibility)
      return tool.randByTime(actSkill.monster, possibility) and actSkill.base.isReady(actSkill)
    end
    
    function states.Atk2.isReady(actSkill)
      return randomBaseCheck(actSkill, 0.4)
    end
  end
  do
    local states = monster.states
    
    function states.counterAtk1.start(counterAtk1)
      counterAtk1.base.start(counterAtk1)
      set_keyframe_enable(npc, 201035010104, true, false)
    end
    
    function states.counterAtk1.finish(counterAtk1)
      counterAtk1.base.finish(counterAtk1)
      set_keyframe_enable(npc, 201035010104, false, false)
    end
  end
end

function monster.go_mad(monster)
  monster.base.go_mad(monster)
  monster.states.Atk2.cd = 6
  monster.states.Atk.cd = 3
  monster.states.Shield_Start.cd = 9
  monster.wander.maxDis = 3
  monster.wander.minDis = 0.5
  monster.states.attack.interval = 1
end

function monster.on_target_self_skill_hit(monster, skill_id, attacker, hit_type, missile_cfg, missile)
  monster.base.on_target_self_skill_hit(monster, skill_id, attacker, hit_type, missile_cfg, missile)
  local self = monster
  if monster.states.Shield_Loop.switch ~= true then
    return
  end
  local pos = get_npc_pos(attacker)
  local offse = get_dir_offset(self.npc, pos.x, pos.z)
  if offse <= 90 then
    monster.states.Shield_Loop.hitswitch = true
  end
end

function monster.on_frame(monster)
  monster.base.on_frame(monster)
  if check_magic(monster.npc, 20103501015) and not is_cast_skill_time(monster.npc, 2010350106, 1) and not is_cast_skill_time(monster.npc, 2010350105, 1) then
    abort_magic_by_id(monster.npc, 20103501015, 99)
  end
end

return monster
