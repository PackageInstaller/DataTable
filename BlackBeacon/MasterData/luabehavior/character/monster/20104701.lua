local monstBase = import("character.base.monster_base")
local monster = Util.create_child_mt(monstBase)

function monster._init(monster, npc)
  monster.npc = npc
  monster.wander = {
    minDis = 0,
    maxDis = 3,
    minTime = 1,
    maxTime = 5,
    type = "walk"
  }
  monster.turnCount = 0
  monster.hitcheck = false
  monster.runhitcheck = false
  monster.ShouldRoar1 = false
  monster.RunCheckMissile = nil
  monster.runhitcheck1 = false
  monster.onlyenteronce = true
  monster.attackcount = 0
  monster.centerX, monster.centerY, monster.centerZ = get_area_pos("center")
  monster.center = {
    x = monster.centerX,
    y = monster.centerY,
    z = monster.centerZ
  }
  monster.RunPushMissile = nil
  monster.cam = true
  monster.challenge_normal = false
  monster.challenge_hard = false
  if get_tower_id() == 220401 or get_tower_id() == 220402 then
    monster.challenge_normal = true
  elseif get_tower_id() == 220403 or get_tower_id() == 220404 or get_tower_id() == 220405 then
    monster.challenge_hard = true
  end
  local skills = {
    Runstart = {
      2020470101,
      10,
      0,
      0,
      999,
      -60,
      60
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
      8,
      -45,
      45,
      nil,
      nil,
      0.3
    },
    DoubleHit = {
      2020470105,
      5,
      0,
      0,
      4,
      -90,
      90
    },
    BigSmash = {
      2020470106,
      15,
      0,
      0,
      3,
      -90,
      90
    },
    TurnPunch = {
      2020470107,
      5,
      0,
      0,
      4,
      -180,
      -90
    },
    ThrowStone = {
      2020470108,
      4,
      4,
      6,
      999,
      -60,
      60
    },
    frontPush = {
      2020470109,
      10,
      0,
      0,
      4,
      -90,
      90
    },
    RiseGround = {
      2020470110,
      5,
      0,
      0,
      6,
      -60,
      60
    },
    AssSmash = {
      2020470112,
      6,
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
      5,
      0,
      0,
      3,
      -60,
      60
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
      45,
      180
    },
    TurnRight = {
      2020470117,
      0,
      0,
      0,
      999,
      -179,
      -45
    },
    DoubleHit1 = {
      2020470105,
      15,
      0,
      0,
      4,
      -90,
      90
    },
    AssSmash2 = {
      2020470112,
      5,
      0,
      0,
      4,
      135,
      225
    },
    Runstart1 = {
      2020470120,
      15,
      0,
      0,
      999,
      -60,
      60
    },
    TurnPunch2 = {
      2020470107,
      5,
      0,
      0,
      4,
      -180,
      -90
    },
    HeavyHit1 = {
      2020470114,
      7,
      0,
      0,
      3,
      -60,
      60
    },
    BigSmash1 = {
      2020470106,
      0,
      0,
      0,
      4,
      -90,
      90
    },
    frontPush1 = {
      2020470109,
      5,
      0,
      0,
      4,
      -90,
      90
    },
    RiseGround1 = {
      2020470110,
      15,
      0,
      0,
      6,
      -60,
      60
    },
    ThrowStone1 = {
      2020470108,
      4,
      0,
      6,
      999,
      -30,
      30
    },
    DrinkWaterStart = {
      2020470132,
      0,
      0,
      0,
      999
    },
    DrinkWaterLoop = {
      2020470133,
      0,
      0,
      0,
      999
    },
    DrinkWaterEnd1 = {
      2020470134,
      0,
      0,
      0,
      999
    },
    DrinkWaterEnd2 = {
      2020470135,
      0,
      0,
      0,
      999
    },
    Roar1 = {
      2020470115,
      0,
      0,
      0,
      999
    },
    TurnPunch1 = {
      2020470121,
      5,
      0,
      0,
      4,
      -180,
      -90
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
    "Turn",
    "close",
    "veryfar",
    "drink",
    "close1",
    "far1",
    "turn1",
    "turnHit"
  }
  local actMoves = {
    "moveToWater",
    "Stand"
  }
  monstBase._init(monster, skills, actMoves, nodes)
  local states = monster.states
  local skills = monster.skills
  if not monster.challenge_normal and not monster.challenge_hard then
    local _ENV = states
    _ENV.attack.interval = 0
    _ENV.gotTarget(_ENV.drink, _ENV.attack, _ENV.wander)
    _ENV.drink(_ENV.moveToWater, _ENV.DrinkWaterStart(_ENV.DrinkWaterLoop(_ENV.DrinkWaterEnd1(_ENV.DrinkWaterEnd2))))
    _ENV.freeAtk(_ENV.turnHit, _ENV.attackforphase1, _ENV.attackforphase2)
    _ENV.turnHit(_ENV.TurnPunch2, _ENV.AssSmash2)
    _ENV.attackforphase1(_ENV.close(_ENV.BigSmash, _ENV.frontPush, _ENV.DoubleHit(_ENV.HeavyHit)), _ENV.veryfar(_ENV.ThrowStone, _ENV.Runstart))
    _ENV.attackforphase2(_ENV.close1(_ENV.RiseGround1, _ENV.frontPush1, _ENV.DoubleHit1, _ENV.HeavyHit1, _ENV.BigSmash1), _ENV.far1(_ENV.ThrowStone1, _ENV.Runstart1))
    _ENV.wander(_ENV.Turn, _ENV.forward, _ENV.Stand)
    _ENV.Turn(_ENV.TurnLeft, _ENV.TurnRight)
  elseif monster.challenge_normal then
    local _ENV = states
    _ENV.attack.interval = 0
    _ENV.gotTarget(_ENV.drink, _ENV.attack, _ENV.wander)
    _ENV.drink(_ENV.moveToWater, _ENV.DrinkWaterStart(_ENV.DrinkWaterLoop(_ENV.DrinkWaterEnd1(_ENV.DrinkWaterEnd2))))
    _ENV.freeAtk(_ENV.turnHit, _ENV.attackforphase1, _ENV.attackforphase2)
    _ENV.turnHit(_ENV.TurnPunch2, _ENV.AssSmash2)
    _ENV.attackforphase1(_ENV.close(_ENV.BigSmash, _ENV.HeavyHit, _ENV.frontPush), _ENV.veryfar(_ENV.Runstart))
    _ENV.attackforphase2(_ENV.close1(_ENV.frontPush1, _ENV.DoubleHit1(_ENV.HeavyHit1), _ENV.BigSmash1), _ENV.far1(_ENV.Runstart1))
    _ENV.wander(_ENV.Turn, _ENV.forward, _ENV.Stand)
    _ENV.Turn(_ENV.TurnLeft, _ENV.TurnRight)
  elseif monster.challenge_hard then
    local _ENV = states
    _ENV.attack.interval = 0
    _ENV.gotTarget(_ENV.drink, _ENV.attack, _ENV.wander)
    _ENV.drink(_ENV.moveToWater, _ENV.DrinkWaterStart(_ENV.DrinkWaterLoop(_ENV.DrinkWaterEnd1(_ENV.DrinkWaterEnd2))))
    _ENV.freeAtk(_ENV.turnHit, _ENV.attackforphase1, _ENV.attackforphase2)
    _ENV.turnHit(_ENV.TurnPunch2, _ENV.AssSmash2)
    _ENV.attackforphase1(_ENV.close(_ENV.BigSmash, _ENV.frontPush, _ENV.DoubleHit(_ENV.HeavyHit)), _ENV.veryfar(_ENV.ThrowStone, _ENV.Runstart))
    _ENV.attackforphase2(_ENV.close1(_ENV.RiseGround1, _ENV.frontPush1, _ENV.DoubleHit1(_ENV.HeavyHit1), _ENV.BigSmash1), _ENV.far1(_ENV.ThrowStone1, _ENV.Runstart1))
    _ENV.wander(_ENV.Turn, _ENV.forward, _ENV.Stand)
    _ENV.Turn(_ENV.TurnLeft, _ENV.TurnRight)
  end
  monster.states.dead.delay = {fx = 1.6, remove = 3}
  do
    local active = monster.states.active
    active.closetMis = nil
    active.closetPos = nil
    active.minDis = 9999
    
    function active.tick(active)
      if not check_magic(active.monster.npc, 2020470106) then
        if active.monster.tool.blueWaters == nil then
          return
        end
        if nil == _G.next(active.monster.tool.blueWaters) then
          return
        end
        local selfPos = get_npc_pos(active.monster.npc)
        if nil == selfPos then
          return
        end
        local closetMis = active.closetMis
        local closetPos = active.closetPos
        local minDis = active.minDis
        for _, waterMis in pairs(active.monster.tool.blueWaters) do
          if npc_is_destroy(waterMis) then
          else
            local misPos = get_missile_pos(waterMis)
            local distSquare = (selfPos.x - misPos.x) * (selfPos.x - misPos.x) + (selfPos.z - misPos.z) * (selfPos.z - misPos.z)
            if minDis > distSquare then
              minDis = distSquare
              closetMis = waterMis
              closetPos = misPos
            end
          end
        end
        if minDis < 180 then
          active.monster.states.drink.distance = true
          active.monster.states.moveToWater.minDis = minDis
          active.monster.states.moveToWater.closetPos = closetPos
          active.monster.states.moveToWater.closetMis = closetMis
        end
      end
      if monster.cam == false and get_npc_distance(monster.npc, 1, get_come_on_hero(), false) < 12 then
        monster.cam = true
        change_follow_target(3, monster.npc, {
          6,
          12,
          {
            x = 0,
            y = 0,
            z = 0
          },
          1,
          0.6
        })
      end
    end
    
    do
      local drink = monster.states.drink
      local drinkEnd1 = monster.states.DrinkWaterEnd1
      local drinkEnd2 = monster.states.DrinkWaterEnd2
      local drrink_loop = monster.states.DrinkWaterLoop
      local drink_Start = monster.skills.DrinkWaterStart
      monster.states.moveToWater.closetPos = nil
      
      function drink.isReady(drink)
        local magic = check_magic(drink.monster.npc, 2020470106)
        if magic then
          return false
        end
        if monster.tool.blueWaters == nil then
          return false
        end
        if nil == _G.next(monster.tool.blueWaters) then
          return false
        end
        if drink_Start.base.isReady(drink_Start) == false then
          return false
        end
        if false == drink.distance then
          return false
        end
        local HpMax = get_npc_attr(drink.monster.npc, 4)
        local current_hp = get_npc_attr(drink.monster.npc, 1)
        local proportion = current_hp / HpMax
        if not monster.challenge_normal and not monster.challenge_hard then
          return proportion <= 0.75
        elseif monster.challenge_normal then
          return proportion <= 0.5
        elseif monster.challenge_hard then
          return proportion <= 0.75
        end
      end
      
      function drinkEnd1.start(drinkEnd1)
        drinkEnd1.base.start(drinkEnd1)
        cast_magic(monster.npc, monster.npc, 30010050226, 1)
      end
      
      function drinkEnd1.finish(drinkEnd1)
        local self = drinkEnd1.monster.npc
        change_npc_prefab(self, 1, true)
        abort_magic_by_id(monster.npc, 1999215, 1)
        cast_magic(monster.npc, monster.npc, 1999215)
        cast_magic(self, self, 2020470106, 1)
        if monster.challenge_normal then
          cast_magic(drinkEnd1.monster.npc, drinkEnd1.monster.npc, 2020470147, 1)
        elseif monster.challenge_hard then
          cast_magic(drinkEnd1.monster.npc, drinkEnd1.monster.npc, 2020470130, 1)
          cast_magic(drinkEnd1.monster.npc, drinkEnd1.monster.npc, 2020470148, 1)
        end
      end
      
      function drinkEnd2.finish(drinkEnd2)
        abort_magic_by_id(monster.npc, 30010050226, 1)
      end
      
      function drink.finTrans(drink)
        return drink.monster.states.active
      end
      
      function drrink_loop.finish(drink)
        stop_missile(drink.monster.states.moveToWater.closetMis)
      end
      
      do
        local moveToWater = monster.states.moveToWater
        
        function moveToWater.start(moveToWater)
          move_to_pos(moveToWater.monster.npc, moveToWater.closetPos)
          switch_move_type(moveToWater.monster.npc, 1)
          local param = {
            npc = moveToWater.monster.npc,
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
        end
        
        function moveToWater.tickTrans(moveToWater)
          local pos = moveToWater.closetPos
          if get_npc_distance(monster.npc, 1, get_come_on_hero(), false) > 13 and monster.cam == true then
            monster.cam = false
            change_follow_target(0)
          end
          if check_npc_distance_to_pos(moveToWater.monster.npc, pos.x, pos.z, 3, false) then
            if monster.RunPushMissile ~= nil then
              stop_missile(monster.RunPushMissile)
            end
            return moveToWater.monster.states.DrinkWaterStart
          end
          if nil == _G.next(monster.tool.blueWaters) then
            if monster.RunPushMissile ~= nil then
              stop_missile(monster.RunPushMissile)
            end
            return moveToWater.monster.states.active
          end
        end
        
        function moveToWater.finTrans()
          return moveToWater.monster.states.wander
        end
      end
    end
    local wander = monster.states.wander
    
    function wander.tickTrans()
      local monster = wander.monster
      local states = monster.states
      local drink = monster.states.drink
      if is_cast_skill_time(monster.npc) then
        return
      end
      if not monster.target then
        return states.noTarget
      end
      if drink.isReady(drink) then
        return drink
      end
      if states.attack then
        return monster.tree:chooseChildAction(states.attack)
      end
    end
  end
  do
    local Runstart = monster.skills.Runstart
    local RunLoop = monster.skills.RunLoop
    local RunEnd = monster.skills.RunEnd
    local RunPunch = monster.skills.RunPunch
    Runstart(RunLoop(RunPunch, RunEnd))
    
    function skills.RunPunch.isReady(RunPunch)
      if monster.runhitcheck1 == true then
        return false
      elseif not RunPunch.base.isReady(RunPunch) then
        return false
      else
        return true
      end
    end
    
    function states.Runstart.start(Runstart)
      if get_npc_distance(monster.npc, 3, nil, true) <= 5 then
        local self = Runstart.monster
        Runstart.isCastOver = false
        local skill = Runstart.skill
        Runstart.curSk = skill
        skill.state = Runstart
        abort_skill(self.npc, true)
        Runstart.timer = get_npc_time(Runstart.monster.npc) + Runstart.cd
        skill.isCastOver = false
        skill.castTimer = get_npc_time(self.npc) + skill.befTime + skill.castTime
        lookat_position(self.npc, self.center.x, self.center.z, false)
        cast_skill(self.npc, nil, 2020470101, self.center.x, self.center.z)
      else
        Runstart.base.start(Runstart)
      end
    end
    
    function states.Runstart1.start(Runstart1)
      if get_npc_distance(monster.npc, 3, nil, true) <= 5 then
        local self = Runstart1.monster
        Runstart1.isCastOver = false
        local skill = Runstart1.skill
        Runstart1.curSk = skill
        skill.state = Runstart1
        abort_skill(self.npc, true)
        Runstart1.timer = get_npc_time(Runstart1.monster.npc) + Runstart1.cd
        skill.isCastOver = false
        skill.castTimer = get_npc_time(self.npc) + skill.befTime + skill.castTime
        cast_skill(self.npc, nil, 2020470120, self.center.x, self.center.z)
      else
        Runstart1.base.start(Runstart1)
      end
    end
    
    function skills.RunLoop.onEnd(RunLoop)
      cast_magic(monster.npc, monster.npc, 2020470102, 1)
      RunLoop.base.onEnd(RunLoop)
    end
    
    function skills.RunLoop.onBegin(RunLoop)
      cast_magic(RunLoop.monster.npc, RunLoop.monster.npc, 2020470103, 1)
      cast_magic(RunLoop.monster.npc, RunLoop.monster.npc, 2020470104, 1)
      if get_npc_distance(monster.npc, 3, 3, false) <= 3 then
        set_keyframe_enable(monster.npc, 202047010208, false, false)
      end
      if get_npc_distance(monster.npc, 3, 1, false) <= 3 then
        set_keyframe_enable(monster.npc, 202047010208, true, false)
      end
    end
    
    function skills.RunLoop.onBreak(RunLoop)
      abort_magic_by_id(monster.npc, 2020470103, 1)
      abort_magic_by_id(monster.npc, 2020470104, 1)
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
  
  function states.frontPush.tick(frontPush)
    local skillMgr = monster.npc.skill_mgr
    local skillInfo = skillMgr and skillMgr:get_skill(2020470109)
    local frame = skillInfo and skillInfo.v_frame
    if nil ~= frame then
      local player = get_come_on_hero()
      if 47 == frame and get_target_angel(frontPush.monster.npc, player, true) < 0 then
        set_keyframe_enable(frontPush.monster.npc, 202047010904, false, true)
      end
    end
  end
  
  function states.frontPush.finish(frontPush)
    frontPush.base.finish(frontPush)
    set_keyframe_enable(frontPush.monster.npc, 202047010904, true, true)
  end
  
  function states.frontPush1.tick(frontPush1)
    local skillMgr = monster.npc.skill_mgr
    local skillInfo = skillMgr and skillMgr:get_skill(2020470109)
    local frame = skillInfo and skillInfo.v_frame
    if nil ~= frame then
      local player = get_come_on_hero()
      if 47 == frame and get_target_angel(frontPush1.monster.npc, player, true) < 0 then
        set_keyframe_enable(frontPush1.monster.npc, 202047010904, false, true)
      end
    end
  end
  
  function states.frontPush1.finish(frontPush1)
    frontPush1.base.finish(frontPush1)
    set_keyframe_enable(frontPush1.monster.npc, 202047010904, true, true)
  end
  
  do
    local Turn = monster.states.Turn
    local TurnLeft = monster.states.TurnLeft
    local TurnRight = monster.states.TurnRight
    local Stand = monster.states.Stand
    
    function Turn.isReady()
      return TurnLeft.isReady(TurnLeft) or TurnRight.isReady(TurnLeft)
    end
    
    function Turn.finTrans(True)
      return True.monster.states.Stand
    end
    
    function Stand.start(Stand)
      stop_move(Stand.monster.npc)
    end
    
    function Stand.tickTrans(Stand)
      local Turn = Stand.monster.states.Turn
      if Turn.base.isReady(Turn) then
        return Turn
      end
    end
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
      return true
    end
  end
  
  function states.attackforphase1.start(attackforphase1)
    attackforphase1.base.start(attackforphase1)
    attackforphase1.monster.attackcount = attackforphase1.monster.attackcount + 1
  end
  
  function states.attackforphase2.isReady(attackforphase2)
    if not attackforphase2.base.isReady(attackforphase2) then
      return false
    end
    local HpMax = get_npc_attr(attackforphase2.monster.npc, 4)
    local current_hp = get_npc_attr(attackforphase2.monster.npc, 1)
    if current_hp > HpMax * 0.5 then
      return false
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
  if 1 == get_role_kind(hit_target) and missile_cfg.Id == 202047010210 and monster.runhitcheck == false then
    local RunLoop = monster.skills[skill_id]
    RunLoop:deriveAuto()
  end
end

function monster.on_target_self_skill_hit(monster, skill_id, caster, hit_type, missile_cfg, missile)
  local player = get_come_on_hero()
  if missile_cfg.Id == 202047010803 or missile_cfg.Id == 202047012903 then
    local npc = monster.npc
    abort_skill(monster.npc, false)
    enter_stun(monster.npc, false, 2.5)
    lookat_npc(npc, player, true)
    cast_magic(npc, npc, Const.MONSTER_BE_HIT.SOUND_REVERB, 0)
    if 0 == get_missile_kill_role_count(npc, missile) then
      cast_magic(player, npc, 1999220)
    end
    cast_magic(player, npc, 1999242)
    cast_magic(player, npc, 1999261)
    cast_magic(player, npc, 1999219)
    cast_magic(player, npc, 1999221)
    cast_magic(player, npc, 1999222)
    cast_magic(player, npc, 1999285)
    cast_magic(player, npc, 1999347)
  end
end

function monster.on_target_self_magic_begin(monster, caster, magic_id, is_self, magic_level)
  monster.base.on_target_self_magic_begin(monster, caster, magic_id, is_self, magic_level)
  if 2020470102 == magic_id then
    abort_magic_by_id(monster.npc, 2020470102, 1)
  end
end

function monster.on_missile_begin_pos(monster, owner, pos_x, pos_z, missile_cfg, missile)
  if owner ~= monster.npc then
    return
  end
  if missile_cfg.Id == 202047010210 then
    monster.RunCheckMissile = missile
  end
  if missile_cfg.Id == 202047013901 then
    monster.RunPushMissile = missile
  end
end

function monster.on_missile_collide(monster, m1_owner, m2_owner, m1, m2, m1_cfg, m2_cfg)
  local player = get_come_on_hero()
  if m1_owner == player and m2_owner == monster.npc then
    local magics = m1_cfg.magic
    local magicId = magics and magics[1]
    if m2_cfg.Id == 202047010803 then
      monster.reboundMis = m2
      monster:try_red_skill_counter(m1, m2)
    end
  end
end

function monster.on_red_skill_countered(monster, attackerNpc, victimNpc, missile)
  if check_magic(monster.npc, 1999218) then
    abort_skill(monster.npc, true)
    abort_magic_by_id(monster.npc, Const.RED_SKILL)
    monster:doAfter(monster.on_red_skill_countered_fx, nil, attackerNpc, missile)
  else
    cast_magic(monster.npc, attackerNpc, 2020470109, 1)
    abort_skill(monster.npc, true)
    create_scene_effect("Fx_M201047_water_hit_3", get_missile_pos(monster.reboundMis), 5, nil, get_npc_pos(monster.npc))
    rebound_missile(monster.reboundMis, attackerNpc, monster.npc, get_npc_pos(monster.npc).x, get_npc_pos(monster.npc).z, 10, false, false, true)
    cast_magic(monster.npc, monster.npc, 2010540607, 1)
    cast_magic(monster.npc, attackerNpc, 201025030809, 1)
    cast_magic(monster.npc, attackerNpc, 201025030810, 1)
    cast_magic(monster.npc, attackerNpc, 2020470145, 1)
  end
end

function monster.on_start(monster)
  print("相机 = ", get_cur_camera_id())
  change_follow_target_new(3, monster.npc, {
    5,
    5,
    {
      x = 0,
      y = 0,
      z = 0
    },
    1,
    0.5,
    0.05,
    nil,
    0,
    1
  })
  monster:xRay()
end

return monster
