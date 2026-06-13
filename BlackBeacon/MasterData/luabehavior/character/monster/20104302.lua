local monstBase = import("character.base.monster_base")
local monster = Util.create_child_mt(monstBase)

function monster._init(monster, npc)
  monster.npc = npc
  monster.wander = {
    minDis = 1.5,
    maxDis = 3,
    minTime = 1,
    maxTime = 2,
    type = "walk"
  }
  local actSkills = {
    Attack360 = {
      2020430101,
      9,
      math.random(1, 4),
      1,
      2.3,
      -45,
      45
    },
    jumpattack = {
      2020430102,
      15,
      math.random(1, 4),
      0,
      4,
      -45,
      45
    },
    tailattack = {
      2020430116,
      5,
      1,
      0,
      2,
      -45,
      45
    },
    tailattack2 = {
      2020430103,
      12,
      1,
      0,
      2.3,
      -45,
      45
    },
    tailattack3 = {
      2020430104,
      0,
      1,
      0,
      9999
    },
    drink_Start = {
      2020430105,
      0,
      0,
      0,
      999
    },
    drink_Loop = {
      2020430106,
      0,
      0,
      0,
      999
    },
    drink_End = {
      2020430107,
      0,
      0,
      0,
      999
    },
    Henshin = {
      2020430118,
      0,
      0,
      0,
      999
    },
    counter_skill1 = {
      2020430102,
      0,
      0,
      0,
      4,
      nil,
      nil,
      nil,
      10,
      1.3
    }
  }
  local nodes = {"drink", "ATK"}
  local actMoves = {
    "moveToWater"
  }
  monstBase._init(monster, actSkills, actMoves, nodes)
  monster.states.drink.distance = false
  monster.states.active.closetMis = nil
  monster.states.active.closetPos = nil
  monster.states.active.minDis = 999999999
  monster.nightSwitch = true
  do
    local _ENV = monster.states
    _ENV.active(_ENV.drink, _ENV.gotTarget, _ENV.noTarget)
    _ENV.drink(_ENV.moveToWater, _ENV.drink_Start(_ENV.drink_Loop(_ENV.drink_End(_ENV.Henshin))))
    _ENV.meleeAtk(_ENV.ATK, _ENV.Attack360, _ENV.jumpattack, _ENV.tailattack)
    _ENV.ATK(_ENV.tailattack2(_ENV.tailattack3))
    _ENV.meleeCounter(_ENV.counter_skill1)
  end
  do
    local ATK = monster.states.ATK
    
    function ATK.isReady(attack)
      local npc = attack.monster.npc
      local hpmax = get_npc_attr(npc, 4)
      local hpnow = get_npc_attr(npc, 1)
      if hpnow / hpmax <= 0.8 then
        return true
      end
    end
  end
  do
    local gotTarget = monster.states.gotTarget
    local active = monster.states.active
    
    function active.tick(active)
      if not check_magic(active.monster.npc, 2020430109) then
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
    local wander = monster.states.wander
    local idle = monster.states.idle
    
    function wander.tickTrans(wander)
      local states = wander.monster.states
      local drink = wander.monster.states.drink
      local skill = monster.tree:chooseChildAction(states.attack)
      if not monster.target then
        return states.noTarget
      end
      if skill then
        return skill
      end
      if drink.isReady(drink) then
        return wander.monster.states.drink
      end
    end
  end
  do
    local drink = monster.states.drink
    local drink_End = monster.states.drink_End
    local drink_Loop = monster.states.drink_Loop
    local drink_Start = monster.states.drink_Start
    
    function drink.isReady(drink)
      local magic = check_magic(drink.monster.npc, 2020430109)
      if magic then
        return false
      end
      if monster.tool.blueWaters == nil then
        return false
      end
      if nil == _G.next(monster.tool.blueWaters) then
        return false
      end
      if drink_Start.isReady(drink_Start) == false then
        return false
      end
      if false == drink.distance then
        return false
      end
      return true
    end
    
    function drink.finish(drink)
      local tool = drink.monster.tool
      local closetMis = drink.monster.states.moveToWater.TarMis
      tool.blueWaters[closetMis].drinkNum = tool.blueWaters[closetMis].drinkNum - 1
    end
    
    function drink.finTrans(drink)
      return drink.monster.states.active
    end
    
    function drink_End.finish(drink_End)
      drink_End.base.finish(drink_End)
      local self = drink_End.monster.npc
      change_npc_prefab(self, 1, true)
      cast_magic(self, self, 2020430109, 1)
    end
    
    function drink_Loop.finish(drink)
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
      switch_move_type(moveToWater.monster.npc, 0)
      local tool = moveToWater.monster.tool
      local closetMis = monster.states.moveToWater.closetMis
      tool.blueWaters[closetMis].drinkNum = tool.blueWaters[closetMis].drinkNum + 1
    end
    
    function moveToWater.tickTrans(moveToWater)
      local pos = moveToWater.randomPos
      local closetMis = monster.states.moveToWater.closetMis
      local Dis = moveToWater.monster.tool.blueWaters[closetMis].drinkDis
      if check_npc_distance_to_pos(moveToWater.monster.npc, pos.x, pos.z, Dis, true) then
        return moveToWater.monster.states.drink_Start
      end
      if _G.next(monster.tool.blueWaters) == nil then
        return moveToWater.monster.states.active
      end
    end
    
    function moveToWater.finTrans(moveToWater)
      return moveToWater.monster.states.active
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
end

function monster.on_missile_end_pos(monster, owner, pos_x, pos_z, missile_cfg, missile)
  if missile_cfg.Id == 201046010801 or missile_cfg.Id == 201046010802 or missile_cfg.Id == 201046010803 then
    monster.tool.blueWaters[missile] = nil
  end
end

function monster.on_target_self_magic_begin(monster, caster, magic_id, is_self, magic_level)
  monster.base.on_target_self_magic_begin(monster, caster, magic_id, is_self, magic_level)
  if 40104404 == magic_id then
    monster.search.minDis = 8
    monster.search.maxDis = 30
  end
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
