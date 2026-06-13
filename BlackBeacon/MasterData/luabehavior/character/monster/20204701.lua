local monstBase = import("character.base.monster_base")
local monster = Util.create_child_mt(monstBase)

function monster._init(monster, npc)
  monster.npc = npc
  monster.wander = {
    minDis = 1.5,
    maxDis = 2,
    minTime = 1,
    maxTime = 2,
    type = "walk"
  }
  monster.turnCount = 0
  monster.hitcheck = false
  monster.runhitcheck = false
  monster.ShouldRoar1 = false
  monster.RunCheckMissile = nil
  monster.runhitcheck1 = false
  monster.onlyenteronce = true
  local skills = {
    Runstart = {
      2020470101,
      0,
      0,
      0,
      999
    },
    RunLoop = {
      2020470102,
      0,
      0
    },
    RunEnd = {
      2020470103,
      0,
      0
    },
    RunPunch = {
      2020470104,
      0,
      0,
      0,
      4,
      -45,
      45
    },
    DoubleHit = {
      2020470105,
      15,
      0,
      0,
      4
    },
    BigSmash = {
      2020470106,
      10,
      0,
      0,
      4,
      -45,
      45
    },
    TurnPunch = {
      2020470107,
      10,
      0,
      0,
      4,
      -180,
      -90
    },
    ThrowStone = {
      2020470108,
      0,
      0,
      0,
      999
    },
    frontPush = {
      2020470109,
      10,
      0,
      0,
      4,
      -45,
      45
    },
    RiseGround = {
      2020470110,
      0,
      0,
      0,
      999
    },
    born = {
      2020470111,
      3,
      0,
      0,
      999
    },
    AssSmash = {
      2020470112,
      10,
      0,
      0,
      4,
      135,
      225
    },
    Rage = {
      2020470113,
      3,
      0,
      0,
      999
    },
    HeavyHit = {
      2020470114,
      0,
      0,
      0,
      999
    },
    Roar = {
      2020470115,
      0,
      0,
      0,
      999
    },
    TurnLeft = {
      2020470116,
      0,
      0,
      0,
      999,
      -180,
      -40
    },
    TurnRight = {
      2020470117,
      0,
      0,
      0,
      999,
      40,
      180
    },
    companyskill1 = {
      2020470136,
      0,
      0,
      0,
      999
    },
    companyskill2 = {
      2020470137,
      0,
      0,
      0,
      999
    },
    companyskill3 = {
      2020470138,
      0,
      0,
      0,
      999
    },
    DoubleHit1 = {
      2020470118,
      15,
      0,
      0,
      8,
      -45,
      45
    },
    AssSmash2 = {
      2020470119,
      5,
      0,
      0,
      4,
      135,
      225
    },
    Runstart1 = {
      2020470120,
      10,
      0,
      3,
      999
    },
    TurnPunch2 = {
      2020470121,
      5,
      0,
      0,
      4,
      -180,
      -90
    },
    HeavyHit1 = {
      2020470123,
      7,
      0,
      0,
      8,
      -60,
      60
    },
    BigSmash1 = {
      2020470124,
      0,
      0,
      0,
      6,
      -60,
      60
    },
    frontPush1 = {
      2020470125,
      5,
      0,
      0,
      7.5,
      -30,
      30
    },
    RiseGround1 = {
      2020470128,
      15,
      0,
      0,
      10,
      -60,
      60
    },
    ThrowStone1 = {
      2020470129,
      4,
      0,
      6,
      999,
      -30,
      30
    }
  }
  local nodes = {
    "attackforphase1",
    "attackforphase2",
    "comboA",
    "comboB",
    "comboC",
    "comboD",
    "comboE",
    "turn",
    "close",
    "veryfar",
    "close1",
    "far1",
    "companyskill"
  }
  monstBase._init(monster, skills, nil, nodes)
  local states = monster.states
  local skills = monster.skills
  do
    local _ENV = states
    _ENV.attack.interval = 0
    _ENV.gotTarget(_ENV.idle)
  end
  do
    local wanderMove = states.wanderMove
    local moveFor = states.moveFor
    wanderMove(moveFor)
  end
  states.Roar1.skill = skills.Roar
  states.TurnPunch1.skill = skills.TurnPunch
  states.AssSmash1.skill = skills.AssSmash
  
  function states.Roar1.finTrans(Roar1)
    return Roar1.monster.states.gotTarget
  end
  
  function states.Roar1.isReady(Roar1)
    if monster.ShouldRoar1 == true then
      return true
    else
      return false
    end
  end
  
  function states.Roar1.start(Roar1)
    Roar1.base.start(Roar1)
    monster.ShouldRoar1 = false
  end
  
  function states.frontPush.tick(frontPush)
    local frame = frontPush.monster.npc.skill_mgr:get_skill(2020470109).v_frame
    local player = get_come_on_hero()
    if 47 == frame and get_target_angel(frontPush.monster.npc, player, true) < 0 then
      set_keyframe_enable(frontPush.monster.npc, 202047010904, false, true)
    end
  end
  
  function states.frontPush.finish(frontPush)
    set_keyframe_enable(frontPush.monster.npc, 202047010904, true, true)
  end
  
  function states.AssSmash1.isReady(AssSmash1)
    local HpMax = get_npc_attr(AssSmash1.monster.npc, 4)
    local current_hp = get_npc_attr(AssSmash1.monster.npc, 1)
    if not AssSmash1.base.isReady(AssSmash1) then
      return false
    end
    if current_hp < HpMax * 0.5 then
      return false
    end
    return false
  end
  
  function states.AssSmash2.isReady(AssSmash2)
    local HpMax = get_npc_attr(AssSmash2.monster.npc, 4)
    local current_hp = get_npc_attr(AssSmash2.monster.npc, 1)
    if not AssSmash2.base.isReady(AssSmash2) then
      return false
    end
    if current_hp > HpMax * 0.5 then
      return true
    end
    return true
  end
  
  function states.AssSmash1.finTrans(AssSmash1)
    return AssSmash1.monster.states.gotTarget
  end
  
  function states.AssSmash2.finTrans(AssSmash2)
    return AssSmash2.monster.states.gotTarget
  end
  
  function states.TurnPunch2.isReady(TurnPunch2)
    local HpMax = get_npc_attr(TurnPunch2.monster.npc, 4)
    local current_hp = get_npc_attr(TurnPunch2.monster.npc, 1)
    if get_npc_distance(TurnPunch2.monster.npc, 3, nil, true) <= 4 then
      return false
    end
    if not TurnPunch2.base.isReady(TurnPunch2) then
      return false
    end
    if current_hp > HpMax * 0.5 then
      return false
    end
    return true
  end
  
  function states.TurnPunch2.finTrans(TurnPunch2)
    return TurnPunch2.monster.states.gotTarget
  end
  
  function states.TurnPunch1.isReady(TurnPunch1)
    local HpMax = get_npc_attr(TurnPunch1.monster.npc, 4)
    local current_hp = get_npc_attr(TurnPunch1.monster.npc, 1)
    if get_npc_distance(TurnPunch1.monster.npc, 3, nil, true) <= 3 then
      return false
    end
    if not TurnPunch1.base.isReady(TurnPunch1) then
      return false
    end
    if current_hp < HpMax * 0.5 then
      return false
    end
    return true
  end
  
  function states.TurnPunch1.finTrans(TurnPunch1)
    return TurnPunch1.monster.states.gotTarget
  end
  
  function monster.states.companyskill1.start(companyskill1)
    companyskill1.base.start(companyskill1)
    set_keyframe_enable(monster.npc, 202047013631, false, false)
    set_keyframe_enable(monster.npc, 202047013632, false, false)
    set_keyframe_enable(monster.npc, 202047013633, false, false)
    print("我来了1")
  end
  
  function monster.states.companyskill3.tick(companyskill3)
    local frame = companyskill3.monster.npc.skill_mgr:get_skill(2020470138).v_frame
    local player = get_come_on_hero()
    if 79 == frame and get_target_angel(companyskill3.monster.npc, player, true) < 0 then
      set_keyframe_enable(companyskill3.monster.npc, 202047013811, false, false)
    end
  end
  
  do
    local Runstart = monster.skills.Runstart
    local RunLoop = monster.skills.RunLoop
    local RunEnd = monster.skills.RunEnd
    local RunPunch = monster.skills.RunPunchs
    Runstart(RunLoop(RunPunch, RunEnd))
    
    function skills.RunPunch.isReady(RunPunch)
      if monster.runhitcheck1 == true then
        monster.runhitcheck1 = false
        return false
      end
      return true
    end
    
    function skills.RunLoop.onEnd(RunLoop)
      cast_magic(monster.npc, monster.npc, 2020470102, 1)
      RunLoop.base.onEnd(RunLoop)
    end
    
    function skills.RunLoop.onBegin(RunLoop)
      cast_magic(RunLoop.monster.npc, RunLoop.monster.npc, 2020470103, 1)
      cast_magic(RunLoop.monster.npc, RunLoop.monster.npc, 2020470104, 1)
      cast_magic(RunLoop.monster.npc, RunLoop.monster.npc, 2020470105, 1)
    end
    
    function skills.RunPunch.onEnd(RunPunch)
      RunPunch.base.onEnd(RunPunch)
      abort_magic_by_id(monster.npc, 2020470103, 1)
      abort_magic_by_id(monster.npc, 2020470104, 1)
      set_keyframe_enable(monster.npc, 202047010208, true, true)
    end
    
    function skills.RunEnd.onEnd(RunEnd)
      RunEnd.base.onEnd(RunEnd)
      abort_magic_by_id(monster.npc, 2020470103, 1)
      abort_magic_by_id(monster.npc, 2020470104, 1)
      set_keyframe_enable(monster.npc, 202047010208, true, true)
    end
    
    function skills.RunLoop.tick(RunLoop)
      RunLoop.base.tick(RunLoop)
      if monster.runhitcheck == true then
        monster.runhitcheck = false
        monster.runhitcheck1 = true
        if monster.RunCheckMissile ~= nil then
          print("来过吗")
          stop_missile(monster.RunCheckMissile)
        end
        monster:doAfter(function(monster)
          RunLoop:deriveAuto()
        end, 1)
      end
    end
  end
  do
    local Runstart1 = monster.skills.Runstart1
    local RunLoop = monster.skills.RunLoop
    local RunEnd = monster.skills.RunEnd
    local RunPunch = monster.skills.RunPunch
    Runstart1(RunLoop(RunPunch, RunEnd))
  end
  
  function states.attack.finTrans(attack)
    return attack.monster.states.gotTarget
  end
  
  function states.turn.tickTrans(turn)
    if monster.turnCount >= 3 then
      monster.turnCount = 0
      return turn.monster.states.Runstart
    end
  end
  
  function states.turn.finTrans(turn)
    return turn.monster.states.attack
  end
  
  function states.TurnLeft.start(TurnLeft)
    monster.turnCount = monster.turnCount + 1
    TurnLeft.base.start(TurnLeft)
  end
  
  function states.TurnRight.start(TurnRight)
    monster.turnCount = monster.turnCount + 1
    TurnRight.base.start(TurnRight)
  end
  
  function states.attackforphase1.isReady(attackforphase1)
    if not attackforphase1.base.isReady(attackforphase1) then
      return false
    end
    local HpMax = get_npc_attr(attackforphase1.monster.npc, 4)
    local current_hp = get_npc_attr(attackforphase1.monster.npc, 1)
    if current_hp <= HpMax * 0.5 then
      return false
    elseif current_hp > HpMax * 0.5 then
      return false
    end
  end
  
  function states.attackforphase2.isReady(attackforphase2)
    if not attackforphase2.base.isReady(attackforphase2) then
      return false
    end
    local HpMax = get_npc_attr(attackforphase2.monster.npc, 4)
    local current_hp = get_npc_attr(attackforphase2.monster.npc, 1)
    if current_hp > HpMax * 0.5 then
      return true
    end
    return true
  end
  
  function states.attackforphase2.tickTrans(attackforphase2)
    local curstate = monster.tree:curState()
    if curstate.isCastOver == true then
      return monster.tree:chooseChildAction(attackforphase2)
    end
  end
end

function monster.on_self_skill_hit(monster, skill_id, hit_target, hit_type, missile_cfg, missile)
  monster.base.on_self_skill_hit(monster, skill_id, hit_target, hit_type, missile_cfg, missile)
  local states = monster.states
  local player = get_come_on_hero()
  if hit_target == player and missile_cfg.Id == 202047010209 and monster.tree:curState() == states.Runstart and monster.runhitcheck == false then
    monster.runhitcheck = true
  end
  if hit_target == player and missile_cfg.Id == 202047010210 and monster.runhitcheck == false then
    local RunLoop = monster.skills[skill_id]
    RunLoop:deriveAuto()
  end
end

function monster.on_target_self_skill_hit(monster, skill_id, caster, hit_type, missile_cfg, missile)
  monster.base.on_target_self_skill_hit(monster, skill_id, caster, hit_type, missile_cfg, missile)
  local player = get_come_on_hero()
  if missile_cfg.Id == 202047010803 or missile_cfg.Id == 202047012903 then
    play_effect(monster.npc, "Fx_common_RedSkillCounter", "Bip001 Chest34", false)
    cast_magic(monster.npc, player, 201025030809, 1)
    cast_magic(monster.npc, player, 201025030810, 1)
  end
end

function monster.on_magic_begin(monster, npc, target, magic_id, is_self, magic_level)
  if 2020470102 == magic_id then
    abort_magic_by_id(monster.npc, 2020470102, 1)
  end
end

function monster.on_start(monster)
  monster:xRay()
  change_follow_target(3, monster.npc, {
    6,
    12,
    {
      x = 0,
      y = -5,
      z = -1.8
    },
    1,
    0.6
  })
end

function monster.on_missile_begin_pos(monster, owner, pos_x, pos_z, missile_cfg, missile)
  if owner ~= monster.npc then
    return
  end
  if missile_cfg.Id == 202047010210 then
    monster.RunCheckMissile = missile
  end
end

function monster.on_self_skill_hit(monster, skill_id, hit_target, hit_type, missile_cfg, missile)
  monster.base.on_self_skill_hit(monster, skill_id, hit_target, hit_type, missile_cfg, missile)
  if missile_cfg.Id == 202047013604 then
    monster.tool.roleFaint(hit_target, 1.27)
  end
  if missile_cfg.Id == 202047013619 then
    set_keyframe_enable(monster.npc, 202047013631, true, false)
    set_keyframe_enable(monster.npc, 202047013632, true, false)
    set_keyframe_enable(monster.npc, 202047013633, true, false)
  end
  if missile_cfg.Id == 202047013703 then
    monster.tool.roleFaint(hit_target, 3)
  end
  if missile_cfg.Id == 202047013803 then
    monster.tool.roleFaint(hit_target, 2.8)
  end
end

function monster.before_damage_target(monster, target, magic_id, damage_sign, damage_type, camp, change_grading, magic_level, skill_id, missile)
  monster.base.before_damage_target(monster, target, magic_id, damage_sign, damage_type, camp, change_grading, magic_level, skill_id, missile)
  if 2020470116 == magic_id then
    monster.tool.roleFaintFinish(target)
  end
  if 2020470116 == magic_id then
    monster.tool.roleFaintFinish(target)
  end
end

function monster.on_missile_collide(monster, m1_owner, m2_owner, m1, m2, m1_cfg, m2_cfg)
  local player = get_come_on_hero()
  if m1_owner == player and m2_owner == monster.npc then
    local magics = m1_cfg.magic
    local magicId = magics and magics[1]
    local magicCfg = magicId and ShareRes.get_magic_cfg(magicId)
    if (m2_cfg.Id == 202047010803 or m2_cfg.Id == 202047012903 or m2_cfg.Id == 202047013805) and nil ~= magics and nil ~= magicId and nil ~= magicCfg and 2 == magicCfg.logic[1] then
      cast_magic(monster.npc, player, 2020470109, 1)
      cast_magic(monster.npc, player, 201025030806, 1)
      create_scene_effect("Fx_M201047_water_hit_3", get_missile_pos(m2), 5, nil, get_npc_pos(monster.npc))
      rebound_missile(m2, player, monster.npc, get_npc_pos(monster.npc).x, get_npc_pos(monster.npc).z, 10, false, false, true)
      cast_magic(monster.npc, player, 201025030809, 1)
      cast_magic(monster.npc, player, 201025030810, 1)
      cast_magic(monster.npc, player, 2020470145, 1)
    end
  end
  if m1_owner == monster.npc and m2_owner == player then
    local magics = m2_cfg.magic
    local magicId = magics and magics[1]
    local magicCfg = magicId and ShareRes.get_magic_cfg(magicId)
    if (m1_cfg.Id == 202047010803 or m1_cfg.Id == 202047012903 or m1_cfg.Id == 202047013805) and nil ~= magics and nil ~= magicId and nil ~= magicCfg and 2 == magicCfg.logic[1] then
      cast_magic(monster.npc, player, 2020470109, 1)
      cast_magic(monster.npc, player, 201025030806, 1)
      create_scene_effect("Fx_M201047_water_hit_3", get_missile_pos(m2), 5, nil, get_npc_pos(monster.npc))
      rebound_missile(m1, player, monster.npc, get_npc_pos(monster.npc).x, get_npc_pos(monster.npc).z, 10, false, false, true)
      cast_magic(monster.npc, player, 201025030809, 1)
      cast_magic(monster.npc, player, 201025030810, 1)
      cast_magic(monster.npc, player, 2020470145, 1)
    end
  end
end

return monster
