local monstBase = import("character.base.monster_base")
local monster = Util.create_child_mt(monstBase)

function monster._init(monster, npc)
  monster.npc = npc
  monster.wander = {
    minDis = 1.5,
    maxDis = 4,
    minTime = 0.5,
    maxTime = 1,
    type = "walk"
  }
  local skills = {
    Kick = {
      nil,
      6,
      2,
      0,
      3.5,
      -90,
      90
    },
    RunStart = {
      nil,
      0,
      0,
      0,
      9999
    },
    RunLoop = {
      nil,
      0,
      0,
      0,
      9999
    },
    RunHit = {
      nil,
      0,
      0,
      0,
      9999
    },
    RunHitDriftLeft = {
      nil,
      0,
      0,
      0,
      9999
    },
    RunHitDriftRight = {
      nil,
      0,
      0,
      0,
      9999
    },
    RunHitStopLeft = {
      nil,
      0,
      0,
      0,
      9999
    },
    RunHitStopRight = {
      nil,
      0,
      0,
      0,
      9999
    },
    RangeAttack = {
      nil,
      15,
      12,
      3,
      9
    },
    DoubleHit = {
      nil,
      5,
      1,
      0,
      3,
      -90,
      90
    },
    DrinkWaterStart = {
      nil,
      0,
      10 + 10 * math.random(),
      0,
      9999
    },
    DrinkWaterLoop = {
      nil,
      0,
      0,
      0,
      9999
    },
    DrinkWaterEnd = {
      nil,
      0,
      0,
      0,
      9999
    },
    DrinkWaterBreak = {
      nil,
      0,
      0,
      0,
      9999
    },
    Turnleft = {
      nil,
      0,
      0,
      0,
      9999
    },
    TurnRight = {
      nil,
      0,
      0,
      0,
      9999
    },
    stunStart = {
      nil,
      0,
      0,
      0,
      9999
    },
    stunLoop = {
      nil,
      0,
      0,
      0,
      9999
    },
    stunEnd = {
      nil,
      0,
      0,
      0,
      9999
    },
    RunHitDrift = {
      nil,
      0,
      0,
      0,
      9999
    },
    DrinkWaterEnd2 = {
      nil,
      0,
      0,
      0,
      9999
    },
    Show_A = {
      nil,
      10,
      10,
      0,
      9999,
      nil,
      nil,
      -5
    },
    Show_B = {
      nil,
      18,
      8,
      0,
      15,
      -90,
      90,
      -5
    },
    Show_C = {
      nil,
      8,
      10,
      0,
      9999,
      nil,
      nil,
      -5
    },
    Show_D = {
      nil,
      15,
      10,
      0,
      9999,
      nil,
      nil,
      -5
    },
    Show_E = {
      nil,
      6,
      10,
      0,
      9999,
      nil,
      nil,
      -5
    },
    RunTurn = {
      "Turnleft",
      0,
      0,
      0,
      9999
    }
  }
  local nodes = {
    "turn",
    "baseMove",
    "drink",
    "SHOW",
    "Run"
  }
  local actMoves = {
    "stand",
    "moveToWater"
  }
  monstBase._init(monster, skills, actMoves, nodes)
  monster.nightSwitch = true
  monster.states.drink.distance = false
  monster.states.active.closetMis = nil
  monster.states.active.closetPos = nil
  monster.states.active.minDis = 999999999
  monster.states.attack.interval = 2
  local states = monster.states
  local skills = monster.skills
  do
    local _ENV = monster.states
    _ENV.active(_ENV.drink, _ENV.SHOW, _ENV.gotTarget, _ENV.noTarget)
    _ENV.meleeAtk(_ENV.Kick, _ENV.DoubleHit)
    _ENV.rangedAtk(_ENV.Run)
    _ENV.SHOW(_ENV.Show_A, _ENV.Show_C, _ENV.Show_E)
    _ENV.drink(_ENV.moveToWater, _ENV.DrinkWaterStart(_ENV.DrinkWaterLoop(_ENV.DrinkWaterEnd(_ENV.DrinkWaterEnd2))))
    _ENV.Run(_ENV.Show_B(_ENV.RunTurn(_ENV.RunStart(_ENV.RunLoop(_ENV.RunHit(_ENV.RunHitStopLeft, _ENV.RunHitStopRight, _ENV.RunHitDrift))))))
    _ENV.wander(_ENV.turn, _ENV.baseMove)
    _ENV.turn(_ENV.Turnleft, _ENV.TurnRight)
    _ENV.baseMove(_ENV.forward, _ENV.stand)
  end
  do
    local _ENV = monster.skills
    _ENV.RunHitStopLeft(_ENV.Show_C)
    _ENV.RunHitStopRight(_ENV.Show_C)
    _ENV.RunHitDrift(_ENV.Show_C)
  end
  do
    local idle = monster.states.idle
    local active = monster.states.active
    
    function active.tick(active)
      if not check_magic(active.monster.npc, 2010440101) then
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
          local misPos = get_missile_pos(waterMis)
          local distSquare = (selfPos.x - misPos.x) * (selfPos.x - misPos.x) + (selfPos.z - misPos.z) * (selfPos.z - misPos.z)
          if waterMis.drinkNum < waterMis.drinkNum_Max and minDis > distSquare then
            minDis = distSquare
            closetMis = waterMis
            closetPos = misPos
          end
        end
        if minDis < 180 and active.monster.tool.blueWaters[closetMis].drinkNum < active.monster.tool.blueWaters[closetMis].drinkNum_Max then
          active.monster.states.drink.distance = true
          active.monster.states.moveToWater.minDis = minDis
          active.monster.states.moveToWater.closetPos = closetPos
          active.monster.states.moveToWater.closetMis = closetMis
        else
          active.monster.states.drink.distance = false
        end
      end
    end
    
    local gotTarget = monster.states.gotTarget
    
    function gotTarget.start(gotTarget)
      gotTarget.base.start(gotTarget)
      monster.idleSwitch = false
      set_can_searched(monster.npc, true)
      set_npc_hp_visible(gotTarget.monster.npc, true)
      gotTarget.monster.search.minDis = 8
      gotTarget.monster.search.maxDis = 30
      gotTarget.monster.nightSwitch = false
      if get_cur_room_id() == 104401 or get_cur_room_id() == 104501 then
        gotTarget.monster.search.minDis = 8
        gotTarget.monster.search.maxDis = 99
        gotTarget.monster.nightSwitch = false
      end
    end
  end
  do
    local wander = states.wander
    local forward = states.forward
    local turn = states.turn
    local baseMove = states.baseMove
    local stand = states.stand
    local attack = states.attack
    states.turn.turnCount = 0
    
    function wander.tickTrans(wander)
    end
    
    function attack.finish(attack)
      attack.timer = get_npc_time(attack.monster.npc) + attack.interval + attack.intervalOffset
      local allies = search_npc(monster.npc, 2, 8, nil, false, false, nil, 2)
      if not allies then
        monster.states.attack.interval = 0
        monster.states.Kick.cd = 2
        monster.states.DoubleHit.cd = 2
      end
      attack.base.finish(attack)
    end
    
    function baseMove.tickTrans(baseMove)
      local monster = baseMove.monster
      local states = monster.states
      local drink = states.drink
      local skill = monster.tree:chooseChildAction(states.attack)
      if not monster.target then
        return states.noTarget
      end
      if drink.isReady(drink) then
        return wander.monster.states.drink
      end
      if skill then
        return skill
      end
    end
    
    function turn.isReady(turn)
      local AngleToPlayer = get_target_angel(turn.monster.npc, turn.monster.target, true)
      if AngleToPlayer > 30 or AngleToPlayer < -30 then
        return true
      else
        return false
      end
    end
    
    function turn.finTrans(turn)
      return turn.monster.states.stand
    end
    
    function forward.isReady(forward)
      local monster = forward.monster
      local distance = get_npc_distance(monster.npc, 1, monster.target, true)
      local time = get_npc_time(monster.npc)
      if monster.states.attack:isRunning() then
        return false
      end
      if time < monster.states.Kick.timer or time < monster.states.DoubleHit.timer then
        return false
      end
      return distance > monster.wander.maxDis
    end
    
    function stand.start(stand)
      stop_move(stand.monster.npc)
    end
    
    function stand.tick(stand)
      local AngleToPlayer = get_target_angel(stand.monster.npc, stand.monster.target, true)
      local time = get_npc_time(monster.npc)
      if AngleToPlayer > 30 or AngleToPlayer < -30 then
        monster:transState(stand.monster.states.turn)
      end
      if forward.isReady(forward) then
        monster:transState(forward)
      end
      if monster.states.SHOW.isReady(monster.states.SHOW) then
        monster:transState(monster.states.SHOW, true)
      end
    end
  end
  do
    local SHOW = monster.states.SHOW
    local Show_C = monster.skills.Show_C
    local Show_B = monster.states.Show_B
    local Show_A = monster.states.Show_A
    local Show_E = monster.states.Show_E
    local faint = monster.states.faint
    local ShowCD = 0
    
    function SHOW.isReady()
      if ShowCD < get_npc_time(monster.npc) then
        return Show_A.isReady(Show_A) or Show_C.isReady(Show_C) or Show_E.isReady(Show_E)
      end
    end
    
    function SHOW.finTrans()
      ShowCD = get_npc_time(monster.npc) + 2 + 5 * math.random()
      return monster.states.attack
    end
    
    function faint.finTrans(faint)
      Show_A.timer = 0
      return Show_A
    end
  end
  
  function states.RunHitDrift.finTrans(RunHitDrift)
    return RunHitDrift.monster.states.wander
  end
  
  function states.RunHitStopLeft.isReady(RunHitStopLeft)
    local AngleToPlayer = get_target_angel(RunHitStopLeft.monster.npc, RunHitStopLeft.monster.target, true)
    if AngleToPlayer < -30 and AngleToPlayer > -180 then
      return true
    end
  end
  
  function states.RunHitStopRight.isReady(RunHitStopRight)
    local AngleToPlayer = get_target_angel(RunHitStopRight.monster.npc, RunHitStopRight.monster.target, true)
    if AngleToPlayer > 30 and AngleToPlayer < 180 then
      return true
    end
  end
  
  do
    local drink = monster.states.drink
    local drinkEnd = monster.states.DrinkWaterEnd
    local drinkEnd2 = monster.states.DrinkWaterEnd2
    local drrink_loop = monster.states.DrinkWaterLoop
    local drink_Start = monster.states.DrinkWaterStart
    
    function drink.isReady(drink)
      local magic = check_magic(drink.monster.npc, 2010440101)
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
      return true
    end
    
    function drinkEnd.finish(drinkEnd)
      drinkEnd.base.finish(drinkEnd)
      local self = drinkEnd.monster.npc
      change_npc_prefab(self, 1, true)
      cast_magic(self, self, 2010440101, 1)
    end
    
    function drink.finish()
      local tool = drink_Start.monster.tool
      local closetMis = drink.monster.states.moveToWater.TarMis
      tool.blueWaters[closetMis].drinkNum = tool.blueWaters[closetMis].drinkNum - 1
    end
    
    function drinkEnd2.isReady(drinkEnd2)
      if check_magic(drinkEnd2.monster.npc, 2010440101) then
        return true
      end
    end
    
    function drink.finTrans(drink)
      return drink.monster.states.active
    end
    
    function drrink_loop.finish(drink)
      local missile = drink.monster.states.moveToWater.TarMis
      local MisId = missile.missile_id
      if 201046010801 == MisId or 201046010802 == MisId or 201046010803 == MisId then
        stop_missile(missile)
      end
    end
  end
  do
    local moveToWater = monster.states.moveToWater
    
    function moveToWater.start(moveToWater)
      cast_magic(monster.npc, monster.npc, 2020470103, 1)
      moveToWater.TarMis = moveToWater.closetMis
      moveToWater.TarPos = moveToWater.closetPos
      moveToWater.randomPos = get_position_offset_position(moveToWater.TarPos, moveToWater.TarPos, math.random(0, 360), 3 * math.random())
      move_to_pos(moveToWater.monster.npc, moveToWater.randomPos)
      switch_move_type(moveToWater.monster.npc, 1)
      local tool = moveToWater.monster.tool
      local closetMis = monster.states.moveToWater.closetMis
      tool.blueWaters[closetMis].drinkNum = tool.blueWaters[closetMis].drinkNum + 1
    end
    
    function moveToWater.tickTrans(moveToWater)
      local pos = moveToWater.randomPos
      local closetMis = monster.states.moveToWater.closetMis
      local Dis = moveToWater.monster.tool.blueWaters[closetMis].drinkDis
      if check_npc_distance_to_pos(moveToWater.monster.npc, pos.x, pos.z, Dis, true) then
        return moveToWater.monster.states.DrinkWaterStart
      end
      if _G.next(monster.tool.blueWaters) == nil then
        return moveToWater.monster.states.active
      end
    end
    
    function moveToWater.finTrans(moveToWater)
      return moveToWater.monster.states.wander
    end
  end
  set_hud_config("warning", {
    Prefab = "UI_Hud10",
    Fore = "UIFight/20240227/battle_bg_jjjdd",
    Back = "UIFight/20240227/battle_bg_jjjdt"
  }, 2, 3, 6)
  set_hud_config("warning2", {
    Prefab = "UI_Hud11",
    Fore = "UIFight/20240227/battle_bg_jjjdd",
    Back = "UIFight/20240227/battle_bg_jjjdt"
  }, 2, 3, 6)
  do
    local HudSwitch = true
    monster.crystal = monster.crystal or {}
    monster.idleSwitch = true
    local noTarget = monster.states.noTarget
    local idle = monster.states.idle
    local Memory = monster.crystal
    monster.WarningDis = {
      3,
      9,
      1,
      4
    }
    monster.sneak = true == get_sync_var("qian_night") or true == get_sync_var("qian_dark")
    
    function noTarget.tickTrans(noTarget)
      local monster = noTarget.monster
      local drink = idle.monster.states.drink
      if drink.isReady(drink) then
        return idle.monster.states.drink
      end
      if monster.target then
        return monster.states.gotTarget
      end
    end
    
    function idle.finish()
      if get_sync_var("qian_night") == true and not check_magic(monster.npc, 40104404) then
        active_hud(monster.npc, "warning", "attachpoint", false, nil)
        active_hud(monster.npc, "warning2", "attachpoint", true, nil)
        cast_magic(monster.npc, monster.npc, 2030430115)
        abort_magic_by_id(monster.npc, 2030430114, 99)
        
        local function delay()
          active_hud(monster.npc, "warning2", "attachpoint", false, nil)
        end
        
        monster:doAfter(delay, 1.5)
      end
      if (get_sync_var("qian_night") == true or true == get_sync_var("qian_dark")) and not check_magic(monster.npc, 40104404) then
        cast_missile3(monster.npc, monster.npc, nil, nil, 30010220103, 1)
      end
    end
    
    function idle.start(idle)
      idle.time = 3
      idle.cd = 8
      abort_skill(monster.npc, false)
      stop_move(idle.monster.npc)
    end
    
    function idle.tick(idle)
      if not monster.sneak then
        return
      end
      if not monster.crystal then
        return
      end
      if not monster.idleSwitch then
        return
      end
      if check_magic(monster.npc, 40104404) then
        return
      end
      if get_sync_var("qian_night") == true then
        local distance = get_npc_distance(monster.npc, 1, get_come_on_hero(), false)
        if get_npc_attr(monster.npc, 3) >= 99 then
          monster.search.minDis = 5
          monster.search.maxDis = 12
        end
        if distance <= monster.WarningDis[2] then
          if not check_magic(monster.npc, 2030430114) then
            cast_magic(monster.npc, monster.npc, 2030430114, 1)
          end
        else
          abort_magic_by_id(monster.npc, 2030430114, 1)
        end
        if distance < monster.WarningDis[1] then
          if not check_magic(monster.npc, 2030430112) then
            lookat_npc(monster.npc, get_come_on_hero(), false)
            cast_magic(monster.npc, monster.npc, 2030430112, 1)
          end
        elseif not check_magic(monster.npc, 2030430113) and get_npc_attr(monster.npc, 3) > 1 then
          cast_magic(monster.npc, monster.npc, 2030430113)
        end
        if get_npc_attr(monster.npc, 3) > 1 and true == HudSwitch then
          HudSwitch = false
          active_hud(monster.npc, "warning", "attachpoint", true, nil)
        elseif get_npc_attr(monster.npc, 3) < 1 and false == HudSwitch then
          HudSwitch = true
          active_hud(monster.npc, "warning", "attachpoint", false, nil)
        end
      end
      if Memory ~= monster.crystal and true == monster.crystal.permission then
        Memory = monster.crystal
        local selfpos = get_npc_pos(monster.npc)
        local tar_pos = get_position_offset_position(monster.crystal.Selfpos, selfpos, math.random() * 90 - 45, 1 * math.random())
        monster:idlemove(tar_pos)
      end
    end
  end
end

function monster.on_self_missile_end_pos(monster, pos_x, pos_z, missile_cfg, missile)
  if missile_cfg.Id == 201046010801 or missile_cfg.Id == 201046010802 or missile_cfg.Id == 201046010803 then
    monster.tool.blueWaters[missile] = nil
  end
  if missile_cfg.Id == 201044010304 then
    remove_missile_by_id(201044011101, monster.npc, false)
  end
end

function monster.go_mad(monster)
  monster.base.go_mad(monster)
  monster.states.Kick.cd = 4
  monster.states.DoubleHit.cd = 4
  monster.states.attack.interval = 1
end

function monster.on_born_behavior(monster)
  monster.base.on_born_behavior(monster)
  if get_npc_group_id(monster.npc) == 10410221 then
    monster.search.minDis = 2
    monster.search.maxDis = 5
  end
  if get_sync_var("qian_night") == true then
    set_can_searched(monster.npc, false)
    monster.search.minDis = monster.WarningDis[3]
    monster.search.maxDis = monster.WarningDis[3]
    cast_magic(monster.npc, monster.npc, 2030430111)
  end
  if true == get_sync_var("qian_dark") then
    monster.search.minDis = monster.WarningDis[4]
    monster.search.maxDis = monster.WarningDis[4]
  end
  if true == get_sync_var("nightSwitch") and true == monster.nightSwitch then
    set_npc_hp_visible(monster.npc, false)
  end
  if true == get_sync_var("darkSwitch") and true == monster.nightSwitch then
    set_npc_hp_visible(monster.npc, false)
  end
  listen_missile_collide_obstacle(monster.npc, 201044011101, monster.on_missile_collide_obstacle, monster)
end

function monster.on_target_self_magic_begin(monster, caster, magic_id, is_self, magic_level)
  monster.base.on_target_self_magic_begin(monster, caster, magic_id, is_self, magic_level)
  if 40104404 == magic_id then
    monster.search.minDis = 8
    monster.search.maxDis = 30
  end
end

function monster.on_missile_collide_obstacle(monster, owner, obstacle_type, missile_cfg, missile)
  if owner ~= monster.npc then
    return
  end
  if missile_cfg.Id ~= 201044011101 then
    return
  end
  abort_skill(monster.npc, false)
  enter_stun(monster.npc, false, 0.5)
end

function monster.on_self_magic_end(monster, target, magic_id, magic_kind, magic_type, is_break)
  monster.base.on_self_magic_end(target, magic_id, magic_kind, magic_type, is_break)
  local switch = check_npc_distance(monster.npc, get_come_on_hero(), monster.WarningDis[1], true)
  if 2030430112 == magic_id and monster.state.name == "idle" and get_npc_attr(monster.npc, 3) <= 100 and switch then
    cast_magic(monster.npc, monster.npc, magic_id)
  end
  if 2030430113 == magic_id and monster.state.name == "idle" and get_npc_attr(monster.npc, 3) > 0 and not switch then
    cast_magic(monster.npc, monster.npc, magic_id)
  end
end

function monster.after_damage_self(monster, npc, magic_id, damage_sign, damage_type, is_crit, damage_val, base_dmg, element_dmg, skill_id, missile)
  monster.base.after_damage_self(monster, npc, magic_id, damage_sign, damage_type, is_crit, damage_val, base_dmg, element_dmg, skill_id, missile)
  if not monster.sneak then
    return
  end
  if monster.state.name == "idle" then
    monster.search.minDis = 8
    monster.search.maxDis = 30
  end
end

function monster.idlemove(monster, pos)
  local idle = monster.states.idle
  idle.time = get_npc_time(idle.monster.npc) + idle.cd
  lookat_position(monster.npc, pos.x, pos.z, false)
  
  local function delay()
    cast_magic(monster.npc, monster.npc, 2010440105, 1)
    switch_move_type(monster.npc, 1)
    move_to_pos(monster.npc, pos)
  end
  
  monster:doAfter(delay, 0.5)
end

function monster.idleturn(monster, pos)
  local idle = monster.states.idle
  idle.time = get_npc_time(idle.monster.npc) + idle.cd
  lookat_position(monster.npc, pos.x, pos.z, false)
end

function monster.on_target_self_skill_hit(monster, skill_id, caster, hit_type, missile_cfg, missile)
  monster.base.on_target_self_skill_hit(monster, skill_id, caster, hit_type, missile_cfg, missile)
  if missile_cfg.Id == 30010220103 and monster.state.name == "idle" then
    local function delay()
      monster.search.minDis = 8
      
      monster.search.maxDis = 30
    end
    
    monster:doAfter(delay, 0.5)
  end
end

return monster
