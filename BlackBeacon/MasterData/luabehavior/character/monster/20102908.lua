local monstBase = import("character.base.monster_base")
local monster = Util.create_child_mt(monstBase)

function monster._init(monster, npc)
  monster.npc = npc
  monster.wander = {
    minDis = 1,
    maxDis = 4,
    minTime = 1,
    maxTime = 2,
    type = "walk"
  }
  local skills = {
    redSkill = {
      2010290801,
      20,
      5 + 8 * math.random(),
      0,
      3.5,
      -60,
      60
    },
    attack1 = {
      2010290804,
      8,
      1,
      3,
      3.5
    },
    attack2 = {
      2010290802,
      8,
      1,
      3,
      4,
      -45,
      45
    },
    Attack360 = {
      2010290803,
      5,
      1,
      2,
      5,
      -90,
      90
    },
    CounterAttack360 = {
      2010290803,
      0,
      0,
      0,
      7,
      nil,
      nil,
      nil,
      1,
      1
    },
    Step_left = {
      2010290805,
      10 * math.random(),
      1,
      2,
      4
    },
    Step_right = {
      2010290806,
      10 * math.random(),
      1,
      2,
      4
    },
    skillA = {
      2010290804,
      0,
      0
    },
    skillB = {
      2010290802,
      8,
      1,
      0,
      4,
      -45,
      45
    },
    skillC = {
      2010290803,
      0,
      0
    },
    Shield = {
      2010290807,
      30,
      0,
      0,
      5
    }
  }
  local nodes = {
    "mid",
    "right",
    "left",
    "ATK",
    "turn"
  }
  monstBase._init(monster, skills, nil, nodes)
  monster.StepTimer = 0
  monster.StepCd = 15
  do
    local _ENV = monster.states
    _ENV.freeAtk(_ENV.turn)
    _ENV.meleeAtk(_ENV.ATK)
    _ENV.meleeCounter(_ENV.CounterAttack360)
    _ENV.ATK(_ENV.Shield, _ENV.redSkill, _ENV.attack1(_ENV.attack2), _ENV.Attack360)
    _ENV.turn(_ENV.right, _ENV.left)
    _ENV.right(_ENV.Step_right(_ENV.skillA(_ENV.skillB), _ENV.skillC))
    _ENV.left(_ENV.Step_left(_ENV.skillA(_ENV.skillB), _ENV.skillC))
  end
  do
    local right = monster.states.right
    local left = monster.states.left
    local Step_right = monster.states.Step_right
    local Step_left = monster.states.Step_left
    
    function right.isReady()
      if get_target_angel(monster.target, monster.npc, true) > 15 and get_target_angel(monster.target, monster.npc, true) < 120 and Step_right.base.isReady(Step_right) then
        return true
      end
    end
    
    function left.isReady()
      if get_target_angel(monster.target, monster.npc, true) < -15 and get_target_angel(monster.target, monster.npc, true) > -120 and Step_left.base.isReady(Step_left) then
        return true
      end
    end
  end
  do
    local skillA = monster.states.skillA
    local skillC = monster.states.skillC
    
    function skillA.isReady(skillA)
      if not monster.tool.randByTime(monster, 0.5) then
        return false
      end
      return true
    end
  end
  do
    local Shield = monster.states.Shield
    
    function Shield.isReady(Shield)
      local now_hp = get_npc_attr(monster.npc, 1)
      local max_hp = get_npc_attr(monster.npc, 4)
      if now_hp / max_hp < 0.5 then
        return Shield.base.isReady(Shield)
      end
    end
  end
end

function monster.before_damage_self(monster, npc, magic_id, damage_sign, damage_type, target_camp, change_level, magic_level, skill_id, missile)
  monster.base.before_damage_self(monster, npc, magic_id, damage_sign, damage_type, target_camp, change_level, magic_level, skill_id, missile)
  if 8 == damage_sign then
    return
  end
  if monster.states.wander:isRunning() and monster.StepTimer < get_npc_time(monster.npc) then
    if get_target_angel(monster.target, monster.npc, true) > 0 then
      monster.StepTimer = get_npc_time(monster.npc) + monster.StepCd
      return monster:transState(monster.states.Step_right, true)
    else
      monster.StepTimer = get_npc_time(monster.npc) + monster.StepCd
      return monster:transState(monster.states.Step_left, true)
    end
  end
end

function monster.on_self_magic_end(monster, target, magic_id)
  if 20102901011 == magic_id then
    cast_magic(monster.npc, monster.npc, 201180049, 1)
  end
end

return monster
