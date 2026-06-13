local monstBase = import("character.base.monster_base")
local monster = Util.create_child_mt(monstBase)

function monster._init(monster, npc)
  set_npc_ignore_sync_area(npc, false)
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
  monster.FirstTimeEnter1 = true
  monster.FirstTimeEnter2 = true
  monster.TargetPos2X, monster.TargetPos2Y, monster.TargetPos2Z = get_area_pos("BB2")
  monster.TargetPos1X, monster.TargetPos1Y, monster.TargetPos1Z = get_area_pos("BB1")
  monster.TargetPos3X, monster.TargetPos3Y, monster.TargetPos3Z = get_area_pos("BB3")
  monster.TargetPos4X, monster.TargetPos4Y, monster.TargetPos4Z = get_area_pos("BB4")
  monster.TargetPos5X, monster.TargetPos5Y, monster.TargetPos5Z = get_area_pos("BB5")
  monster.TargetPos6X, monster.TargetPos6Y, monster.TargetPos6Z = get_area_pos("BB6")
  monster.TargetPos7X, monster.TargetPos7Y, monster.TargetPos7Z = get_area_pos("BB7")
  monster.TargetPos8X, monster.TargetPos8Y, monster.TargetPos8Z = get_area_pos("BB8")
  monster.TargetPos1 = {
    x = monster.TargetPos1X,
    y = monster.TargetPos1Y,
    z = monster.TargetPos1Z
  }
  monster.TargetPos2 = {
    x = monster.TargetPos2X,
    y = monster.TargetPos2Y,
    z = monster.TargetPos2Z
  }
  monster.TargetPos3 = {
    x = monster.TargetPos3X,
    y = monster.TargetPos3Y,
    z = monster.TargetPos3Z
  }
  monster.TargetPos4 = {
    x = monster.TargetPos4X,
    y = monster.TargetPos4Y,
    z = monster.TargetPos4Z
  }
  monster.TargetPos5 = {
    x = monster.TargetPos5X,
    y = monster.TargetPos5Y,
    z = monster.TargetPos5Z
  }
  monster.TargetPos6 = {
    x = monster.TargetPos6X,
    y = monster.TargetPos6Y,
    z = monster.TargetPos6Z
  }
  monster.TargetPos7 = {
    x = monster.TargetPos7X,
    y = monster.TargetPos7Y,
    z = monster.TargetPos7Z
  }
  monster.TargetPos8 = {
    x = monster.TargetPos8X,
    y = monster.TargetPos8Y,
    z = monster.TargetPos8Z
  }
  monster.AllowRun = false
  monster.FirstTimeEnter = true
  monster.FirstTimeBB1 = true
  monster.FirstTimeBB2 = true
  monster.FirstTimeBB3 = true
  monster.FirstTimeBB4 = true
  monster.FirstTimeBB5 = true
  monster.FirstTimeBB6 = true
  monster.FirstTimeBB7 = true
  monster.FirstTimeBB8 = true
  monster.AllowCastSkill = false
  monster.ArriveTargetPos1 = false
  monster.ArriveTargetPos2 = false
  monster.ArriveTargetPos3 = false
  monster.ArriveTargetPos4 = false
  monster.ArriveTargetPos5 = false
  monster.ArriveTargetPos6 = false
  monster.ArriveTargetPos7 = false
  monster.ArriveTargetPos8 = false
  local actskills = {
    DoubleHit = {
      2020470105,
      15,
      0,
      0,
      999
    },
    BigSmash = {
      2020470106,
      10,
      0,
      0,
      999,
      -45,
      45
    },
    TurnPunch1 = {
      2020470107,
      10,
      0,
      0,
      999,
      -250,
      -40
    },
    ThrowStone = {
      2020470108,
      10,
      0,
      0,
      999,
      -45,
      45
    },
    frontPush = {
      2020470109,
      10,
      0,
      0,
      999,
      -45,
      45
    },
    RiseGround = {
      2020470110,
      10,
      0,
      0,
      999,
      -45,
      45
    },
    AssSmash1 = {
      2020470112,
      10,
      0,
      0,
      999,
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
      999,
      -45,
      45
    },
    Roar1 = {
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
    frontPush1 = {
      2020470125,
      0,
      0,
      0,
      999
    }
  }
  local nodes = {
    "turn",
    "close",
    "veryfar",
    "running",
    "battle",
    "attackforphase1"
  }
  local actMoves = {"running"}
  monstBase._init(monster, actskills, actMoves, nodes)
  local states = monster.states
  local skills = monster.skills
  do
    local _ENV = states
    _ENV.gotTarget(_ENV.running, _ENV.battle)
    _ENV.battle(_ENV.AssSmash1, _ENV.TurnPunch1, _ENV.turn, _ENV.attack, _ENV.wander, _ENV.frontPush1)
    _ENV.turn(_ENV.TurnLeft, _ENV.TurnRight)
    _ENV.TurnLeft(_ENV.TurnLeft, _ENV.TurnRight)
    _ENV.TurnRight(_ENV.TurnLeft, _ENV.TurnRight)
    _ENV.attack(_ENV.freeAtk)
    _ENV.freeAtk(_ENV.attackforphase1)
    _ENV.attackforphase1(_ENV.close(_ENV.DoubleHit, _ENV.BigSmash, _ENV.frontPush, _ENV.RiseGround, _ENV.AssSmash1, _ENV.HeavyHit), _ENV.veryfar(_ENV.ThrowStone))
  end
  
  function states.dead.isReady(dead)
    return false
  end
  
  function states.running.isReady(running)
    if monster.AllowRun == true then
      return true
    else
      return false
    end
  end
  
  function states.battle.isReady(battle)
    if monster.AllowRun == true then
      return false
    else
      return true
    end
  end
  
  function states.wander.finTrans(wander)
    return wander.monster.states.gotTarget
  end
  
  function states.attack.finTrans(attack)
    return attack.monster.states.gotTarget
  end
  
  function states.running.start(runnning)
    cast_magic(monster.npc, monster.npc, 2020470201, 1)
    cast_magic(monster.npc, monster.npc, 2020470202, 1)
    local param = {
      npc = monster.npc,
      target = monster.target,
      posx = get_npc_pos(monster.npc).x,
      posz = get_npc_pos(monster.npc).z,
      missile_id = 202047013901,
      missile_level = 1,
      lookat_posx = get_npc_pos(monster.npc).x,
      lookat_posz = get_npc_pos(monster.npc).z,
      lookat_posy = get_npc_pos(monster.npc).y,
      posy = get_npc_pos(monster.npc).y,
      born_posx = get_npc_pos(monster.npc).x,
      born_posz = get_npc_pos(monster.npc).z,
      born_posy = get_npc_pos(monster.npc).y
    }
    cast_missile2(param)
    if check_npc_distance_to_pos(monster.npc, monster.TargetPos8.x, monster.TargetPos8.z, 2.1, false) == false and monster.AllowRun == true and false == monster.ArriveTargetPos8 and true == monster.ArriveTargetPos1 and true == monster.ArriveTargetPos2 and true == monster.ArriveTargetPos3 and true == monster.ArriveTargetPos4 and true == monster.ArriveTargetPos5 and true == monster.ArriveTargetPos6 and true == monster.ArriveTargetPos7 then
      monster.AllowRun = false
      switch_move_type(monster.npc, 1)
      move_to_pos(monster.npc, monster.TargetPos8)
      monster.FirstTimeEnter = true
    end
    if false == check_npc_distance_to_pos(monster.npc, monster.TargetPos7.x, monster.TargetPos7.z, 2.1, false) and monster.AllowRun == true and false == monster.ArriveTargetPos7 and true == monster.ArriveTargetPos1 and true == monster.ArriveTargetPos2 and true == monster.ArriveTargetPos3 and true == monster.ArriveTargetPos4 and true == monster.ArriveTargetPos5 and true == monster.ArriveTargetPos6 then
      monster.AllowRun = false
      switch_move_type(monster.npc, 1)
      move_to_pos(monster.npc, monster.TargetPos7)
      monster.FirstTimeEnter = true
    end
    if false == check_npc_distance_to_pos(monster.npc, monster.TargetPos6.x, monster.TargetPos6.z, 2.1, false) and monster.AllowRun == true and false == monster.ArriveTargetPos6 and true == monster.ArriveTargetPos1 and true == monster.ArriveTargetPos2 and true == monster.ArriveTargetPos3 and true == monster.ArriveTargetPos4 and true == monster.ArriveTargetPos5 then
      monster.AllowRun = false
      switch_move_type(monster.npc, 1)
      move_to_pos(monster.npc, monster.TargetPos6)
      monster.FirstTimeEnter = true
    end
    if false == check_npc_distance_to_pos(monster.npc, monster.TargetPos5.x, monster.TargetPos5.z, 2.1, false) and monster.AllowRun == true and false == monster.ArriveTargetPos5 and true == monster.ArriveTargetPos1 and true == monster.ArriveTargetPos2 and true == monster.ArriveTargetPos3 and true == monster.ArriveTargetPos4 then
      monster.AllowRun = false
      switch_move_type(monster.npc, 1)
      move_to_pos(monster.npc, monster.TargetPos5)
      monster.FirstTimeEnter = true
    end
    if false == check_npc_distance_to_pos(monster.npc, monster.TargetPos4.x, monster.TargetPos4.z, 2.1, false) and monster.AllowRun == true and false == monster.ArriveTargetPos4 and true == monster.ArriveTargetPos1 and true == monster.ArriveTargetPos2 and true == monster.ArriveTargetPos3 then
      monster.AllowRun = false
      switch_move_type(monster.npc, 1)
      move_to_pos(monster.npc, monster.TargetPos4)
      monster.FirstTimeEnter = true
    end
    if false == check_npc_distance_to_pos(monster.npc, monster.TargetPos3.x, monster.TargetPos3.z, 2.1, false) and monster.AllowRun == true and false == monster.ArriveTargetPos3 and true == monster.ArriveTargetPos1 and true == monster.ArriveTargetPos2 then
      monster.AllowRun = false
      switch_move_type(monster.npc, 1)
      move_to_pos(monster.npc, monster.TargetPos3)
      monster.FirstTimeEnter = true
    end
    if false == check_npc_distance_to_pos(monster.npc, monster.TargetPos2.x, monster.TargetPos2.z, 2.1, false) and monster.AllowRun == true and false == monster.ArriveTargetPos2 and true == monster.ArriveTargetPos1 then
      monster.AllowRun = false
      switch_move_type(monster.npc, 1)
      move_to_pos(monster.npc, monster.TargetPos2)
      monster.FirstTimeEnter = true
    end
    if false == check_npc_distance_to_pos(monster.npc, monster.TargetPos1.x, monster.TargetPos1.z, 2.1, false) and monster.AllowRun == true and false == monster.ArriveTargetPos1 then
      monster.AllowRun = false
      switch_move_type(monster.npc, 1)
      move_to_pos(monster.npc, monster.TargetPos1)
      monster.FirstTimeEnter = true
    end
  end
  
  states.attack.interval = 0
  
  function states.running.tick(running)
    if check_npc_distance_to_pos(monster.npc, monster.TargetPos8.x, monster.TargetPos8.z, 2.1, false) == false and monster.AllowRun == true and false == monster.ArriveTargetPos8 and true == monster.ArriveTargetPos1 and true == monster.ArriveTargetPos2 and true == monster.ArriveTargetPos3 and true == monster.ArriveTargetPos4 and true == monster.ArriveTargetPos5 and true == monster.ArriveTargetPos6 and true == monster.ArriveTargetPos7 then
      monster.AllowRun = false
      switch_move_type(monster.npc, 1)
      move_to_pos(monster.npc, monster.TargetPos8)
      monster.FirstTimeEnter = true
    end
    if false == check_npc_distance_to_pos(monster.npc, monster.TargetPos7.x, monster.TargetPos7.z, 2.1, false) and monster.AllowRun == true and false == monster.ArriveTargetPos7 and true == monster.ArriveTargetPos1 and true == monster.ArriveTargetPos2 and true == monster.ArriveTargetPos3 and true == monster.ArriveTargetPos4 and true == monster.ArriveTargetPos5 and true == monster.ArriveTargetPos6 then
      monster.AllowRun = false
      switch_move_type(monster.npc, 1)
      move_to_pos(monster.npc, monster.TargetPos7)
      monster.FirstTimeEnter = true
    end
    if false == check_npc_distance_to_pos(monster.npc, monster.TargetPos6.x, monster.TargetPos6.z, 2.1, false) and monster.AllowRun == true and false == monster.ArriveTargetPos6 and true == monster.ArriveTargetPos1 and true == monster.ArriveTargetPos2 and true == monster.ArriveTargetPos3 and true == monster.ArriveTargetPos4 and true == monster.ArriveTargetPos5 then
      monster.AllowRun = false
      switch_move_type(monster.npc, 1)
      move_to_pos(monster.npc, monster.TargetPos6)
      monster.FirstTimeEnter = true
    end
    if false == check_npc_distance_to_pos(monster.npc, monster.TargetPos5.x, monster.TargetPos5.z, 2.1, false) and monster.AllowRun == true and false == monster.ArriveTargetPos5 and true == monster.ArriveTargetPos1 and true == monster.ArriveTargetPos2 and true == monster.ArriveTargetPos3 and true == monster.ArriveTargetPos4 then
      monster.AllowRun = false
      switch_move_type(monster.npc, 1)
      move_to_pos(monster.npc, monster.TargetPos5)
      monster.FirstTimeEnter = true
    end
    if false == check_npc_distance_to_pos(monster.npc, monster.TargetPos4.x, monster.TargetPos4.z, 2.1, false) and monster.AllowRun == true and false == monster.ArriveTargetPos4 and true == monster.ArriveTargetPos1 and true == monster.ArriveTargetPos2 and true == monster.ArriveTargetPos3 then
      monster.AllowRun = false
      switch_move_type(monster.npc, 1)
      move_to_pos(monster.npc, monster.TargetPos4)
      monster.FirstTimeEnter = true
    end
    if false == check_npc_distance_to_pos(monster.npc, monster.TargetPos3.x, monster.TargetPos3.z, 2.1, false) and monster.AllowRun == true and false == monster.ArriveTargetPos3 and true == monster.ArriveTargetPos1 and true == monster.ArriveTargetPos2 then
      monster.AllowRun = false
      switch_move_type(monster.npc, 1)
      move_to_pos(monster.npc, monster.TargetPos3)
      monster.FirstTimeEnter = true
    end
    if false == check_npc_distance_to_pos(monster.npc, monster.TargetPos2.x, monster.TargetPos2.z, 2.1, false) and monster.AllowRun == true and false == monster.ArriveTargetPos2 and true == monster.ArriveTargetPos1 then
      monster.AllowRun = false
      switch_move_type(monster.npc, 1)
      move_to_pos(monster.npc, monster.TargetPos2)
      monster.FirstTimeEnter = true
    end
    if false == check_npc_distance_to_pos(monster.npc, monster.TargetPos1.x, monster.TargetPos1.z, 2.1, false) and monster.AllowRun == true and false == monster.ArriveTargetPos1 then
      monster.AllowRun = false
      switch_move_type(monster.npc, 1)
      move_to_pos(monster.npc, monster.TargetPos1)
      monster.FirstTimeEnter = true
    end
    if true == check_npc_distance_to_pos(monster.npc, monster.TargetPos1.x, monster.TargetPos1.z, 2.1, false) and true == monster.FirstTimeBB1 then
      monster.FirstTimeBB1 = false
      monster.ArriveTargetPos1 = true
    end
    if true == check_npc_distance_to_pos(monster.npc, monster.TargetPos2.x, monster.TargetPos2.z, 2.1, false) and true == monster.FirstTimeBB2 then
      monster.FirstTimeBB2 = false
      monster.ArriveTargetPos2 = true
    end
    if true == check_npc_distance_to_pos(monster.npc, monster.TargetPos3.x, monster.TargetPos3.z, 2.1, false) and true == monster.FirstTimeBB3 then
      monster.FirstTimeBB3 = false
      monster.ArriveTargetPos3 = true
    end
    if true == check_npc_distance_to_pos(monster.npc, monster.TargetPos5.x, monster.TargetPos5.z, 2.1, false) and true == monster.FirstTimeBB5 then
      monster.FirstTimeBB5 = false
      monster.ArriveTargetPos5 = true
      monster.AllowRun = true
    end
    if true == check_npc_distance_to_pos(monster.npc, monster.TargetPos6.x, monster.TargetPos6.z, 2.1, false) and true == monster.FirstTimeBB6 then
      monster.FirstTimeBB6 = false
      monster.ArriveTargetPos6 = true
      monster.AllowRun = true
    end
    if true == check_npc_distance_to_pos(monster.npc, monster.TargetPos7.x, monster.TargetPos7.z, 2.1, false) and true == monster.FirstTimeBB7 then
      monster.FirstTimeBB7 = false
      monster.ArriveTargetPos7 = true
      monster.AllowRun = true
    end
    if true == check_npc_distance_to_pos(monster.npc, monster.TargetPos8.x, monster.TargetPos8.z, 1.1, false) and true == monster.FirstTimeBB8 then
      monster.FirstTimeBB8 = false
      monster.ArriveTargetPos8 = true
    end
  end
  
  function states.running.finish(running)
    abort_magic_by_id(monster.npc, 2020470201, 1)
    abort_magic_by_id(monster.npc, 2020470202, 1)
  end
  
  function states.running.tickTrans(running)
    if monster.AllowCastSkill == true then
      monster.AllowCastSkill = false
      return monster.states.frontPush1
    end
    if true == monster.ArriveTargetPos4 and false == monster.AllowRun and true == monster.FirstTimeEnter2 and true == monster.FirstTimeEnter1 then
      monster.FirstTimeEnter2 = false
      abort_magic_by_id(monster.npc, 2020470201, 1)
      abort_magic_by_id(monster.npc, 2020470202, 1)
      return monster.states.battle
    end
    if true == check_npc_distance_to_pos(monster.npc, monster.TargetPos4.x, monster.TargetPos4.z, 2.1, false) and true == monster.FirstTimeBB4 then
      monster.FirstTimeBB4 = false
      monster.ArriveTargetPos4 = true
      monster.AllowRun = false
      abort_magic_by_id(monster.npc, 2020470201, 1)
      abort_magic_by_id(monster.npc, 2020470202, 1)
      return running.monster.states.gotTarget
    end
  end
  
  function states.running.finTrans(running)
    abort_magic_by_id(monster.npc, 2020470201, 1)
    abort_magic_by_id(monster.npc, 2020470202, 1)
    return monster.states.gotTarget
  end
  
  function states.frontPush1.start(frontPush1)
    frontPush1.isCastOver = false
    local skill = frontPush1.skill
    frontPush1.curSk = skill
    skill.state = frontPush1
    abort_skill(frontPush1.monster.npc, true)
    skill.timer = get_npc_time(monster.npc) + skill.cd
    skill.isCastOver = false
    skill.castTimer = get_npc_time(frontPush1.monster.npc) + skill.befTime + skill.castTime
    cast_skill(frontPush1.monster.npc, nil, 2020470125)
  end
  
  function states.frontPush1.finish(frontPush1)
    monster.AllowRun = true
  end
  
  function states.frontPush1.finTrans(frontPush1)
    monster.AllowRun = true
    return monster.states.running
  end
  
  function states.turn.finTrans(turn)
    return turn.monster.states.attack
  end
  
  function states.active.tick(active)
    local HpMax = get_npc_attr(active.monster.npc, 4)
    local current_hp = get_npc_attr(active.monster.npc, 1)
    if current_hp <= HpMax * 0.7 and monster.AllowRun == false and false == monster.ArriveTargetPos4 then
      monster.AllowRun = true
      set_sync_var("70%", true)
    end
    if current_hp <= HpMax * 0.3 and monster.AllowRun == false and false == monster.ArriveTargetPos8 and true == monster.FirstTimeEnter1 then
      monster.FirstTimeEnter1 = false
      monster.AllowRun = true
      set_sync_var("30%", true)
    end
  end
  
  do
    local wander = states.wander
    local moveFor = states.moveFor
    wander(moveFor)
  end
  states.Roar1.skill = skills.Roar
  states.TurnPunch1.skill = skills.TurnPunch
  states.AssSmash1.skill = skills.AssSmash
  
  function states.AssSmash1.finTrans(AssSmash1)
    return AssSmash1.monster.states.gotTarget
  end
  
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
  
  function states.TurnPunch1.finTrans(TurnPunch1)
    return TurnPunch1.monster.states.gotTarget
  end
  
  function states.TurnPunch1.isReady(TurnPunch1)
    if get_npc_distance(TurnPunch1.monster.npc, 3, 1, true) <= 3 or get_npc_distance(TurnPunch1.monster.npc, 3, 2, true) <= 3 or get_npc_distance(TurnPunch1.monster.npc, 3, 3, true) <= 3 or get_npc_distance(TurnPunch1.monster.npc, 3, 4, true) <= 3 then
      return false
    end
    if not TurnPunch1.base.isReady(TurnPunch1) then
      return false
    end
    return true
  end
  
  function states.battle.finTrans(battle)
    if monster.AllowRun == true then
      return states.running
    end
    return battle.monster.states.gotTarget
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

function monster.on_magic_begin(monster, npc, target, magic_id, is_self, magic_level)
  if 2020470102 == magic_id then
    abort_magic_by_id(monster.npc, 2020470102, 1)
  end
end

function monster.on_start(monster)
  monster:xRay()
end

function monster.on_missile_begin_pos(monster, owner, pos_x, pos_z, missile_cfg, missile)
  if owner ~= monster.npc then
    return
  end
  if missile_cfg.Id == 202047010210 then
    monster.RunCheckMissile = missile
  end
end

function monster.after_damage(monster, npc, target, magic_id, damage_sign, damage_type, is_crit, damage_val, base_dmg, element_dmg)
  local player = get_come_on_hero()
  if target == player and monster.ShouldRoar1 == false then
    monster.ShouldRoar1 = true
  end
end

function monster.on_enter_area(monster, npc, area)
  if npc == monster.npc and check_magic(monster.npc, 2020470201) == true then
    if area.Key == "R1" then
      set_sync_var("TheRush1", true)
      monster.AllowCastSkill = true
      monster.AllowRun = false
    end
    if area.Key == "R2" then
      set_sync_var("TheRush2", true)
    end
    if area.Key == "R3" then
      set_sync_var("TheRush3", true)
    end
    if area.Key == "R4" then
      set_sync_var("TheRush4", true)
    end
    if area.Key == "R5" then
      set_sync_var("TheRush5", true)
    end
    if area.Key == "E1" then
      set_sync_var("TheEnd", true)
    end
  end
end

function monster.on_npc_hp_zero(monster, npc)
end

return monster
